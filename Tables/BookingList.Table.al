Table 50025 "Booking List"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Booking List" - Editorial Module

    LookupPageID = "Booking List";

    fields
    {
        field(1; "Dummy Plan No."; Code[20])
        {
        }
        field(2; "From Type"; Option)
        {
            OptionMembers = Ads,Content;
        }
        field(3; "Booking No."; Code[20])
        {
            TableRelation = if ("From Type" = const(Ads)) "Ads. Booking Header"
            else
            if ("From Type" = const(Content)) "Content Index Header";
        }
        field(4; "Booking Line No."; Integer)
        {
        }
        field(5; "Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine));
        }
        field(6; "Content Code"; Code[20])
        {
        }
        field(7; "Content Type"; Code[20])
        {
        }
        field(8; "Blackground Color"; Option)
        {
            OptionMembers = " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White;
        }
        field(9; "Foreground Color"; Option)
        {
            OptionMembers = " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White;
        }
        field(10; "Planning Status"; Option)
        {
            Editable = false;
            OptionMembers = " ",Occupied,Confirmed;
        }
        field(11; "Column Name"; Text[50])
        {
        }
        field(20; "Revision No."; Integer)
        {
            Editable = false;
        }
        field(24; "Counting Unit"; Decimal)
        {
        }
        field(27; "Magazine Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Sub Product";
        }
        field(28; "Ads. Position"; Code[20])
        {
            TableRelation = "Ads. Position" where("Magazine Code" = field("Magazine Code"));
        }
        field(29; "Ads. Product"; Code[20])
        {
            TableRelation = Brand;
        }
        field(30; "Ads. Size"; Code[20])
        {
            TableRelation = "Ads. Size";
        }
        field(31; "Owner Customer"; Code[20])
        {
            TableRelation = Customer;
        }
        field(32; Description; Text[50])
        {
        }
        field(33; "Author Name"; Text[50])
        {
        }
        field(34; "Source of Information"; Text[50])
        {
        }
        field(35; "Content Receipt Date"; Date)
        {
        }
        field(36; "Ads. Type"; Code[20])
        {
            TableRelation = "Ads. Type";
        }
        field(37; "Ads. Sub-Type"; Code[20])
        {
            TableRelation = "Ads. Sub Type".Code where("Ads. Type" = field("Ads. Type"));
        }
        field(38; "Salesperson Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(40; Remark; Text[50])
        {
        }
        field(100; Archived; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Dummy Plan No.", "Revision No.", "From Type", "Booking No.", "Booking Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Planning Status", "planning status"::" ");
        TestField(Archived, false);

        UpdateAdsBookingContentIndex;
    end;

    trigger OnModify()
    begin
        TestField("Planning Status", "planning status"::" ");
        TestField(Archived, false);
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';


    procedure UpdateAdsBookingContentIndex()
    var
        ContentIndexLine: Record "Content Index Line";
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        if "From Type" = "from type"::Content then begin
            ContentIndexLine.Get("Booking No.", "Booking Line No.");
            ContentIndexLine.Status := ContentIndexLine.Status::" ";
            ContentIndexLine.Modify;
        end else begin
            AdsBookingLine.Get("Booking No.", "Booking Line No.");
            AdsBookingLine."Planning Status" := AdsBookingLine."planning status"::" ";
            AdsBookingLine.Modify;
        end;
    end;
}

