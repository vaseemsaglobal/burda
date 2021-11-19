TableExtension 50043 tableextension50043 extends "Bank Account Ledger Entry"
{
    fields
    {
        modify("Post Dated Check No.")
        {
            Caption = 'Post Dated Check No.';
        }
        field(50000; "Vendor Bank Account No."; Text[30])
        {
        }
        field(50001; "Vendor Bank Branch No."; Text[20])
        {
            Caption = 'Vendor Bank Branch No.';
        }
        field(50002; "Customer/Vendor Bank"; Code[10])
        {
            Caption = 'Customer/Vendor Bank';
            TableRelation = if ("Bal. Account Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Bal. Account No."))
            else
            if ("Bal. Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Bal. Account No."));
        }
    }

}

