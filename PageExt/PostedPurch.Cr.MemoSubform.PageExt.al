PageExtension 50045 pageextension50045 extends "Posted Purch. Cr. Memo Subform" 
{
    Caption = 'Lines';
    layout
    {
        addafter("Variant Code")
        {
            field("WHT Absorb Base";"WHT Absorb Base")
            {
                ApplicationArea = Basic;
            }
            field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("WHT Product Posting Group";"WHT Product Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("No.";"IC Partner Code")
    }
}

