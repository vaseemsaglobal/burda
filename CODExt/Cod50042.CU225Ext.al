codeunit 50042 "Cod50042.CU225Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnApplyCustomerLedgerEntryOnBeforeModify', '', false, false)]
    local procedure OnApplyCustomerLedgerEntryOnBeforeModify(var GenJnlLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry");
    begin
        GenJnlLine."Deal No." := CustLedgerEntry."Deal No.";
    end;

}
