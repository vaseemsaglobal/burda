Codeunit 55001 "Settle Petty Cash - Post"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   22.08.2006   KKE   -Petty Cash

    Permissions = TableData "Vendor Ledger Entry" = rm;
    TableNo = "Settle Petty Cash Header";

    trigger OnRun()
    var
        TotalPettyCashLine: Record "Petty Cash Line";
        //TempJnlLineDim: Record "Journal Line Dimension" temporary;
        SettlePettyCashHdr: Record "Settle Petty Cash Header";
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

        SettlePettyCashHeader.Copy(Rec);
        with SettlePettyCashHeader do begin
            TestField("Petty Cash Vendor No.");
            TestField("Posting Date");
            TestField("Settle Account No.");
            if GenJnlCheckLine.DateNotAllowed("Posting Date") then
                FieldError("Posting Date", Text004);
            GetGLSetup;

            CalcFields("Balance Settle");
            if "Balance Settle" = 0 then
                Error(Text002);

            Vend.Get("Petty Cash Vendor No.");
            Vend.CheckBlockedVendOnDocs(Vend, true);
            VendPostingGroup.Get(Vend."Vendor Posting Group");

            SourceCodeSetup.Get;
            SourceCodeSetup.TestField("Petty Cash");
            SrcCode := SourceCodeSetup."Petty Cash";

            if RECORDLEVELLOCKING then begin
                SettlePettyCashLine.LockTable;
                GLEntry.LockTable;
                if GLEntry.Find('+') then;
            end;

            if GuiAllowed then
                Window.Open(
                  '#1#################################\\' +
                  Text005 +
                  Text006);

            if GuiAllowed then
                Window.Update(1, StrSubstNo(Text009, "No.", SettlePettyCashHeader."No."));

            //Post apply vendor ledger entries
            VendLedgEntry.Reset;
            VendLedgEntry.SetRange("Vendor No.", "Petty Cash Vendor No.");
            VendLedgEntry.SetRange("Document Type", VendLedgEntry."document type"::Payment);
            VendLedgEntry.SetRange(Open, true);
            VendLedgEntry.SetFilter("Posting Date", '..%1', "Posting Date");
            if VendLedgEntry.Find('-') then begin
                if not PaymentToleranceMgt.PmtTolVend(VendLedgEntry) then begin
                    if GuiAllowed then
                        Window.Close;
                    exit;
                end;

                if GuiAllowed then
                    Window.Update(2, 1);

                ApplicationDate := 0D;
                EntriesToApply.SetCurrentkey("Vendor No.", "Applies-to ID");
                EntriesToApply.SetRange("Vendor No.", VendLedgEntry."Vendor No.");
                EntriesToApply.SetRange("Applies-to ID", VendLedgEntry."Applies-to ID");
                EntriesToApply.Find('-');
                repeat
                    if EntriesToApply."Posting Date" > ApplicationDate then
                        ApplicationDate := EntriesToApply."Posting Date";
                    case EntriesToApply."Document Type" of
                        EntriesToApply."document type"::Invoice:
                            InvoiceNo := EntriesToApply."Document No.";
                        EntriesToApply."document type"::"Credit Memo":
                            CreditMemoNo := EntriesToApply."Document No.";
                    end;
                until EntriesToApply.Next = 0;

                /*--
                PostApplication.SetValues("Document No.",ApplicationDate);
                PostApplication.LOOKUPMODE(TRUE);
                IF ACTION::LookupOK = PostApplication.RUNMODAL THEN BEGIN
                  GenJnlLine.INIT;
                  PostApplication.GetValues(GenJnlLine."Document No.",GenJnlLine."Posting Date");
                  IF GenJnlLine."Posting Date" < ApplicationDate THEN
                    ERROR(
                      Text003,
                      GenJnlLine.FIELDCAPTION("Posting Date"),FIELDCAPTION("Posting Date"),TABLECAPTION);
                END ELSE
                  EXIT;
                ---*/

                GenJnlLine.Init;
                GenJnlLine."Posting Date" := ApplicationDate;
                GenJnlLine."Document No." := VendLedgEntry."Document No.";
                GenJnlLine."Document Date" := ApplicationDate;
                GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
                GenJnlLine."Account No." := VendLedgEntry."Vendor No.";
                VendLedgEntry.CalcFields("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
                GenJnlLine.Correction :=
                  (VendLedgEntry."Debit Amount" < 0) or (VendLedgEntry."Credit Amount" < 0) or
                  (VendLedgEntry."Debit Amount (LCY)" < 0) or (VendLedgEntry."Credit Amount (LCY)" < 0);
                GenJnlLine."Document Type" := VendLedgEntry."Document Type";
                GenJnlLine.Description := VendLedgEntry.Description;
                GenJnlLine."Shortcut Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
                GenJnlLine."Posting Group" := VendLedgEntry."Vendor Posting Group";
                GenJnlLine."Source Type" := GenJnlLine."source type"::Vendor;
                GenJnlLine."Source No." := VendLedgEntry."Vendor No.";
                GenJnlLine."Source Code" := SrcCode;
                GenJnlLine."System-Created Entry" := true;

                GenJnlPostLine.VendPostApplyVendLedgEntry(GenJnlLine, VendLedgEntry);

                EntriesToApply.ModifyAll("Applies-to ID", '');
            end;

            // Insert archived settle petty cash
            /*
            PettyCashInvHeader.INIT;
            PettyCashInvHeader.TRANSFERFIELDS(PettyCashHeader);
            IF GUIALLOWED THEN
              Window.UPDATE(1,STRSUBSTNO(Text009,"No.",PettyCashInvHeader."No."));
            PettyCashInvHeader."Source Code" := SrcCode;
            PettyCashInvHeader."User ID" := USERID;
            PettyCashInvHeader.INSERT;
            CopyCommentLines(
              PettyCashCmtLine."Document Type"::Invoice,PettyCashCmtLine."Document Type"::"Posted Invoice",
                "No.",PettyCashInvHeader."No.");
            */

            // Post vendor entries
            if GuiAllowed then
                Window.Update(3, 1);
            GenJnlLine.Init;
            GenJnlLine."Posting Date" := "Posting Date";
            GenJnlLine."Document Date" := "Document Date";
            GenJnlLine.Description := 'Petty Cash ' + "No.";
            //  GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            //  GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
            GenJnlLine."Account No." := "Petty Cash Vendor No.";
            GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
            if "Cheque Printed" and ("Cheque No." <> '') then begin
                GenJnlLine."Document No." := "Cheque No.";
                GenJnlLine."External Document No." := "No.";
                GenJnlLine."Check Printed" := true;
                GenJnlLine."Bank Payment Type" := "Bank Payment Type";
            end else
                GenJnlLine."Document No." := "No.";
            GenJnlLine."Currency Code" := "Currency Code";
            GenJnlLine.Amount := -"Balance Settle";
            GenJnlLine."Amount (LCY)" := -"Balance Settle";
            GenJnlLine."Amount Including VAT (ACY)" := -"Balance Settle";
            GenJnlLine."Source Currency Code" := "Currency Code";
            GenJnlLine."Source Currency Amount" := -"Balance Settle";
            if SettlePettyCashHeader."Currency Code" = '' then
                GenJnlLine."Currency Factor" := 1
            else
                GenJnlLine."Currency Factor" := SettlePettyCashHeader."Currency Factor";
            GenJnlLine."Sell-to/Buy-from No." := "Petty Cash Vendor No.";
            GenJnlLine."Bill-to/Pay-to No." := "Petty Cash Vendor No.";
            GenJnlLine."System-Created Entry" := true;
            GenJnlLine."Allow Application" := true;
            GenJnlLine."Source Type" := GenJnlLine."source type"::Vendor;
            GenJnlLine."Source No." := "Petty Cash Vendor No.";
            GenJnlLine."Source Code" := SrcCode;
            GenJnlLine."Posting No. Series" := "No. Series";
            if "Payment Invoice Description" <> '' then
                GenJnlLine.Description := CopyStr("Payment Invoice Description", 1, 50);

            GenJnlLine."Bal. Account Type" := "Settle Account Type";
            GenJnlLine."Bal. Account No." := "Settle Account No.";

            /*TempJnlLineDim.DeleteAll;
            TempDocDim.Reset;
            TempDocDim.SetRange("Table ID",Database::"Settle Petty Cash Header");
            DimMgt.CopyDocDimToJnlLineDim(TempDocDim,TempJnlLineDim);
            GenJnlPostLine.RunWithCheck(GenJnlLine,TempJnlLineDim);*///SAG dimension not used
            GenJnlPostLine.RunWithCheck(GenJnlLine);//SAG

            //Post and Print - Print Purchase Voucher
            if PostAndPrint then begin
                SettlePettyCashHdr.Reset;
                SettlePettyCashHdr.SetRange("No.", "No.");
                Report.Run(Report::"Payment Voucher - Petty Cash", false, false, SettlePettyCashHdr);
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
                SettlePettyCashLine.LockTable(true, true);
            end;

            Delete;

            SettlePettyCashLine.DeleteAll;

            PettyCashCmtLine.SetRange("Document Type", PettyCashCmtLine."document type"::Invoice);
            PettyCashCmtLine.SetRange("No.", "No.");
            PettyCashCmtLine.DeleteAll;

            Commit;

            Clear(GenJnlPostLine);
            if GuiAllowed then
                Window.Close;
        end;

    end;

    var
        GLSetup: Record "General Ledger Setup";
        SettlePettyCashHeader: Record "Settle Petty Cash Header";
        SettlePettyCashLine: Record "Settle Petty Cash Line";
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
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        VendEntryApplyPostedEntries: Codeunit "VendEntry-Apply Posted Entries";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        PostCodeCheck: Codeunit "Post Code Check";
        DimMgt: Codeunit DimensionManagement;
        DimBufMgt: Codeunit "Dimension Buffer Management";
        SrcCode: Code[10];
        Text001: label 'Do you want to post settle petty cash?';
        Text002: label 'There is nothing to post.';
        Text003: label 'The settle petty cash was successfully posted.';
        Text004: label 'is not within your range of allowed posting dates';
        Text005: label 'Posting lines              #2######\';
        Window: Dialog;
        LineCount: Integer;
        GLSetupRead: Boolean;
        PostAndPrint: Boolean;
        NeedPrint: Boolean;
        TotalAmount: Decimal;
        TotalWHTAmount: Decimal;
        TotalWHTAmountLCY: Decimal;
        Text006: label 'Posting to vendors         #3######\';
        Text009: label '%1 -> settle petty cash %2';
        EntriesToApply: Record "Vendor Ledger Entry";
        ApplicationDate: Date;
        InvoiceNo: Code[20];
        CreditMemoNo: Code[20];

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
        GenJnlPostLine.RunWithCheck(GenJnlLine, TempJnlLineDim);*/ //SAg Dim not used
        GenJnlPostLine.RunWithCheck(GenJnlLine);//SAG
    end;


    procedure CheckPostAndPrint(_PostAndPrint: Boolean)
    begin
        PostAndPrint := _PostAndPrint;
    end;
}

