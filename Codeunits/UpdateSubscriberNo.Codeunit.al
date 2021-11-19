Codeunit 50002 "Update Subscriber No."
{

    trigger OnRun()
    begin
        if not Confirm('Do you want to change Subscriber Contract No.?') then
          exit;
        scb.SetRange("No.",'SCB08-000001','SCB08-000018');
        if scb.Find('-') then
          repeat
            scb2.Get(scb."No.");
            scb2.Rename(ConvertStr(scb."No.",'SCB','SUB'));
          until scb.Next=0;

        Message('Update complete.');
    end;

    var
        scb: Record Subscriber;
        scb2: Record Subscriber;
}

