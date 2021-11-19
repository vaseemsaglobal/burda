Codeunit 55050 "Cash Advance - Post"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   -Cash Advance
    // Burda
    // 002   14.08.2007   KKE   -Average VAT

    Permissions = TableData "G/L Register" = rm;
    TableNo = "Cash Advance Header";

    trigger OnRun()
    var
        TotalCashAdvLine: Record "Cash Advance Line";
        //TempJnlLineDim: Record "Journal Line Dimension" temporary;
        CashAdvHdr: Record "Cash Advance Header";
        SettleCashAdvHdr: Record "Settle Cash Advance Header";
        SettleCashAdvLine: Record "Settle Cash Advance Line";
        EntryNo: Integer;
        LineNo: Integer;
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
        if not UserSetup."Allow Post Cash Adv. Invoice" then
            Error(Text000);

        CashAdvanceSetup.Get;
        CashAdvanceSetup.TestField("Settle Cash Advance Nos.");

        CashAdvHeader.Copy(Rec);
        with CashAdvHeader do begin
            TestField("Cash Advance Vendor No.");
            TestField("Posting Date");
            TestField("Document Date");
            if GenJnlCheckLine.DateNotAllowed("Posting Date") then
                FieldError("Posting Date", Text004);
            GetGLSetup;

            CashAdvLine.Reset;
            CashAdvLine.SetRange("Document No.", "No.");
            CashAdvLine.CalcSums("Amount (LCY) Incl. VAT");
            if CashAdvLine."Amount (LCY) Incl. VAT" = 0 then
                Error(Text002);

            //CopyAndCheckDocDimToTempDocDim; //VAH

            Vend.Get("Cash Advance Vendor No.");
            Vend.CheckBlockedVendOnDocs(Vend, true);

            VendPostingGroup.Get(Vend."Vendor Posting Group");
            Vend.CheckVendorCashAdvance;

            if RECORDLEVELLOCKING then begin
                //DocDim.LockTable; //SAG
                CashAdvLine.LockTable;
                GLEntry.LockTable;
                if GLEntry.Find('+') then;
            end;

            SourceCodeSetup.Get;
            SourceCodeSetup.TestField("Cash Advance");
            SrcCode := SourceCodeSetup."Cash Advance";

            if GuiAllowed then
                Window.Open(
                  '#1#################################\\' +
                  Text005 +
                  Text006 +
                  Text007 +
                  Text008);

            // Insert cash advance invoice header
            CashAdvInvHeader.Init;
            CashAdvInvHeader.TransferFields(CashAdvHeader);
            if GuiAllowed then
                Window.Update(1, StrSubstNo(Text009, "No.", CashAdvInvHeader."No."));
            CashAdvInvHeader."Source Code" := SrcCode;
            CashAdvInvHeader."User ID" := UserId;
            CashAdvInvHeader.Insert;
            /*DimMgt.MoveOneDocDimToPostedDocDim(
              DocDim,Database::"Cash Advance Header",DocDim."document type"::Invoice,"No.",0,
              Database::"Cash Advance Invoice Header",CashAdvInvHeader."No.");*/ //SAG
            CashAdvInvHeader."Dimension Set ID" := CashAdvHeader."Dimension Set ID";//SAG
            CopyCommentLines(
              CashAdvCmtLine."document type"::Invoice, CashAdvCmtLine."document type"::"Posted Invoice",
                "No.", CashAdvInvHeader."No.");
            /*PostCodeCheck.CopyAllAddressID(
              Database::"Cash Advance Header", GetPosition,
              Database::"Cash Advance Invoice Header", CashAdvInvHeader.GetPosition); */ //SAG
            CopyAllAddressID(
            Database::"Cash Advance Header", GetPosition,
            Database::"Cash Advance Invoice Header", CashAdvInvHeader.GetPosition);//SAG

            // Lines
            TotalCashAdvLine.Init;

            CashAdvLine.Reset;
            CashAdvLine.SetRange("Document No.", "No.");
            LineCount := 0;

            if CashAdvLine.Find('-') then
                repeat
                    LineCount := LineCount + 1;
                    if GuiAllowed then
                        Window.Update(2, LineCount);

                    /*TempDocDim.SetRange("Table ID", Database::"Cash Advance Line");
                    TempDocDim.SetRange("Line No.", CashAdvLine."Line No.");
                    UpdateTempDimBuf(EntryNo);*/ //SAG

                    if CashAdvLine."Amount Incl. VAT" <> 0 then begin
                        CashAdvLine.TestField("No.");
                        CashAdvLine.TestField(Type, CashAdvLine.Type::"G/L Account");
                        CashAdvLine.TestField("Gen. Bus. Posting Group");
                        CashAdvLine.TestField("Gen. Prod. Posting Group");
                    end else
                        CashAdvLine.TestField(Type, 0);

                    // Insert invoice line or credit memo line
                    CashAdvInvLine.Init;
                    CashAdvInvLine.TransferFields(CashAdvLine);
                    CashAdvInvLine.Insert;
                    /*DimMgt.MoveOneDocDimToPostedDocDim(
                      DocDim, Database::"Cash Advance Line", DocDim."document type"::Invoice, "No.", CashAdvLine."Line No.",
                      Database::"Cash Advance Invoice Line", CashAdvInvHeader."No.");*/ //SAG

                    CashAdvLine."Dimension Set ID" := CashAdvInvLine."Dimension Set ID";//SAG

                    // Post cash advance and VAT to G/L entries from buffer
                    if GuiAllowed then
                        Window.Update(3, LineCount);
                    GenJnlLine.Init;
                    GenJnlLine."Posting Date" := "Posting Date";
                    GenJnlLine."Document Date" := "Document Date";
                    GenJnlLine.Description := CashAdvLine.Description;
                    GenJnlLine."Document Type" := GenJnlLine."document type"::Invoice;
                    GenJnlLine."Document No." := "No.";
                    GenJnlLine."External Document No." := CashAdvLine."External Document No.";
                    GenJnlLine."Account No." := CashAdvLine."No.";
                    GenJnlLine."System-Created Entry" := true;

                    //KKE : #002 +
                    if CashAdvLine."VAT Claim %" <> 0 then begin
                        GenJnlLine."Use Average VAT" := true;
                        GenJnlLine."Average VAT Year" := CashAdvLine."Average VAT Year";
                        GenJnlLine."VAT Claim %" := CashAdvLine."VAT Claim %";
                        GenJnlLine.Amount := CashAdvLine."Amount Incl. VAT" - CashAdvLine."Avg. VAT Amount";
                        GenJnlLine."VAT Base Amount" := CashAdvLine."Amount Incl. VAT" - CashAdvLine."Avg. VAT Amount";
                        GenJnlLine."VAT Base (ACY)" := CashAdvLine."Amount Incl. VAT" - CashAdvLine."Avg. VAT Amount";
                        GenJnlLine."VAT Amount" := CashAdvLine."Avg. VAT Amount";
                        GenJnlLine."VAT Amount (ACY)" := CashAdvLine."Avg. VAT Amount";
                        GenJnlLine."VAT Difference" := CashAdvLine."VAT Difference";
                        GenJnlLine."VAT Difference (ACY)" := CashAdvLine."VAT Difference";
                        GenJnlLine."Amount Including VAT (ACY)" := CashAdvLine."Amount (LCY) Incl. VAT";
                    end else begin
                        //KKE : #002 -
                        GenJnlLine.Amount := CashAdvLine."VAT Base Amount (LCY)";
                        GenJnlLine."VAT Base Amount" := CashAdvLine."VAT Base Amount (LCY)";
                        GenJnlLine."VAT Base (ACY)" := CashAdvLine."VAT Base Amount (LCY)";
                        GenJnlLine."VAT Amount" := CashAdvLine."VAT Amount (LCY)";
                        GenJnlLine."VAT Amount (ACY)" := CashAdvLine."VAT Amount (LCY)";
                        GenJnlLine."VAT Difference" := CashAdvLine."VAT Difference";
                        GenJnlLine."VAT Difference (ACY)" := CashAdvLine."VAT Difference";
                        GenJnlLine."Amount Including VAT (ACY)" := CashAdvLine."Amount (LCY) Incl. VAT";
                    end;

                    GenJnlLine."Source Currency Code" := "Currency Code";
                    GenJnlLine."Source Currency Amount" := CashAdvLine."Amount Incl. VAT";
                    //GenJnlLine.Correction := Correction;
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::Purchase;
                    GenJnlLine."Gen. Bus. Posting Group" := CashAdvLine."Gen. Bus. Posting Group";
                    GenJnlLine."Gen. Prod. Posting Group" := CashAdvLine."Gen. Prod. Posting Group";
                    GenJnlLine."VAT Bus. Posting Group" := CashAdvLine."VAT Bus. Posting Group";
                    GenJnlLine."VAT Prod. Posting Group" := CashAdvLine."VAT Prod. Posting Group";
                    GenJnlLine.VATLineNo := CashAdvLine."Line No.";
                    GenJnlLine."VAT Calculation Type" := CashAdvLine."VAT Calculation Type";
                    //GenJnlLine."VAT Base Discount %" := "VAT Base Discount %";
                    GenJnlLine."Source Curr. VAT Base Amount" := CashAdvLine."VAT Base Amount (LCY)";
                    GenJnlLine."Source Curr. VAT Amount" := CashAdvLine."VAT Amount (LCY)";
                    GenJnlLine."VAT Posting" := GenJnlLine."vat posting"::"Manual VAT Entry";
                    GenJnlLine."Shortcut Dimension 1 Code" := CashAdvLine."Shortcut Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := CashAdvLine."Shortcut Dimension 2 Code";
                    GenJnlLine."Dimension Set ID" := CashAdvLine."Dimension Set ID";//VAH
                    GenJnlLine."Source Code" := SrcCode;
                    GenJnlLine."Sell-to/Buy-from No." := "Cash Advance Vendor No.";
                    GenJnlLine."Bill-to/Pay-to No." := "Cash Advance Vendor No.";
                    GenJnlLine."Source Type" := GenJnlLine."source type"::Vendor;
                    GenJnlLine."Source No." := "Cash Advance Vendor No.";
                    GenJnlLine."Posting No. Series" := "No. Series";
                    if CashAdvLine."Tax Invoice No." <> '' then
                        GenJnlLine."Tax Invoice No." := CashAdvLine."Tax Invoice No."
                    else
                        GenJnlLine."Tax Invoice No." := CashAdvLine."External Document No.";
                    GenJnlLine."Tax Invoice Date" := CashAdvLine."Tax Invoice Date";
                    GenJnlLine."Real Customer/Vendor Name" := CashAdvLine."Real Customer/Vendor Name";
                    /*
                    IF "Invoice Description" <> '' THEN
                      GenJnlLine.Description := COPYSTR("Invoice Description",1,50);
                    */
                    GenJnlLine.Description := CashAdvLine.Description;  //Burda 12.10.2007

                    RunGenJnlPostLine(GenJnlLine, EntryNo);

                    // Sumtotal
                    TotalCashAdvLine."Amount Incl. VAT" += CashAdvLine."Amount Incl. VAT";
                    TotalCashAdvLine."Amount (LCY) Incl. VAT" += CashAdvLine."Amount (LCY) Incl. VAT";
                    TotalCashAdvLine."VAT Amount" += CashAdvLine."VAT Amount";
                    TotalCashAdvLine."VAT Amount (LCY)" += CashAdvLine."VAT Amount (LCY)";
                    TotalCashAdvLine."VAT Base Amount" += CashAdvLine."VAT Base Amount";
                    TotalCashAdvLine."VAT Base Amount (LCY)" += CashAdvLine."VAT Base Amount (LCY)";
                until CashAdvLine.Next = 0;

            // Post vendor entries
            if GuiAllowed then
                Window.Update(4, 1);
            GenJnlLine.Init;
            GenJnlLine."Posting Date" := "Posting Date";
            GenJnlLine."Document Date" := "Document Date";
            GenJnlLine.Description := 'Cash Advance ' + "No.";
            GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            //GenJnlLine."Reason Code" := "Reason Code";
            GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
            GenJnlLine."Account No." := "Cash Advance Vendor No.";
            GenJnlLine."Document Type" := GenJnlLine."document type"::Invoice;
            GenJnlLine."Document No." := "No.";
            GenJnlLine."External Document No." := CashAdvLine."External Document No.";
            GenJnlLine."Currency Code" := "Currency Code";
            GenJnlLine.Amount := -TotalCashAdvLine."Amount Incl. VAT";
            GenJnlLine."Amount (LCY)" := -TotalCashAdvLine."Amount (LCY) Incl. VAT";
            //GenJnlLine."Vendor Exchange Rate (ACY)":="Vendor Exchange Rate (ACY)";
            GenJnlLine."Amount Including VAT (ACY)" := -TotalCashAdvLine."Amount (LCY) Incl. VAT";
            GenJnlLine."Source Currency Code" := "Currency Code";
            GenJnlLine."Source Currency Amount" := -TotalCashAdvLine."Amount Incl. VAT";
            if CashAdvHeader."Currency Code" = '' then
                GenJnlLine."Currency Factor" := 1
            else
                GenJnlLine."Currency Factor" := CashAdvHeader."Currency Factor";
            //GenJnlLine."Sales/Purch. (LCY)" := -TotalCashAdvLine.Amount;
            //GenJnlLine.Correction := Correction;
            //GenJnlLine."Inv. Discount (LCY)" := -TotalPurchLineLCY."Inv. Discount Amount";
            GenJnlLine."Sell-to/Buy-from No." := "Cash Advance Vendor No.";
            GenJnlLine."Bill-to/Pay-to No." := "Cash Advance Vendor No.";
            //GenJnlLine."Salespers./Purch. Code" := "Purchaser Code";
            GenJnlLine."System-Created Entry" := true;
            //GenJnlLine."On Hold" := "On Hold";
            GenJnlLine."Allow Application" := true;
            //GenJnlLine."Due Date" := "Due Date";
            //GenJnlLine."Payment Terms Code" := "Payment Terms Code";
            //GenJnlLine."Pmt. Discount Date" := "Pmt. Discount Date";
            //GenJnlLine."Payment Discount %" := "Payment Discount %";
            GenJnlLine."Source Type" := GenJnlLine."source type"::Vendor;
            GenJnlLine."Source No." := "Cash Advance Vendor No.";
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
                //NeedPrint := WHTManagement.InsertVendPayWHTCashAdv(CashAdvHeader, GenJnlLine);//VAH
                NeedPrint := WHTManagementExt.InsertVendPayWHTCashAdv(CashAdvHeader, GenJnlLine);//VAH
                GenJnlLine2.Reset;
                GenJnlLine2.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                GenJnlLine2.SetRange("Is WHT", true);
                if GenJnlLine2.Find('-') then
                    repeat
                        TotalWHTAmount := TotalWHTAmount + GenJnlLine2.Amount;
                        TotalWHTAmountLCY := TotalWHTAmountLCY + GenJnlLine2."Amount (LCY)";
                    until GenJnlLine2.Next = 0;
                GenJnlLine.Amount := -TotalCashAdvLine."Amount Incl. VAT" - TotalWHTAmount;
                GenJnlLine."Amount (LCY)" := -TotalCashAdvLine."Amount (LCY) Incl. VAT" - TotalWHTAmountLCY;
                GenJnlLine."Amount Including VAT (ACY)" := -TotalCashAdvLine."Amount (LCY) Incl. VAT" - TotalWHTAmountLCY;
            end;

            /*
            //set applied to doc no.
            VendLedgEntry.GET("Cash Advance Payment Entry No.");
            GenJnlLine."Applies-to Doc. Type" := VendLedgEntry."Document Type";
            GenJnlLine."Applies-to Doc. No." := VendLedgEntry."Document No.";
            */
            /*TempJnlLineDim.DeleteAll;
            TempDocDim.Reset;
            TempDocDim.SetRange("Table ID", Database::"Cash Advance Header");
            DimMgt.CopyDocDimToJnlLineDim(TempDocDim, TempJnlLineDim);*/// SAG
            GenJnlLine."Dimension Set ID" := "Dimension Set ID";//SAG
            //GenJnlPostLine.RunWithCheck(GenJnlLine, TempJnlLineDim);//SAG
            GenJnlPostLine.RunWithCheck(GenJnlLine);//SAG
            // WHT account
            GLSetup.Get;
            if GLSetup."Enable WHT" then begin
                //NeedPrint := WHTManagement.InsertVendPayWHTCashAdv(CashAdvHeader,GenJnlLine);
                WHTEntry.Reset;
                WHTEntry.SetRange("Document Type", WHTEntry."document type"::Payment);
                WHTEntry.SetRange("Document No.", CashAdvHeader."No.");
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
                            //WHTManagement.PrintWHTSlips(GLReg); //VAH
                            WHTManagementExt.PrintWHTSlips(GLReg, false); //VAH
                        end;
                end;
            end;

            //Post and Print - Print Purchase Voucher
            if PostAndPrint then begin
                CashAdvHdr.Reset;
                CashAdvHdr.SetRange("No.", "No.");
                Report.Run(Report::"Purchase Voucher -Cash Advance", false, false, CashAdvHdr);
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
                CashAdvLine.LockTable(true, true);
            end;

            //transfer to settlement
            /*
            CALCFIELDS("Balance Amount Settle");
            IF "Balance Amount Settle" <> "Cash Advance Amount" THEN BEGIN
              VendLedgEntry.RESET;
              IF "Balance Amount Settle" < "Cash Advance Amount" THEN
                VendLedgEntry.SETRANGE("Entry No.","Cash Advance Payment Entry No.")
              ELSE BEGIN
                VendLedgEntry.SETRANGE("Document Type",VendLedgEntry."Document Type"::Invoice);
                VendLedgEntry.SETRANGE("Document No.","No.");
                VendLedgEntry.SETRANGE("Posting Date","Posting Date");
              END;

              IF VendLedgEntry.FIND('-') THEN BEGIN
                SettleCashAdvHdr.INIT;
                SettleCashAdvHdr."No." := NoSeriesMgt.GetNextNo(CashAdvanceSetup."Settle Cash Advance Nos.",WORKDATE,TRUE);
                SettleCashAdvHdr.INSERT(TRUE);
                SettleCashAdvHdr."Cash Advance Vendor No." := "Cash Advance Vendor No.";
                SettleCashAdvHdr."Cash Advance Name" := Name;
                SettleCashAdvHdr.MODIFY;

                LineNo := 0;
                REPEAT
                  LineNo += 10000;
                  SettleCashAdvLine.INIT;
                  SettleCashAdvLine."Settle Cash Advance No." := SettleCashAdvHdr."No.";
                  SettleCashAdvLine."Line No." := LineNo;
                  SettleCashAdvLine."Cash Advance Vendor No." := "Cash Advance Vendor No.";
                  SettleCashAdvLine.VALIDATE("Entry No.",VendLedgEntry."Entry No.");
                  SettleCashAdvLine.INSERT;
                UNTIL VendLedgEntry.NEXT=0;

                CashAdvInvHeader.GET("No.");
                CashAdvInvHeader.Status := CashAdvInvHeader.Status::Transferred;
                CashAdvInvHeader.MODIFY;
              END;
            END;
            */
            /*DocDim.Reset;
            DocDim.SetRange("Table ID", Database::"Cash Advance Header");
            DocDim.SetRange("Document Type", DocDim."document type"::Invoice);
            DocDim.SetRange("Document No.", "No.");
            DocDim.DeleteAll;
            DocDim.SetRange("Table ID", Database::"Cash Advance Line");
            DocDim.DeleteAll;*/ //SAG

            Delete;

            CashAdvLine.DeleteAll;

            CashAdvCmtLine.SetRange("Document Type", CashAdvCmtLine."document type"::Invoice);
            CashAdvCmtLine.SetRange("No.", "No.");
            CashAdvCmtLine.DeleteAll;

            Commit;

            Clear(WHTManagement);
            Clear(GenJnlPostLine);
            if GuiAllowed then
                Window.Close;
        end;

    end;

    var
        GLSetup: Record "General Ledger Setup";
        CashAdvHeader: Record "Cash Advance Header";
        CashAdvLine: Record "Cash Advance Line";
        CashAdvInvHeader: Record "Cash Advance Invoice Header";
        CashAdvInvLine: Record "Cash Advance Invoice Line";
        CashAdvCmtLine: Record "Cash Advance Comment Line";
        CashAdvanceSetup: Record "Cash Advance Setup";
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
        SrcCode: Code[10];
        Text000: label 'You do not have permission to post cash advance invoice.';
        Text001: label 'Do you want to post the cash advance invoice?';
        Text002: label 'There is nothing to post.';
        Text003: label 'The cash advance invoice was successfully posted.';
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
        WHTManagementExt: Codeunit Cu28040Ext;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GLSetup.Get;
        GLSetupRead := true;
    end;

    local procedure CopyCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        CashAdvCmtLine2: Record "Cash Advance Comment Line";
    begin
        CashAdvCmtLine.SetRange("Document Type", FromDocumentType);
        CashAdvCmtLine.SetRange("No.", FromNumber);
        if CashAdvCmtLine.Find('-') then
            repeat
                CashAdvCmtLine2 := CashAdvCmtLine;
                CashAdvCmtLine2."Document Type" := ToDocumentType;
                CashAdvCmtLine2."No." := ToNumber;
                CashAdvCmtLine2.Insert;
            until CashAdvCmtLine.Next = 0;
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
        GenJnlPostLine.RunWithCheck(GenJnlLine, TempJnlLineDim);*/ //SAG
        GenJnlPostLine.RunWithCheck(GenJnlLine);//SAG
    end;

    local procedure CopyAndCheckDocDimToTempDocDim()
    var
        CashAdvLine2: Record "Cash Advance Line";
    begin
        /*TempDocDim.Reset;
        TempDocDim.DeleteAll;
        DocDim.SetFilter("Table ID", '%1|%2', Database::"Cash Advance Header", Database::"Cash Advance Line");
        DocDim.SetRange("Document Type", DocDim."document type"::Invoice);
        DocDim.SetRange("Document No.", CashAdvHeader."No.");
        if DocDim.Find('-') then begin
            repeat
                TempDocDim.Init;
                TempDocDim := DocDim;
                TempDocDim.Insert;
            until DocDim.Next = 0;
            TempDocDim.SetRange("Line No.", 0);
            CheckDimComb(0);
        end;*/ //SAG
        CashAdvLine2."Line No." := 0;
        CheckDimValuePosting(CashAdvLine2);

        CashAdvLine2.SetRange("Document No.", CashAdvHeader."No.");
        CashAdvLine2.SetFilter(Type, '<>%1', CashAdvLine2.Type::" ");
        if CashAdvLine2.Find('-') then
            repeat
                //TempDocDim.SetRange("Line No.", CashAdvLine2."Line No."); //SAG
                CheckDimComb(CashAdvLine2."Line No.");
                CheckDimValuePosting(CashAdvLine2);
            until CashAdvLine2.Next = 0;
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
            until TempDocDim.Next = 0;*/ //SAG
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
                  CashAdvHeader."No.", DimMgt.GetDimCombErr)
            else
                Error(
                  Text033,
                  CashAdvHeader."No.", LineNo, DimMgt.GetDimCombErr);*/ //SAG

        if not DimMgt.CheckDimIDComb(LineNo) then
            if LineNo = 0 then
                Error(
                  Text032,
                  CashAdvHeader."No.", DimMgt.GetDimCombErr)
            else
                Error(
                  Text033,
                  CashAdvHeader."No.", LineNo, DimMgt.GetDimCombErr); //SAG
    end;

    local procedure CheckDimValuePosting(var CashAdvLine2: Record "Cash Advance Line")
    var
        TheCashAdvLine: Record "Cash Advance Line";
        TableIDArr: array[10] of Integer;
        NumberArr: array[10] of Code[20];
    begin
        if CashAdvLine2."Line No." = 0 then begin
            TableIDArr[1] := Database::Vendor;
            NumberArr[1] := CashAdvHeader."Cash Advance Vendor No.";
            /*if not DimMgt.CheckDocDimValuePosting(TempDocDim, TableIDArr, NumberArr) then
                Error(
                  Text034,
                  CashAdvHeader."No.", DimMgt.GetDimValuePostingErr);*///SAG
            if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, CashAdvHeader."Dimension Set ID") then
                Error(
                  Text034,
                  CashAdvHeader."No.", DimMgt.GetDimValuePostingErr); //SAG
        end else begin
            TableIDArr[1] := DimMgt.TypeToTableID3(CashAdvLine2.Type);
            NumberArr[1] := CashAdvLine2."No.";
            /*if not DimMgt.CheckDocDimValuePosting(TempDocDim, TableIDArr, NumberArr) then
                Error(
                  Text035,
                  CashAdvHeader."No.", CashAdvLine2."Line No.", DimMgt.GetDimValuePostingErr);*/
            if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, CashAdvHeader."Dimension Set ID") then
                Error(
                  Text035,
                  CashAdvHeader."No.", CashAdvLine2."Line No.", DimMgt.GetDimValuePostingErr);//SAG
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

