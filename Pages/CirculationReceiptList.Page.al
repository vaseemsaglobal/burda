Page 50059 "Circulation Receipt List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    CardPageId = "Circulation Receipt";
    PageType = List;
    SourceTable = "Circulation Receipt Header";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentDate; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerNo; "Customer No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

