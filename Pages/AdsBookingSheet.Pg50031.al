Page 50031 "Ads. Booking Sheet"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   11.05.2007   KKE   New form for "Ads. Booking Worksheet" - Ads. Sales Module
    // 002   28.08.2007   KKE   User permission for salesperson.
    // 003   18.09.2007   KKE   Add column Bill-to Customer Name.
    // 004   19.10.2010   GKU   Add field "Status Date"
    UsageCategory = Tasks;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = "Ads. Booking Line";
    SourceTableView = where("Line Status" = const(Approved));
    //SourceTableView = sorting("Ads. Item No.", "Line Status", "Sub Product Code");

    layout
    {
        area(content)
        {
            field(SubProductFilter; SubProductFilter)
            {
                ApplicationArea = Basic;
                Caption = 'Sub Product Code Filter';

                trigger OnLookup(var Text: Text): Boolean
                var
                    SubProduct: Record "Sub Product";
                begin
                    if Page.RunModal(0, SubProduct) = Action::LookupOK then begin
                        Text := SubProduct."Product Code";
                        exit(true);
                    end;
                end;

                trigger OnValidate()
                begin
                    SubProductFilterOnAfterValidate;
                end;
            }
            field(PublicationPeriodFilter; "Date Filter")
            {
                ApplicationArea = Basic;
                Caption = 'Publication Period Filter';

                trigger OnValidate()
                begin
                    PublicationPeriodFilterOnAfterValidate;
                end;
            }
            repeater(Control1000000000)
            {
                Editable = false;
                field(BookingNo; "Deal No.")
                {
                    ApplicationArea = Basic;
                    //Visible = false;
                }
                field("Sub Deal No."; "Subdeal No.")
                {
                    ApplicationArea = Basic;

                }
                field(MagazineCode; "Sub Product Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(LineNo; "Line No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(LineStatus; "Line Status")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(CancelledDate; "Cancelled Date")
                {
                    ApplicationArea = Basic;
                }
                field(PlanningStatus; "Planning Status")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(CashInvoiceNo; "Cash Invoice No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BarterInvoiceNo; "Barter Invoice No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(SelltoCustomerNo; "Sell-to Customer No.")
                {
                    Caption = 'Final Customer No.';
                    ApplicationArea = Basic;
                }
                field(SelltoCustomerName; SellToCustomer.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Sell-to Customer Name';
                    Editable = false;
                    Visible = false;
                }
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerName; BillToCustomer.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Bill-to Customer Name';
                    Editable = false;
                }
                field(SalespersonCode; "Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000083; Salesperson.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salesperson Name';
                    Editable = false;
                }
                field(Remark; Remark)
                {
                    ApplicationArea = Basic;
                }

                field(VolumeNo; "Volume No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(IssueNo; "Issue No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BookingRevenueCode; "Ads. Type code (Revenue type Code)")
                {
                    ApplicationArea = Basic;
                }
                field(BookingRevenueDescription; BookingRev.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Booking Revenue Description';
                    Editable = false;
                }
                field(BookingRevenueType; "Booking Revenue Type")
                {
                    ApplicationArea = Basic;
                }
                field(AdsType; "Ads. Type")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000105; AdsType.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Type Description';
                    Editable = false;
                }
                field(AdsSubType; "Ads. Sub-Type")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000107; AdsSubType.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Sub-Type Description';
                    Editable = false;
                }
                field(AdsSize; "Ads. Size Code")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000109; AdsSize.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Size Description';
                    Editable = false;
                }
                field(AdsPosition; "Ads. Position Code")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000091; AdsPosition.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Position Description';
                    Editable = false;
                }
                field(AdsProduct; "Brand Code")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000095; AdsProduct.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Product Description';
                    Editable = false;
                }
                field(ProductCategory; "Industry Category Code")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000097; ProductCategory.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Category Description';
                    Editable = false;
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
                field(CreateSalesInvoice; "Create Sales Invoice")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(CashInvoiceAmount; "Cash Invoice Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BillRevenueGLAccount; "Bill Revenue G/L Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BarterAmount; "Barter Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BarterGLAccount; "Barter G/L Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BarterRequiredDocument; "Barter Required Document")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(CountingUnit; "Counting Unit")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Basic;
                }
                field(UnitPriceExclVAT; "Unit Price Excl. VAT")
                {
                    ApplicationArea = Basic;
                }
                field(WaitingListNo; "Waiting List No.")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduledInvoiceDate; "Scheduled Invoice Date")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Publication Month"; "Publication Month")
                {
                    ApplicationArea = Basic;

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateAdsInvoice)
            {
                ApplicationArea = Basic;
                Caption = 'Create Ads. Invoice & Recognize Revenue';
                Image = NewSalesInvoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    AdsBookingLine: Record "Ads. Booking Line";
                    CreateSalesInv: Report "Create Ads Invoice Recog Rev";
                    AdsBookingLineCopy: Record "Ads. Booking Line";
                    DealNo: code[20];
                begin
                    Clear(DealNo);
                    Clear(CreateSalesInv);
                    Clear(AdsBookingLineCopy);
                    CurrPage.SetSelectionFilter(AdsBookingLine);
                    AdsBookingLineCopy.copy(AdsBookingLine);
                    if AdsBookingLineCopy.FindSet() then begin
                        DealNo := AdsBookingLineCopy."Deal No.";
                        repeat
                            if DealNo <> AdsBookingLineCopy."Deal No." then
                                Error('Deal no. for all the selected lines should be same');
                            AdsBookingLineCopy.TestField("Line Status", AdsBookingLineCopy."Line Status"::Approved);
                        until AdsBookingLineCopy.next = 0;
                    end;
                    AdsBookingLine.SETPERMISSIONFILTER;
                    CreateSalesInv.SetTableview(AdsBookingLine);
                    CreateSalesInv.RunModal();
                end;
            }


        }
    }

    trigger OnAfterGetRecord()
    begin
        if not Salesperson.Get("Salesperson Code") then
            Clear(Salesperson);
        if not SellToCustomer.Get("Sell-to Customer No.") then
            Clear(SellToCustomer);
        if not BillToCustomer.Get("Bill-to Customer No.") then
            Clear(BillToCustomer);
        if not AdsPosition.Get("Ads. Position Code") then
            Clear(AdsPosition);
        if not AdsProduct.Get("Brand Code") then
            Clear(AdsProduct);
        if not AdsSize.Get("Ads. Size Code") then
            Clear(AdsSize);
        if not AdsType.Get("Ads. Type") then
            Clear(AdsType);
        if not AdsSubType.Get("Ads. Type", "Ads. Sub-Type") then
            Clear(AdsSubType);
        if not ProductCategory.Get("Industry Category Code") then
            Clear(ProductCategory);
        if not BookingRev.Get("Ads. Type code (Revenue type Code)") then
            Clear(BookingRev);
        if not OwnerCust.Get("Owner Customer") then
            Clear(OwnerCust);
    end;

    trigger OnOpenPage()
    begin
        //KKE : #002 +
        UserSetup.Get(UserId);
        case UserSetup."Ads. Booking Filter" of
            UserSetup."ads. booking filter"::" ":
                Error(Text001);
            UserSetup."ads. booking filter"::Salesperson:
                begin
                    UserSetup.TestField("Salesperson Code");
                    Salesperson.SetFilter(Code, UserSetup."Salesperson Code");
                    FilterGroup(2);
                    SetFilter("Salesperson Code", Salesperson.GetFilter(Code));
                    FilterGroup(0);
                end;
            UserSetup."ads. booking filter"::Team:
                begin
                    UserSetup.TestField("Salesperson Code");
                    TeamSales.SetRange("Salesperson Code", UserSetup."Salesperson Code");
                    if not TeamSales.Find('-') then
                        Salesperson.SetFilter(Code, UserSetup."Salesperson Code")
                    else begin
                        repeat
                            if StrLen(TeamSalesFilter + TeamSales."Team Code") < 500 then
                                if TeamSalesFilter = '' then
                                    TeamSalesFilter := TeamSales."Team Code"
                                else
                                    TeamSalesFilter := TeamSalesFilter + '|' + TeamSales."Team Code";
                        until TeamSales.Next = 0;
                        TeamSales.Reset;
                        TeamSales.SetFilter("Team Code", TeamSalesFilter);
                        TeamSales.Find('-');
                        repeat
                            if StrLen(SalespersonFilter + TeamSales."Team Code") < 500 then
                                if SalespersonFilter = '' then
                                    SalespersonFilter := TeamSales."Salesperson Code"
                                else
                                    SalespersonFilter := SalespersonFilter + '|' + TeamSales."Salesperson Code";
                        until TeamSales.Next = 0;
                        Salesperson.SetFilter(Code, SalespersonFilter);
                        FilterGroup(2);
                        SetFilter("Salesperson Code", Salesperson.GetFilter(Code));
                        FilterGroup(0);
                    end;
                end;
            UserSetup."ads. booking filter"::All:
                begin
                    Salesperson.Reset;
                end;
        end;
        //KKE : #002 -
    end;

    var
        Salesperson: Record "Salesperson/Purchaser";
        UserSetup: Record "User Setup";
        TeamSales: Record "Team Salesperson";
        AdsPosition: Record "Ads. Position";
        AdsProduct: Record Brand;
        AdsSize: Record "Ads. Size";
        AdsType: Record "Ads. Type";
        AdsSubType: Record "Ads. Sub Type";
        ProductCategory: Record "Product Category";
        BillToCustomer: Record Customer;
        SellToCustomer: Record Customer;
        OwnerCust: Record Customer;
        BookingRev: Record "Booking Revenue Type";
        SubProductFilter: Text[250];

        Text001: label 'You do not have permision to see Ads. Booking Worksheet.';
        TeamSalesFilter: Text[500];
        SalespersonFilter: Text[500];

    local procedure SubProductFilterOnAfterValidate()
    begin
        SetFilter("Sub Product Code", SubProductFilter);
        CurrPage.Update;
    end;

    local procedure PublicationPeriodFilterOnAfterValidate()
    begin
        SetFilter("Publication date", format(rec.GetFilter("Date Filter")));
        CurrPage.Update;
    end;
}

