Page 50050 "Ads. Booking List"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Ads. Booking List" - Ads. Sales Module
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    CardPageId = "Ads. Booking";
    RefreshOnActivate = true;
    PageType = List;
    SourceTable = "Ads. Booking Header";


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
                field(Control1000000026; Salesperson.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salesperson Name';
                }
                field(SelltoCustomerNo; "Final Customer No.")
                {
                    Caption = 'Final Customer No.';
                    ApplicationArea = Basic;
                }
                field(FinalCustName; FinalCustName)
                {
                    Caption = 'Final Customer Name';
                    ApplicationArea = Basic;

                }
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(BillToName; BillToName)
                {

                    Caption = 'Bill-to Customer Name';
                    ApplicationArea = basic;
                }
                field("Email Validation"; "Email Validation")
                {
                    Caption = 'Validation Status';
                    ApplicationArea = basic;
                }
                field(PaymentTermsCode; "Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field(AdsSalesType; "Client Type")
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
                field("Deferred/Prepayment"; "Deferred/Prepayment")
                {
                    ApplicationArea = Basic;

                }
                field("Accrued Amount"; "Accrued Amount")
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
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }

        }
        area(Processing)
        {

            action(DealsOverview)
            {
                Caption = 'Deals Overview';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = ViewServiceOrder;
                trigger OnAction()
                var
                    AdsBookingHeader: Record "Ads. Booking Header";
                    DealOverView: Page "Deals Overview";
                begin
                    AdsBookingHeader.Reset();
                    AdsBookingHeader.SetCurrentKey("No.");
                    AdsBookingHeader.SetRange("Deal Completed", false);
                    if AdsBookingHeader.FindLast() then;
                    DealOverView.SetTableView(AdsBookingHeader);

                    DealOverView.SetRecord(AdsBookingHeader);
                    DealOverView.Run();
                end;
            }
            action(AdsSalesSubDealOverview)
            {
                Caption = 'Subdeals Overview';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = ViewServiceOrder;

                trigger OnAction()
                var
                    AdsBookingLine: Record "Ads. Booking Line";
                    AdsSaleSubDealOverview: Page "Subdeals Overview";
                begin
                    AdsBookingLine.Reset();
                    AdsBookingLine.SetCurrentKey("Publication Month", "deal no.");
                    AdsBookingLine.SetFilter("Line Status", '%1|%2', AdsBookingLine."Line Status"::Approved, AdsBookingLine."Line Status"::"Invoice Generated");
                    AdsBookingLine.SetFilter("Posting Status", '%1|%2|%3|%4', AdsBookingLine."Posting Status"::Open, AdsBookingLine."Posting Status"::"Rev. Pending", AdsBookingLine."Posting Status"::"Rev. Pending", AdsBookingLine."Posting Status"::Rejected);
                    if AdsBookingLine.FindLast() then;
                    AdsSaleSubDealOverview.SetTableView(AdsBookingLine);
                    AdsSaleSubDealOverview.SetRecord(AdsBookingLine);
                    AdsSaleSubDealOverview.Run();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Clear(FinalCustName);
        Clear(BillToName);
        if Cust.get("Final Customer No.") then
            FinalCustName := Cust.Name;
        if Cust.get("Bill-to Customer No.") then
            BillToName := Cust.Name;
        if not Salesperson.Get("Salesperson Code") then
            Clear(Salesperson);
    end;

    var
        Salesperson: Record "Salesperson/Purchaser";
        FinalCustName: Text;
        BillToName: Text;
        Cust: Record Customer;
}

