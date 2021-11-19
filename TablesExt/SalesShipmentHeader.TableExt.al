TableExtension 50023 tableextension50023 extends "Sales Shipment Header"
{
    fields
    {
        field(50001; "Sell-to Name (Thai)"; Text[50])
        {
            Caption = 'Sell-to Name (Thai)';
            Description = 'Reduce Size 120->50';
        }
        field(50002; "Sell-to Address (Thai)"; Text[50])
        {
            Caption = 'Sell-to Address (Thai)';
            Description = 'Reduce Size 200->50';
        }
        field(50003; "Sell-to Address 3"; Text[150])
        {
            Caption = 'Sell-to Address 3';
        }
        field(50004; "Bill-to Name (Thai)"; Text[120])
        {
            Caption = 'Bill-to Name (Thai)';
        }
        field(50005; "Bill-to Address (Thai)"; Text[200])
        {
            Caption = 'Bill-to Address (Thai)';
        }
        field(50006; "Bill-to Address 3"; Text[150])
        {
            Caption = 'Bill-to Address 3';
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
        field(50026; "Remark 1"; Text[100])
        {
            Description = 'Burda1.00';
        }
        field(50027; "Remark 2"; Text[100])
        {
            Description = 'Burda1.00';
        }
    }

}

