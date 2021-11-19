PageExtension 50030 pageextension50030 extends "Applied Customer Entries"
{
    layout
    {
        addafter(Description)
        {
            field("External Document No."; "External Document No.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Closed by Currency Amount")
        {
            field("Transaction No."; "Transaction No.")
            {
                ApplicationArea = Basic;
            }
            field("Applies-to ID"; "Applies-to ID")
            {
                ApplicationArea = Basic;
            }
        }
    }



}

