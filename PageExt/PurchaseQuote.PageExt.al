PageExtension 50023 pageextension50023 extends "Purchase Quote"
{
    layout
    {

        addafter("No. of Archived Versions")
        {
            field("PO Type"; "PO Type")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

