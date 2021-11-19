PageExtension 50087 pageextension50087 extends "Sales Return Order Subform"
{

    layout
    {

        addafter("IC Partner Ref. Type")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("WHT Business Posting Group"; "WHT Business Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("WHT Product Posting Group"; "WHT Product Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("Unit Price"; "Return Qty. to Receive")
        moveafter("Line Discount %"; "Return Qty. Received")
        moveafter("Line Discount Amount"; "Quantity Invoiced")
        moveafter("Allow Invoice Disc."; "Allow Item Charge Assignment")
    }

}

