PageExtension 50034 pageextension50034 extends "User Setup"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   02.03.2007   KKE   Petty Cash and Cash Advance.
      Burda
      002   08.05.2007   KKE   Ads Sales Module - Add fields
    */
    layout
    {

        addafter("Service Resp. Ctr. Filter")
        {
            field("Magazine Filter"; "Magazine Filter")
            {
                ApplicationArea = Basic;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Magazine: Record "Sub Product";
                begin
                    if PAGE.RunModal(0, Magazine) = Action::LookupOK then begin
                        Text := Magazine."Sub Product Code";
                        exit(true);
                    end;
                end;
            }
            field("Ads. Booking Filter"; "Ads. Booking Filter")
            {
                ApplicationArea = Basic;
            }
            field("Salesperson Code"; "Salesperson Code")
            {
                ApplicationArea = Basic;
            }
            field("Allow Confirm Ads. Booking"; "Allow Confirm Ads. Booking")
            {
                ApplicationArea = Basic;
            }
            field("Allow Cancel Ads. Booking"; "Allow Cancel Ads. Booking")
            {
                ApplicationArea = Basic;
            }
            field("Allow Approve Ads. Booking"; "Allow Approve Ads. Booking")
            {
                ApplicationArea = Basic;
            }
            field("Allow Hold Ads. Booking"; "Allow Hold Ads. Booking")
            {
                ApplicationArea = Basic;
            }
            field("Allow Close Ads. Booking"; "Allow Close Ads. Booking")
            {
                ApplicationArea = Basic;
            }
            field("Allow Create Ads. Invoice"; "Allow Create Ads. Invoice")
            {
                ApplicationArea = Basic;
            }
            field("Sales Posting Option"; "Sales Posting Option")
            {
                ApplicationArea = Basic;
            }
            field("Purchase Posting Option"; "Purchase Posting Option")
            {
                ApplicationArea = Basic;
            }
            field("Allow Change Issue Date"; "Allow Change Issue Date")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Allow Unblock Bank Cheque"; "Allow Unblock Bank Cheque")
            {
                ApplicationArea = Basic;
            }
            field("Allow Post Petty Cash Invoice"; "Allow Post Petty Cash Invoice")
            {
                ApplicationArea = Basic;
            }
            field("Allow Post Cash Adv. Invoice"; "Allow Post Cash Adv. Invoice")
            {
                ApplicationArea = Basic;
            }
            field("Manual Approval"; "Manual Approval")
            {
                ApplicationArea = All;

            }
        }
    }
}

