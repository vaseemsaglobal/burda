pageextension 50140 PurchaseOrderList extends "Purchase Order List"
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
