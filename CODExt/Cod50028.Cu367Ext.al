codeunit 50028 Cu367Ext
{
    /*     Microsoft Business Solutions Navision
     ----------------------------------------
     Project: Localization TH
     KKE : Kanoknard Ketnut

     No.   Date         Sign  Description
     ----------------------------------------
     001   23.08.2006   KKE  -Petty Cash
     002   30.08.2006   KKE  -Cash Advance
     003   03.11.2006   KKE  -Fix error when void check, system calculate wrong WHT amount.*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnBeforeVoidCheckGenJnlLine2Modify', '', false, false)]
    local procedure OnBeforeVoidCheckGenJnlLine2Modify(var GenJournalLine2: Record "Gen. Journal Line"; GenJournalLine: Record "Gen. Journal Line");
    begin
        GenJournalLine2."Document No." := GenJournalLine2."External Document No.";  //KKE : #003
    end;

    PROCEDURE VoidCheckPettyCash(VAR SettlePettyCash: Record "Settle Petty Cash Header");
    VAR
        SettlePettyCash2: Record "Settle Petty Cash Header";
        Currency: Record Currency;
        CheckAmountLCY: Decimal;
        Text55000: Label 'Check amount must be positive.';
    BEGIN
        //KKE : #001 +
        SettlePettyCash.TESTFIELD("Bank Payment Type", SettlePettyCash."Bank Payment Type"::"Computer Check");
        SettlePettyCash.TESTFIELD("Cheque Printed", TRUE);
        SettlePettyCash.TESTFIELD("No.");

        SettlePettyCash.CALCFIELDS("Balance Settle");
        CheckAmountLCY := -SettlePettyCash."Balance Settle";
        IF CheckAmountLCY <= 0 THEN
            ERROR(Text55000);

        CheckLedgEntry2.RESET;
        CheckLedgEntry2.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
        CheckLedgEntry2.SETRANGE("Bank Account No.", SettlePettyCash."Settle Account No.");
        CheckLedgEntry2.SETRANGE("Entry Status", CheckLedgEntry2."Entry Status"::Printed);
        CheckLedgEntry2.SETRANGE("Check No.", SettlePettyCash."Cheque No.");
        CheckLedgEntry2.FIND('-');
        CheckLedgEntry2."Original Entry Status" := CheckLedgEntry2."Entry Status";
        CheckLedgEntry2."Entry Status" := CheckLedgEntry2."Entry Status"::Voided;
        CheckLedgEntry2.Open := FALSE;
        CheckLedgEntry2.MODIFY;

        //IF SettlePettyCash."Settle Account No." = '' THEN BEGIN
        SettlePettyCash."Cheque Printed" := FALSE;
        SettlePettyCash."Cheque No." := '';
        SettlePettyCash.MODIFY;
        //END;

        //KKE : #001 -
    END;

    PROCEDURE VoidCheckCashAdv(VAR SettleCashAdv: Record "Settle Cash Advance Header");
    VAR
        SettleCashAdv2: Record "Settle Cash Advance Header";
        Currency: Record Currency;
        CheckAmountLCY: Decimal;
        Text55000: Label 'Check amount must be positive.';
    BEGIN
        //KKE : #002 +
        SettleCashAdv.TESTFIELD("Bank Payment Type", SettleCashAdv."Bank Payment Type"::"Computer Check");
        SettleCashAdv.TESTFIELD("Cheque Printed", TRUE);
        SettleCashAdv.TESTFIELD("No.");

        SettleCashAdv.CALCFIELDS("Balance Settle");
        CheckAmountLCY := -SettleCashAdv."Balance Settle";
        IF CheckAmountLCY <= 0 THEN
            ERROR(Text55000);

        CheckLedgEntry2.RESET;
        CheckLedgEntry2.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
        CheckLedgEntry2.SETRANGE("Bank Account No.", SettleCashAdv."Settle Account No.");
        CheckLedgEntry2.SETRANGE("Entry Status", CheckLedgEntry2."Entry Status"::Printed);
        CheckLedgEntry2.SETRANGE("Check No.", SettleCashAdv."Cheque No.");
        CheckLedgEntry2.FIND('-');
        CheckLedgEntry2."Original Entry Status" := CheckLedgEntry2."Entry Status";
        CheckLedgEntry2."Entry Status" := CheckLedgEntry2."Entry Status"::Voided;
        CheckLedgEntry2.Open := FALSE;
        CheckLedgEntry2.MODIFY;
        //IF SettleCashAdv."Settle Account No." = '' THEN BEGIN
        SettleCashAdv."Cheque Printed" := FALSE;
        SettleCashAdv."Cheque No." := '';
        SettleCashAdv.MODIFY;
        //END;
        //KKE : #002 -
    END;

    var
        CheckLedgEntry2: Record "Check Ledger Entry";
}
