PageExtension 50029 pageextension50029 extends "Purch. Invoice Subform"
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
    }

}

