pageextension 50138 "Pag-Ext50138.Pg146." extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Location Code")
        {
            field("Posting Description"; "Posting Description")
            {
                ApplicationArea = Basic;

            }
        }
    }
}
