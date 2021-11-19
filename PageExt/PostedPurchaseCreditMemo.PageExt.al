PageExtension 50044 pageextension50044 extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Buy-from Address 2")
        {
            field("Buy-from Address 3"; "Buy-from Address 3")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Pay-to Address 2")
        {
            field("Pay-to Address 3"; "Pay-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Applies-to Doc. No.")
        {
            field("Dummy Vendor"; "Dummy Vendor")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Ship-to Address 2")
        {
            field("Ship-to Address 3"; "Ship-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Adjustment Details")
        {
            group("Address (Thai)")
            {
                Caption = 'Address (Thai)';
                field("Buy-from Name (Thai)"; "Buy-from Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Buy-from Address (Thai)"; "Buy-from Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Pay-to Name (Thai)"; "Pay-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pay-to Address (Thai)"; "Pay-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Ship-to Name (Thai)"; "Ship-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ship-to Address (Thai)"; "Ship-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
            }
        }
    }
}

