Page 50005 "Subscription Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // PTH : Phitsanu Thoranasoonthorn
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New Form for Subscription, Magazine & Ads. Setup
    // 002   02.07.2008   PTH   Add Field Complaint Nos.
    UsageCategory = Administration;
    ApplicationArea = all;
    //DeleteAllowed = false;
    //InsertAllowed = false;
    PageType = Card;
    SourceTable = "Subscription Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(SubscriberNos; "Subscriber Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PromotionNos; "Promotion Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(SubscriberContractNos; "Subscriber Contract Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PostedInvoiceNos; "Posted Invoice Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PostedCreditMemoNos; "Posted Credit Memo Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerNos; "Customer Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(DeliveryLocationCode; "Delivery Location Code")
                {
                    ApplicationArea = Basic;
                }
                field(ComplaintNos; "Complaint Nos.")
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

