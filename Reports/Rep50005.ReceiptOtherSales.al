report 50005 "Receipt - Other Sales"
{
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
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
    procedure InitRequest(var SalesInvoiceHeader: record "Sales Invoice Header")
    var
        myInt: Integer;
    begin

    end;
}

