Codeunit 55051 "Settle Cash Advance - Post"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   -Cash Advance
    // RICHASIA
    // 002   22.01.2007   KKE   -Allow to post incase "Settle Account Type" = Vendor.

    TableNo = "Settle Cash Advance Header";

    trigger OnRun()
    var
        TotalCashAdvLine: Record "Cash Advance Line";
        //TempJnlLineDim: Record "Journal Line Dimension" temporary;
        SettleCashAdvHdr: Record "Settle Cash Advance Header";
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

        SettleCashAdvHeader.Copy(Rec);
        with SettleCashAdvHeader do begin
            TestField("Cash Advance Vendor No.");
            TestField("Posting Date");
            TestField("Settle Account No.");
            if GenJnlCheckLine.DateNotAllowed("Posting Date") then
                FieldError("Posting Date", Text004);
            GetGLSetup;

            CalcFields("Balance Settle");
            if "Balance Settle" = 0 then
                Error(Text002);

            Vend.Get("Cash Advance Vendor No.");
            Vend.CheckBlockedVendOnDocs(Vend, true);
            VendPostingGroup.Get(Vend."Vendor Posting Group");

            SourceCodeSetup.Get;
            SourceCodeSetup.TestField("Cash Advance");
            SrcCode := SourceCodeSetup."Cash Advance";

            if RECORDLEVELLOCKING then begin
                SettleCashAdvLine.LockTable;
                GLEntry.LockTable;
                if GLEntry.Find('+') then;
            end;

            if GuiAllowed then
                Window.Open(
                  '#1#################################\\' +
                  Text005 +
                  Text006);

            if GuiAllowed then
                Window.Update(1, StrSubstNo(Text009, "No.", SettleCashAdvHeader."No."));

            // Post vendor entries
            if GuiAllowed then
                Window.Update(3, 1);
            GenJnlLine.Init;
            GenJnlLine."Posting Date" := "Posting Date";
            GenJnlLine."Document Date" := "Document Date";
            GenJnlLine.Description := 'Cash Advance ' + "No.";
            //  GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            //  GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
            GenJnlLine."Account No." := "Cash Advance Vendor No.";
            if ("Balance Settle" < 0) and ("Settle Account Type" <> "settle account type"::Vendor) then  //KKE : #001
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
            if SettleCashAdvHeader."Currency Code" = '' then
                GenJnlLine."Currency Factor" := 1
            else
                GenJnlLine."Currency Factor" := "Currency Factor";
            GenJnlLine."Sell-to/Buy-from No." := "Cash Advance Vendor No.";
            GenJnlLine."Bill-to/Pay-to No." := "Cash Advance Vendor No.";
            GenJnlLine."System-Created Entry" := true;
            GenJnlLine."Allow Application" := true;
            GenJnlLine."Source Type" := GenJnlLine."source type"::Vendor;
            GenJnlLine."Source No." := "Cash Advance Vendor No.";
            GenJnlLine."Source Code" := SrcCode;
            GenJnlLine."Posting No. Series" := "No. Series";
            if "Payment Invoice Description" <> '' then
                GenJnlLine.Description := CopyStr("Payment Invoice Description", 1, 50);

            if "Settle Account Type" <> "settle account type"::Vendor then begin
                GenJnlLine."Bal. Account Type" := "Settle Account Type";
                GenJnlLine."Bal. Account No." := "Settle Account No.";
                GenJnlLine."Applies-to ID" := "No.";
            end;

            /*TempJnlLineDim.DeleteAll; //SAG
            TempDocDim.Reset;
            TempDocDim.SetRange("Table ID",Database::"Settle Cash Advance Header");
            DimMgt.CopyDocDimToJnlLineDim(TempDocDim,TempJnlLineDim);
            GenJnlPostLine.RunWithCheck(GenJnlLine,TempJnlLineDim);*/ //SAG Dimension Not used for this 
            GenJnlPostLine.RunWithCheck(GenJnlLine);//SAG

            if "Settle Account Type" = "settle account type"::Vendor then begin
                GenJnlLine.Init;
                GenJnlLine."Posting Date" := "Posting Date";
                GenJnlLine."Document Date" := "Document Date";
                GenJnlLine.Description := 'Cash Advance ' + "No.";
                //  GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                //  GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                GenJnlLine."Account Type" := "Settle Account Type";
                GenJnlLine."Account No." := "Settle Account No.";
                if "Cheque Printed" and ("Cheque No." <> '') then begin
                    GenJnlLine."Document No." := "Cheque No.";
                    GenJnlLine."External Document No." := "No.";
                    GenJnlLine."Check Printed" := true;
                    GenJnlLine."Bank Payment Type" := "Bank Payment Type";
                end else
                    GenJnlLine."Document No." := "No.";
                GenJnlLine."Currency Code" := "Currency Code";
                GenJnlLine.Amount := "Balance Settle";
                GenJnlLine."Amount (LCY)" := "Balance Settle";
                GenJnlLine."Amount Including VAT (ACY)" := -"Balance Settle";
                GenJnlLine."Source Currency Code" := "Currency Code";
                GenJnlLine."Source Currency Amount" := "Balance Settle";
                if SettleCashAdvHeader."Currency Code" = '' then
                    GenJnlLine."Currency Factor" := 1
                else
                    GenJnlLine."Currency Factor" := "Currency Factor";
                GenJnlLine."Sell-to/Buy-from No." := "Cash Advance Vendor No.";
                GenJnlLine."Bill-to/Pay-to No." := "Cash Advance Vendor No.";
                GenJnlLine."System-Created Entry" := true;
                GenJnlLine."Allow Application" := true;
                GenJnlLine."Source Type" := "Settle Account Type";
                GenJnlLine."Source No." := "Settle Account No.";
                GenJnlLine."Source Code" := SrcCode;
                GenJnlLine."Posting No. Series" := "No. Series";
                if "Payment Invoice Description" <> '' then
                    GenJnlLine.Description := CopyStr("Payment Invoice Description", 1, 50);
                /*TempJnlLineDim.DeleteAll;
                TempDocDim.Reset;
                TempDocDim.SetRange("Table ID", Database::"Settle Cash Advance Header");
                DimMgt.CopyDocDimToJnlLineDim(TempDocDim, TempJnlLineDim);
                GenJnlPostLine.RunWithCheck(GenJnlLine, TempJnlLineDim);*///SAG
                GenJnlPostLine.RunWithCheck(GenJnlLine);//SAG

            end;

            //Post and Print - Print Purchase Voucher
            if PostAndPrint then begin
                SettleCashAdvHdr.Reset;
                SettleCashAdvHdr.SetRange("No.", "No.");
                Report.Run(Report::"Payment Voucher - Cash Advance", false, false, SettleCashAdvHdr);
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
                SettleCashAdvLine.LockTable(true, true);
            end;

            Delete;

            SettleCashAdvLine.DeleteAll;

            CashAdvCmtLine.SetRange("Document Type", CashAdvCmtLine."document type"::Invoice);
            CashAdvCmtLine.SetRange("No.", "No.");
            CashAdvCmtLine.DeleteAll;

            Commit;

            Clear(GenJnlPostLine);
            if GuiAllowed then
                Window.Close;
        end;

    end;

    var
        GLSetup: Record "General Ledger Setup";
        SettleCashAdvHeader: Record "Settle Cash Advance Header";
        SettleCashAdvLine: Record "Settle Cash Advance Line";
        CashAdvCmtLine: Record "Cash Advance Comment Line";
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
        Text001: label 'Do you want to post settle cash advance?';
        Text002: label 'There is nothing to post.';
        Text003: label 'The settle cash advance was successfully posted.';
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
        Text009: label '%1 -> settle cash advance %2';
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
          GenJnlLine."Journal Batch Name", GenJnlLine."Line No.");*/// SAG Dim not used
        //GenJnlPostLine.RunWithCheck(GenJnlLine, TempJnlLineDim);
        GenJnlPostLine.RunWithCheck(GenJnlLine);//SAG
    end;


    procedure CheckPostAndPrint(_PostAndPrint: Boolean)
    begin
        PostAndPrint := _PostAndPrint;
    end;
}

