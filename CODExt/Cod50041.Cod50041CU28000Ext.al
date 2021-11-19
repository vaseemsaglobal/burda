codeunit 50041 "Cod50041.CU28000Ext"
{
    procedure CopyAllAddressID(FromTableNo: Integer; FromTableKey: Text[1024]; ToTableNo: Integer; ToTableKey: Text[1024])
    var
        FromAddressID: Record "Address ID";
        ToAddressID: Record "Address ID";
    begin
        FromAddressID.SetRange("Table No.", FromTableNo);
        FromAddressID.SetRange("Table Key", FromTableKey);
        ToAddressID.SetRange("Table No.", ToTableNo);
        ToAddressID.SetRange("Table Key", ToTableKey);
        ToAddressID.DeleteAll();
        if FromAddressID.Find('-') then
            repeat
                ToAddressID.Init();
                ToAddressID := FromAddressID;
                ToAddressID."Table No." := ToTableNo;
                ToAddressID."Table Key" := ToTableKey;
                ToAddressID.Insert();
            until FromAddressID.Next() = 0;
    end;

}
