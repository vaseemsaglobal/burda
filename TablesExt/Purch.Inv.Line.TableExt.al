TableExtension 50031 tableextension50031 extends "Purch. Inv. Line"
{
    fields
    {
        field(50020; "VAT Claim %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50021; "VAT Unclaim %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50022; "Avg. VAT Amount"; Decimal)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50024; "Average VAT Year"; Integer)
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Average VAT Setup";
        }
        field(50090; "Use VAT Announce Price"; Boolean)
        {
        }
        field(50091; "Org. VAT Base Amount"; Decimal)
        {
        }
    }

}

