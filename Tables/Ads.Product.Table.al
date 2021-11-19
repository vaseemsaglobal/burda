Table 50031 Brand
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Ads. Product" - Ads. Sales Module
    // 002   15.10.2008   KKE   Add new field "Product Group"

    LookupPageID = Brands;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Indutry Category"; Code[20])
        {
            TableRelation = "Product Category";
        }
        field(4; "Owner Customer"; Code[20])
        {
            TableRelation = Customer;
        }
        field(5; "Short Description"; Text[15])
        {
        }
        field(6; "Product Group"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

