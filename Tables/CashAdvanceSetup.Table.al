Table 55050 "Cash Advance Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.

    Caption = 'Cash Advance Setup';

    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2;"Cash Advance Nos.";Code[10])
        {
            Caption = 'Cash Advance Nos.';
            TableRelation = "No. Series";
        }
        field(3;"Bank Account No.";Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(4;"Cash Advance Account No.";Code[20])
        {
            Caption = 'Cash Advance Account No.';
            TableRelation = "G/L Account";
        }
        field(5;"Allow VAT Difference";Boolean)
        {
            Caption = 'Allow VAT Difference';
        }
        field(6;"Settle Cash Advance Nos.";Code[10])
        {
            Caption = 'Settle Cash Advance Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

