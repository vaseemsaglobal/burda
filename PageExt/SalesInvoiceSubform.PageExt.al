PageExtension 50022 pageextension50022 extends "Sales Invoice Subform"
{

    layout
    {
        modify("WHT Business Posting Group")
        {
            Visible = true;
        }
        modify("WHT Product Posting Group")
        {
            Visible = true;
        }
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
        addafter("Unit of Measure Code")
        {
            field("Ads. Booking No."; "Ads. Booking No.")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Ads. Booking Line No."; "Ads. Booking Line No.")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Deal No."; "Deal No.")
            {
                ApplicationArea = All;
                //Editable = false;
            }
            field("Sub Deal No."; "Sub Deal No.")
            {
                ApplicationArea = All;
                //Editable = false;
            }
        }
        moveafter(Nonstock; "VAT Prod. Posting Group")
    }

}

