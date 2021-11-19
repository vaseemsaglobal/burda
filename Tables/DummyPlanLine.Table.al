Table 50024 "Dummy Plan Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Dummy Plan Line" - Editorial Module


    fields
    {
        field(1; "Dummy Plan No."; Code[20])
        {
            TableRelation = "Dummy Plan";
        }
        field(2; "Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine));
        }
        field(3; "Page No."; Integer)
        {
        }
        field(4; "Line No."; Integer)
        {
        }
        field(5; "Content Code"; Code[20])
        {
            TableRelation = Brand;
        }
        field(6; "Content Type"; Code[20])
        {
        }
        field(7; "Blackground Color"; Option)
        {
            OptionMembers = " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White;
        }
        field(8; "Foreground Color"; Option)
        {
            OptionMembers = " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White;
        }
        field(9; "Planning Status"; Option)
        {
            Editable = false;
            OptionMembers = " ",Occupied,Confirmed;
        }
        field(10; "From Type"; Option)
        {
            OptionMembers = Ads,Content;
        }
        field(11; "Booking No."; Code[20])
        {
        }
        field(12; "Booking Line No."; Integer)
        {
        }
        field(13; "Column Name"; Text[50])
        {
        }
        field(15; "Sub Page No."; Integer)
        {
        }
        field(20; "Revision No."; Integer)
        {
            Editable = false;
        }
        field(24; "Counting Unit"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(25; "From Ads. Item No."; Code[20])
        {
        }
        field(26; "RBG Foreground"; Integer)
        {
        }
        field(27; "Box No."; Integer)
        {
            MinValue = 1;
        }
        field(28; "CUnit Before Page"; Decimal)
        {
        }
        field(29; "RBG Blackground"; Integer)
        {
        }
        field(30; "Color Index Foreground"; Integer)
        {
        }
        field(31; "Color Index Blackground"; Integer)
        {
        }
        field(50; "Has Detail"; Boolean)
        {
            CalcFormula = exist("Dummy Plan Line" where("Dummy Plan No." = field("Dummy Plan No."),
                                                         "Revision No." = field("Revision No."),
                                                         "Page No." = field("Page No."),
                                                         "Sub Page No." = field("Sub Page No."),
                                                         "Line No." = filter(<> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Detail of Page"; Text[150])
        {
        }
        field(52; "Detail of Page 2"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Dummy Plan No.", "Revision No.", "Page No.", "Sub Page No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Counting Unit";
        }
        key(Key2; "Dummy Plan No.", "Revision No.", "Box No.")
        {
        }
    }

    fieldgroups
    {
    }
}

