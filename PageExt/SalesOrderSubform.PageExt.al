PageExtension 50021 pageextension50021 extends "Sales Order Subform"
{

    layout
    {

        addafter(Nonstock)
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field("WHT Business Posting Group"; "WHT Business Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("WHT Product Posting Group"; "WHT Product Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Bin Code")
        {
            field("Subscriber Contract No."; "Subscriber Contract No.")
            {
                ApplicationArea = Basic;
            }
            field("Agent Customer No."; "Agent Customer No.")
            {
                ApplicationArea = Basic;
            }
        }
    }

}

