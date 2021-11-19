pageextension 50135 "CashReceiptJournal.PageExt" extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field("Tax Invoice No."; "Tax Invoice No.")
            {
                ApplicationArea = basic;
                Style = Unfavorable;

            }
            field("Tax Invoice Date"; "Tax Invoice Date")
            {
                ApplicationArea = basic;
                Style = Unfavorable;
            }
            field("Deal No."; "Deal No.")
            {
                //Editable = false;
                ApplicationArea = All;

            }
            field("Check No."; "Check No.")
            {
                ApplicationArea = basic;
            }
            field("Cheque Date"; "Cheque Date")
            {
                ApplicationArea = basic;

            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            group("P&rint")
            {
                Caption = 'P&rint';
                action("Receipt Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipt Voucher';
                    Image = PrintVoucher;
                    trigger OnAction()
                    var
                        GenJnlLine: Record "Gen. Journal Line";
                    begin
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        GenJnlLine.SetRange("Document No.", "Document No.");
                        Report.Run(Report::"Receipts Voucher Report", true, false, GenJnlLine);
                    end;
                }
            }
        }
    }
}