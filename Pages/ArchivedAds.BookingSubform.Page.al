Page 50052 "Archived Ads. Booking Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   09.05.2007   KKE   New form for "Archived Ads. Booking Subform" - Ads. Sales Module
    // 002   19.10.2010   GKU   Add field "Status Date"

    Editable = false;
    PageType = ListPart;
    SourceTable = "Archived Ads. Booking Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(AdsItemNo;"Ads. Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(MagazineCode;"Magazine Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(VolumeNo;"Volume No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(IssueNo;"Issue No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(IssueDate;"Issue Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AdsClosingDate;"Ads. Closing Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(VATBusPostingGroup;"VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(VATProdPostingGroup;"VAT Prod. Posting Group")
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
                field(ShortcutDimension5Code;"Shortcut Dimension 5 Code")
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
                    Visible = false;
                }
                field(ProductCategory;"Product Category")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(CountingUnit;"Counting Unit")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity;Quantity)
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
                field(CashInvoiceAmount;"Cash Invoice Amount")
                {
                    ApplicationArea = Basic;
                }
                field(BillRevenueGLAccount;"Bill Revenue G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(BarterAmount;"Barter Amount")
                {
                    ApplicationArea = Basic;
                }
                field(BarterGLAccount;"Barter G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(BarterRequiredDocument;"Barter Required Document")
                {
                    ApplicationArea = Basic;
                }
                field(CreateSalesInvoice;"Create Sales Invoice")
                {
                    ApplicationArea = Basic;
                }
                field(RequireContract;"Require Contract")
                {
                    ApplicationArea = Basic;
                }
                field(HaveArtwork;"Have Artwork")
                {
                    ApplicationArea = Basic;
                }
                field(Contactpersonforartwork;"Contact person for artwork")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(TotalNumberofInsertion;"Total Number of Insertion")
                {
                    ApplicationArea = Basic;
                }
                field(ActualSubPageNo;"Actual Sub Page No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ComplimentaryOffer;"Complimentary Offer")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(LineStatus;"Line Status")
                {
                    ApplicationArea = Basic;
                }
                field(CancelledDate;"Cancelled Date")
                {
                    ApplicationArea = Basic;
                }
                field(WaitingListNo;"Waiting List No.")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduledInvoiceDate;"Scheduled Invoice Date")
                {
                    ApplicationArea = Basic;
                }
                field(BookingDate;"Booking Date")
                {
                    ApplicationArea = Basic;
                }
                field(CashInvoiceNo;"Cash Invoice No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BarterInvoiceNo;"Barter Invoice No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Closed;Closed)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

