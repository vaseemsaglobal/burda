TableExtension 50028 tableextension50028 extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50020; "Subscriber Contract No."; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Subscriber Contract";
        }
        field(50021; "Agent Customer No."; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Agent Customer Header";
        }
        field(50022; "Circulation Receipt No."; Code[20])
        {
            Description = 'Burda1.00';
            TableRelation = "Circulation Receipt Header";
        }
        field(50023; "Ads. Sales Type"; Code[10])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "General Master Setup".Code where(Type = const("Customer Type"));
        }
        field(50024; "Zone Area"; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Zone Area";
        }
        field(50025; "Ads. Booking No."; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Ads. Booking Header";
        }
        field(50026; "Ads. Booking Line No."; Integer)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50027; "Last Pick-up Date"; Date)
        {
            CalcFormula = lookup(Item."Last Pick-up Date" where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50062; "Sales Tax Invoice/Receipt No."; Code[20])
        {
            Description = 'Burda1.00';
        }
        field(50063; "Sales Tax Invoice/Receipt Line"; Integer)
        {
            Description = 'Burda1.00';
        }
    }
    keys
    {

        key(Key2; "Sales Tax Invoice/Receipt No.", "Sales Tax Invoice/Receipt Line")
        {
        }
    }

}

