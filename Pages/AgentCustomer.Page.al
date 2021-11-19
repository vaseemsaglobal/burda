Page 50054 "Agent Customer"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New form for Agent Customer - Circulation Module

    PageType = Document;
    SourceTable = "Agent Customer Header";
    RefreshOnActivate = true;
    //UsageCategory = Documents;
    //ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; "No.")
                {
                    ApplicationArea = Basic;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(MagazineItemNo; "Magazine Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(UnitofMeasureCode; "Unit of Measure Code")
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
                field(DocumentDate; "Document Date")
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
            }
            part("Agent Customer Subform"; "Agent Customer Subform")
            {
                SubPageLink = "Agent Customer No." = field("No.");
                ApplicationArea = basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action(CopyDocument)
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    var
                        CopyAgentCust: Report "Copy Agent Customer";
                    begin
                        CopyAgentCust.SetAgentCustHdr(Rec);
                        CopyAgentCust.RunModal;
                        Clear(CopyAgentCust);
                    end;
                }
            }
        }
    }
}

