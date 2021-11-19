Page 50067 "Ads. Billing Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   25.05.2007   KKE   New form for "Ads. Billing Note Subform" - Ads. Sales Module

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Ads. Billing Line";


    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(LineNo; "Line No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(CustLedgerEntryNo; "Cust. Ledger Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(DocumentType; "Document Type")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; "Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(DueDate; "Due Date")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(SalespersonCode; "Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field(OriginalAmount; "Original Amount")
                {
                    ApplicationArea = Basic;
                }
                field(RemainingAmount; "Remaining Amount")
                {
                    ApplicationArea = Basic;
                }
                field(RemainingAmtLCY; "Remaining Amt. (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(BillingAmount; "Billing Amount")
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if not AdsBookingHeader.Get("Billing No.") then
            Clear(AdsBookingHeader);
        "Bill-to Customer No." := AdsBookingHeader."Bill-to Customer No.";
    end;

    var
        AdsBookingHeader: Record "Ads. Billing Header";
}

