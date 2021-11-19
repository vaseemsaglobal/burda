pageextension 50136 "GeneralJournal.PageExt" extends "General Journal"
{
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
                    Caption = 'Journal Voucher';
                    Image = PrintVoucher;
                    trigger OnAction()
                    var
                        GenJnlLine: Record "Gen. Journal Line";
                    begin
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        GenJnlLine.SetRange("Document No.", "Document No.");
                        Report.Run(Report::"Journal Voucher", true, false, GenJnlLine);
                    end;
                }
            }
        }
    }
}
