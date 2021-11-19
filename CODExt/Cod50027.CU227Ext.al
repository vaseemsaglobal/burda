codeunit 50027 CU227Ext
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VendEntry-Apply Posted Entries", 'OnAfterPostApplyVendLedgEntry', '', false, false)]
    local procedure OnAfterPostApplyVendLedgEntry(GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line");
    begin
        VendorLedgerEntry.MODIFYALL("Applies-to ID", '');  //KKE : #002
    end;

}
