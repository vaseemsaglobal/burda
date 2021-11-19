Page 50097 "Settle Cash Advance List"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    CardPageId = "Settle Cash Advance";
    PageType = List;
    SourceTable = "Settle Cash Advance Header";
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
                field(CashAdvanceVendorNo; "Cash Advance Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field(CashAdvanceName; "Cash Advance Name")
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentDate; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceAmount; "Balance Amount")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceSettle; "Balance Settle")
                {
                    ApplicationArea = Basic;
                }
                field(SettleAccountType; "Settle Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(SettleAccountNo; "Settle Account No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Settle)
            {
                Caption = '&Settle';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Settle Cash Advance";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

