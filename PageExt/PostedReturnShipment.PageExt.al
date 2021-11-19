PageExtension 50089 pageextension50089 extends "Posted Return Shipment"
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
        addafter("Ship-to Address 2")
        {
            field("Ship-to Address 3"; "Ship-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Foreign Trade")
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

