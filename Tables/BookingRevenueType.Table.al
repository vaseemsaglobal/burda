Table 50027 "Booking Revenue Type"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Booking Revenue Type" - Ads. Sales Module

    LookupPageID = "Booking Revenue Type";

    fields
    {
        field(1; "Code"; Code[20])
        {
            TableRelation = "Ads. Type";
            NotBlank = true;
            trigger OnValidate()
            var
                AdsType: Record "Ads. Type";
            begin
                Validate("Ads. Type", Code);
                AdsType.Get(Code);
                Description := AdsType.Description;
            end;
        }
        field(50; "Shortcut Dimension 7 Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), Blocked = const(false));
            CaptionClass = '1,2,7';
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Magazine Code"; Code[20])
        {
            Caption = 'Sub Product Code';
            TableRelation = "Sub Product";
        }
        field(4; "Ads. Type"; Code[20])
        {

            TableRelation = "Ads. Type";
        }
        field(5; Type; Option)
        {
            OptionMembers = Billable,"Non-Billable","House-Ads.";
        }
        field(6; "Create Sale Invoice"; Boolean)
        {
        }
        field(7; "Bill Revenue G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Required Barter G/L Account"; Boolean)
        {
        }
        field(9; "Barter G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(10; "Blackground Color"; Option)
        {
            OptionMembers = " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White;
        }
        field(11; "Foreground Color"; Option)
        {
            OptionMembers = " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White;
        }
        field(60; "Shortcut Dimension 1 Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            CaptionClass = '1,2,1';
        }
    }

    keys
    {
        key(Key1; "Code", "Shortcut Dimension 7 Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; code, Description) { }
    }
}

