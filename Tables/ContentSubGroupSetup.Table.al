Table 50016 "Content Sub Group Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New table for "Content Sub Type Setup" - Editorial Module

    LookupPageID = "Content Sub Group Setup";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";
        }
        field(3; Description; Text[50])
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

