Page 50049 "Ads. Booking Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Ads. Booking Subform" - Ads. Sales Module

    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = "Ads. Booking Line";
    SourceTableView = sorting("Deal No.", "Subdeal No.") order(ascending);
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Product Code"; "Product Code")
                {
                    ApplicationArea = Basic;

                }
                field("Product Name"; "Product Name")
                {
                    ApplicationArea = Basic;

                }
                field("Sub Product Code"; "Sub Product Code")
                {
                    ApplicationArea = Basic;
                    //Visible = false;
                }
                field(SubProdName; SubProdName)
                {
                    Caption = 'Sub Product Name';
                    Editable = false;
                    ApplicationArea = Basic;

                }
                field("Sub Deal No."; "Subdeal No.")
                {
                    ApplicationArea = Basic;

                }
                field(BookingRevenueCode; "Ads. Type Code (Revenue Type Code)")
                {
                    ApplicationArea = Basic;
                }
                field(BookingRevenueDescription; BookingRev.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Type Name';
                    Editable = false;
                }
                field(AdsPosition; "Ads. Position Code")
                {
                    Caption = 'Ads. Position Code';
                    ApplicationArea = Basic;
                }
                field(Control1000000093; AdsPosition.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Position Name';
                    Editable = false;
                }
                field("Publication Date"; "Publication Date")
                {
                    Visible = false;
                    ApplicationArea = Basic;

                }
                field("Publication Month"; "Publication Month")
                {
                    ApplicationArea = Basic;
                    trigger onvalidate()
                    var
                        myInt: Integer;
                    begin
                        //if "Publication Month" <> '' then
                        //  evaluate("Publication Date", Format("Publication Month") + '-01');
                    end;

                }
                field(LineStatus; "Line Status")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(AdsSize; "Ads. Size Code")
                {
                    Caption = 'Ads. Size Code';
                    ApplicationArea = Basic;
                }
                field(Control1000000097; AdsSize.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Size Description';
                    Editable = false;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Basic;
                }
                field(VATProdPostingGroup; "VAT Prod. Posting Group")
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
                field(AdsProduct; "Brand Code")
                {
                    Caption = 'Brand Code';
                    ApplicationArea = Basic;
                }
                field(Control1000000103; AdsProduct.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Brand Name';
                    Editable = false;
                }
                field(ProductCategory; "Industry Category Code")
                {
                    Caption = 'Industry Category Code';
                    ApplicationArea = Basic;
                }
                field(Control1000000107; ProductCategory.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Industry Category Name';
                    Editable = false;
                }
                field("Note(Column)"; "Line Remark (If any)")
                {
                    ApplicationArea = Basic;

                }
                field(CancelledDate; "Cancelled Date")
                {
                    ApplicationArea = Basic;
                }
                field("Booking Status"; "Booking Status")
                {
                    Caption = 'Booking Status';
                    ApplicationArea = Basic;

                }

                field("Posting Status"; "Posting Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Proof Submitted"; "Job Proof Submitted")
                {
                    Caption = 'Job Proof Submitted';
                    ApplicationArea = Basic;

                }
                field(CreateSalesInvoice; "Create Sales Invoice")
                {
                    ApplicationArea = Basic;
                }
                field(CashInvoiceAmount; "Cash Invoice Amount")
                {
                    ApplicationArea = Basic;
                }
                field(VolumeNo; "Volume No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field(IssueNo; "Issue No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(IssueDate; "Issue Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }



                field(WaitingListNo; "Waiting List No.")
                {
                    ApplicationArea = Basic;
                }
                field(AdsClosingDate; "Ads. Closing Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Ads. Closing DateEditable";
                    Visible = false;
                }
                field(VATBusPostingGroup; "VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }



                field(BookingRevenueType; "Booking Revenue Type")
                {
                    ApplicationArea = Basic;
                }

                field(AdsType; "Ads. Type")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000099; AdsType.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Type Description';
                    Editable = false;
                }
                field(AdsSubType; "Ads. Sub-Type")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000101; AdsSubType.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Sub Type Description';
                    Editable = false;
                }
                field(AdsProductDescription2; "Ads. Product Description 2")
                {
                    ApplicationArea = Basic;
                }
                field(OwnerCustomer; "Owner Customer")
                {
                    ApplicationArea = Basic;
                }
                field(OwnerCustomerName; OwnerCust.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Owner Customer Name';
                    Editable = false;
                }
                field(BaseUnitofMeasure; "Base Unit of Measure")
                {
                    ApplicationArea = Basic;
                }

                field(Control1000000087; Amount)
                {
                    ApplicationArea = Basic;
                }



                field(BillRevenueGLAccount; "Bill Revenue G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(CashInvoiceNo; "Cash Invoice No.")
                {
                    ApplicationArea = Basic;
                }
                field(RequireContract; "Require Contract")
                {
                    ApplicationArea = Basic;
                }
                field(HaveArtwork; "Have Artwork")
                {
                    ApplicationArea = Basic;
                }
                field(Contactpersonforartwork; "Contact person for artwork")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(TotalNumberofInsertion; "Total Number of Insertion")
                {
                    ApplicationArea = Basic;
                }
                field(Remark; Remark)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ComplimentaryOffer; "Complimentary Offer")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ScheduledInvoiceDate; "Scheduled Invoice Date")
                {
                    ApplicationArea = Basic;
                }
                field(BookingDate; "Booking Date")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000063; "Cash Invoice No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Control1000000065; "Barter Invoice No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(PlanningStatus; "Planning Status")
                {
                    ApplicationArea = Basic;
                }
                field("Remark for Accountant"; "Remark for Accountant")
                {
                    Caption = 'Remark for Accountant';
                    ApplicationArea = Basic;
                    Style = AttentionAccent;

                }

                field("Remark From Accountant"; "Remark from Accountant")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    Editable = false;

                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Agency Commission %"; "Agency Commission %")
                {
                    ApplicationArea = All;

                }
                field("Agency Commission Amount"; "Agency Commission Amount")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action(Confirm)
                {
                    ApplicationArea = Basic;
                    Caption = 'Con&firm';
                    Visible = false;
                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50048. Unsupported part was commented. Please check it.
                        /*CurrPage.AdsBookingSubf.PAGE.*/
                        _ConfirmBooking;

                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic;
                    Caption = '&Reopen';
                    Image = ReOpen;
                    Visible = false;
                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50048. Unsupported part was commented. Please check it.
                        /*CurrPage.AdsBookingSubf.PAGE.*/
                        _ReopenConfirm;

                    end;
                }
                action(Cancel)
                {
                    ApplicationArea = Basic;
                    Caption = '&Cancel';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50048. Unsupported part was commented. Please check it.
                        /*CurrPage.AdsBookingSubf.PAGE.*/
                        _CancelBooking;

                    end;
                }
                action(Close)
                {
                    ApplicationArea = Basic;
                    Caption = 'C&lose';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50048. Unsupported part was commented. Please check it.
                        /*CurrPage.AdsBookingSubf.PAGE.*/
                        _CloseBooking;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        clear(SubProdName);
        AdsItemSetup.Get;
        "Ads. Closing DateEditable" := not AdsItemSetup."Lock Ads. Closing Date";
        if SubProduct.Get("Sub Product Code") then
            SubProdName := SubProduct.Description;
        if not AdsPosition.Get("Ads. Position Code") then
            Clear(AdsPosition);
        if not AdsProduct.Get("Brand Code") then
            Clear(AdsProduct);
        if not AdsSize.Get("Ads. Type", "Ads. Size Code") then
            Clear(AdsSize);
        if not AdsType.Get("Ads. Type") then
            Clear(AdsType);
        if not AdsSubType.Get("Ads. Type", "Ads. Sub-Type") then
            Clear(AdsSubType);
        if not ProductCategory.Get("Industry Category Code") then
            Clear(ProductCategory);
        if not BookingRev.Get("Ads. Type code (Revenue type Code)", "Shortcut Dimension 7 Code") then
            Clear(BookingRev);
        if not OwnerCust.Get("Owner Customer") then
            Clear(OwnerCust);
    end;

    trigger OnInit()
    begin
        "Ads. Closing DateEditable" := true;
    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        CurrPage.Update(false);
    end;

    var
        AdsItemSetup: Record "Ads. Item Setup";
        AdsPosition: Record "Ads. Position";
        AdsProduct: Record Brand;
        AdsSize: Record "Ads. Size";
        AdsType: Record "Ads. Type";
        AdsSubType: Record "Ads. Sub Type";
        ProductCategory: Record "Product Category";
        OwnerCust: Record Customer;
        BookingRev: Record "Booking Revenue Type";
        SubProdName: Text[50];
        SubProduct: Record "Sub Product";
        [InDataSet]
        "Ads. Closing DateEditable": Boolean;
        [InDataSet]
        PublicMonthEditable: Boolean;


    procedure _ConfirmBooking()
    var
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        CurrPage.SetSelectionFilter(AdsBookingLine);
        if AdsBookingLine.Find('-') then
            repeat
                AdsBookingLine.ConfirmBooking;
            until AdsBookingLine.Next = 0;
    end;


    procedure ConfirmBooking()
    var
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        CurrPage.SetSelectionFilter(AdsBookingLine);
        if AdsBookingLine.Find('-') then
            repeat
                AdsBookingLine.ConfirmBooking;
            until AdsBookingLine.Next = 0;
    end;


    procedure _CancelBooking()
    begin
        Rec.CancelBooking;
    end;


    procedure CancelBooking()
    begin
        Rec.CancelBooking;
    end;


    procedure _CloseBooking()
    begin
        Rec.CloseBooking;
    end;


    procedure CloseBooking()
    begin
        Rec.CloseBooking;
    end;


    procedure _ReopenConfirm()
    var
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        CurrPage.SetSelectionFilter(AdsBookingLine);
        if AdsBookingLine.Find('-') then
            repeat
                AdsBookingLine.ReopenConfirm;
            until AdsBookingLine.Next = 0;
    end;


    procedure ReopenConfirm()
    var
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        CurrPage.SetSelectionFilter(AdsBookingLine);
        if AdsBookingLine.Find('-') then
            repeat
                AdsBookingLine.ReopenConfirm;
            until AdsBookingLine.Next = 0;
    end;
}

