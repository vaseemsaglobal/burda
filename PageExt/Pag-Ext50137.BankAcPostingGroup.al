pageextension 50137 "Pag-Ext373.BankAcPostingGroup" extends "Bank Account Posting Groups"
{
    layout
    {
        addafter("G/L Account No.")
        {
            field("G/L Bank Account No."; "G/L Bank Account No.")
            {
                ApplicationArea = All;

            }
        }
    }
}
