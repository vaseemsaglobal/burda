report 50041 "Circulation Receipt"
{
    dataset
    {
        dataitem(CirculationReceiptHeader; "Circulation Receipt Header")
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

    procedure InitRequest("_ReceiptFirst50%": Boolean)
    begin
        //ReceiptFirst50Percent := "_ReceiptFirst50%";
    end;
}
