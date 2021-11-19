Table 50057 Complaint
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // PTH : Phitsanu Thoranasoonthorn
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   02.07.2008   PTH   Complaint


    fields
    {
        field(1; "Complaint No."; Code[20])
        {
        }
        field(2; "Complaint Date"; Date)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = " ",Member,"Non-Member";
        }
        field(4; "Subscriber No."; Code[20])
        {
            TableRelation = Subscriber."No.";

            trigger OnValidate()
            begin
                GetSubscriber("Subscriber No.");
                "Customer No." := Subscriber."Customer No.";
                "Subscriber Name" := Subscriber.Name;
                "Address-1" := Subscriber."Address 1";
                "Address-2" := Subscriber."Address 2";
                "Address-3" := Subscriber."Address 3";
                "Phone No." := Subscriber."Phone No.";
                "Mobile No." := Subscriber."Mobile No.";
                "Fax No." := Subscriber."Fax No.";
            end;
        }
        field(5; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(6; "Subscriber Name"; Text[50])
        {
        }
        field(7; "Address-1"; Text[50])
        {
        }
        field(8; "Address-2"; Text[50])
        {
        }
        field(9; "Address-3"; Text[50])
        {
        }
        field(10; "Phone No."; Text[30])
        {
        }
        field(11; "Mobile No."; Text[30])
        {
        }
        field(12; "Fax No."; Text[30])
        {
        }
        field(13; "Call Category"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = filter("Call Category"));
        }
        field(14; "Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";
        }
        field(15; "Start Time"; Time)
        {
            Editable = false;
        }
        field(16; "End Time"; Time)
        {
            Editable = false;
        }
        field(17; "Usage Time"; Integer)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(18; "Message-1"; Text[100])
        {
        }
        field(19; "Message-2"; Text[100])
        {
        }
        field(20; "Message-3"; Text[100])
        {
        }
        field(21; "Complaint Topic"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = filter("Complaint Topic"));
        }
        field(22; "Last Update by"; Code[10])
        {
        }
        field(23; "Update Date"; Date)
        {
        }
        field(99; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Complaint No.")
        {
            Clustered = true;
        }
        key(Key2; "Complaint Date", "Complaint No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        SubscriptionSetup.Get;
        if "Complaint No." = '' then begin
            SubscriptionSetup.TestField("Complaint Nos.");
            NoSeriesMgt.InitSeries(SubscriptionSetup."Complaint Nos.", xRec."No. Series", 0D, "Complaint No.", "No. Series");
        end;

        "Complaint Date" := Today;
        "Last Update by" := UserId;
        "Update Date" := Today;
        "Start Time" := Time;
    end;

    trigger OnModify()
    begin
        if "End Time" = 0T then
            "End Time" := Time;
        "Usage Time" := "End Time" - "Start Time";

        "Last Update by" := UserId;
        "Update Date" := Today;
    end;

    var
        SubscriptionSetup: Record "Subscription Setup";
        Subscriber: Record Subscriber;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Complain: Record Complaint;


    procedure AssistEdit(OldComplaint: Record Complaint): Boolean
    var
        Complaint2: Record Complaint;
    begin
        with Complain do begin
            Complain := Rec;
            SubscriptionSetup.Get;
            SubscriptionSetup.TestField("Complaint Nos.");
            if NoSeriesMgt.SelectSeries(SubscriptionSetup."Complaint Nos.", OldComplaint."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Complaint No.");
                Rec := Complain;
                exit(true);
            end;
        end;
    end;


    procedure GetSubscriber(No: Code[20])
    begin
        if No <> Subscriber."No." then
            Subscriber.Get(No);
    end;
}

