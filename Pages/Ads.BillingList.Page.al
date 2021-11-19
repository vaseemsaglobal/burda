Page 50068 "Ads. Billing List"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   25.05.2007   KKE   New form for "Ads. Billing Note List" - Ads. Sales Module
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    PageType = List;
    CardPageId = "Ads. Billing";
    SourceTable = "Ads. Billing Header";
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
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoName; "Bill-to Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
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
            }
        }
    }

    actions
    {
    }
}

