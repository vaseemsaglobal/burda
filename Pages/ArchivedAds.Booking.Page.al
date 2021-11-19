Page 50051 "Archived Ads. Booking"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   09.05.2007   KKE   New form for "Archived Ads. Booking" - Ads. Sales Module

    Editable = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Archived Ads. Booking Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                label(Control1000000035)
                {
                    ApplicationArea = Basic;
                    CaptionClass = FORMAT(Salesperson.Name);
                    Editable = false;
                }
                field(PaymentTermsCode; "Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field(ZoneArea; "Zone Area")
                {
                    ApplicationArea = Basic;
                }
                field(SelltoCustomerNo; "Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                label(Control1000000036)
                {
                    ApplicationArea = Basic;
                    CaptionClass = FORMAT(Cust.Name);
                    Editable = false;
                }
                field(SelltoCustomerType; "Sell-to Customer Type")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerType; "Bill-to Customer Type")
                {
                    ApplicationArea = Basic;
                }
            }
            part(AdsBookingSubf; "Archived Ads. Booking Subform")
            {
                SubPageLink = "Booking No." = field("No.");
                ApplicationArea = basic;
            }
            group(Contact)
            {
                Caption = 'Contact';
                field(Control1000000019; Contact)
                {
                    ApplicationArea = Basic;
                }
                field(PhoneNo; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(FaxNo; "Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field(MobileNo; "Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field(EMail; "E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(Remark; Remark)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        Salesperson: Record "Salesperson/Purchaser";
        Cust: Record Customer;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if not Salesperson.Get("Salesperson Code") then
            Clear(Salesperson);
        if not Cust.Get("Sell-to Customer No.") then
            Clear(Cust);
    end;
}

