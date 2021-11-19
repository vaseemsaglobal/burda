codeunit 50016 TbExt28044
{
    [EventSubscriber(ObjectType::Table, Database::"WHT Entry", 'OnBeforeValidateEvent', 'Unrealized Amount (LCY)', true, true)]
    local procedure Tb28040_OnValidate(var Rec: Record "WHT Entry")
    begin
        //KKE : #001 +
        IF Rec."Currency Code" = '' THEN BEGIN
            Rec."Unrealized Amount" := Rec."Unrealized Amount (LCY)";
            Rec."WHT Difference" := Rec."Unrealized Amount (LCY)" - ROUND((Rec."Unrealized Base (LCY)" * Rec."WHT %") / 100);
        END;
        //KKE : #001 -
    end;
}
