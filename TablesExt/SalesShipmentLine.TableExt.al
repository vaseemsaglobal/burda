TableExtension 50024 tableextension50024 extends "Sales Shipment Line"
{
    fields
    {
        field(50020; "Subscriber Contract No."; Code[20])
        {
            Editable = false;
            TableRelation = "Subscriber Contract";
        }
    }



}

