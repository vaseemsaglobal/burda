TableExtension 50026 tableextension50026 extends "Sales Invoice Line"
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
        field(50090; "Use VAT Announce Price"; Boolean)
        {
        }
        field(50091; "Org. VAT Base Amount"; Decimal)
        {
        }
        field(51000; "Report Issuedate"; Date)
        {
            Description = 'Burda1.00';
        }
        field(50092; "Deal No."; Code[20])
        {
            TableRelation = "Ads. Booking Header"."No.";
        }
        field(50093; "Sub Deal No."; Text[30])
        {

        }
        field(50094; "Publication Month"; Text[10])
        {

        }
        field(50095; Brand; Code[20])
        {

        }
        field(50096; "Invoice Type"; Option)
        {
            OptionMembers = ,Revenue,Deferred;
        }
    }
    keys
    {

        key(Key2; "Sales Tax Invoice/Receipt No.", "Sales Tax Invoice/Receipt Line")
        {
        }

    }

}

