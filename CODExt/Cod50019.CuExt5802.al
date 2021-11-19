codeunit 50019 CuExt5802
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnPostInvtPostBufOnAfterInitGenJnlLine', '', false, false)]
    local procedure OnPostInvtPostBufOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var ValueEntry: Record "Value Entry");
    begin
        GenJournalLine."Reason Code" := ValueEntry."Reason Code";  //KKE : #001
    end;

}
