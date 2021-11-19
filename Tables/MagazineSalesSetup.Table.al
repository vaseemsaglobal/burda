Table 50007 "Magazine Sales Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New table for Magazine Sales Setup


    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2;"Default Base UOM";Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(3;"Default Costing Method";Option)
        {
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(4;"Default Gen. Prod. Posting";Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(5;"Default VAT Prod. Posting Grou";Code[10])
        {
            Caption = 'Default VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(6;"Default WHT Prod. Posting Grou";Code[10])
        {
            Caption = 'Default WHT Prod. Posting Group';
            TableRelation = "WHT Product Posting Group";
        }
        field(7;"Default Inventory Posting Grou";Code[10])
        {
            Caption = 'Default Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(10;"Agent Customer Nos.";Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11;"Circulation Billing Nos.";Code[10])
        {
            TableRelation = "No. Series";
        }
        field(12;"Circulation Receipt Nos.";Code[10])
        {
            TableRelation = "No. Series";
        }
        field(13;"Posted Invoice Nos.";Code[10])
        {
            Caption = 'Posted Invoice Nos.';
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

