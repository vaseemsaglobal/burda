Table 50006 "Subscriber Contract L/E"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New table for Subscriber Contract L/E - Subscription Module


    fields
    {
        field(1; "Subscriber Contract No."; Code[20])
        {
            TableRelation = "Subscriber Contract";
        }
        field(2; "Subscriber No."; Code[20])
        {
            TableRelation = Subscriber;
        }
        field(3; "Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";

            trigger OnValidate()
            begin
                "Issue Date" := 0D;
                if MagazineVolumeIssue.Get("Magazine Code", "Volume No.", "Issue No.") then
                    "Issue Date" := MagazineVolumeIssue."Issue Date";
            end;
        }
        field(4; "Volume No."; Code[20])
        {
            TableRelation = Volume;

            trigger OnValidate()
            begin
                "Issue Date" := 0D;
                if MagazineVolumeIssue.Get("Magazine Code", "Volume No.", "Issue No.") then
                    "Issue Date" := MagazineVolumeIssue."Issue Date";
            end;
        }
        field(5; "Issue No."; Code[20])
        {
            TableRelation = "Issue No.";

            trigger OnValidate()
            begin
                "Issue Date" := 0D;
                if MagazineVolumeIssue.Get("Magazine Code", "Volume No.", "Issue No.") then
                    "Issue Date" := MagazineVolumeIssue."Issue Date";
            end;
        }
        field(6; "Issue Date"; Date)
        {
        }
        field(7; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(8; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(9; "Shipping Agent Code"; Code[20])
        {
            TableRelation = Customer where("Shipping Agent" = const(true));
        }
        field(10; "Paid Flag"; Boolean)
        {
            Editable = false;
        }
        field(11; "Sales Order Flag"; Boolean)
        {
            Editable = false;
        }
        field(12; "Sales Order Date"; Date)
        {
            Editable = false;
        }
        field(13; "Sales Order No."; Code[20])
        {
            Editable = false;
        }
        field(14; "Sales Order Line No."; Integer)
        {
            Editable = false;
        }
        field(15; "Delivered Flag"; Boolean)
        {
            Editable = false;
        }
        field(16; "Delivered Date"; Date)
        {
            Editable = false;
        }
        field(17; "Delivered Document No."; Code[20])
        {
            Editable = false;
        }
        field(18; "Paid Sales Order No."; Code[20])
        {
            Editable = false;
        }
        field(19; "Reversed Flag"; Boolean)
        {
            Editable = false;
        }
        field(20; "Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine));

            trigger OnValidate()
            begin
                "Volume No." := '';
                "Issue No." := '';
                "Issue Date" := 0D;
                if Item.Get("Magazine Item No.") then begin
                    TestField("Magazine Code", Item."Magazine Code");
                    "Volume No." := Item."Volume No.";
                    "Issue No." := Item."Issue No.";
                    "Issue Date" := Item."Issue Date";
                end;
            end;
        }
        field(21; "Reversed Credit Memo No."; Code[20])
        {
            Editable = false;
        }
        field(29; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(30; "Old Subscriber No."; Code[20])
        {
            CalcFormula = lookup(Subscriber."Old Subscriber No." where("No." = field("Subscriber No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; Replaced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Subscriber Contract No.", "Subscriber No.", "Magazine Code", "Volume No.", "Issue No.")
        {
            Clustered = true;
            SumIndexFields = "Unit Price", Quantity;
        }
        key(Key2; "Paid Sales Order No.")
        {
        }
        key(Key3; "Shipping Agent Code", "Delivered Flag")
        {
        }
        key(Key4; "Sales Order No.")
        {
        }
        key(Key5; "Subscriber No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Paid Flag" = false then
            exit;
        SubscriberContract.Get("Subscriber Contract No.");
        if SubscriberContract."Payment Status" = SubscriberContract."payment status"::Paid then
            Error(Text001);
        SubscriberContract.TestField("Contract Status", SubscriberContract."contract status"::Open);
    end;

    trigger OnInsert()
    begin
        SubscriberContract.Get("Subscriber Contract No.");
        SubscriberContract.TestField("Contract Status", SubscriberContract."contract status"::Open);
        TestField("Subscriber No.", SubscriberContract."Subscriber No.");
        TestField("Magazine Code", SubscriberContract."Magazine Code");
    end;

    trigger OnModify()
    begin
        TestField("Paid Flag", false);
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        SubscriberContract: Record "Subscriber Contract";
        Text000: label 'You cannot rename a %1.';
        Text001: label 'This subscriber contract has already paid.';
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        Item: Record Item;
}

