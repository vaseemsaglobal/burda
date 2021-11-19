codeunit 50005 "COD50005.TbExt232"
{
    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Batch", 'OnBeforeModifyEvent', '', true, true)]
    local procedure TB232_Modify(RunTrigger: Boolean; var Rec: Record "Gen. Journal Batch")
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        if not RunTrigger then
            exit;
        //KKE : #001 +
        GenJnlTemplate.GET(rec."Journal Template Name");
        IF GenJnlTemplate.Type IN [GenJnlTemplate.Type::Payments, GenJnlTemplate.Type::"Petty Cash"] THEN BEGIN
            PurchSetup.GET;
            IF PurchSetup."Allow Manual WHT Cert. No." = FALSE THEN
                rec.TESTFIELD("Allow Manual WHT Cert. No.", FALSE);
        END ELSE
            rec."Allow Manual WHT Cert. No." := FALSE;
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Batch", 'OnBeforeSetupNewBatch', '', false, false)]
    local procedure OnBeforeSetupNewBatch(GenJournalBatch: Record "Gen. Journal Batch"; var IsHandled: Boolean);
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        //KKE : #001 +
        GenJnlTemplate.Get(GenJournalBatch."Journal Template Name");
        if GenJnlTemplate.Type IN [GenJnlTemplate.Type::Payments, GenJnlTemplate.type::"Petty Cash"] then begin
            PurchSetup.Get;
            GenJournalBatch."Allow Manual WHT Cert. No." := PurchSetup."Allow Manual WHT Cert. No."
        end;
        //KKE : #001 -
    end;

}
