Page 50046 "Ads. Item List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "Ads. Item";
    CardPageId = "Ads. Item";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(AdsItemNo; "Ads. Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Product Code"; "Product Code")
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
                field(BaseUnitofMeasure; "Base Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(AdsClosingDate; "Ads. Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                }
                field(VATProdPostingGroup; "VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(BookingLine; "Booking Line")
                {
                    ApplicationArea = Basic;
                }
                field(ConfirmedBooking; "Confirmed Booking")
                {
                    ApplicationArea = Basic;
                }
                field(WaitingListBooking; "Waiting List Booking")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedBooking; "Approved Booking")
                {
                    ApplicationArea = Basic;
                }
                field(HoldBooking; "Hold Booking")
                {
                    ApplicationArea = Basic;
                }
                field(CancelledBooking; "Cancelled Booking")
                {
                    ApplicationArea = Basic;
                }
                field(InvoicedBooking; "Invoiced Booking")
                {
                    ApplicationArea = Basic;
                }
                field(ClosedBooking; "Closed Booking")
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
            group(AdsItem)
            {
                Caption = '&Ads. Item';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Ads. Item";
                    RunPageLink = "Ads. Item No." = field("Ads. Item No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

