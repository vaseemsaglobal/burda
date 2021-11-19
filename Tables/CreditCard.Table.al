Table 50003 "Credit Card"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New table for Credit Card - Subscription Module


    fields
    {
        field(1;Bank;Code[10])
        {
            TableRelation = "General Master Setup".Code where (Type=const("Credit Card Bank"));
        }
        field(2;"Credit Card Type";Code[10])
        {
            TableRelation = "General Master Setup".Code where (Type=const("Credit Card Type"));
        }
        field(3;"Start Date";Date)
        {
        }
        field(4;"End Date";Date)
        {
        }
        field(5;"% Charge Fee (Cust.)";Decimal)
        {
            DecimalPlaces = 0:2;
            MaxValue = 100;
            MinValue = 0;
        }
        field(6;"VAT % for Charge Fee";Decimal)
        {
            DecimalPlaces = 0:2;
            MaxValue = 100;
            MinValue = 0;
        }
        field(7;"% Charge Fee (Bank)";Decimal)
        {
            DecimalPlaces = 0:2;
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1;Bank,"Credit Card Type","Start Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

