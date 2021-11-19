Table 50033 "Ads. Sub Type"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Ads. Sub Type" - Ads. Sales Module

    LookupPageID = "Ads. Sub Type";

    fields
    {
        field(1;"Ads. Type";Code[20])
        {
            TableRelation = "Ads. Type";
        }
        field(2;"Code";Code[20])
        {
        }
        field(3;Description;Text[50])
        {
        }
        field(4;GroupType;Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Ads. Type","Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

