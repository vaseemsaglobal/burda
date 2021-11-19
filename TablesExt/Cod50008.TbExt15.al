codeunit 50008 TbExt15
{
    [EventSubscriber(ObjectType::Table, database::"G/L Account", 'OnBeforeValidateEvent', 'Direct Posting', true, true)]
    local procedure Tb81_AccountType_OnValidate(var Rec: Record "G/L Account"; var xRec: Record "G/L Account")
    var
        CalcGLAccWhereUsed: Codeunit CU100Ext;
    begin
        //KKE : #002 +
        IF rec."Direct Posting" THEN
            IF CalcGLAccWhereUsed.CheckGLAccForDirectPosting(rec."No.") = FALSE THEN //VAH
                rec."Direct Posting" := FALSE;
        //KKE : #002 -
    END;

}
