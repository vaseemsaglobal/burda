Table 50056 "Average VAT Setup"
{
    DrillDownPageID = "Zone Area";
    LookupPageID = "Zone Area";

    fields
    {
        field(1; Year; Integer)
        {
        }
        field(2; "From Date"; Date)
        {
        }
        field(3; "To Date"; Date)
        {
        }
        field(4; "VAT Claim %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5; "VAT Unclaim %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(6; "User ID"; Code[10])
        {
            Editable = false;
            TableRelation = User;
        }
    }

    keys
    {
        key(Key1; Year)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := UserId;
    end;
}

