TableExtension 50063 tableextension50063 extends "WHT Entry"
{
    fields
    {

        modify("Actual Vendor No.")
        {
            TableRelation = Vendor;
        }


        field(50000; "Dummy Vendor"; Boolean)
        {
        }
        field(50001; "VAT Registration No.(Dummy)"; Text[20])
        {
            Caption = 'VAT Registration No.(Dummy)';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
            end;
        }
        field(50002; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            Editable = false;
        }
        field(50003; Cancelled; Boolean)
        {
        }
        field(50010; "Certificate Printed"; Boolean)
        {

        }
    }
    keys
    {

    }


}

