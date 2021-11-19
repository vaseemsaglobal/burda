Table 50045 "Archived Content Index Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   18.05.2007   KKE   New table for "Archived Content Index Header" - Editorial Module

    LookupPageID = "Archived Content Index List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Creation Date"; Date)
        {
        }
        field(3; "Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine));
        }
        field(5; "Magazine Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Sub Product";
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(20; Close; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';
}

