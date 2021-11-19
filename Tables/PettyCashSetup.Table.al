Table 55000 "Petty Cash Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.

    Caption = 'Petty Cash Setup';

    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2;"Petty Cash Nos.";Code[10])
        {
            Caption = 'Petty Cash Nos.';
            TableRelation = "No. Series";
        }
        field(3;"Bank Account No.";Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(4;"Petty Cash Account No.";Code[20])
        {
            Caption = 'Petty Cash Account No.';
            TableRelation = "G/L Account";
        }
        field(5;"Allow VAT Difference";Boolean)
        {
            Caption = 'Allow VAT Difference';
        }
        field(6;"Settle Petty Cash Nos.";Code[10])
        {
            Caption = 'Settle Petty Cash Nos.';
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

