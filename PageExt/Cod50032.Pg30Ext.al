codeunit 50032 Pg30Ext
{
    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnOpenPageEvent', '', true, true)]
    local procedure Pg30_OnOpenPage(var Rec: Record Item)
    var
        UserMgt: Codeunit CU5700Ext;
    begin
        //KKE : #003 +
        IF UserMgt.GetMagazineItemFilter() <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETFILTER("Magazine Code", UserMgt.GetMagazineItemFilter());
            rec.FILTERGROUP(0);
        END;

        //KKE : #003 -
    end;
}
