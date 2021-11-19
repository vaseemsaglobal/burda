TableExtension 50005 tableextension50005 extends Customer
{
    fields
    {
        field(50000; "Name (Thai)"; Text[120])
        {
        }
        field(50001; "Address (Thai)"; Text[200])
        {
        }
        field(50002; "Address 3"; Text[150])
        {
        }
        field(50020; "Shipping Agent"; Boolean)
        {
            Description = 'Burda1.00';
        }
        field(50021; "Customer Type"; Code[10])
        {
            Description = 'Burda1.00';
            TableRelation = "General Master Setup".Code where(Type = const("Customer Type"));
        }
        field(50022; "Zone Area"; Code[20])
        {
            Description = 'Burda1.00';
            TableRelation = "Zone Area";
        }
        field(50023; "Have Credit Problem"; Boolean)
        {
            Description = 'Burda1.00';
        }
        field(50024; Branch; Text[50])
        {

        }
        field(50025; "Branch No."; text[5])
        {

        }
    }
}

