Page 50099 "Get Vendor Ledger Entries"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.

    Caption = 'Get Vendor Ledger Entries';
    Editable = false;
    PageType = Card;
    SourceTable = "Vendor Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(EntryNo;"Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate;"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentType;"Document Type")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo;"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(RemainingAmount;"Remaining Amount")
                {
                    ApplicationArea = Basic;
                }
                field(AmountLCY;"Amount (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(CurrencyCode;"Currency Code")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                    Lookup = false;
                    Visible = false;
                }
                field(GlobalDimension1Code;"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code;"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                ApplicationArea = Basic;
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    GetVendLedgEntries.SetSettleHeader(SettleCashAdvHeader);
                    GetVendLedgEntries.CreateSettleLines(Rec);
                    CurrPage.Close;
                end;
            }
        }
    }

    var
        PostedCashAdvHdr: Record "Cash Advance Invoice Header";
        SettleCashAdvHeader: Record "Settle Cash Advance Header";
        GetVendLedgEntries: Codeunit "Cash Adv. - Get Vend. Ledge";


    procedure SetSettleCashAdvHeader(var SettleCashAdvHeader2: Record "Settle Cash Advance Header")
    begin
        SettleCashAdvHeader.Get(SettleCashAdvHeader2."No.");
    end;
}

