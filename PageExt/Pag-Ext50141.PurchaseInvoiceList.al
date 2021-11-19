pageextension 50141 PurchaseInvoiceList extends "Purchase Invoices"
{
    layout
    {
        addafter("Location Code")
        {
            field("Invoice Description"; "Invoice Description")
            {
                ApplicationArea = basic;
            }
        }
    }
}
