PageExtension 50040 pageextension50040 extends "Posted Sales Cr. Memo Subform" 
{
    Caption = 'Lines';
    layout
    {
        addafter(Description)
        {
            field("Circulation Receipt No.";"Circulation Receipt No.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

