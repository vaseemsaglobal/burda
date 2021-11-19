PageExtension 50003 pageextension50003 extends "Chart of Accounts"
{
    layout
    {

        //Unsupported feature: Property Modification (SubFormLink) on "Control1905532107(Control 1905532107)".

        addafter(Name)
        {

            field("Full Name (Thai)"; "Full Name (Thai)")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Full Name (Eng)"; "Full Name (Eng)")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            /*
            field("No. 2"; "No. 2")
            {
                ApplicationArea = All;
                Caption = 'Group Account No.';
            }
            */
            field(Name2; Name2)
            {
                ApplicationArea = All;
                Caption = 'Group Account Name';
            }
        }
        addafter(Totaling)
        {
            field("Petty Cash Account"; "Petty Cash Account")
            {
                ApplicationArea = Basic;
            }
            field("Cash Advance Account"; "Cash Advance Account")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field("WHT Business Posting Group"; "WHT Business Posting Group")
            {
                ApplicationArea = Basic;
            }
            field("WHT Product Posting Group"; "WHT Product Posting Group")
            {
                ApplicationArea = Basic;
            }
            field(Indentation; Indentation)
            {
                ApplicationArea = All;

            }
        }

    }


}

