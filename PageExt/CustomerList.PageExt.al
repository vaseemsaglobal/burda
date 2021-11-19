PageExtension 50008 pageextension50008 extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(Balance; Balance)
            {
                ApplicationArea = Basic;
            }

            field("Name (Thai)"; "Name (Thai)")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {

        modify("Sales Journal")
        {
            Visible = false;
        }
        modify("Aged Acc. Rec. (BackDating)")
        {
            Visible = false;
        }
        modify("AU/NZ Statement")
        {
            Visible = false;
        }

    }
}

