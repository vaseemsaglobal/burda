PageExtension 50061 pageextension50061 extends "Post Codes" 
{
    layout
    {
        addafter(City)
        {
            field("Zone Area";"Zone Area")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

