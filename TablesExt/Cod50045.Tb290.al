codeunit 50045 Tb290
{
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchInvLine', '', false, false)]
    local procedure OnAfterCopyFromPurchInvLine(var VATAmountLine: Record "VAT Amount Line"; PurchInvLine: Record "Purch. Inv. Line");
    begin
        VATAmountLine."VAT Claim %" := PurchInvLine."VAT Claim %";
        VATAmountLine."VAT Unclaim %" := PurchInvLine."VAT Unclaim %";
        VATAmountLine."Avg. VAT Amount" := PurchInvLine."Avg. VAT Amount";
    end;

}
