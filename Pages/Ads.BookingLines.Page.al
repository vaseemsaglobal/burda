Page 50100 "Ads. Booking Lines"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   09.05.2007   KKE   New form for "Ads. Booking Lines" - Ads. Sales Module

    Editable = false;
    PageType = List;
    SourceTable = "Ads. Booking Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(BookingNo; "Deal No.")
                {
                    ApplicationArea = Basic;
                }
                field(LineNo; "Line No.")
                {
                    ApplicationArea = Basic;
                }
                field(AdsItemNo; "Ads. Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(LineStatus; "Line Status")
                {
                    ApplicationArea = Basic;
                }
                field(SalespersonCode; "Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000058; Salesperson.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salesperson Name';
                }
                field(SelltoCustomerNo; "Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(MagazineCode; "Sub Product Code")
                {
                    ApplicationArea = Basic;
                }
                field(VolumeNo; "Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueNo; "Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueDate; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field(BookingRevenueCode; "Ads. Type Code (Revenue Type Code)")
                {
                    ApplicationArea = Basic;
                }
                field(BookingRevenueType; "Booking Revenue Type")
                {
                    ApplicationArea = Basic;
                }
                field(CountingUnit; "Counting Unit")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Basic;
                }
                field(TotalCountingUnit; "Total Counting Unit")
                {
                    ApplicationArea = Basic;
                }
                field(BaseUnitofMeasure; "Base Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(UnitPriceExclVAT; "Unit Price Excl. VAT")
                {
                    ApplicationArea = Basic;
                }
                field(AmountIncludingVAT; "Amount Including VAT")
                {
                    ApplicationArea = Basic;
                }
                field(AdsSize; "Ads. Size Code")
                {
                    ApplicationArea = Basic;
                }
                field(AdsType; "Ads. Type")
                {
                    ApplicationArea = Basic;
                }
                field(AdsSubType; "Ads. Sub-Type")
                {
                    ApplicationArea = Basic;
                }
                field(AdsPosition; "Ads. Position Code")
                {
                    ApplicationArea = Basic;
                }
                field(AdsProduct; "Brand Code")
                {
                    ApplicationArea = Basic;
                }
                field(OwnerCustomer; "Owner Customer")
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory; "Industry Category Code")
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
                    RunObject = Page "Ads. Booking";
                    RunPageLink = "No." = field("Deal No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if not Salesperson.Get("Salesperson Code") then
            Clear(Salesperson);
    end;

    var
        AdsBookingLine: Record "Ads. Booking Line";
        Salesperson: Record "Salesperson/Purchaser";
        SellToCustFilter: Code[20];
        BillToCustFilter: Code[20];
}

