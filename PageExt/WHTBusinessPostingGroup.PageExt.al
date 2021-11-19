PageExtension 50091 pageextension50091 extends "WHT Business Posting Group" 
{

    //Unsupported feature: Property Modification (PageType) on ""WHT Business Posting Group"(Page 28040)".

    layout
    {
        addafter(Description)
        {
            field("WHT Certificate No. Series";"WHT Certificate No. Series")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        modify("&Setup")
        {
            Caption = '&Setup';
        }
    }
}

