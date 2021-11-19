PageExtension 50006 pageextension50006 extends "General Ledger Entries"
{

    //Unsupported feature: Property Insertion (SourceTableView) on ""General Ledger Entries"(Page 20)".

    layout
    {

        addafter("G/L Account Name")
        {
            field("System-Created Entry"; "System-Created Entry")
            {
                ApplicationArea = Basic;
            }
            field("Document Date"; "Document Date")
            {

                ApplicationArea = Basic;
            }
            field("Salesperson Code"; "Salesperson Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            /*
            field("Source No."; "Source No.")
            {
                ApplicationArea = Basic;
            }
            */
            field("Source Name"; "Source Name")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Global Dimension 2 Code")
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = Basic;
            }
            field("Deal No."; "Deal No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sub Deal No."; "Sub Deal No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Publication Month"; "Publication Month")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Product Code"; "Product Code")
            {
                ApplicationArea = All;
            }
        }


    }



}


