TableExtension 50006 tableextension50006 extends "Cust. Ledger Entry"
{
    fields
    {
        field(50020; "Used By Ads. Billing No."; Code[20])
        {
            CalcFormula = lookup("Ads. Billing Line"."Billing No." where("Cust. Ledger Entry No." = field("Entry No.")));
            Description = 'Burda1.00';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "Deal No."; Code[20])
        {
            TableRelation = "Ads. Booking Header";
        }
    }


    keys
    {

        //Unsupported feature: Property Deletion (Enabled) on ""Customer No.",Open,Positive,"Calculate Interest","Due Date"(Key)".

    }

}

