TableExtension 50016 tableextension50016 extends "Invoice Post. Buffer"
{
    fields
    {
        field(50100; "Use Average VAT"; Boolean)
        {
        }
        field(50101; "Average VAT Year"; Integer)
        {
        }
        field(50102; "VAT Claim Percentage"; Decimal)
        {
        }
        field(50105; "Deal No."; Code[20])
        {
            TableRelation = "Ads. Booking Header";
        }
        field(50106; "Sub Deal No."; Text[20])
        {

        }
        field(50107; "Publication Month"; Text[10])
        {

        }
        field(50108; Brand; Code[20])
        {

        }
        field(50109; "Salesperson Code"; Code[20])
        {

        }
    }


}

