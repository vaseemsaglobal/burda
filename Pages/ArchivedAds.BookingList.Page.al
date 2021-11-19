Page 50053 "Archived Ads. Booking List"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   09.05.2007   KKE   New form for "Archvied Ads. Booking List" - Ads. Sales Module
    UsageCategory = History;
    ApplicationArea = all;
    Editable = false;
    CardPageId = "Archived Ads. Booking";
    PageType = List;
    SourceTable = "Archived Ads. Booking Header";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(BookingDate; "Booking Date")
                {
                    ApplicationArea = Basic;
                }
                field(SalespersonCode; "Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field(SelltoCustomerNo; "Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentTermsCode; "Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field(SelltoCustomerType; "Sell-to Customer Type")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerType; "Bill-to Customer Type")
                {
                    ApplicationArea = Basic;
                }
                field(ZoneArea; "Zone Area")
                {
                    ApplicationArea = Basic;
                }
                field(Contact; Contact)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Line)
            {
                Caption = '&Line';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Archived Ads. Booking";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

