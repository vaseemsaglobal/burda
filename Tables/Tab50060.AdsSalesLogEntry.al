table 50060 "Ads. Sales Log Entry"
{
    Caption = 'Ads. Sales Log Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Creation Date Time"; DateTime)
        {
            Caption = 'Creation Date Time';
            DataClassification = ToBeClassified;
        }
        field(3; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(4; "Documnet Type"; Option)
        {
            Caption = 'Documnet Type';
            OptionMembers = Revenue,Deferred,JV;
            DataClassification = ToBeClassified;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Deal No."; Code[20])
        {
            Caption = 'Deal No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Sub Deal No."; Code[20])
        {
            Caption = 'Sub Deal No.';
            DataClassification = ToBeClassified;
        }
        field(8; Deleted; Boolean)
        {
            Caption = 'Deleted';
            DataClassification = ToBeClassified;
        }
        field(9; "Deleted By"; Code[20])
        {
            Caption = 'Deleted By';
            DataClassification = ToBeClassified;
        }
        field(10; "Remark From Accountant"; Text[120])
        {
            Caption = 'Remark From Accountant';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}
