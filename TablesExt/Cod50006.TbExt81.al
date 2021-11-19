codeunit 50006 TbExt81
{
    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnBeforeModifyEvent', '', true, true)]
    local procedure Tb81_Modify(RunTrigger: Boolean; var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line")
    begin
        if not RunTrigger then
            exit;
        //KKE : #001 +
        IF (Rec."Certificate Printed" = xRec."Certificate Printed") AND
           (Rec."WHT Certificate No." = xRec."WHT Certificate No.") AND
           (Rec."One Doc. Per WHT Slip" = xRec."One Doc. Per WHT Slip") AND
           (Rec."Skip WHT" = xRec."Skip WHT") AND
           (Rec."External Document No." = xRec."External Document No.") AND  //Burda
           (Rec."Shortcut Dimension 1 Code" <> xRec."Shortcut Dimension 1 Code") AND
           (Rec."Shortcut Dimension 2 Code" <> xRec."Shortcut Dimension 2 Code") AND
           (Rec.Description = xRec.Description)
        THEN
            //KKE : #001 -
            Rec.TESTFIELD("Check Printed", FALSE);

        IF (Rec."External Document No." = '') AND (xRec."External Document No." <> '') THEN
            Rec.TESTFIELD("Check Printed", FALSE);

    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnBeforeValidateEvent', 'Account Type', true, true)]
    local procedure Tb81_AccountType_OnValidate(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line")
    begin
        //KKE : #001 +
        IF rec."Account Type" <> xRec."Account Type" THEN BEGIN
            rec.TESTFIELD("Applies-to Doc. No.", '');
            rec.TESTFIELD("Applies-to ID", '');
        END;
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnBeforeValidateEvent', 'Account No.', true, true)]
    local procedure Tb81_AccountNo_OnValidate(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line")
    begin
        //KKE : #001 +
        IF rec."Account No." <> xRec."Account No." THEN BEGIN
            rec.TESTFIELD("Applies-to Doc. No.", '');
            rec.TESTFIELD("Applies-to ID", '');
        END;
        //KKE : #001 -
        //KKE : #004 +
        IF rec."Account No." <> xRec."Account No." THEN
            rec.VALIDATE("Customer/Vendor Bank", '');
        //KKE : #004 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetCustomerAccount', '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetCustomerAccount(var GenJournalLine: Record "Gen. Journal Line"; var Customer: Record Customer; CallingFieldNo: Integer);
    begin

        //KKE : #002 +
        IF Customer.Name = '' THEN
            GenJournalLine.Description := COPYSTR(Customer."Name (Thai)", 1, 50);
        //KKE : #002 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorAccount', '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetVendorAccount(var GenJournalLine: Record "Gen. Journal Line"; var Vendor: Record Vendor; CallingFieldNo: Integer);
    begin

        //KKE : #002 +
        IF Vendor.Name = '' THEN
            GenJournalLine.Description := COPYSTR(Vendor."Name (Thai)", 1, 50);
        //KKE : #002 -

        //KKE : #001 +
        IF Vendor."Name (Thai)" <> '' THEN
            GenJournalLine."Payee Name" := Vendor."Name (Thai)"
        ELSE
            GenJournalLine."Payee Name" := Vendor.Name + Vendor."Name 2";
        GenJournalLine."Dummy Vendor" := Vendor."Dummy Vendor";
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnValidateVATPctOnBeforeUpdateSalesPurchLCY', '', false, false)]
    local procedure OnValidateVATPctOnBeforeUpdateSalesPurchLCY(var GenJournalLine: Record "Gen. Journal Line"; Currency: Record Currency);
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        GLSetup: Record "General Ledger Setup";
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        AverageVATSetup: Record "Average VAT Setup";
        CurrExchRate: Record "Currency Exchange Rate";
    begin

        //KKE : #005 +
        IF (GenJournalLine."VAT Amount" = 0) AND (GenJournalLine."Bal. VAT Amount" = 0) THEN BEGIN
            GenJournalLine."VAT Claim %" := 0;
            GenJournalLine."Use Average VAT" := FALSE;
            GenJournalLine."Average VAT Year" := 0;
        END ELSE BEGIN
            GenJnlTemplate.GET(GenJournalLine."Journal Template Name");
            IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice) AND (GenJnlTemplate.Type = GenJnlTemplate.Type::Purchases) THEN BEGIN
                //GetGLSetup;
                GLSetup.get;
                IF GLSetup."Enable VAT Average" THEN BEGIN
                    IF NOT VATProdPostingGrp.GET(GenJournalLine."VAT Prod. Posting Group") THEN
                        VATProdPostingGrp.INIT;
                    IF VATProdPostingGrp."Average VAT" THEN BEGIN
                        VATPostingSetup.GET(GenJournalLine."VAT Bus. Posting Group", GenJournalLine."VAT Prod. Posting Group");
                        AverageVATSetup.RESET;
                        AverageVATSetup.SETFILTER("From Date", '<=%1', GenJournalLine."Posting Date");
                        AverageVATSetup.SETFILTER("To Date", '>=%1', GenJournalLine."Posting Date");
                        IF AverageVATSetup.FIND('+') THEN BEGIN
                            AverageVATSetup.TESTFIELD("VAT Claim %");
                            GenJournalLine."VAT Claim %" := AverageVATSetup."VAT Claim %";
                            GenJournalLine."Use Average VAT" := TRUE;
                            GenJournalLine."Average VAT Year" := AverageVATSetup.Year;
                            GenJournalLine."VAT Amount" :=
                                ROUND(GenJournalLine."VAT Amount" * GenJournalLine."VAT Claim %" / 100,
                                  Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                            GenJournalLine."VAT Posting" := GenJournalLine."VAT Posting"::"Manual VAT Entry";
                        END;
                    END;
                END;
            END;
        END;
        //KKE : #005 -

        GenJournalLine."VAT Base Amount" := GenJournalLine.Amount - GenJournalLine."VAT Amount";
        GenJournalLine."VAT Difference" := 0;

        IF GenJournalLine."Currency Code" = '' THEN
            GenJournalLine."VAT Amount (LCY)" := GenJournalLine."VAT Amount"
        ELSE
            GenJournalLine."VAT Amount (LCY)" :=
              ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  GenJournalLine."Posting Date", GenJournalLine."Currency Code",
                  GenJournalLine."VAT Amount", GenJournalLine."Currency Factor"));
        GenJournalLine."VAT Base Amount (LCY)" := GenJournalLine."Amount (LCY)" - GenJournalLine."VAT Amount (LCY)";
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnBeforeValidateEvent', 'Bal. Account No.', true, true)]
    local procedure Tb81_BalAccountNo_OnValidate(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line")
    begin
        //KKE : #001 +
        IF rec."Bal. Account No." <> xRec."Bal. Account No." THEN BEGIN
            rec.TESTFIELD("Applies-to Doc. No.", '');
            rec.TESTFIELD("Applies-to ID", '');
        END;
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnBeforeValidateEvent', 'Bal. Account Type', true, true)]
    local procedure Tb81_BalAccountType_OnValidate(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line")
    begin
        //KKE : #001 +
        IF rec."Bal. Account Type" <> xRec."Bal. Account Type" THEN BEGIN
            rec.TESTFIELD("Applies-to Doc. No.", '');
            rec.TESTFIELD("Applies-to ID", '');
        END;
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromInvPostBuffer', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromInvPostBuffer(InvoicePostBuffer: Record "Invoice Post. Buffer"; var GenJournalLine: Record "Gen. Journal Line");
    begin
        GenJournalLine."Deal No." := InvoicePostBuffer."Deal No.";
        GenJournalLine."Sub Deal No." := InvoicePostBuffer."Sub Deal No.";
        GenJournalLine."Publication Month" := InvoicePostBuffer."Publication Month";
        GenJournalLine.Brand := InvoicePostBuffer.Brand;
        GenJournalLine."Salesperson Code" := GenJournalLine."Salesperson Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line");
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.reset;
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter("Deal No.", '<>%1', '');
        if SalesLine.FindFirst() then
            GenJournalLine."Deal No." := SalesLine."Deal No.";
        GenJournalLine."Invoice Type" := salesheader."Invoice Type";

    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure Tb81_OnDelete(RunTrigger: Boolean; var Rec: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        if not RunTrigger then
            exit;
        if rec."Sub Deal No." <> '' then begin
            rec.TestField("Remark from Accountant");
            AdsBookingLine.Reset();
            AdsBookingLine.SetRange("Deal No.", rec."Deal No.");
            AdsBookingLine.SetRange("Subdeal No.", Rec."Sub Deal No.");
            if AdsBookingLine.FindFirst() then begin
                AdsBookingLine."Remark from Accountant" := rec."Remark from Accountant";
                AdsBookingLine."Posting Status" := AdsBookingLine."Posting Status"::Rejected;
                AdsBookingLine.Modify();
            end;
            InsertAdsSaleLogEntr(Rec);
            GenJnlLine.Reset();
            GenJnlLine.SetRange("Journal Template Name", rec."Journal Template Name");
            GenJnlLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
            GenJnlLine.SetRange("Sub Deal No.", rec."Sub Deal No.");
            if GenJnlLine.FindSet() then
                GenJnlLine.DeleteAll();
        end;
    end;

    local procedure InsertAdsSaleLogEntr(var GenJnlLine: Record "Gen. Journal Line")
    var
        AdsSalesLogEntry: Record "Ads. Sales Log Entry";
        LogEntryNo: Integer;

    begin
        if AdsSalesLogEntry.FindLast() then
            LogEntryNo := AdsSalesLogEntry."Entry No."
        else
            LogEntryNo := 0;
        LogEntryNo += 1;
        AdsSalesLogEntry.Init();
        AdsSalesLogEntry."Entry No." := LogEntryNo;
        AdsSalesLogEntry."Creation Date Time" := CurrentDateTime;
        AdsSalesLogEntry."User ID" := UserId;
        AdsSalesLogEntry."Documnet Type" := AdsSalesLogEntry."Documnet Type"::JV;
        AdsSalesLogEntry."Document No." := GenJnlLine."Document No.";
        AdsSalesLogEntry."Deal No." := GenJnlLine."Deal No.";
        AdsSalesLogEntry."Sub Deal No." := GenJnlLine."Sub Deal No.";
        AdsSalesLogEntry.Deleted := true;
        AdsSalesLogEntry."Deleted By" := UserId;
        AdsSalesLogEntry."Remark From Accountant" := GenJnlLine."Remark from Accountant";
        AdsSalesLogEntry.Insert();
    end;

}
