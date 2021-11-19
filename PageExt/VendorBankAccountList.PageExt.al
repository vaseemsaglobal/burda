PageExtension 50067 pageextension50067 extends "Vendor Bank Account List"
{
    layout
    {



        addafter("Bank Account No.")
        {
            field("Bank Branch No."; "Bank Branch No.")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter(Name; "Bank Account No.")
    }
}

