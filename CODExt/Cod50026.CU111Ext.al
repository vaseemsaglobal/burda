codeunit 50026 CU111Ext
{
    [EventSubscriber(ObjectType::Codeunit, 111, 'OnAfterUpdateVendLedgerEntry', '', false, false)]
    local procedure OnAfterUpdateVendLedgerEntry_Subscriber(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var TempVendLedgEntry: Record "Vendor Ledger Entry"; ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; AppliesToID: Code[50])
    var
        WHTManagementExt: Codeunit Cu28040Ext;
    begin
        // KKE : #001
        WHTManagementExt.SetApplId(VendorLedgerEntry."Document No.", VendorLedgerEntry."Posting Date", AppliesToID);
    end;
}
