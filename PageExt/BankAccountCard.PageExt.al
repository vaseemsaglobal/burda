PageExtension 50062 pageextension50062 extends "Bank Account Card"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   11.04.2005   KKE   -Add field "Format Cheque".
    */
    layout
    {
        modify(Transfer)
        {
            Caption = 'Transfer';
        }
        addafter("Balance Last Statement")
        {
            field("Format Cheque"; "Format Cheque")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {

        modify("Receivables-Payables")
        {
            Caption = 'Receivables-Payables';
        }
        modify("Cash Receipt Journals")
        {
            Caption = 'Cash Receipt Journals';
        }
        modify("Payment Journals")
        {
            Caption = 'Payment Journals';
        }
        modify(List)
        {
            Caption = 'List';
        }
        modify("Detail Trial Balance")
        {
            Caption = 'Detail Trial Balance';
        }
        modify(Action1906306806)
        {
            Caption = 'Receivables-Payables';
        }
        modify("Check Details")
        {
            Caption = 'Check Details';
        }
    }



}

