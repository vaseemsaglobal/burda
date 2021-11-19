PageExtension 50028 pageextension50028 extends "Purchase Order Subform"
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
                Visible = false;
            }
        }
    }

}

