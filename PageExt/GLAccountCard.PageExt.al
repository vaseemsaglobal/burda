PageExtension 50004 pageextension50004 extends "G/L Account Card"
{
    layout
    {

        //Unsupported feature: Property Modification (SubFormLink) on "Control1905532107(Control 1905532107)".

        addafter("New Page")
        {
            field("Full Name (Thai)"; "Full Name (Thai)")
            {
                ApplicationArea = Basic;
            }
            field("Full Name (Eng)"; "Full Name (Eng)")
            {
                ApplicationArea = Basic;
            }
            field("For Manual Invoice"; "For Manual Invoice")
            {
                ApplicationArea = Basic;
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
    }



}

