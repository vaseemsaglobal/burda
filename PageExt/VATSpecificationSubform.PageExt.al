PageExtension 50072 pageextension50072 extends "VAT Specification Subform"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   25.01.2006   KKE   Fix error when change value on "VAT Amount".
      Burda
      002   16.07.2007   KKE   Average VAT
    */
    layout
    {
        addafter("Amount Including VAT")
        {
            field("VAT Claim %"; "VAT Claim %")
            {
                ApplicationArea = Basic;
            }
            field("Avg. VAT Amount"; "Avg. VAT Amount")
            {
                ApplicationArea = Basic;
            }
        }
    }



}

