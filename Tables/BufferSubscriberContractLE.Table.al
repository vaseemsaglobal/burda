Table 50013 "Buffer Subscriber Contract L/E"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New buffer table for "Deposit Realized Revenue" - Subscription Module


    fields
    {
        field(1; Status; Code[1])
        {
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(3; "Subscriber No."; Code[20])
        {
            TableRelation = Subscriber;
        }
        field(4; "Subscriber Contract No."; Code[20])
        {
            TableRelation = "Subscriber Contract";
        }
        field(5; "Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";
        }
        field(6; "Volume No."; Code[20])
        {
            TableRelation = Volume;
        }
        field(7; "Issue No."; Code[20])
        {
            TableRelation = "Issue No.";
        }
        field(8; "Deposit Paid"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(9; "Realized Revenue"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(10; "Unrealized Revenue"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(11; "Reversed Amount"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(15; Show; Boolean)
        {
        }
        field(16; Block; Boolean)
        {
        }
        field(17; "Contract Status"; Option)
        {
            OptionMembers = Open,Confirm,Released,Closed,Cancelled," ";
        }
    }

    keys
    {
        key(Key1; "Subscriber No.", Status, "Subscriber Contract No.", "Magazine Code", "Volume No.", "Issue No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text007: label 'Create Buffer Deposit Realized Revenue...\\';
        Text008: label 'Subscriber No.    #1##########';


    procedure InsertBufferSubscriberLine(MagazineFilter: Code[20])
    var
        BufferSubscriberLE: Record "Buffer Subscriber Contract L/E";
        Subscriber: Record Subscriber;
        SubscriberContract: Record "Subscriber Contract";
        SubscriberContractLE: Record "Subscriber Contract L/E";
        Window: Dialog;
    begin
        //Subscriber Contract No.,Subscriber No.,Magazine Code,Volume No.,Issue No.
        BufferSubscriberLE.SETPERMISSIONFILTER;
        BufferSubscriberLE.Reset;
        BufferSubscriberLE.DeleteAll;
        Window.Open(Text007 + Text008);

        with SubscriberContractLE do begin
            SETPERMISSIONFILTER;
            if MagazineFilter <> '' then
                SetFilter("Magazine Code", MagazineFilter);
            if Find('-') then
                repeat
                    Window.Update(1, "Subscriber No.");
                    //total by subscriber no.
                    if not BufferSubscriberLE.Get(
                        "Subscriber No.", '0',
                        '',
                        '',
                        '',
                        '')
                    then begin
                        Clear(BufferSubscriberLE);
                        BufferSubscriberLE.Init;
                        BufferSubscriberLE."Subscriber No." := "Subscriber No.";
                        BufferSubscriberLE.Status := '0';
                        Subscriber.Get("Subscriber No.");
                        BufferSubscriberLE."Customer No." := Subscriber."Customer No.";
                        BufferSubscriberLE.Show := true;
                        BufferSubscriberLE."Contract Status" := BufferSubscriberLE."contract status"::" ";
                        BufferSubscriberLE.Insert;
                    end;
                    if "Paid Flag" then
                        BufferSubscriberLE."Deposit Paid" += "Unit Price";
                    if "Paid Flag" and "Delivered Flag" then
                        BufferSubscriberLE."Realized Revenue" += "Unit Price";
                    if "Reversed Flag" then
                        BufferSubscriberLE."Reversed Amount" += "Unit Price"
                    else
                        if "Paid Flag" and (not "Delivered Flag") then
                            BufferSubscriberLE."Unrealized Revenue" += "Unit Price";
                    BufferSubscriberLE.Modify;

                    //total by subscriber no.,subscriber contract no.,magazine code
                    if not BufferSubscriberLE.Get(
                        "Subscriber No.", '1',
                        "Subscriber Contract No.",
                        "Magazine Code",
                        '',
                        '')
                    then begin
                        Clear(BufferSubscriberLE);
                        BufferSubscriberLE.Init;
                        BufferSubscriberLE."Subscriber No." := "Subscriber No.";
                        BufferSubscriberLE.Status := '1';
                        Subscriber.Get("Subscriber No.");
                        BufferSubscriberLE."Customer No." := Subscriber."Customer No.";
                        BufferSubscriberLE."Subscriber Contract No." := SubscriberContractLE."Subscriber Contract No.";
                        BufferSubscriberLE."Magazine Code" := SubscriberContractLE."Magazine Code";
                        SubscriberContract.Get("Subscriber Contract No.");
                        BufferSubscriberLE.Block := SubscriberContract.Block;
                        BufferSubscriberLE."Contract Status" := SubscriberContract."Contract Status";
                        BufferSubscriberLE.Insert;
                    end;
                    if "Paid Flag" then
                        BufferSubscriberLE."Deposit Paid" += "Unit Price";
                    if "Paid Flag" and "Delivered Flag" then
                        BufferSubscriberLE."Realized Revenue" += "Unit Price";
                    if "Reversed Flag" then
                        BufferSubscriberLE."Reversed Amount" += "Unit Price"
                    else
                        if "Paid Flag" and (not "Delivered Flag") then
                            BufferSubscriberLE."Unrealized Revenue" += "Unit Price";
                    BufferSubscriberLE.Modify;
                until Next = 0;
        end;
        Commit;
        Window.Close;
    end;
}

