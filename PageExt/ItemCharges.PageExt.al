PageExtension 50085 pageextension50085 extends "Item Charges"
{
    layout
    {
        addafter("Tax Group Code")
        {
            field("WHT Product Posting Group"; "WHT Product Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
    }

}

