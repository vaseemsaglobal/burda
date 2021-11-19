page 50010 "Subscriber Contract List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    CardPageId = "Subscriber Contracts";
    PageType = List;
    SourceTable = "Subscriber Contract";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(content1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Subscriber No."; "Subscriber No.")
                {
                    ApplicationArea = Basic;
                }
                field("Subscriber Name"; "Subscriber Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Subscriber Name';
                }
                field(Address1; Subscriber."Address 1")

                {
                    ApplicationArea = Basic;
                    Caption = 'Address 1';
                }
                field("Address 2"; Subscriber."Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Address 2';
                }
                field("Address 3"; Subscriber."Address 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Address 3';
                }
                field(PhonNoMobileNo; Subscriber."Phone No." + '  ' + Subscriber."Mobile No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Phone No.';
                }
                field("Subscription Date"; "Subscription Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expired Date"; "Expired Date")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Issue No."; "Contract Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Quantity"; "Contract Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Magazine Item No."; "Starting Magazine Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Volume No."; "Starting Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Issue No."; "Starting Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Issue Date"; "Starting Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Magazine Item No."; "Ending Magazine Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Volume No."; "Ending Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Issue No."; "Ending Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Issue Date"; "Ending Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Sub Type"; "Contract Sub Type")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Status"; "Contract Status")
                {
                    ApplicationArea = Basic;
                }
                field("Magazine Code"; "Magazine Code")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Category"; "Contract Category")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Resource Lead"; "Resource Lead")
                {
                    ApplicationArea = Basic;
                }
                field("Resource Channel"; "Resource Channel")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Status"; "Payment Status")
                {
                    ApplicationArea = basic;

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Contract")
            {
                Caption = '&Contract';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Subscriber Contracts";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Subscriber Contract L/E";
                    RunPageLink = "Subscriber Contract No." = FIELD("No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Subscriber Contract"), "No." = FIELD("No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT Subscriber.GET("Subscriber No.") THEN
            Subscriber.INIT;
    end;

    var
        Subscriber: Record "Subscriber";
}

