Page 50084 "Cash Advance Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.
    UsageCategory = Administration;
    ApplicationArea = all;
    Caption = 'Cash Advance Setup';
    PageType = Card;
    SourceTable = "Cash Advance Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CashAdvanceNos; "Cash Advance Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(SettleCashAdvanceNos; "Settle Cash Advance Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccountNo; "Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AllowVATDifference; "Allow VAT Difference")
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

