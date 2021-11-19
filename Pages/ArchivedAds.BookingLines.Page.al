Page 50101 "Archived Ads. Booking Lines"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   09.05.2007   KKE   New form for "Archived Ads. Booking Lines" - Ads. Sales Module

    Editable = false;
    PageType = Card;
    SourceTable = "Archived Ads. Booking Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(BookingNo;"Booking No.")
                {
                    ApplicationArea = Basic;
                }
                field(AdsItemNo;"Ads. Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(SalespersonCode;"Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field(SelltoCustomerNo;"Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerNo;"Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(MagazineCode;"Magazine Code")
                {
                    ApplicationArea = Basic;
                }
                field(VolumeNo;"Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueNo;"Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueDate;"Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field(BookingRevenueCode;"Booking Revenue Code")
                {
                    ApplicationArea = Basic;
                }
                field(BookingRevenueType;"Booking Revenue Type")
                {
                    ApplicationArea = Basic;
                }
                field(CountingUnit;"Counting Unit")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity;Quantity)
                {
                    ApplicationArea = Basic;
                }
                field(TotalCountingUnit;"Total Counting Unit")
                {
                    ApplicationArea = Basic;
                }
                field(BaseUnitofMeasure;"Base Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(UnitPriceExclVAT;"Unit Price Excl. VAT")
                {
                    ApplicationArea = Basic;
                }
                field(AmountIncludingVAT;"Amount Including VAT")
                {
                    ApplicationArea = Basic;
                }
                field(AdsSize;"Ads. Size")
                {
                    ApplicationArea = Basic;
                }
                field(AdsType;"Ads. Type")
                {
                    ApplicationArea = Basic;
                }
                field(AdsSubType;"Ads. Sub-Type")
                {
                    ApplicationArea = Basic;
                }
                field(AdsPosition;"Ads. Position")
                {
                    ApplicationArea = Basic;
                }
                field(AdsProduct;"Ads. Product")
                {
                    ApplicationArea = Basic;
                }
                field(OwnerCustomer;"Owner Customer")
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory;"Product Category")
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
                    RunPageLink = "No."=field("Booking No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }

    var
        AdsBookingLine: Record "Ads. Booking Line";
        SellToCustFilter: Code[20];
        BillToCustFilter: Code[20];
}

