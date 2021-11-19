Page 50030 "Content Cost"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   17.05.2007   KKE   New form for "Content Cost" - Editorial Module

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Content Cost";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(ExpenseCode;"Expense Code")
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

