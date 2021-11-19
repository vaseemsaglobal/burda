codeunit 50011 TbExt125
{
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchCrMemoLine', '', false, false)]
    local procedure OnAfterCopyFromPurchCrMemoLine(var VATAmountLine: Record "VAT Amount Line"; PurchCrMemoLine: Record "Purch. Cr. Memo Line");
    begin
        //KKE : #002 +
        VATAmountLine."VAT Claim %" := PurchCrMemoLine."VAT Claim %";
        VATAmountLine."VAT Unclaim %" := PurchCrMemoLine."VAT Unclaim %";
        VATAmountLine."Avg. VAT Amount" := PurchCrMemoLine."Avg. VAT Amount";
        VATAmountLine."Average VAT Year" := PurchCrMemoLine."Average VAT Year";
        //KKE : #002 -
    end;


}
