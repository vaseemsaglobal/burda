PageExtension 50070 pageextension50070 extends "VAT Product Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field("No VAT"; "No VAT")
            {
                ApplicationArea = Basic;
            }
            field("Average VAT"; "Average VAT")
            {
                ApplicationArea = Basic;
            }
        }
    }

}

