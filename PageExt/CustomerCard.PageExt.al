PageExtension 50007 pageextension50007 extends "Customer Card"
{
    layout
    {


        addafter("Address 2")
        {
            field("Address 3"; "Address 3")
            {
                ApplicationArea = Basic;
            }
        }
        addafter(ContactName)
        {
            field("Name (Thai)"; "Name (Thai)")
            {
                ApplicationArea = Basic;
            }
            field("Address (Thai)"; "Address (Thai)")
            {
                ApplicationArea = Basic;
                MultiLine = true;
            }
            field(Branch; Branch)
            {
                ApplicationArea = All;
            }
            field("Branch No."; "Branch No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("Shipping Agent"; "Shipping Agent")
            {
                ApplicationArea = Basic;
            }
            field("Customer Type"; "Customer Type")
            {
                ApplicationArea = Basic;
            }
            field("Zone Area"; "Zone Area")
            {
                ApplicationArea = Basic;
            }
            field("Have Credit Problem"; "Have Credit Problem")
            {
                ApplicationArea = Basic;
            }
        }

    }
    actions
    {

        addafter("Bank Accounts")
        {
            action(Subscriber)
            {
                ApplicationArea = Basic;
                Caption = 'Subscriber';
                RunPageLink = "Customer No." = FIELD("No.");
                RunObject = Page "Subscriber List";
            }
        }
        addafter(Contact)
        {
            action(Action1000000001)
            {
                ApplicationArea = Basic;
                Caption = 'Subscriber';
                RunPageLink = "Customer No." = FIELD("No.");
                RunObject = Page "Subscriber List";
            }
        }
    }
}

