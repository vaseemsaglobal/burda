Page 50025 "Editorial Setup"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Editorial Setup";

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                field(ContentIndexNos; "Content Index Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(DummyPlanNos; "Dummy Plan Nos.")
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

