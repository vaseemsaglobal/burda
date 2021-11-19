Page 50035 "Ads. Item Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Ads. Item Setup" - Ads. Sales Module
    UsageCategory = Administration;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "Ads. Item Setup";
    Caption = 'Ads. Sale Setup';

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
                field(AdsRevenueAccount; "Ads. Revenue Account")
                {
                    ApplicationArea = Basic;
                }
                field(VATProdPostingGroup; "VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;

                }
                field(LockAdsClosingDate; "Lock Ads. Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field(AllowDuplicateBillingLine; "Allow Duplicate Billing Line")
                {
                    ApplicationArea = Basic;
                }
                field("Deferred A/c No."; "Deffered A/c No.")
                {
                    ApplicationArea = Basic;

                }
                field("Accrued A/c No."; "Accrued A/c No.")
                {
                    ApplicationArea = Basic;

                }
                field("Ads. Sales Template"; "Ads. Sales Template")
                {
                    ApplicationArea = All;

                }
                field("Ads. Sales Batch Name"; "Ads. Sales Batch")
                {
                    ApplicationArea = All;

                }
                field("Enable Email Approval"; "Enable Email Approval")
                {
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field(BookingNos; "Booking Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(AdsSalesInvoiceNos; "Ads. Sales Invoice Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(BillingNos; "Billing Nos.")
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

