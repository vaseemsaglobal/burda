PageExtension 50011 pageextension50011 extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field(Balance; Balance)
            {
                ApplicationArea = Basic;
            }
            field("VAT Registration No."; "VAT Registration No.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

