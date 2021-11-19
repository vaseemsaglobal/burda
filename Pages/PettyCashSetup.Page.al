Page 50069 "Petty Cash Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.
    UsageCategory = Administration;
    ApplicationArea = all;
    Caption = 'Petty Cash Setup';
    PageType = Card;
    SourceTable = "Petty Cash Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(PettyCashNos; "Petty Cash Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(SettlePettyCashNos; "Settle Petty Cash Nos.")
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

