PageExtension 50043 pageextension50043 extends "Posted Purch. Invoice Subform" 
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
            field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("WHT Business Posting Group";"WHT Business Posting Group")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("WHT Product Posting Group";"WHT Product Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("No.";"IC Partner Code")
    }
}

