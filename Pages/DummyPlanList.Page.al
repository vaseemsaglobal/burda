Page 50032 "Dummy Plan List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    PageType = List;
    SourceTable = "Dummy Plan";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(DummyPlanNo; "Dummy Plan No.")
                {
                    ApplicationArea = Basic;
                }
                field(RevisionNo; "Revision No.")
                {
                    ApplicationArea = Basic;
                }
                field(PlanningStatus; "Planning Status")
                {
                    ApplicationArea = Basic;
                }
                field(MagazineItemNo; "Magazine Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentDate; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(NoofPage; "No. of Page")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field(RevisionDateTime; "Revision Date/Time")
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

