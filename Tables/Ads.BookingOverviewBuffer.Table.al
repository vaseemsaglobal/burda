Table 50049 "Ads. Booking Overview Buffer"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New table for "Ads. Booking Overview Buffer" - Ads. Sales Module


    fields
    {
        field(1; "Issue No."; Code[20])
        {
            TableRelation = "Issue No.";
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; Totaling; Text[250])
        {
            Caption = 'Totaling';
        }
        field(6; Visible; Boolean)
        {
            Caption = 'Visible';
            InitValue = true;
        }
        field(7; Indentation; Integer)
        {
            Caption = 'Indentation';
        }
        field(8; "Show in Bold"; Boolean)
        {
            Caption = 'Show in Bold';
        }
        field(9; Quantity; Decimal)
        {
            CalcFormula = sum("Ads. Booking Line"."Total Counting Unit" where("Ads. Type code (Revenue type Code)" = field(filter("Booking Revenue Code Filter")),
                                                                               "Issue No." = field(filter("Issue No. Filter")),
                                                                               "Ads. Size Code" = field(filter("Ads. Size Filter")),
                                                                               "Ads. Position Code" = field(filter("Ads. Position Filter")),
                                                                               "Sub Product Code" = field(filter("Magazine Code Filter")),
                                                                               "Volume No." = field(filter("Volume No. Filter")),
                                                                               "Line Status" = field(filter("Line Status Filter")),
                                                                               "Salesperson Code" = field(filter("Salesperson Filter")),
                                                                               "Ads. Type" = field(filter("Ads. Type Filter"))));
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Ads. Position Filter"; Code[20])
        {
            TableRelation = "Ads. Position";
        }
        field(11; "Booking Revenue Code Filter"; Code[20])
        {
            TableRelation = "Booking Revenue Type";
        }
        field(12; "Issue No. Filter"; Code[20])
        {
            TableRelation = "Issue No.";
        }
        field(13; "Ads. Size Filter"; Code[20])
        {
            TableRelation = "Ads. Size";
        }
        field(14; "Magazine Code Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Sub Product";
        }
        field(15; "Volume No. Filter"; Code[20])
        {
            TableRelation = Volume;
        }
        field(16; "Line Status Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = Booking,"Waiting List",Confirmed,Approved,Hold,Cancelled,Invoiced,Closed," ";
        }
        field(17; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(18; Status; Text[150])
        {
        }
        field(19; "Salesperson Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(20; "Ads. Type Filter"; Code[20])
        {
            TableRelation = "Ads. Type";
        }
    }

    keys
    {
        key(Key1; "Issue No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AdsBuffer: Record "Ads. Booking Overview Buffer";
        IssueNo: Record "Issue No.";
        EntryNo: Integer;
        V1Linestatus: Text[150];
}

