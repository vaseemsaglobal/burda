TableExtension 50045 tableextension50045 extends "VAT Amount Line"
{
    fields
    {

        field(50000; "VAT Claim %"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50001; "VAT Unclaim %"; Decimal)
        {
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50002; "Avg. VAT Amount"; Decimal)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50003; "Avg. VAT Amount (ACY)"; Decimal)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50004; "Average VAT Year"; Integer)
        {
            Description = 'Burda1.00';
            TableRelation = "Average VAT Setup";
        }
        field(50090; "VAT Announce Price"; Decimal)
        {
        }
        field(50091; "Org. VAT Base"; Decimal)
        {
        }
    }

}

