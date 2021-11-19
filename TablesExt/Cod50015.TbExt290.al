codeunit 50015 TbExt290
{
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterValidateEvent', 'VAT Amount', true, true)]
    local procedure Tb290_OnValidate(var Rec: Record "VAT Amount Line")
    var
        Currency: Record Currency;
    begin
        Currency.Initialize('');
        //KKE : #002 +
        //rec.SetCurrency('');
        IF Rec."VAT Claim %" <> 0 THEN BEGIN
            Rec."Avg. VAT Amount" :=
                  ROUND(
                    (Rec."VAT Amount" * Rec."VAT Claim %" / 100),
                    Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
        END;
        //KKE : #0
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnInsertLineOnBeforeModify', '', false, false)]
    local procedure OnInsertLineOnBeforeModify(var VATAmountLine: Record "VAT Amount Line"; FromVATAmountLine: Record "VAT Amount Line");
    begin
        //KKE : #001 +
        IF VATAmountLine."VAT Announce Price" <> 0 THEN BEGIN
            VATAmountLine."Org. VAT Base" := VATAmountLine."VAT Base";
            VATAmountLine."VAT Base" := VATAmountLine."VAT Announce Price";
        END;
        //KKE : #001 -
        //KKE : #002 +
        VATAmountLine."Avg. VAT Amount" := VATAmountLine."Avg. VAT Amount" + VATAmountLine."Avg. VAT Amount";
        VATAmountLine."Avg. VAT Amount (ACY)" := VATAmountLine."Avg. VAT Amount (ACY)" + VATAmountLine."Avg. VAT Amount (ACY)";
        //KKE : #002 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnInsertLineOnBeforeInsert', '', false, false)]
    local procedure OnInsertLineOnBeforeInsert(var VATAmountLine: Record "VAT Amount Line"; var FromVATAmountLine: Record "VAT Amount Line");
    begin
        //KKE : #001 +
        IF VATAmountLine."VAT Announce Price" <> 0 THEN BEGIN
            VATAmountLine."Org. VAT Base" := VATAmountLine."VAT Base";
            VATAmountLine."VAT Base" := VATAmountLine."VAT Announce Price";
        END;
        //KKE : #001 -
        VATAmountLine."VAT Amount (ACY)" := VATAmountLine."VAT Amount (ACY)";
        //KKE : #002 +
        VATAmountLine."Avg. VAT Amount" := VATAmountLine."Avg. VAT Amount";
        VATAmountLine."Avg. VAT Amount (ACY)" := VATAmountLine."Avg. VAT Amount (ACY)";
        //KKE : #002 -
    end;


}
