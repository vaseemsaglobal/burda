PageExtension 50026 pageextension50026 extends "Purchase Credit Memo"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   01.02.2006   KKE   Add new fields for localization.
      Burda
      002   08.06.2007   KKE   Add Print "Account Payable Voucher"
    */
    layout
    {

        addafter("Buy-from Contact")
        {
            field("Cal. WHT for any Inv. Amount"; "Cal. WHT for any Inv. Amount")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Vendor Exchange Rate (ACY)")
        {
            field("Invoice Description"; "Invoice Description")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Adjustment Details")
        {
            group("Address (Thai)")
            {
                Caption = 'Address (Thai)';
                field("Buy-from Name (Thai)"; "Buy-from Name (Thai)")
                {
                    ApplicationArea = Basic;
                }
                field("Buy-from Address (Thai)"; "Buy-from Address (Thai)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Pay-to Name (Thai)"; "Pay-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to Address (Thai)"; "Pay-to Address (Thai)")
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
    }
    actions
    {


        addafter("P&osting")
        {
            group("&Print")
            {

                action("Account Payable Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Payable Voucher';

                    trigger OnAction()
                    var
                        PurchHeader: Record "Purchase Header";
                    begin
                        //KKE : #002 +
                        PurchHeader.Reset;
                        PurchHeader.SetRange("Document Type", "Document Type");
                        PurchHeader.SetRange("No.", "No.");
                        Report.Run(Report::"Account Payable Voucher -Pre.", true, false, PurchHeader);
                        //KKE : #002 -
                    end;
                }
            }
        }
    }
}

