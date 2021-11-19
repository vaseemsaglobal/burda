Page 50103 "Archived Ads. Billing"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   01.06.2007   KKE   New form for "Archived Ads. Billing" - Ads. Sales Module

    Editable = false;
    RefreshOnActivate = true;
    PageType = Card;
    SourceTable = "Archived Ads. Billing Header";

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
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoName; "Bill-to Name")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoAddress; "Bill-to Address")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoAddress2; "Bill-to Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoAddress3; "Bill-to Address 3")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoPostCodeCity; "Bill-to Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bill-to Post Code/City';
                }
                field(BilltoCity; "Bill-to City")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCounty; "Bill-to County")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCountyCountryCode; "Bill-to Country Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bill-to County/Country Code';
                }
                field(BilltoContact; "Bill-to Contact")
                {
                    ApplicationArea = Basic;
                }
                field(Remark; Remark)
                {
                    ApplicationArea = Basic;
                }
                field(BillingDate; "Billing Date")
                {
                    ApplicationArea = Basic;
                }
                field(ExpectedReceiptDate; "Expected Receipt Date")
                {
                    ApplicationArea = Basic;
                }
                field(DueDate; "Due Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(BillingSubform; "Archived Ads. Billing Subform")
            {
                SubPageLink = "Billing No." = field("No.");
                ApplicationArea = basic;
            }
        }
    }

    actions
    {
    }
}

