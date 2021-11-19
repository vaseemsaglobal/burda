Page 50029 "Photo Expense"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   17.05.2007   KKE   New form for "Photo Expense" - Editorial Module

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Photo Expense";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(PictureCode;"Picture Code")
                {
                    ApplicationArea = Basic;
                }
                field(PictureSize;"Picture Size")
                {
                    ApplicationArea = Basic;
                }
                field(ReferenceNo;"Reference No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Agency;Agency)
                {
                    ApplicationArea = Basic;
                }
                field(InvoiceNo;"Invoice No.")
                {
                    ApplicationArea = Basic;
                }
                field(CurrencyCode;"Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field(ExchangeRate;"Exchange Rate")
                {
                    ApplicationArea = Basic;
                }
                field(CostAmount;"Cost Amount")
                {
                    ApplicationArea = Basic;
                }
                field(CostAmountLCY;"Cost Amount (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(BillingDate;"Billing Date")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentDate;"Payment Date")
                {
                    ApplicationArea = Basic;
                }
                field(Note;Note)
                {
                    ApplicationArea = Basic;
                }
                field(PaymentStatus;"Payment Status")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
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

