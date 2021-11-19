Table 50002 "General Master Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // PTH : Phitsanu Thoranasoonthorn
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New table for General Master Setup
    // 002   02.07.2008   PTH   Add New 2 Option for Filed "Type" ...,Credit Card Type,Call Category,Complaint Topic.

    Caption = 'General Master Setup';
    LookupPageID = "General Master Setup List";

    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = Occupation,Position,Education,"Zone Area","Customer Type","Resource Lead","Resource Channel",,"Credit Card Bank","Credit Card Type","Call Category","Complaint Topic","Revenue Status","Payment Status","Publication Month";
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; code, Description) { }
    }
}

