PageExtension 50020 pageextension50020 extends "Sales List"
{
    layout
    {
        addafter("Sell-to Contact")
        {
            field(Amount; Amount)
            {
                ApplicationArea = Basic;
            }
            field("Amount Including VAT"; "Amount Including VAT")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("Shortcut Dimension 2 Code"; "Assigned User ID")
        moveafter("Location Code"; "Currency Code")
    }
    actions
    {
        modify("Sales Reservation Avail.")
        {
            Caption = 'Sales Reservation Avail.';
        }
    }
}

