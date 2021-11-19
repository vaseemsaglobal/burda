PageExtension 50012 pageextension50012 extends "Vendor Ledger Entries"
/*
      Project : Burda
      001  03.01.2008  KKE  -Allow reverse transaction for Cash Advance Invoice,Petty Cash Invoice
*/
{
    layout
    {
        addafter("WHT Amount (LCY)")
        {
            field("Rem. Amt for WHT"; "Rem. Amt for WHT")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Rem. Amt"; "Rem. Amt")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Document Date"; "Document Date")
            {
                ApplicationArea = basic;

            }
        }
    }
    actions
    {
        modify(ReverseTransaction)
        {
            Visible = false;
        }
        addafter(RemittanceAdvance)
        {
            action(ReverseTransaction1)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reverse Transaction';
                Ellipsis = true;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                ToolTip = 'Reverse an erroneous vendor ledger entry.';

                trigger OnAction()
                var
                    ReversalEntry: Record "Reversal Entry";
                begin
                    Clear(ReversalEntry);
                    if Reversed then
                        ReversalEntry.AlreadyReversedEntry(TableCaption, "Entry No.");
                    if "Journal Batch Name" = '' then begin
                        //KKE : #001 +
                        Vendor.GET("Vendor No.");
                        IF NOT (Vendor."Cash Advance" OR Vendor."Petty Cash") THEN
                            //KKE : #001 -
                            ReversalEntry.TestFieldError;
                    end;
                    TestField("Transaction No.");
                    ReversalEntry.ReverseTransaction("Transaction No.");
                end;
            }

        }
    }
    var
        Vendor: Record Vendor;

    var
        VendEntryEdit: Codeunit "Vend. Entry-Edit";
}

