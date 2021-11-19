TableExtension 50033 tableextension50033 extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; "Applies-to Doc. No."; Code[20])
        {
        }
        field(50001; "Applies-to Line No."; Integer)
        {
            TableRelation = "Purch. Inv. Line"."Line No." where("Document No." = field("Applies-to Doc. No."));
        }
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
    }

}

