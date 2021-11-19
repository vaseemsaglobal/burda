codeunit 50046 CU231Ext
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean);
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        VATEntry: Record "VAT Entry";
        VATAmount: Decimal;
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        PurchVATUnrealAccount: Code[20];
        AverageVATSetup: Record "Average VAT Setup";
        GLAmt: Decimal;
        VATAmtNew: Decimal;
        GenJournalLine1: Record "Gen. Journal Line" temporary;
    begin
        exit;
        if GenJournalLine.FindSet() then
            repeat
                if (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) and
                (GenJournalLine."Applies-to Doc. No." <> '') and (GenJournalLine."Applies-to Doc. Type" = GenJournalLine."Applies-to Doc. Type"::Invoice) then begin
                    VendLedgerEntry.Reset;
                    VendLedgerEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                    if GenJournalLine."Account Type" = GenJournalLine."account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", GenJournalLine."Account No.");
                    if GenJournalLine."Bal. Account Type" = GenJournalLine."bal. account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", GenJournalLine."Bal. Account No.");
                    VendLedgerEntry.SetRange("Document Type", GenJournalLine."Applies-to Doc. Type");
                    VendLedgerEntry.SetRange("Document No.", GenJournalLine."Applies-to Doc. No.");
                    if VendLedgerEntry.Find('-') then
                        repeat
                            VendLedgerEntry.CalcFields(Amount);
                            VATEntry.Reset();
                            VATEntry.SetRange("Document No.", VendLedgerEntry."Document No.");
                            if VATEntry.FindFirst() then begin
                                VendLedgerEntry.CalcFields("Amount (LCY)");
                                VATAmount := VendLedgerEntry."Purchase (LCY)" - VendLedgerEntry."Amount (LCY)";
                            end;
                            IF NOT VATProdPostingGrp.GET(VATEntry."VAT Prod. Posting Group") THEN //VATEntry2 replaced by VATEntry //VAH
                                VATProdPostingGrp.INIT;
                            IF NOT VATPostingSetup.GET(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group") THEN
                                VATPostingSetup.INIT;
                            PurchVATUnrealAccount := VATPostingSetup."Purch. VAT Unreal. Account";//VAH
                            IF VATProdPostingGrp."Average VAT" THEN BEGIN
                                AverageVATSetup.RESET;
                                AverageVATSetup.SETFILTER("From Date", '<=%1', GenJournalLine."Posting Date");
                                AverageVATSetup.SETFILTER("To Date", '>=%1', GenJournalLine."Posting Date");
                                IF AverageVATSetup.FIND('+') THEN BEGIN
                                    AverageVATSetup.TESTFIELD(AverageVATSetup."VAT Claim %");
                                    VATAmtNew := VATAmount * AverageVATSetup."VAT Claim %" / 100;
                                    if (VATEntry."Unrealized Amount" - VATAmtNew) <> 0 then begin
                                        GenJournalLine1.Init();
                                        //GenJournalLine1 := GenJournalLine;
                                        GenJournalLine1."Journal Batch Name" := GenJournalLine."Journal Batch Name";
                                        GenJournalLine1."Journal Template Name" := GenJournalLine."Journal Template Name";
                                        GenJournalLine1.Validate("Source Code", GenJournalLine."Source Code");
                                        GenJournalLine1.Validate("Document Type", GenJournalLine1."Document Type"::Payment);
                                        GenJournalLine1.Validate("Document No.", GenJournalLine."Document No.");
                                        GenJournalLine1.Validate("Posting Date", GenJournalLine."Posting Date");
                                        GenJournalLine1."Line No." := GenJournalLine."Line No." + 10000;
                                        //GenJournalLine1.Validate("Applies-to Doc. Type", GenJournalLine1."Applies-to Doc. Type"::" ");
                                        //GenJournalLine1.Validate("Applies-to Doc. No.", '');
                                        GenJournalLine1.validate("Account Type", GenJournalLine1."Account Type"::"G/L Account");
                                        GenJournalLine1.validate("Account No.", '890510');
                                        GenJournalLine1.Validate("WHT Business Posting Group", '');
                                        GenJournalLine1.validate(Amount, VATEntry."Unrealized Amount" - VATAmtNew);
                                        GenJournalLine1.validate("Bal. Account Type", GenJournalLine1."Bal. Account Type"::"G/L Account");
                                        GenJournalLine1.validate("Bal. Account No.", '112950');

                                        GenJournalLine1.Insert();
                                    end;
                                end;
                            end;
                        //VATAmount := VATEntry."Unrealized Amount"-VATEntry.purch
                        until VendLedgerEntry.Next = 0;
                    GenJournalLine := GenJournalLine1;
                    GenJournalLine.Insert();
                end;

            until GenJournalLine.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode_1(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean);
    var
        GenJnlLine1: Record "Gen. Journal Line";
    begin
        GenJnlLine1 := GenJournalLine;
        GenJnlLine1.SetFilter("Deal No.", '<>%1', '');
        GenJnlLine1.SetRange("Document No.", GenJournalLine."Document No.");
        if GenJnlLine1.FindFirst() then begin
            if GenJournalLine.FindSet() then
                repeat
                    if GenJournalLine."Deal No." = '' then begin
                        GenJournalLine."Deal No." := GenJnlLine1."Deal No.";
                        GenJournalLine.Modify();
                    end;
                until GenJournalLine.Next() = 0;
        end;
    end;

}
