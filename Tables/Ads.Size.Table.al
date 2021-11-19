Table 50028 "Ads. Size"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Ads. Size" - Ads. Sales Module

    LookupPageID = "Ads. Size";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Counting Unit"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(5; "Ads Type Code"; Code[20])
        {
            TableRelation = "Ads. Type".Code;
        }
    }

    keys
    {
        key(Key1; "Ads Type Code", "Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }
}

