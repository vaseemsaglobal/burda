Table 50036 "Ads. Item"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Ads. Item" - Ads. Sales Module
    // 002   29.05.2007   KKE   Flowfield Summary change DecimalPlaces from 0:5 to 0:2

    LookupPageID = "Ads. Item List";

    fields
    {
        field(1; "Ads. Item No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Sub Product Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Sub Product";
        }
        field(3; "Volume No."; Code[20])
        {
            Editable = false;
            TableRelation = Volume;
        }
        field(4; "Issue No."; Code[20])
        {
            Editable = false;
            TableRelation = "Issue No.";
        }
        field(5; "Issue Date"; Date)
        {
            Editable = false;
        }
        field(6; "Base Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(7; "Ads. Closing Date"; Date)
        {
        }
        field(8; Closed; Boolean)
        {
            Editable = false;
        }
        field(9; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(10; "Booking Line"; Decimal)
        {
            CalcFormula = sum("Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                               "Line Status" = const(Booking),
                                                                               "Sub Product Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = '#002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Confirmed Booking"; Decimal)
        {
            CalcFormula = sum("Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                               "Line Status" = const(Confirmed),
                                                                               "Sub Product Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = '#002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Waiting List Booking"; Decimal)
        {
            CalcFormula = sum("Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                               "Line Status" = const("Waiting List"),
                                                                               "Sub Product Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = '#002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Approved Booking"; Decimal)
        {
            CalcFormula = sum("Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                               "Line Status" = const(Approved),
                                                                               "Sub Product Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = '#002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Hold Booking"; Decimal)
        {
            CalcFormula = sum("Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                               "Line Status" = const(Hold),
                                                                               "Sub Product Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = '#002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Cancelled Booking"; Decimal)
        {
            CalcFormula = sum("Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                               "Line Status" = const(Cancelled),
                                                                               "Sub Product Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = '#002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Invoiced Booking"; Decimal)
        {
            CalcFormula = sum("Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                               "Line Status" = const(Invoiced),
                                                                               "Sub Product Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = '#002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Closed Booking"; Decimal)
        {
            CalcFormula = sum("Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                               "Line Status" = const(Closed),
                                                                               "Sub Product Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = '#002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(21; "Archived Cancelled Booking"; Decimal)
        {
            CalcFormula = sum("Archived Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                                        "Line Status" = const(Cancelled),
                                                                                        "Magazine Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = 'Sum from table Archived #002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Archived Closed Booking"; Decimal)
        {
            CalcFormula = sum("Archived Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                                        "Line Status" = const(Closed),
                                                                                        "Magazine Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = 'Sum from table Archived #002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Archived Invoiced Booking"; Decimal)
        {
            CalcFormula = sum("Archived Ads. Booking Line"."Total Counting Unit" where("Ads. Item No." = field("Ads. Item No."),
                                                                                        "Line Status" = const(Invoiced),
                                                                                        "Magazine Code" = field("Sub Product Code")));
            DecimalPlaces = 0 : 2;
            Description = 'Sum from table Archived #002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Product Code"; Code[20])
        {

        }

    }

    keys
    {
        key(Key1; "Ads. Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Ads. Item No.", "Sub Product Code", "Volume No.", "Issue No.")
        {

        }
    }

    trigger OnDelete()
    begin
        CalcFields("Booking Line", "Confirmed Booking", "Waiting List Booking", "Approved Booking",
          "Hold Booking", "Cancelled Booking", "Invoiced Booking", "Closed Booking",
          "Archived Cancelled Booking", "Archived Closed Booking", "Archived Invoiced Booking");
        if ("Booking Line" <> 0) or
           ("Confirmed Booking" <> 0) or
           ("Waiting List Booking" <> 0) or
           ("Approved Booking" <> 0) or
           ("Hold Booking" <> 0) or
           ("Cancelled Booking" <> 0) or
           ("Invoiced Booking" <> 0) or
           ("Closed Booking" <> 0) or
           ("Archived Cancelled Booking" <> 0) or
           ("Archived Closed Booking" <> 0) or
           ("Archived Invoiced Booking" <> 0)
        then
            Error(Text001);
    end;

    var
        Text001: label 'You cannot delete this ads. item because there still has one or more entries.';
}

