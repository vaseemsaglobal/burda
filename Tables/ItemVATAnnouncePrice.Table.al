Table 50090 "Item VAT Announce Price"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   01.02.2006   KKE   LOC-VAT-001.


    fields
    {
        field(1;"Item No.";Code[20])
        {
            TableRelation = Item;
        }
        field(2;"VAT Type";Option)
        {
            OptionMembers = "Input VAT","Output VAT";
        }
        field(3;"Starting Date";Date)
        {
        }
        field(4;"Ending Date";Date)
        {
        }
        field(5;"Announce Price";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Item No.","VAT Type","Starting Date","Ending Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

