page 50150 "Language Caption"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Language Caption";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Caption Code"; "Caption Code")
                {
                    ApplicationArea = All;
                }
                field("Report ID"; "Report ID")
                {
                    ApplicationArea = All;
                }
                field("Report Name"; "Report Name")
                {
                    ApplicationArea = all;
                }
                field("Caption in Thai"; "Caption in Thai")
                {
                    ApplicationArea = All;
                }
                field("Caption in English"; "Caption in English")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}