PageExtension 50033 pageextension50033 extends "General Ledger Setup"
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
        addafter("Round Amount for WHT Calc")
        {
            field("Max. WHT Difference Allowed"; "Max. WHT Difference Allowed")
            {
                ApplicationArea = Basic;
            }
            field("Min. WHT Calc only on Inv. Amt"; "Min. WHT Calc only on Inv. Amt")
            {
                ApplicationArea = Basic;
            }

            field("Enable VAT Average"; "Enable VAT Average")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("Full GST on Prepayment"; "Interest Cal Excl. VAT")
    }



}

