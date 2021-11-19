Codeunit 55000 "Petty Cash - Post"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   17.08.2006   KKE   -Petty Cash
    // Burda
    // 002   14.08.2007   KKE   -Average VAT

    Permissions = TableData "G/L Register" = rm;
    TableNo = "Petty Cash Header";

    trigger OnRun()
    var
        TotalPettyCashLine: Record "Petty Cash Line";
        //TempJnlLineDim: Record "Journal Line Dimension" temporary;
        PettyCashHdr: Record "Petty Cash Header";
        EntryNo: Integer;
    begin
        if not Confirm(Text001, false) then
            exit;

        TestField(Status, Status::Released);

        if PostAndPrint then begin
            ClearAll;
            PostAndPrint := true;
        end else
            ClearAll;

        UserSetup.Get(UserId);
        if not UserSetup."Allow Post Petty Cash Invoice" then
            Error(Text000);

        PettyCashHeader.Copy(Rec);
        with PettyCashHeader do begin
            TestField("Petty Cash Vendor No.");
            TestField("Posting Date");
            TestField("Document Date");
            if GenJnlCheckLine.DateNotAllowed("Posting Date") then
                FieldError("Posting Date", Text004);
            GetGLSetup;

            PettyCashLine.Reset;
            PettyCashLine.SetRange("Document No.", "No.");
            PettyCashLine.CalcSums("Amount (LCY) Incl. VAT");
            if PettyCashLine."Amount (LCY) Incl. VAT" = 0 then
                Error(Text002);

            //CopyAndCheckDocDimToTempDocDim; //VAH

            Vend.Get("Petty Cash Vendor No.");
            Vend.CheckBlockedVendOnDocs(Vend, true);

            VendPostingGroup.Get(Vend."Vendor Posting Group");
            Vend.CheckVendorPettyCash;

            if RECORDLEVELLOCKING then begin
                //DocDim.LockTable; //SAG
                PettyCashLine.LockTable;
                GLEntry.LockTable;
                if GLEntry.Find('+') then;
            end;

            SourceCodeSetup.Get;
            SourceCodeSetup.TestField("Petty Cash");
            SrcCode := SourceCodeSetup."Petty Cash";

            if GuiAllowed then
                Window.Open(
                  '#1#################################\\' +
                  Text005 +
                  Text006 +
                  Text007 +
                  Text008);

            // Insert petty cash invoice header
            PettyCashInvHeader.Init;
            PettyCashInvHeader.TransferFields(PettyCashHeader);
            if GuiAllowed then
                Window.Update(1, StrSubstNo(Text009, "No.", PettyCashInvHeader."No."));
            PettyCashInvHeader."Source Code" := SrcCode;
            PettyCashInvHeader."User ID" := UserId;
            PettyCashInvHeader.Insert;
            /*DimMgt.MoveOneDocDimToPostedDocDim(
              DocDim,Database::"Petty Cash Header",DocDim."document type"::Invoice,"No.",0,
              Database::"Petty Cash Invoice Header",PettyCashInvHeader."No.");*/ //SAG
            PettyCashInvHeader."Dimension Set ID" := PettyCashHeader."Dimension Set ID";//SAG
            CopyCommentLines(
              PettyCashCmtLine."document type"::Invoice, PettyCashCmtLine."document type"::"Posted Invoice",
                "No.", PettyCashInvHeader."No.");
            /*PostCodeCheck.CopyAllAddressID(
              Database::"Petty Cash Header", GetPosition,
              Database::"Petty Cash Invoice Header", PettyCashInvHeader.GetPosition);*///SAG
            CopyAllAddressID(
            Database::"Petty Cash Header", GetPosition,
            Database::"Petty Cash Invoice Header", PettyCashInvHeader.GetPosition);//SAG

            // Lines
            TotalPettyCashLine.Init;

            PettyCashLine.Reset;
            PettyCashLine.SetRange("Document No.", "No.");
            LineCount := 0;

            if PettyCashLine.Find('-') then
                repeat
                    LineCount := LineCount + 1;
                    if GuiAllowed then
                        Window.Update(2, LineCount);

                    //TempDocDim.SetRange("Table ID", Database::"Petty Cash Line");//SAG
                    //TempDocDim.SetRange("Line No.", PettyCashLine."Line No.");//SAG
                    UpdateTempDimBuf(EntryNo);

                    if PettyCashLine."Amount Incl. VAT" <> 0 then begin
                        PettyCashLine.TestField("No.");
                        PettyCashLine.TestField(Type, PettyCashLine.Type::"G/L Account");
                        PettyCashLine.TestField("Gen. Bus. Posting Group");
                        PettyCashLine.TestField("Gen. Prod. Posting Group");
                    end else
                        PettyCashLine.TestField(Type, 0);

                    // Insert invoice line or credit memo line
                    PettyCashInvLine.Init;
                    PettyCashInvLine.TransferFields(PettyCashLine);
                    PettyCashInvLine.Insert;
                    /*DimMgt.MoveOneDocDimToPostedDocDim(
                      DocDim, Database::"Petty Cash Line", DocDim."document type"::Invoice, "No.", PettyCashLine."Line No.",
                      Database::"Petty Cash Invoice Line", PettyCashInvHeader."No.");*///SAG
                    PettyCashInvLine."Dimension Set ID" := PettyCashLine."Dimension Set ID"; //SAG
                    // Post petty cash and VAT to G/L entries from buffer
                    if GuiAllowed then
                        Window.Update(3, LineCount);
                    GenJnlLine.Init;
                    GenJnlLine."Posting Date" := "Posting Date";
                    GenJnlLine."Document Date" := "Document Date";
                    GenJnlLine.Description := PettyCashLine.Description;
                    GenJnlLine."Document Type" := GenJnlLine."document type"::Invoice;
                    GenJnlLine."Document No." := "No.";
                    GenJnlLine."External Document No." := PettyCashLine."External Document No.";
                    GenJnlLine."Account No." := PettyCashLine."No.";
                    GenJnlLine."System-Created Entry" := true;

                    //KKE : #002 +
                    if PettyCashLine."VAT Claim %" <> 0 then begin
                        GenJnlLine."Use Average VAT" := true;
                        GenJnlLine."Average VAT Year" := PettyCashLine."Average VAT Year";
                        GenJnlLine."VAT Claim %" := PettyCashLine."VAT Claim %";
                        GenJnlLine.Amount := PettyCashLine."Amount Incl. VAT" - PettyCashLine."Avg. VAT Amount";
                        GenJnlLine."VAT Base Amount" := PettyCashLine."Amount Incl. VAT" - PettyCashLine."Avg. VAT Amount";
                        GenJnlLine."VAT Base (ACY)" := PettyCashLine."Amount Incl. VAT" - PettyCashLine."Avg. VAT Amount";
                        GenJnlLine."VAT Amount" := PettyCashLine."Avg. VAT Amount";
                        GenJnlLine."VAT Amount (ACY)" := PettyCashLine."Avg. VAT Amount";
                        GenJnlLine."VAT Difference" := PettyCashLine."VAT Difference";
                        GenJnlLine."VAT Difference (ACY)" := PettyCashLine."VAT Difference";
                        GenJnlLine."Amount Including VAT (ACY)" := PettyCashLine."Amount (LCY) Incl. VAT";
                    end else begin
                        //KKE : #002 -
                        GenJnlLine.Amount := PettyCashLine."VAT Base Amount (LCY)";
                        GenJnlLine."VAT Base Amount" := PettyCashLine."VAT Base Amount (LCY)";
                        GenJnlLine."VAT Base (ACY)" := PettyCashLine."VAT Base Amount (LCY)";
                        GenJnlLine."VAT Amount" := PettyCashLine."VAT Amount (LCY)";
                        GenJnlLine."VAT Amount (ACY)" := PettyCashLine."VAT Amount (LCY)";
                        GenJnlLine."VAT Difference" := PettyCashLine."VAT Difference";
                        GenJnlLine."VAT Difference (ACY)" := PettyCashLine."VAT Difference";
                        GenJnlLine."Amount Including VAT (ACY)" := PettyCashLine."Amount (LCY) Incl. VAT";
                    end;

                    GenJnlLine."Source Currency Code" := "Currency Code";
                    GenJnlLine."Source Currency Amount" := PettyCashLine."Amount Incl. VAT";
                    //GenJnlLine.Correction := Correction;
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::Purchase;
                    GenJnlLine."Gen. Bus. Posting Group" := PettyCashLine."Gen. Bus. Posting Group";
                    GenJnlLine."Gen. Prod. Posting Group" := PettyCashLine."Gen. Prod. Posting Group";
                    GenJnlLine."VAT Bus. Posting Group" := PettyCashLine."VAT Bus. Posting Group";
                    GenJnlLine."VAT Prod. Posting Group" := PettyCashLine."VAT Prod. Posting Group";
                    GenJnlLine.VATLineNo := PettyCashLine."Line No.";
                    GenJnlLine."VAT Calculation Type" := PettyCashLine."VAT Calculation Type";
                    //GenJnlLine."VAT Base Discount %" := "VAT Base Discount %";
                    GenJnlLine."Source Curr. VAT Base Amount" := PettyCashLine."VAT Base Amount (LCY)";
                    GenJnlLine."Source Curr. VAT Amount" := PettyCashLine."VAT Amount (LCY)";
                    GenJnlLine."VAT Posting" := GenJnlLine."vat posting"::"Manual VAT Entry";
                    GenJnlLine."Shortcut Dimension 1 Code" := PettyCashLine."Shortcut Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PettyCashLine."Shortcut Dimension 2 Code";
                    GenJnlLine."Dimension Set ID" := PettyCashLine."Dimension Set ID";//VAH
                    GenJnlLine."Source Code" := SrcCode;
                    GenJnlLine."Sell-to/Buy-from No." := "Petty Cash Vendor No.";
                    GenJnlLine."Bill-to/Pay-to No." := "Petty Cash Vendor No.";
                    GenJnlLine."Source Type" := GenJnlLine."source type"::Vendor;
                    GenJnlLine."Source No." := "Petty Cash Vendor No.";
                    GenJnlLine."Posting No. Series" := "No. Series";
                    if PettyCashLine."Tax Invoice No." <> '' then
                        GenJnlLine."Tax Invoice No." := PettyCashLine."Tax Invoice No."
                    else
                        GenJnlLine."Tax Invoice No." := PettyCashLine."External Document No.";
                    GenJnlLine."Tax Invoice Date" := PettyCashLine."Tax Invoice Date";
                    GenJnlLine."Real Customer/Vendor Name" := PettyCashLine."Real Customer/Vendor Name";
                    /*
                    IF "Invoice Description" <> '' THEN
                      GenJnlLine.Description := COPYSTR("Invoice Description",1,50);
                    */
                    GenJnlLine.Description := PettyCashLine.Description;  //Burda 12.10.2007

                    RunGenJnlPostLine(GenJnlLine, EntryNo);

                    // Sumtotal
                    TotalPettyCashLine."Amount Incl. VAT" += PettyCashLine."Amount Incl. VAT";
                    TotalPettyCashLine."Amount (LCY) Incl. VAT" += PettyCashLine."Amount (LCY) Incl. VAT";
                    TotalPettyCashLine."VAT Amount" += PettyCashLine."VAT Amount";
                    TotalPettyCashLine."VAT Amount (LCY)" += PettyCashLine."VAT Amount (LCY)";
                    TotalPettyCashLine."VAT Base Amount" += PettyCashLine."VAT Base Amount";
                    TotalPettyCashLine."VAT Base Amount (LCY)" += PettyCashLine."VAT Base Amount (LCY)";
                until PettyCashLine.Next = 0;

            // Post vendor entries
            if GuiAllowed then
                Window.Update(4, 1);
            GenJnlLine.Init;
            GenJnlLine."Posting Date" := "Posting Date";
            GenJnlLine."Document Date" := "Document Date";
            GenJnlLine.Description := 'Petty Cash ' + "No.";
            GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            //GenJnlLine."Reason Code" := "Reason Code";
            GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
            GenJnlLine."Account No." := "Petty Cash Vendor No.";
            GenJnlLine."Document Type" := GenJnlLine."document type"::Invoice;
            GenJnlLine."Document No." := "No.";
            GenJnlLine."External Document No." := PettyCashLine."External Document No.";
            GenJnlLine."Currency Code" := "Currency Code";
            GenJnlLine.Amount := -TotalPettyCashLine."Amount Incl. VAT";
            GenJnlLine."Amount (LCY)" := -TotalPettyCashLine."Amount (LCY) Incl. VAT";
            //GenJnlLine."Vendor Exchange Rate (ACY)":="Vendor Exchange Rate (ACY)";
            GenJnlLine."Amount Including VAT (ACY)" := -TotalPettyCashLine."Amount (LCY) Incl. VAT";
            GenJnlLine."Source Currency Code" := "Currency Code";
            GenJnlLine."Source Currency Amount" := -TotalPettyCashLine."Amount Incl. VAT";
            if PettyCashHeader."Currency Code" = '' then
                GenJnlLine."Currency Factor" := 1
            else
                GenJnlLine."Currency Factor" := PettyCashHeader."Currency Factor";
            //GenJnlLine."Sales/Purch. (LCY)" := -TotalPettyCashLine.Amount;
            //GenJnlLine.Correction := Correction;
            //GenJnlLine."Inv. Discount (LCY)" := -TotalPurchLineLCY."Inv. Discount Amount";
            GenJnlLine."Sell-to/Buy-from No." := "Petty Cash Vendor No.";
            GenJnlLine."Bill-to/Pay-to No." := "Petty Cash Vendor No.";
            //GenJnlLine."Salespers./Purch. Code" := "Purchaser Code";
            GenJnlLine."System-Created Entry" := true;
            //GenJnlLine."On Hold" := "On Hold";
            GenJnlLine."Allow Application" := true;
            //GenJnlLine."Due Date" := "Due Date";
            //GenJnlLine."Payment Terms Code" := "Payment Terms Code";
            //GenJnlLine."Pmt. Discount Date" := "Pmt. Discount Date";
            //GenJnlLine."Payment Discount %" := "Payment Discount %";
            GenJnlLine."Source Type" := GenJnlLine."source type"::Vendor;
            GenJnlLine."Source No." := "Petty Cash Vendor No.";
            GenJnlLine."Source Code" := SrcCode;
            GenJnlLine."Posting No. Series" := "No. Series";
            /*
            GenJnlLine."IC Partner Code" := "Pay-to IC Partner Code";
            GenJnlLine.Adjustment := Adjustment;
            GenJnlLine."BAS Adjustment" := "BAS Adjustment";
            GenJnlLine."Adjustment Applies-to" := "Adjustment Applies-to";
            */
            GenJnlLine."Real Customer/Vendor Name" := "Name (Thai)";
            if "Invoice Description" <> '' then
                GenJnlLine.Description := CopyStr("Invoice Description", 1, 50);

            TotalWHTAmount := 0;
            TotalWHTAmountLCY := 0;
            GLSetup.Get;
            if GLSetup."Enable WHT" then begin
                NeedPrint := WHTManagementExt.InsertVendPayWHTPettyCash(PettyCashHeader, GenJnlLine); //VAH
                GenJnlLine2.Reset;
                GenJnlLine2.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                GenJnlLine2.SetRange("Is WHT", true);
                if GenJnlLine2.Find('-') then
                    repeat
                        TotalWHTAmount := TotalWHTAmount + GenJnlLine2.Amount;
                        TotalWHTAmountLCY := TotalWHTAmountLCY + GenJnlLine2."Amount (LCY)";
                    until GenJnlLine2.Next = 0;
                GenJnlLine.Amount := -TotalPettyCashLine."Amount Incl. VAT" - TotalWHTAmount;
                GenJnlLine."Amount (LCY)" := -TotalPettyCashLine."Amount (LCY) Incl. VAT" - TotalWHTAmountLCY;
                GenJnlLine."Amount Including VAT (ACY)" := -TotalPettyCashLine."Amount (LCY) Incl. VAT" - TotalWHTAmountLCY;
            end;

            /*TempJnlLineDim.DeleteAll;
            TempDocDim.Reset;
            TempDocDim.SetRange("Table ID", Database::"Petty Cash Header");
            DimMgt.CopyDocDimToJnlLineDim(TempDocDim, TempJnlLineDim);*/
            GenJnlLine."Dimension Set ID" := "Dimension Set ID"; //SAG
            //GenJnlPostLine.RunWithCheck(GenJnlLine, TempJnlLineDim); //SAG
            GenJnlPostLine.RunWithCheck(GenJnlLine); //SAG

            // WHT account
            GLSetup.Get;
            if GLSetup."Enable WHT" then begin
                //NeedPrint := WHTManagement.InsertVendPayWHTPettyCash(PettyCashHeader,GenJnlLine);
                WHTEntry.Reset;
                WHTEntry.SetRange("Document Type", WHTEntry."document type"::Payment);
                WHTEntry.SetRange("Document No.", PettyCashHeader."No.");
                if WHTEntry.Find('+') then
                    if GLReg.Find('+') then begin
                        GLReg."To WHT Entry No." := WHTEntry."Entry No.";
                        GLReg.Modify;
                    end;
                LineCount := 0;
                GenJnlLine2.Reset;
                GenJnlLine2.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                GenJnlLine2.SetRange("Is WHT", true);
                if GenJnlLine2.Find('-') then begin
                    repeat
                        LineCount := LineCount + 1;
                        if GuiAllowed then
                            Window.Update(5, LineCount);
                        //GenJnlLine2."Bal. Account Type" := GenJnlLine2."Bal. Account Type"::"G/L Account";
                        //GenJnlLine2."Bal. Account No." := VendPostingGroup."Payables Account";
                        //GenJnlPostLine.RunWithoutCheck(GenJnlLine2, TempJnlLineDim);//SAG
                        GenJnlPostLine.RunWithoutCheck(GenJnlLine2);//SAG
                    until GenJnlLine2.Next = 0;
                    GenJnlLine2.DeleteAll;

                    if PostAndPrint or NeedPrint then
                        if GLReg.Find('+') then begin
                            GLReg.SetRecfilter;
                            WHTManagementExt.PrintWHTSlips(GLReg, false); //VAH
                        end;
                end;
            end;

            //Post and Print - Print Purchase Voucher
            if PostAndPrint then begin
                PettyCashHdr.Reset;
                PettyCashHdr.SetRange("No.", "No.");
                Report.Run(Report::"Petty Cash Test", false, false, PettyCashHdr);
            end;

            /*
            GLEntry.SETRANGE(GLEntry."Document No.","No.");
            IF GLEntry.FIND('-') THEN
            REPEAT
              MESSAGE('%1  %2',GLEntry."G/L Account No.",GLEntry.Amount);
            UNTIL GLEntry.NEXT=0;
            */ //Check consistency

            // Modify/delete purchase header and purchase lines
            if not RECORDLEVELLOCKING then begin
                //DocDim.LockTable(true, true); //SAG
                PettyCashLine.LockTable(true, true);
            end;

            /*DocDim.Reset;
            DocDim.SetRange("Table ID", Database::"Petty Cash Header");
            DocDim.SetRange("Document Type", DocDim."document type"::Invoice);
            DocDim.SetRange("Document No.", "No.");
            DocDim.DeleteAll;
            DocDim.SetRange("Table ID", Database::"Petty Cash Line");
            DocDim.DeleteAll;*/

            Delete;

            PettyCashLine.DeleteAll;

            PettyCashCmtLine.SetRange("Document Type", PettyCashCmtLine."document type"::Invoice);
            PettyCashCmtLine.SetRange("No.", "No.");
            PettyCashCmtLine.DeleteAll;

            Commit;

            Clear(WHTManagement);
            Clear(GenJnlPostLine);
            if GuiAllowed then
                Window.Close;
        end;

    end;

    var
        GLSetup: Record "General Ledger Setup";
        PettyCashHeader: Record "Petty Cash Header";
        PettyCashLine: Record "Petty Cash Line";
        PettyCashInvHeader: Record "Petty Cash Invoice Header";
        PettyCashInvLine: Record "Petty Cash Invoice Line";
        PettyCashCmtLine: Record "Petty Cash Comment Line";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        //DocDim: Record "Document Dimension";
        //TempDocDim: Record "Document Dimension" temporary;
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
        GLReg: Record "G/L Register";
        WHTEntry: Record "WHT Entry";
        GenPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        VendPostingGroup: Record "Vendor Posting Group";
        SourceCodeSetup: Record "Source Code Setup";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        UserSetup: Record "User Setup";
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        PostCodeCheck: Codeunit "Post Code Check";
        DimMgt: Codeunit DimensionManagement;
        DimBufMgt: Codeunit "Dimension Buffer Management";
        WHTManagement: Codeunit WHTManagement;
        WHTManagementExt: Codeunit Cu28040Ext;
        SrcCode: Code[10];
        Text000: label 'You do not have permission to post petty cash invoice.';
        Text001: label 'Do you want to post the petty cash invoice?';
        Text002: label 'There is nothing to post.';
        Text003: label 'The petty cash invoice was successfully posted.';
        Text004: label 'is not within your range of allowed posting dates';
        Text005: label 'Posting lines              #2######\';
        Text006: label 'Posting purchases and VAT  #3######\';
        Text007: label 'Posting to vendors         #4######\';
        Text008: label 'Posting to WHT    #5######';
        Window: Dialog;
        Text009: label '%1 -> Invoice %2';
        LineCount: Integer;
        GLSetupRead: Boolean;
        Text032: label 'The combination of dimensions used in %1 is blocked. %2';
        Text033: label 'The combination of dimensions used in %1 , line no. %2 is blocked. %3';
        Text034: label 'The dimensions used in %1 are invalid. %2';
        Text035: label 'The dimensions used in %1 , line no. %2 are invalid. %3';
        PostAndPrint: Boolean;
        NeedPrint: Boolean;
        TotalAmount: Decimal;
        TotalWHTAmount: Decimal;
        TotalWHTAmountLCY: Decimal;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GLSetup.Get;
        GLSetupRead := true;
    end;

    local procedure CopyCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        PettyCashCmtLine2: Record "Petty Cash Comment Line";
    begin
        PettyCashCmtLine.SetRange("Document Type", FromDocumentType);
        PettyCashCmtLine.SetRange("No.", FromNumber);
        if PettyCashCmtLine.Find('-') then
            repeat
                PettyCashCmtLine2 := PettyCashCmtLine;
                PettyCashCmtLine2."Document Type" := ToDocumentType;
                PettyCashCmtLine2."No." := ToNumber;
                PettyCashCmtLine2.Insert;
            until PettyCashCmtLine.Next = 0;
    end;

    local procedure RunGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; DimEntryNo: Integer)
    var
        TempDimBuf: Record "Dimension Buffer" temporary;
    //TempJnlLineDim: Record "Journal Line Dimension" temporary;
    begin
        /*TempDimBuf.DeleteAll;
        TempJnlLineDim.DeleteAll; 
        DimBufMgt.GetDimensions(DimEntryNo, TempDimBuf);
        DimMgt.CopyDimBufToJnlLineDim(
          TempDimBuf, TempJnlLineDim, GenJnlLine."Journal Template Name",
          GenJnlLine."Journal Batch Name", GenJnlLine."Line No.");
          
        GenJnlPostLine.RunWithCheck(GenJnlLine, TempJnlLineDim);*///SAG
        GenJnlPostLine.RunWithCheck(GenJnlLine);//SAG
    end;

    local procedure CopyAndCheckDocDimToTempDocDim()
    var
        PettyCashLine2: Record "Petty Cash Line";
    begin
        /*TempDocDim.Reset;
        TempDocDim.DeleteAll;
        DocDim.SetFilter("Table ID", '%1|%2', Database::"Petty Cash Header", Database::"Petty Cash Line");
        DocDim.SetRange("Document Type", DocDim."document type"::Invoice);
        DocDim.SetRange("Document No.", PettyCashHeader."No.");
        if DocDim.Find('-') then begin
            repeat
                TempDocDim.Init;
                TempDocDim := DocDim;
                TempDocDim.Insert;
            until DocDim.Next = 0;
            TempDocDim.SetRange("Line No.", 0);
            CheckDimComb(0);
        end;*/ //SAG
        PettyCashLine2."Line No." := 0;
        CheckDimValuePosting(PettyCashLine2);

        PettyCashLine2.SetRange("Document No.", PettyCashHeader."No.");
        PettyCashLine2.SetFilter(Type, '<>%1', PettyCashLine2.Type::" ");
        if PettyCashLine2.Find('-') then
            repeat
                //TempDocDim.SetRange("Line No.", PettyCashLine2."Line No."); //SAG
                CheckDimComb(PettyCashLine2."Line No.");
                CheckDimValuePosting(PettyCashLine2);
            until PettyCashLine2.Next = 0;
        //TempDocDim.Reset; //SAG
    end;


    procedure UpdateTempDimBuf(var EntryNo: Integer)
    var
        TempDimBuf: Record "Dimension Buffer" temporary;
    begin
        /*if TempDocDim.Find('-') then
            repeat
                TempDimBuf."Table ID" := TempDocDim."Table ID";
                TempDimBuf."Dimension Code" := TempDocDim."Dimension Code";
                TempDimBuf."Dimension Value Code" := TempDocDim."Dimension Value Code";
                TempDimBuf.Insert;
            until TempDocDim.Next = 0;*///SAG
        EntryNo := DimBufMgt.FindDimensions(TempDimBuf);
        if EntryNo = 0 then
            EntryNo := DimBufMgt.InsertDimensions(TempDimBuf);
    end;

    local procedure CheckDimComb(LineNo: Integer)
    begin
        /*if not DimMgt.CheckDocDimComb(TempDocDim) then
            if LineNo = 0 then
                Error(
                  Text032,
                  PettyCashHeader."No.", DimMgt.GetDimCombErr)*/ //SAG
        if not DimMgt.CheckDimIDComb(LineNo) then
            if LineNo = 0 then
                Error(
                  Text032,
                  PettyCashHeader."No.", DimMgt.GetDimCombErr) //SAG

            else
                Error(
                  Text033,
                  PettyCashHeader."No.", LineNo, DimMgt.GetDimCombErr);
    end;

    local procedure CheckDimValuePosting(var PettyCashLine2: Record "Petty Cash Line")
    var
        ThePettyCashLine: Record "Petty Cash Line";
        TableIDArr: array[10] of Integer;
        NumberArr: array[10] of Code[20];
    begin
        if PettyCashLine2."Line No." = 0 then begin
            TableIDArr[1] := Database::Vendor;
            NumberArr[1] := PettyCashHeader."Petty Cash Vendor No.";
            /*if not DimMgt.CheckDocDimValuePosting(TempDocDim, TableIDArr, NumberArr) then
                Error(
                  Text034,
                  PettyCashHeader."No.", DimMgt.GetDimValuePostingErr);*/ //SAG
            if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, PettyCashHeader."Dimension Set ID") then
                Error(
                  Text034,
                  PettyCashHeader."No.", DimMgt.GetDimValuePostingErr);//SAG
        end else begin
            TableIDArr[1] := DimMgt.TypeToTableID3(PettyCashLine2.Type);
            NumberArr[1] := PettyCashLine2."No.";
            /*if not DimMgt.CheckDocDimValuePosting(TempDocDim, TableIDArr, NumberArr) then
                Error(
                  Text035,
                  PettyCashHeader."No.", PettyCashLine2."Line No.", DimMgt.GetDimValuePostingErr);*///SAG
            if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, PettyCashLine2."Dimension Set ID") then
                Error(
                  Text035,
                  PettyCashHeader."No.", PettyCashLine2."Line No.", DimMgt.GetDimValuePostingErr);//SAG
        end;
    end;


    procedure CheckPostAndPrint(_PostAndPrint: Boolean)
    begin
        PostAndPrint := _PostAndPrint;
    end;

    procedure CopyAllAddressID(FromTableNo: Integer; FromTableKey: Text[1024]; ToTableNo: Integer; ToTableKey: Text[1024])
    var
        FromAddressID: Record "Address ID";
        ToAddressID: Record "Address ID";
    begin
        FromAddressID.SetRange("Table No.", FromTableNo);
        FromAddressID.SetRange("Table Key", FromTableKey);
        ToAddressID.SetRange("Table No.", ToTableNo);
        ToAddressID.SetRange("Table Key", ToTableKey);
        ToAddressID.DeleteAll();
        if FromAddressID.Find('-') then
            repeat
                ToAddressID.Init();
                ToAddressID := FromAddressID;
                ToAddressID."Table No." := ToTableNo;
                ToAddressID."Table Key" := ToTableKey;
                ToAddressID.Insert();
            until FromAddressID.Next = 0;
    end;

}

