Table 50047 "Archived Dummy Plan"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   18.05.2007   KKE   New table for "Archived Dummy Plan" - Editorial Module

    LookupPageID = "Archived Dummy Plan List";

    fields
    {
        field(1; "Dummy Plan No."; Code[20])
        {
        }
        field(2; "Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine));
        }
        field(3; "Planning Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,"Final Approve";
        }
        field(4; "Document Date"; Date)
        {
        }
        field(5; "No. of Page"; Integer)
        {

            trigger OnValidate()
            var
                BoxNo: Integer;
            begin
            end;
        }
        field(6; "Magazine Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Sub Product";
        }
        field(10; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(11; "Revision No."; Integer)
        {
            Editable = false;
        }
        field(12; "Revision Date/Time"; DateTime)
        {
            Editable = false;
        }
        field(13; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Dummy Plan No.", "Revision No.")
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

