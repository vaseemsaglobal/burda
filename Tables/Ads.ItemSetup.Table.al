Table 50026 "Ads. Item Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Ads. Item Setup" - Ads. Sales Module


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Default Base UOM"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(3; "Ads. Revenue Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4; "Booking Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(5; "Billing Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(6; "Lock Ads. Closing Date"; Boolean)
        {
        }
        field(7; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(8; "Ads. Sales Invoice Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(9; "Allow Duplicate Billing Line"; Boolean)
        {
        }
        field(13; "Posted Invoice Nos."; Code[10])
        {
            Caption = 'Posted Invoice Nos.';
            TableRelation = "No. Series";
        }
        field(20; "Deffered A/C No."; Code[20])
        {
            TableRelation = "G/L Account";

        }
        field(30; "Accrued A/C No."; code[20])
        {
            TableRelation = "G/L Account";
        }
        field(40; "Ads. Sales Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50; "Ads. Sales Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Ads. Sales Template"));
        }
        field(60; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(70; "Enable Email Approval"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

