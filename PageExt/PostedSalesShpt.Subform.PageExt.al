PageExtension 50036 pageextension50036 extends "Posted Sales Shpt. Subform"
{

    layout
    {
        addafter(Description)
        {
            field("Subscriber Contract No."; "Subscriber Contract No.")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("Shipping Time"; "Outbound Whse. Handling Time")
    }

}

