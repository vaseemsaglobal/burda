page 50008 "Subscriber Promotion List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    CardPageId = "Subscriber Promotion";
    PageType = List;
    SourceTable = "Promotion";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Date"; "Promotion Date")
                {
                    ApplicationArea = Basic;
                }
                field("Magazine Item Code"; "Magazine Item Code")
                {
                    ApplicationArea = Basic;
                }
                field("Magazine Code"; "Magazine Code")
                {
                    ApplicationArea = Basic;
                }
                field("Volume No."; "Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field("Issue No."; "Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Type"; "Promotion Type")
                {
                    ApplicationArea = Basic;

                }
                field("Promotion Duration"; "Promotion Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Price"; "Promotion Price")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Quantity"; "Promotion Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Net Price"; "Promotion Net Price")
                {
                    ApplicationArea = Basic;
                }
                field("Discount Type"; "Discount Type")
                {
                    ApplicationArea = Basic;
                }
                field("Discount Value"; "Discount Value")
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
            group("&Promotion")
            {
                Caption = '&Promotion';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Subscriber Promotion";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Promotion), "No." = FIELD("No.");
                }
            }
        }
    }
}

