Page 50104 "Archived Ads. Billing Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   01.06.2007   KKE   New form for "Archived Ads. Billing Subform" - Ads. Sales Module

    AutoSplitKey = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Archived Ads. Billing Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(LineNo;"Line No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(CustLedgerEntryNo;"Cust. Ledger Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerNo;"Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(DocumentType;"Document Type")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo;"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(DueDate;"Due Date")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(SalespersonCode;"Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field(ZoneArea;"Zone Area")
                {
                    ApplicationArea = Basic;
                }
                field(SaleType;"Sale Type")
                {
                    ApplicationArea = Basic;
                }
                field(OriginalAmount;"Original Amount")
                {
                    ApplicationArea = Basic;
                }
                field(RemainingAmount;"Remaining Amount")
                {
                    ApplicationArea = Basic;
                }
                field(RemainingAmtLCY;"Remaining Amt. (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(BillingAmount;"Billing Amount")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }

    var
        AdsBookingHeader: Record "Ads. Billing Header";
}

