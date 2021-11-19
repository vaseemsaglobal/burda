PageExtension 50056 pageextension50056 extends "Source Code Setup"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization Demo TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   24.08.2006   KKE   -Petty Cash
      002   30.08.2006   KKE   -Cash Advance
      */
    Caption = 'Source Code Setup';
    layout
    {
        modify(Service)
        {
            Caption = 'Service';
        }
        addafter("Compress Vend. Ledger")
        {
            field("Petty Cash"; "Petty Cash")
            {
                ApplicationArea = Basic;
            }
            field("Cash Advance"; "Cash Advance")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

