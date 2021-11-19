Page 50081 "Settle Petty Cash Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.

    AutoSplitKey = true;
    Caption = 'Settle Petty Cash Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Settle Petty Cash Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(PettyCashVendorNo;"Petty Cash Vendor No.")
                {
                    ApplicationArea = Basic;
                }
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
                field(CurrencyCode;"Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AmountInclVAT;"Amount Incl. VAT")
                {
                    ApplicationArea = Basic;
                }
                field(AmountLCYInclVAT;"Amount (LCY) Incl. VAT")
                {
                    ApplicationArea = Basic;
                }
                field(WHTAmountLCY;"WHT Amount (LCY)")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if SettlePettyCashHdr.Get("Settle Petty Cash No.") then
          "Petty Cash Vendor No." := SettlePettyCashHdr."Petty Cash Vendor No.";
    end;

    var
        SettlePettyCashHdr: Record "Settle Petty Cash Header";


    procedure CalcTotalAmount(): Decimal
    var
        SettlePettyCashLine: Record "Settle Petty Cash Line";
    begin
        SettlePettyCashLine.Reset;
        SettlePettyCashLine.SetRange("Settle Petty Cash No.","Settle Petty Cash No.");
        //PettyCashLine.SETFILTER("Line No.",'..%1',"Line No.");
        SettlePettyCashLine.CalcSums("Amount (LCY) Incl. VAT","WHT Amount (LCY)");
        exit(SettlePettyCashLine."Amount (LCY) Incl. VAT" + SettlePettyCashLine."WHT Amount (LCY)");
    end;


    procedure CalcBalanceAmt(): Decimal
    var
        SettlePettyCashHdr: Record "Settle Petty Cash Header";
        SettlePettyCashLine: Record "Settle Petty Cash Line";
    begin
        if not SettlePettyCashHdr.Get("Settle Petty Cash No.") then
         exit;
        SettlePettyCashHdr.CalcFields("Balance Amount");
        SettlePettyCashLine.Reset;
        SettlePettyCashLine.SetRange("Settle Petty Cash No.","Settle Petty Cash No.");
        SettlePettyCashLine.SetFilter("Line No.",'..%1',"Line No.");
        if not SettlePettyCashLine.Find('-') then
          SettlePettyCashLine.SetRange("Line No.");
        SettlePettyCashLine.CalcSums("Amount (LCY) Incl. VAT","WHT Amount (LCY)");
        exit(SettlePettyCashHdr."Balance Amount" + SettlePettyCashLine."Amount (LCY) Incl. VAT");
    end;
}

