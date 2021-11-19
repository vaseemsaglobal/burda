Page 50056 "Agent Customer List"
{
    Editable = false;
    PageType = List;
    CardPageId = "Agent Customer";
    SourceTable = "Agent Customer Header";
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;
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
                field(MagazineItemNo; "Magazine Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(MagazineCode; "Magazine Code")
                {
                    ApplicationArea = Basic;
                }
                field(VolumeNo; "Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueNo; "Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueDate; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field(SalespersonCode; "Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field(LocationCode; "Location Code")
                {
                    ApplicationArea = Basic;
                }
                field(UnitofMeasureCode; "Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(AgentCustomer)
            {
                Caption = '&Agent Customer';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Agent Customer";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

