PageExtension 50035 pageextension50035 extends "Posted Sales Shipment"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   01.02.2006   KKE   Add new fields for localization.
    */
    layout
    {
        addafter("Sell-to Address 2")
        {
            field("Sell-to Address 3"; "Sell-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Bill-to Address 2")
        {
            field("Bill-to Address 3"; "Bill-to Address 3")
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
        addafter(Billing)
        {
            group("Address (Thai)")
            {
                Caption = 'Address (Thai)';
                field("Sell-to Name (Thai)"; "Sell-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sell-to Address (Thai)"; "Sell-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Bill-to Name (Thai)"; "Bill-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bill-to Address (Thai)"; "Bill-to Address (Thai)")
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
        moveafter("Sell-to Contact"; "Posting Date")
    }
}

