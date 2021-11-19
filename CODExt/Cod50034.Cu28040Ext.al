codeunit 50034 Cu28040Ext
{
    procedure PrintWHTSlips(var GLReg: Record "G/L Register"; ScheduleInJobQueue: Boolean)
    var
        GLEntry: Record "G/L Entry";
        WHTEntry: Record "WHT Entry";
        WHTEntry2: Record "WHT Entry";
        WHTSlipBuffer: Record "WHT Certificate Buffer";
        PurchSetup: Record "Purchases & Payables Setup";
        ReportSelection: Record "Report Selections";
        SalesSetup: Record "Sales & Receivables Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        BatchPostingPrintMgt: Codeunit "Batch Posting Print Mgt.";
        GLRegFilter: Text[250];
        StartTrans: Integer;
        EndTrans: Integer;
        x: Integer;
        PrintSlips: Integer;
        WHTSlipBuffer2: Code[20];
        WHTSlipDocument2: Code[20];
        VendorArray: array[1000] of Code[20];
        DocumentArray: array[1000] of Code[20];
        WHTSlipNo: Code[20];
        ActualVendorNo: Boolean;
    begin
        x := 0;
        GLRegFilter := GLReg.GetFilters;
        GLEntry.Reset();
        if GLReg."From Entry No." < 0 then
            GLEntry.SetRange("Entry No.", GLReg."To Entry No.", GLReg."From Entry No.")
        else
            GLEntry.SetRange("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
        GLEntry.FindFirst;
        StartTrans := GLEntry."Transaction No.";
        GLEntry.FindLast;
        EndTrans := GLEntry."Transaction No.";
        WHTEntry.Reset();
        WHTEntry.SetCurrentKey("Bill-to/Pay-to No.", "Original Document No.", "WHT Revenue Type");
        WHTEntry.SetRange("Transaction No.", StartTrans, EndTrans);
        if not WHTEntry.FindFirst then
            exit;
        repeat
            if WHTEntry."Transaction Type" = WHTEntry."Transaction Type"::Sale then begin
                if WHTEntry."Document Type" in [
                                                WHTEntry."Document Type"::Invoice,
                                                WHTEntry."Document Type"::Payment]
                then
                    exit;

                SalesSetup.Get();
                if not SalesSetup."Print WHT on Credit Memo" then
                    if WHTEntry."Document Type" = WHTEntry."Document Type"::"Credit Memo" then
                        exit;
            end;
            x := x + 1;
            if WHTEntry."Actual Vendor No." <> '' then begin
                VendorArray[x] := WHTEntry."Actual Vendor No.";
                ActualVendorNo := true;
            end else
                VendorArray[x] := WHTEntry."Bill-to/Pay-to No.";
            DocumentArray[x] := WHTEntry."Original Document No.";
        until WHTEntry.Next = 0;

        PurchSetup.Get();
        WHTSlipBuffer.DeleteAll();
        for PrintSlips := 1 to x do begin
            WHTSlipBuffer.Init();
            WHTSlipBuffer."Line No." := PrintSlips;
            WHTSlipBuffer."Vendor No." := VendorArray[PrintSlips];
            WHTSlipBuffer."Document No." := DocumentArray[PrintSlips];
            WHTSlipBuffer.Insert();
        end;

        x := 0;
        Clear(VendorArray);
        Clear(DocumentArray);
        WHTSlipBuffer.Reset();
        WHTSlipBuffer.SetCurrentKey("Vendor No.", "Document No.");
        WHTSlipBuffer.FindSet;
        repeat
            x := x + 1;
            VendorArray[x] := WHTSlipBuffer."Vendor No.";
            DocumentArray[x] := WHTSlipBuffer."Document No.";
        until WHTSlipBuffer.Next = 0;

        for PrintSlips := 1 to x do begin
            if (VendorArray[PrintSlips] <> WHTSlipBuffer2) or
               (DocumentArray[PrintSlips] <> WHTSlipDocument2)
            then begin
                WHTSlipNo :=
                  NoSeriesMgt.GetNextNo(
                    PurchSetup."WHT Certificate No. Series", WHTEntry."Posting Date", true);
                WHTEntry.Reset();
                WHTEntry.SetCurrentKey("Bill-to/Pay-to No.", "Original Document No.", "WHT Revenue Type");
                if ActualVendorNo then
                    WHTEntry.SetRange("Actual Vendor No.", VendorArray[PrintSlips])
                else
                    WHTEntry.SetRange("Bill-to/Pay-to No.", VendorArray[PrintSlips]);
                WHTEntry.SetRange("Original Document No.", DocumentArray[PrintSlips]);
                if WHTEntry.FindSet then
                    repeat
                        WHTRevenueTypes.Reset();
                        WHTRevenueTypes.SetRange(Code, WHTEntry."WHT Revenue Type");
                        WHTEntry2.Reset();
                        WHTEntry2 := WHTEntry;
                        if WHTRevenueTypes.FindFirst then begin
                            WHTEntry2."WHT Certificate No." := WHTSlipNo;
                            WHTEntry2.Modify();
                        end;
                    until WHTEntry.Next = 0;
                WHTEntry.Reset();
                WHTEntry.SetCurrentKey("Bill-to/Pay-to No.", "Original Document No.", "WHT Revenue Type");
                if ActualVendorNo then
                    WHTEntry.SetRange("Actual Vendor No.", VendorArray[PrintSlips])
                else
                    WHTEntry.SetRange("Bill-to/Pay-to No.", VendorArray[PrintSlips]);
                WHTEntry.SetRange("Original Document No.", DocumentArray[PrintSlips]);
                WHTEntry.SetRange("WHT Certificate No.", WHTSlipNo);
                if WHTEntry.FindSet then
                    ReportSelection.Reset();
                ReportSelection.SetRange(Usage, ReportSelection.Usage::"WHT Certificate");
                GeneralLedgerSetup.Get();
                if ReportSelection.FindSet then
                    repeat
                        if ScheduleInJobQueue then
                            BatchPostingPrintMgt.SchedulePrintJobQueueEntry(WHTEntry, ReportSelection."Report ID", GeneralLedgerSetup."Report Output Type")
                        else
                            REPORT.Run(ReportSelection."Report ID", PurchSetup."Print Dialog", false, WHTEntry);
                    until ReportSelection.Next = 0;
            end;
            WHTSlipBuffer2 := VendorArray[PrintSlips];
            WHTSlipDocument2 := DocumentArray[PrintSlips];
        end;
    end;

    PROCEDURE SetApplId(ApplyDocNo: Code[20]; PostingDate: Date; AppliesToID: Code[20]);
    VAR
        WHTEntry: Record "WHT ENtry";
    BEGIN
        //KKE : #002 +
        WHTEntry.LOCKTABLE;
        WHTEntry.RESET;
        WHTEntry.SETRANGE("Document No.", ApplyDocNo);
        WHTEntry.SETRANGE("Posting Date", PostingDate);
        WHTEntry.SETRANGE(Closed, FALSE);
        IF WHTEntry.FIND('-') THEN
            REPEAT
                WHTEntry."Applies-to ID" := AppliesToID;
                WHTEntry.MODIFY;
            UNTIL WHTEntry.NEXT = 0;
        //KKE : #002 -
    END;

    PROCEDURE WHTEntryEdit(VAR xWHTEntry: Record 28044);
    VAR
        WHTEntry: Record "WHT ENtry";
    BEGIN
        //KKE : #002 +
        WHTEntry := xWHTEntry;
        WHTEntry.LOCKTABLE;
        WHTEntry.FIND;
        WHTEntry.Cancelled := xWHTEntry.Cancelled;
        WHTEntry."WHT Certificate No." := xWHTEntry."WHT Certificate No.";
        WHTEntry.MODIFY;
        xWHTEntry := WHTEntry;
        //KKE : #002 -
    END;

    PROCEDURE InsertVendPayWHTPettyCash(VAR PettyCashHeader: Record "Petty Cash Header"; GenJnlLine: Record "Gen. Journal Line"): Boolean;
    VAR
        PettyCashLine: Record "Petty Cash Line";
        PettyCashInvLine: Record "Petty Cash Invoice Line";
        WHTEntry2: Record "WHT Entry";
        NextEntryNo: Integer;
        NeedPrint: Boolean;
        GLSetup: Record "General Ledger Setup";
        Vendor: Record vendor;
    BEGIN
        //KKE : #008 +
        //Insert WHT from Petty Cash module.
        GLSetup.GET;
        IF GLSetup."Enable GST (Australia)" THEN BEGIN
            Vendor.GET(PettyCashHeader."Petty Cash Vendor No.");
            IF (Vendor.ABN <> '') OR (Vendor."Foreign Vend") THEN
                EXIT;
        END;

        WHTEntry2.RESET;
        IF WHTEntry2.FIND('+') THEN
            NextEntryNo := WHTEntry2."Entry No.";

        WITH PettyCashHeader DO BEGIN
            TransNo := 0;
            GLEntry.RESET;
            GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
            GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Invoice);
            GLEntry.SETRANGE("Document No.", "No.");
            GLEntry.SETRANGE("Posting Date", "Posting Date");
            IF GLEntry.FIND('-') THEN
                TransNo := GLEntry."Transaction No.";

            PettyCashLine.RESET;
            PettyCashLine.SETRANGE("Document No.", "No.");
            PettyCashLine.SETFILTER("Amount Incl. VAT", '<>0');
            PettyCashLine.SETCURRENTKEY("Actual Vendor No.", "WHT Business Posting Group", "WHT Product Posting Group");
            IF PettyCashLine.FIND('-') THEN
                REPEAT
                    NextEntryNo := NextEntryNo + 1;
                    WHTPostingSetup.GET(PettyCashLine."WHT Business Posting Group", PettyCashLine."WHT Product Posting Group");
                    WHTEntry2.INIT;
                    WHTEntry2."Entry No." := NextEntryNo;
                    WHTEntry2."Posting Date" := "Posting Date";
                    WHTEntry2."Document Date" := "Document Date";
                    WHTEntry2."Document Type" := WHTEntry2."Document Type"::Payment;
                    WHTEntry2."Document No." := PettyCashLine."Document No.";
                    WHTEntry2."External Document No." := PettyCashLine."External Document No.";
                    WHTEntry2."Gen. Bus. Posting Group" := PettyCashLine."Gen. Bus. Posting Group";
                    WHTEntry2."Gen. Prod. Posting Group" := PettyCashLine."Gen. Prod. Posting Group";
                    WHTEntry2."Bill-to/Pay-to No." := "Petty Cash Vendor No.";
                    WHTEntry2."WHT Bus. Posting Group" := PettyCashLine."WHT Business Posting Group";
                    WHTEntry2."WHT Prod. Posting Group" := PettyCashLine."WHT Product Posting Group";
                    WHTEntry2."WHT Revenue Type" := WHTPostingSetup."Revenue Type";
                    WHTEntry2."Currency Code" := PettyCashLine."Currency Code";
                    WHTEntry2."User ID" := USERID;
                    WHTEntry2."Actual Vendor No." := PettyCashLine."Actual Vendor No.";
                    WHTEntry2."Original Document No." := PettyCashLine."Document No.";
                    WHTEntry2."Source Code" := "Source Code";
                    WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Purchase;
                    WHTEntry2."Transaction No." := TransNo;
                    WHTEntry2."WHT %" := WHTPostingSetup."WHT %";
                    WHTEntry2."WHT Report" := WHTPostingSetup."WHT Report";
                    IF PettyCashLine."WHT Absorb Base" <> 0 THEN BEGIN
                        WHTEntry2.Base := PettyCashLine."WHT Absorb Base";
                        WHTEntry2."Base (LCY)" := PettyCashLine."WHT Absorb Base";
                    END ELSE BEGIN
                        WHTEntry2.Base := PettyCashLine."VAT Base Amount";
                        WHTEntry2."Base (LCY)" := PettyCashLine."VAT Base Amount (LCY)";
                    END;

                    IF GLSetup."Round Amount for WHT Calc" THEN BEGIN
                        WHTEntry2.Amount := ROUND(ROUND(WHTEntry2.Base, 1, '<') * WHTEntry2."WHT %" / 100, 1, '<');
                        WHTEntry2."Amount (LCY)" := ROUND(ROUND(WHTEntry2."Base (LCY)", 1, '<') * WHTEntry2."WHT %" / 100, 1, '<');
                    END ELSE BEGIN
                        WHTEntry2.Amount := ROUND(WHTEntry2.Base * WHTEntry2."WHT %" / 100);
                        WHTEntry2."Amount (LCY)" := ROUND(WHTEntry2."Base (LCY)" * WHTEntry2."WHT %" / 100);
                    END;

                    IF PettyCashLine."Certificate Printed" THEN
                        WHTEntry2."WHT Certificate No." := PettyCashLine."WHT Certificate No.";
                    WHTEntry2.INSERT;

                    PettyCashInvLine.GET(PettyCashLine."Document No.", PettyCashLine."Line No.");
                    PettyCashInvLine."WHT Entry No." := WHTEntry2."Entry No.";
                    PettyCashInvLine.MODIFY;

                    IF (WHTEntry2.Amount <> 0) AND (WHTEntry2."WHT Certificate No." = '') THEN
                        NeedPrint := TRUE;
                    IF WHTEntry2.Amount <> 0 THEN;
                    InsertWHTPostingBuffer(WHTEntry2, GenJnlLine, 0, FALSE); //VAH

                UNTIL PettyCashLine.NEXT = 0;
        END;
        EXIT(NeedPrint);
        //KKE : #008 -
    END;

    PROCEDURE InsertVendPayWHTCashAdv(VAR CashAdvHeader: Record "Cash Advance Header"; GenJnlLine: Record "Gen. Journal Line"): Boolean;
    VAR
        CashAdvLine: Record "Cash Advance Line";
        CashAdvInvLine: Record "Cash Advance Invoice Line";
        WHTEntry2: Record "WHT Entry";
        NextEntryNo: Integer;
        NeedPrint: Boolean;
        GLSetup: Record "General Ledger Setup";
        Vendor: Record Vendor;
        WHTMnmt: Codeunit WHTManagement;

    BEGIN
        //KKE : #009 +
        //Insert WHT from Cash Advance module.
        GLSetup.GET;
        IF GLSetup."Enable GST (Australia)" THEN BEGIN
            Vendor.GET(CashAdvHeader."Cash Advance Vendor No.");
            IF (Vendor.ABN <> '') OR (Vendor."Foreign Vend") THEN
                EXIT;
        END;

        WHTEntry2.RESET;
        IF WHTEntry2.FIND('+') THEN
            NextEntryNo := WHTEntry2."Entry No.";

        WITH CashAdvHeader DO BEGIN
            TransNo := 0;
            GLEntry.RESET;
            GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
            GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Invoice);
            GLEntry.SETRANGE("Document No.", "No.");
            GLEntry.SETRANGE("Posting Date", "Posting Date");
            IF GLEntry.FIND('-') THEN
                TransNo := GLEntry."Transaction No.";

            CashAdvLine.RESET;
            CashAdvLine.SETRANGE("Document No.", "No.");
            CashAdvLine.SETFILTER("Amount Incl. VAT", '<>0');
            CashAdvLine.SETCURRENTKEY("Actual Vendor No.", "WHT Business Posting Group", "WHT Product Posting Group");
            IF CashAdvLine.FIND('-') THEN
                REPEAT
                    NextEntryNo := NextEntryNo + 1;
                    WHTPostingSetup.GET(CashAdvLine."WHT Business Posting Group", CashAdvLine."WHT Product Posting Group");
                    WHTEntry2.INIT;
                    WHTEntry2."Entry No." := NextEntryNo;
                    WHTEntry2."Posting Date" := "Posting Date";
                    WHTEntry2."Document Date" := "Document Date";
                    WHTEntry2."Document Type" := WHTEntry2."Document Type"::Payment;
                    WHTEntry2."Document No." := CashAdvLine."Document No.";
                    WHTEntry2."External Document No." := CashAdvLine."External Document No.";
                    WHTEntry2."Gen. Bus. Posting Group" := CashAdvLine."Gen. Bus. Posting Group";
                    WHTEntry2."Gen. Prod. Posting Group" := CashAdvLine."Gen. Prod. Posting Group";
                    WHTEntry2."Bill-to/Pay-to No." := "Cash Advance Vendor No.";
                    WHTEntry2."WHT Bus. Posting Group" := CashAdvLine."WHT Business Posting Group";
                    WHTEntry2."WHT Prod. Posting Group" := CashAdvLine."WHT Product Posting Group";
                    WHTEntry2."WHT Revenue Type" := WHTPostingSetup."Revenue Type";
                    WHTEntry2."Currency Code" := CashAdvLine."Currency Code";
                    WHTEntry2."User ID" := USERID;
                    WHTEntry2."Actual Vendor No." := CashAdvLine."Actual Vendor No.";
                    WHTEntry2."Original Document No." := CashAdvLine."Document No.";
                    WHTEntry2."Source Code" := "Source Code";
                    WHTEntry2."Transaction Type" := WHTEntry2."Transaction Type"::Purchase;
                    WHTEntry2."Transaction No." := TransNo;
                    WHTEntry2."WHT %" := WHTPostingSetup."WHT %";
                    WHTEntry2."WHT Report" := WHTPostingSetup."WHT Report";
                    IF CashAdvLine."WHT Absorb Base" <> 0 THEN BEGIN
                        WHTEntry2.Base := CashAdvLine."WHT Absorb Base";
                        WHTEntry2."Base (LCY)" := CashAdvLine."WHT Absorb Base";
                    END ELSE BEGIN
                        WHTEntry2.Base := CashAdvLine."VAT Base Amount";
                        WHTEntry2."Base (LCY)" := CashAdvLine."VAT Base Amount (LCY)";
                    END;

                    IF GLSetup."Round Amount for WHT Calc" THEN BEGIN
                        WHTEntry2.Amount := ROUND(ROUND(WHTEntry2.Base, 1, '<') * WHTEntry2."WHT %" / 100, 1, '<');
                        WHTEntry2."Amount (LCY)" := ROUND(ROUND(WHTEntry2."Base (LCY)", 1, '<') * WHTEntry2."WHT %" / 100, 1, '<');
                    END ELSE BEGIN
                        WHTEntry2.Amount := ROUND(WHTEntry2.Base * WHTEntry2."WHT %" / 100);
                        WHTEntry2."Amount (LCY)" := ROUND(WHTEntry2."Base (LCY)" * WHTEntry2."WHT %" / 100);
                    END;

                    IF CashAdvLine."Certificate Printed" THEN
                        WHTEntry2."WHT Certificate No." := CashAdvLine."WHT Certificate No.";
                    WHTEntry2.INSERT;

                    CashAdvInvLine.GET(CashAdvLine."Document No.", CashAdvLine."Line No.");
                    CashAdvInvLine."WHT Entry No." := WHTEntry2."Entry No.";
                    CashAdvInvLine.MODIFY;

                    IF (WHTEntry2.Amount <> 0) AND (WHTEntry2."WHT Certificate No." = '') THEN
                        NeedPrint := TRUE;
                    IF WHTEntry2.Amount <> 0 THEN;
                    //InsertWHTPostingBuffer(WHTEntry2, GenJnlLine, 0, FALSE);//VAH
                    //WHTMnmt.InsertWHTPostingBuffer(WHTEntry2,GenJnlLine,0,false);
                    InsertWHTPostingBuffer(WHTEntry2, GenJnlLine, 0, false);//VAH
                UNTIL CashAdvLine.NEXT = 0;
        END;
        EXIT(NeedPrint);
        //KKE : #009 -
    END;

    procedure InsertWHTPostingBuffer(var WHTEntryGL: Record "WHT Entry"; var GenJnlLine: Record "Gen. Journal Line"; Source: Option Payment,Refund; Oldest: Boolean)
    var
        PurchSetup: Record "General Ledger Setup";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        HighestLineNo: Integer;
        TType: Option Purchase,Sale;
    begin
        TType := TType::Purchase;//VAH
        GLSetup.get();//VAH
        WHTPostingSetup.Get(WHTEntryGL."WHT Bus. Posting Group", WHTEntryGL."WHT Prod. Posting Group");
        PurchSetup.Get();
        GenJnlLine2 := GenJnlLine;
        GenJnlLine2.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        if GenJnlLine2.FindLast then;
        HighestLineNo := GenJnlLine2."Line No." + 10000;
        GenJnlLine3.Reset();
        GenJnlLine3 := GenJnlLine;
        GenJnlLine3.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine3.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        GenJnlLine3."Line No." := HighestLineNo;
        if GenJnlLine3.Next() = 0 then
            GenJnlLine3."Line No." := HighestLineNo + 10000
        else begin
            while GenJnlLine3."Line No." = HighestLineNo + 1 do begin
                HighestLineNo := GenJnlLine3."Line No.";
                if GenJnlLine3.Next() = 0 then
                    GenJnlLine3."Line No." := HighestLineNo + 20000;
            end;
            GenJnlLine3."Line No." := HighestLineNo + 10000;
        end;

        GenJnlLine3.Init();
        GenJnlLine3.Validate("Posting Date", GenJnlLine."Posting Date");
        GenJnlLine3."Document Type" := GenJnlLine."Document Type";
        GenJnlLine3."Account Type" := GenJnlLine3."Account Type"::"G/L Account";
        GenJnlLine3."System-Created Entry" := true;
        GenJnlLine3."Is WHT" := true;
        if GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund then begin
            if TType = TType::Purchase then
                GenJnlLine3.Validate("Account No.", WHTPostingSetup."Purch. WHT Adj. Account No.");
            if TType = TType::Sale then
                GenJnlLine3.Validate("Account No.", WHTPostingSetup."Sales WHT Adj. Account No.");
        end else begin
            if TType = TType::Purchase then
                GenJnlLine3.Validate("Account No.", WHTPostingSetup."Payable WHT Account Code");
            if TType = TType::Sale then begin
                WHTPostingSetup.TestField("Prepaid WHT Account Code");
                GenJnlLine3.Validate("Account No.", WHTPostingSetup."Prepaid WHT Account Code");
            end;
        end;
        GenJnlLine3.Validate("Currency Code", WHTEntryGL."Currency Code");
        if GLSetup."Round Amount for WHT Calc" then begin
            GenJnlLine3.Validate(Amount, Round(-WHTEntryGL.Amount, 1, '<'));
            GenJnlLine3."Amount (LCY)" := Round(-WHTEntryGL."Amount (LCY)", 1, '<');
        end else begin
            GenJnlLine3.Validate(Amount, -WHTEntryGL.Amount);
            GenJnlLine3."Amount (LCY)" := -WHTEntryGL."Amount (LCY)";
        end;
        GenJnlLine3."Gen. Posting Type" := GenJnlLine."Gen. Posting Type";
        GenJnlLine3."System-Created Entry" := true; // Payment Method Code
        GLSetup.Get();
        if (Oldest = true) or GLSetup."Manual Sales WHT Calc." then begin
            if TType = TType::Purchase then begin
                case WHTPostingSetup."Bal. Payable Account Type" of
                    WHTPostingSetup."Bal. Payable Account Type"::"Bank Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                    WHTPostingSetup."Bal. Payable Account Type"::"G/L Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"G/L Account";
                end;
                WHTPostingSetup.TestField("Bal. Payable Account No.");
                GenJnlLine3.Validate("Bal. Account No.", WHTPostingSetup."Bal. Payable Account No.");
            end;

            if TType = TType::Sale then begin
                case WHTPostingSetup."Bal. Prepaid Account Type" of
                    WHTPostingSetup."Bal. Prepaid Account Type"::"Bank Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                    WHTPostingSetup."Bal. Prepaid Account Type"::"G/L Account":
                        GenJnlLine3."Bal. Account Type" := GenJnlLine3."Account Type"::"G/L Account";
                end;
                WHTPostingSetup.TestField("Bal. Prepaid Account No.");
                GenJnlLine3.Validate("Bal. Account No.", WHTPostingSetup."Bal. Prepaid Account No.");
            end;
        end;
        GenJnlLine3."Source Code" := GenJnlLine."Source Code";
        GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
        GenJnlLine3."Shortcut Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        GenJnlLine3."Shortcut Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
        GenJnlLine3."Allow Zero-Amount Posting" := true;
        GenJnlLine3."WHT Business Posting Group" := WHTEntryGL."WHT Bus. Posting Group";
        GenJnlLine3."WHT Product Posting Group" := WHTEntryGL."WHT Prod. Posting Group";
        GenJnlLine3."Document Type" := GenJnlLine."Document Type";
        GenJnlLine3."Document No." := GenJnlLine."Document No.";
        GenJnlLine3."External Document No." := GenJnlLine."External Document No.";
        if Source = Source::Refund then
            GenJnlLine3."Gen. Posting Type" := GenJnlLine3."Gen. Posting Type"::" ";
        GenJnlLine3.Insert();
    end;





    var
        WHTRevenueTypes: Record "WHT Revenue Types";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TransNo: Integer;
        GLEntry: Record "G/L Entry";
        WHTPostingSetup: Record "WHT Posting Setup";
        WHTMngt: Codeunit WHTManagement;
        GLSetup: Record "General Ledger Setup";
}
