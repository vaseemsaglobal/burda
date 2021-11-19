TableExtension 50030 tableextension50030 extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Cal. WHT for any Inv. Amount"; Boolean)
        {
        }
        field(50001; "Buy-from Name (Thai)"; Text[120])
        {
            Caption = 'Buy-from Name (Thai)';
        }
        field(50002; "Buy-from Address (Thai)"; Text[200])
        {
            Caption = 'Buy-from Address (Thai)';
        }
        field(50003; "Buy-from Address 3"; Text[150])
        {
            Caption = 'Buy-from Address 3';
        }
        field(50004; "Pay-to Name (Thai)"; Text[120])
        {
            Caption = 'Pay-to Name (Thai)';
        }
        field(50005; "Pay-to Address (Thai)"; Text[200])
        {
            Caption = 'Pay-to Address (Thai)';
        }
        field(50006; "Pay-to Address 3"; Text[150])
        {
            Caption = 'Pay-to Address 3';
        }
        field(50007; "Ship-to Name (Thai)"; Text[120])
        {
            Caption = 'Ship-to Name (Thai)';
        }
        field(50008; "Ship-to Address (Thai)"; Text[200])
        {
            Caption = 'Ship-to Address (Thai)';
        }
        field(50009; "Ship-to Address 3"; Text[150])
        {
            Caption = 'Ship-to Address 3';
        }
        field(50011; "Dummy Vendor"; Boolean)
        {
        }
        field(50012; "Invoice Description"; Text[100])
        {
        }
        field(50020; "PO Type"; Code[20])
        {
            Editable = false;
            TableRelation = "PO Type";
        }
    }

}

