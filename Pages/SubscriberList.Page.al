page 50002 "Subscriber List"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New Form for Subscriber List.
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageId = "Subscriber Card";
    PageType = List;
    SourceTable = Subscriber;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Old Subscriber No."; "Old Subscriber No.")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Contact No."; "Contact No.")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No."; "Mobile No.")
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
            group("&Subscriber")
            {
                Caption = '&Subscriber';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Subscriber Card";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Subscriber), "No." = FIELD("No.");
                }
                action("C&ustomer")
                {
                    ApplicationArea = Basic;
                    Caption = 'C&ustomer';
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Customer No.");
                }
            }
        }
    }

    var
        NoFilter: Text[250];
        FirstNameFilter: Text[250];
        MiddleNameFilter: Text[250];
        LastNameFilter: Text[250];
        DateOfBirth: Text[250];
        PhoneNo: Text[250];
        MobileNo: Text[250];
}

