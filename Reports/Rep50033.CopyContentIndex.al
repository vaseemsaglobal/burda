report 50033 "Copy Content Index"
{
    dataset
    {
        dataitem(ContentIndexLine; "Content Index Line")
        {
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    procedure InitRequest(_ContentIndexHdr: Record "Content Index Header")
    begin

    end;
}
