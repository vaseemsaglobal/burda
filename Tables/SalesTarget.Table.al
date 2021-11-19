Table 50035 "Sales Target"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Sales Target" - Ads. Sales Module


    fields
    {
        field(1;"Salesperson Code";Code[10])
        {
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                if not Salesperson.Get("Salesperson Code") then
                  Clear(Salesperson);

                "Salesperson Name" := Salesperson.Name;
            end;
        }
        field(2;"Salesperson Name";Text[50])
        {
        }
        field(3;"Start Date";Date)
        {
        }
        field(4;"End Date";Date)
        {
        }
        field(5;"Target Sales Amount";Decimal)
        {
            AutoFormatType = 1;
        }
    }

    keys
    {
        key(Key1;"Salesperson Code","Start Date","End Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Salesperson: Record "Salesperson/Purchaser";
}

