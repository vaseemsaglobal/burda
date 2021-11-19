PageExtension 50009 pageextension50009 extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Closed by Entry No."; "Closed by Entry No.")
            {
                ApplicationArea = Basic;
                Visible = false;
            }

            field("Closed by Amount"; "Closed by Amount")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Closed at Date"; "Closed at Date")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Deal No."; "Deal No.")
            {
                ApplicationArea = Basic;

            }
            field("Document Date"; "Document Date")
            {
                ApplicationArea = basic;

            }
        }
    }



}

