Table 50000 "Subscription Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New table for Subscription,Magazine and Ads. Setup.
    // 002   02.07.2008   PTH   Add Field "Complaint NOS."


    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2;"Subscriber Nos.";Code[10])
        {
            Caption = 'Subscriber Nos.';
            TableRelation = "No. Series";
        }
        field(3;"Promotion Nos.";Code[10])
        {
            Caption = 'Promotion Nos.';
            TableRelation = "No. Series";
        }
        field(4;"Subscriber Contract Nos.";Code[10])
        {
            TableRelation = "No. Series";
        }
        field(5;"Deposit Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(6;"Def. Pmt. Method for Delivery";Code[10])
        {
            TableRelation = "Payment Method";
        }
        field(13;"Posted Invoice Nos.";Code[10])
        {
            Caption = 'Posted Invoice Nos.';
            TableRelation = "No. Series";
        }
        field(15;"Posted Credit Memo Nos.";Code[10])
        {
            Caption = 'Posted Credit Memo Nos.';
            TableRelation = "No. Series";
        }
        field(16;"Customer Nos.";Code[10])
        {
            TableRelation = "No. Series";
        }
        field(20;"Delivery Location Code";Code[10])
        {
            TableRelation = Location;
        }
        field(21;"Complaint Nos.";Code[10])
        {
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

