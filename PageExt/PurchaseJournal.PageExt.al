PageExtension 50054 pageextension50054 extends "Purchase Journal"
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

        addafter(Description)
        {

            field("Average VAT Year"; "Average VAT Year")
            {
                ApplicationArea = Basic;
            }
            field("VAT Claim %"; "VAT Claim %")
            {
                ApplicationArea = Basic;
            }
            field("Use Average VAT"; "Use Average VAT")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {


        addfirst(Processing)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Purchase Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Purchase Voucher';

                    trigger OnAction()
                    begin
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        GenJnlLine.SetRange("Document No.", "Document No.");
                        Report.Run(Report::"Purchase Voucher", true, false, GenJnlLine);
                    end;
                }
            }
        }
    }



    var
        GenJnlLine: Record "Gen. Journal Line";
}

