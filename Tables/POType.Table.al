Table 50014 "PO Type"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New table for "PO Type" - Purchase Module

    DrillDownPageID = "PO Type Setup";
    LookupPageID = "PO Type Setup";

    fields
    {
        field(1;"PO Type Code";Code[20])
        {
        }
        field(2;Description;Text[50])
        {
        }
        field(3;"Nos. for PO";Code[10])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1;"PO Type Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

