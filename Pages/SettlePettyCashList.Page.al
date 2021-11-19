Page 50082 "Settle Petty Cash List"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageId = "Settle Petty Cash";
    Editable = false;
    PageType = List;
    SourceTable = "Settle Petty Cash Header";
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
                field(PettyCashVendorNo; "Petty Cash Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field(PettyCashName; "Petty Cash Name")
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
                field(PettyCashAmount; "Petty Cash Amount")
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
                    RunObject = Page "Settle Petty Cash";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

