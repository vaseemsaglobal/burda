codeunit 50010 TbExt27
{
    [EventSubscriber(ObjectType::Table, Database::item, 'OnAfterDeleteEvent', '', true, true)]
    local procedure Tb27_Delete(RunTrigger: Boolean; var Rec: Record Item)
    var
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
    begin
        //KKE : #003 +
        IF Rec."Item Type" = Rec."Item Type"::Magazine THEN BEGIN
            MagazineVolumeIssue.GET(Rec."Magazine Code", Rec."Volume No.", Rec."Issue No.");
            IF MagazineVolumeIssue."Magazine Item No." = Rec."No." THEN BEGIN
                MagazineVolumeIssue."Create as Item" := FALSE;
                MagazineVolumeIssue."Magazine Item No." := '';
                MagazineVolumeIssue.MODIFY;
            END;
        END;
        //KKE : #003 +
    end;

}
