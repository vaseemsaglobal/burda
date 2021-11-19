Page 50013 "Magazine Sales Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New form for Magazine Sales Setup
    UsageCategory = Administration;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Magazine Sales Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DefaultBaseUOM; "Default Base UOM")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultCostingMethod; "Default Costing Method")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultVATProdPostingGrou; "Default VAT Prod. Posting Grou")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultWHTProdPostingGrou; "Default WHT Prod. Posting Grou")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultInventoryPostingGrou; "Default Inventory Posting Grou")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field(AgentCustomerNos; "Agent Customer Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(CirculationBillingNos; "Circulation Billing Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(CirculationReceiptNos; "Circulation Receipt Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PostedInvoiceNos; "Posted Invoice Nos.")
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

