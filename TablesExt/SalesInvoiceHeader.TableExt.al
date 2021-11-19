TableExtension 50025 tableextension50025 extends "Sales Invoice Header"
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
        field(50020; "Get by Circulation Receipt"; Boolean)
        {
            CalcFormula = - exist("Sales Invoice Line" where("Document No." = field("No."),
                                                             "Circulation Receipt No." = filter(''),
                                                             Type = filter(<> " ")));
            Description = 'Burda1.00';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; Open; Boolean)
        {
            CalcFormula = lookup("Cust. Ledger Entry".Open where("Customer No." = field("Bill-to Customer No."),
                                                                  "Document No." = field("No."),
                                                                  "Posting Date" = field("Posting Date")));
            Description = 'Burda1.00';
            Editable = false;
            FieldClass = FlowField;
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
        field(50025; "PO No."; Code[20])
        {
            Description = 'Burda1.00';
        }
        field(50026; "Remark 1"; Text[100])
        {
            Description = 'Burda1.00';
        }
        field(50027; "Remark 2"; Text[100])
        {
            Description = 'Burda1.00';
        }
        field(50028; "No. of Circulation Receipt"; Integer)
        {
            CalcFormula = count("Circulation Receipt Line" where("Document Type" = const(Invoice),
                                                                  "Document No." = field("No."),
                                                                  "Deposit Amount" = filter(0)));
            Description = 'Burda1.00';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50098; "Product (Ads. Invoice)"; Text[50])
        {
            Caption = 'Brand';
            //Description = 'Burda1.00';
        }
        field(50096; "Invoice Type"; Option)
        {
            OptionMembers = ,Revenue,Deferred;
        }
    }


}

