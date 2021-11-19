table 50059 "Booking Ledger Entry"
{
    Caption = 'Booking Ledger Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(30; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(40; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(50; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = ,"Revenue Invoice","Prepayment Invoice",Payment,"JV(Accured/Deffered)";
            DataClassification = ToBeClassified;
        }
        field(60; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionMembers = ,"Revenue Recognized","Deferred Revenue",Accured;
            DataClassification = ToBeClassified;
        }
        field(70; "Deal No."; Code[20])
        {
            Caption = 'Deal No.';
            DataClassification = ToBeClassified;
        }
        field(80; "Sub Deal No."; Code[20])
        {
            Caption = 'Sub Deal No.';
            DataClassification = ToBeClassified;
        }
        field(90; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(100; "GL Acc No."; Code[20])
        {
            Caption = 'GL Acc No.';
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
