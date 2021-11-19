PageExtension 50031 pageextension50031 extends "Sales Cr. Memo Subform"
{

    layout
    {

        addafter(Nonstock)
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("WHT Business Posting Group")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("WHT Product Posting Group")
        {
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field(Control1000000006; "VAT Prod. Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
    }



}

