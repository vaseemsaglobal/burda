PageExtension 50005 pageextension50005 extends "G/L Account List"
{
    layout
    {

        //Unsupported feature: Property Modification (SubFormLink) on "Control1905532107(Control 1905532107)".

        addafter("Credit Amount")
        {
            field(Balance; Balance)
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Debit Amount")
        {
            field("Full Name (Eng)"; "Full Name (Eng)")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter("Income/Balance")
        {
            field("Debit/Credit"; "Debit/Credit")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Account Type")
        {
            field("Consol. Translation Method"; "Consol. Translation Method")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Reconciliation Account")
        {
            field("WHT Business Posting Group"; "WHT Business Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("WHT Product Posting Group"; "WHT Product Posting Group")
            {
                ApplicationArea = Basic;
            }
        }
    }



}

