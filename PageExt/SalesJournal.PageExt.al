PageExtension 50053 pageextension50053 extends "Sales Journal"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   01.02.2006   KKE   Add print button for localization.
    */
    layout
    {

    }
    actions
    {

        addfirst(Processing)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Sales Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sales Voucher';

                    trigger OnAction()
                    begin
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        GenJnlLine.SetRange("Document No.", "Document No.");
                        Report.Run(Report::"Sales Voucher", true, false, GenJnlLine);
                    end;
                }
            }
        }
    }



    var
        GenJnlLine: Record "Gen. Journal Line";
}

