PageExtension 50002 pageextension50002 extends "Company Information"
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
        addafter("Industrial Classification")
        {
            field("Company Name (Thai)"; "Company Name (Thai)")
            {
                ApplicationArea = Basic;
            }
            field("Company Address (Thai)"; "Company Address (Thai)")
            {
                ApplicationArea = Basic;
            }
            field("Company Address 2 (Thai)"; "Company Address 2 (Thai)")
            {
                ApplicationArea = All;
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
        addafter(Iban)
        {
            field("Order Party Account"; "Order Party Account")
            {
                ApplicationArea = Basic;
            }
            field("Order Party Account Currency"; "Order Party Account Currency")
            {
                ApplicationArea = Basic;
                MultiLine = true;
            }
        }
        addafter("Ship-to Address 2")
        {
            field("Ship-to Address 3"; "Ship-to Address 3")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("Post Code"; City)
        addafter(BankAccountPostingGroup)
        {
            field("Bank Name 2"; "Bank Name 2")
            {
                ApplicationArea = all;
            }
            field("Bank Branch"; Rec."Bank Branch")
            {
                ApplicationArea = all;
            }
            field("Bank Address"; Rec."Bank Address")
            {
                ApplicationArea = all;
            }
            field("Bank A/C Name"; Rec."Bank A/C Name")
            {
                ApplicationArea = all;
            }
            field("Bank Name (Short)"; Rec."Bank Name (Short)")
            {
                ApplicationArea = all;
            }

            field("Invoice Caption"; "Invoice Caption")
            {
                ApplicationArea = All;

            }
        }
        addafter("VAT Registration No.")
        {
            field("Registration No."; "Registration No.")
            {
                ApplicationArea = All;
                //FieldPropertyName = FieldPropertyValue;
            }
        }
    }
}

