Page 50096 "Settle Cash Advance Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Settle Cash Advance Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(CashAdvanceVendorNo;"Cash Advance Vendor No.")
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
        if SettleCashAdvHdr.Get("Settle Cash Advance No.") then
          "Cash Advance Vendor No." := SettleCashAdvHdr."Cash Advance Vendor No.";
    end;

    var
        SettleCashAdvHdr: Record "Settle Cash Advance Header";


    procedure CalcTotalAmount(): Decimal
    var
        SettleCashAdvLine: Record "Settle Cash Advance Line";
    begin
        SettleCashAdvLine.Reset;
        SettleCashAdvLine.SetRange("Settle Cash Advance No.","Settle Cash Advance No.");
        //CashAdvLine.SETFILTER("Line No.",'..%1',"Line No.");
        SettleCashAdvLine.CalcSums("Amount (LCY) Incl. VAT","WHT Amount (LCY)");
        exit(SettleCashAdvLine."Amount (LCY) Incl. VAT" + SettleCashAdvLine."WHT Amount (LCY)");
    end;


    procedure CalcBalanceAmt(): Decimal
    var
        SettleCashAdvHdr: Record "Settle Cash Advance Header";
        SettleCashAdvLine: Record "Settle Cash Advance Line";
    begin
        if not SettleCashAdvHdr.Get("Settle Cash Advance No.") then
         exit;
        SettleCashAdvHdr.CalcFields("Balance Amount");
        SettleCashAdvLine.Reset;
        SettleCashAdvLine.SetRange("Settle Cash Advance No.","Settle Cash Advance No.");
        SettleCashAdvLine.SetFilter("Line No.",'..%1',"Line No.");
        if not SettleCashAdvLine.Find('-') then
          SettleCashAdvLine.SetRange("Line No.");
        SettleCashAdvLine.CalcSums("Amount (LCY) Incl. VAT","WHT Amount (LCY)");
        exit(SettleCashAdvHdr."Balance Amount" + SettleCashAdvLine."Amount (LCY) Incl. VAT");
    end;
}

