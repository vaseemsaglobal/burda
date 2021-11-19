Table 50030 "Product Category"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Product Category" - Ads. Sales Module

    LookupPageID = "Industry Categories";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Main Category"; Code[20])
        {
        }
        field(4; "Main Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Main Category")
        {
        }
    }

    fieldgroups
    {
    }
}

