PageExtension 50086 pageextension50086 extends "Sales Return Order"
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
            }
        }
        addafter(Status)
        {
            field("Applied-to Tax Invoice"; "Applied-to Tax Invoice")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Bill-to Address 2")
        {
            field("Bill-to Address 3"; "Bill-to Address 3")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Bill-to Contact")
        {
            field("Posting Description"; "Posting Description")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Posting No. Series"; "Posting No. Series")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Ship-to Address 2")
        {
            field("Ship-to Address 3"; "Ship-to Address 3")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Adjustment Details")
        {
            group("Address (Thai)")
            {
                Caption = 'Address (Thai)';
                field("Sell-to Name (Thai)"; "Sell-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Address (Thai)"; "Sell-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Bill-to Name (Thai)"; "Bill-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Address (Thai)"; "Bill-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Ship-to Name (Thai)"; "Ship-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Address (Thai)"; "Ship-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
            }
        }
        moveafter("Sell-to Contact"; "Posting Date")
    }
}

