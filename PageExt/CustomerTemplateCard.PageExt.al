PageExtension 50078 pageextension50078 extends "Customer Template Card"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Burda (Thailand) Co., Ltd
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   27.03.2007   KKE   New field for WHT Bus.
    */
    layout
    {
        addafter("VAT Bus. Posting Group")
        {
            field("WHT Business Posting Group"; "WHT Business Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
    }

}

