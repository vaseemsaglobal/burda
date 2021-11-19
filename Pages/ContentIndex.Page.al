Page 50026 "Content Index"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New form for "Content List" - Editorial Module

    PageType = Document;
    SourceTable = "Content Index Header";
    RefreshOnActivate = true;

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
                    Editable = "No.Editable";

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(CreationDate; "Creation Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Creation DateEditable";
                }
                field(MagazineItemNo; "Magazine Item No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Magazine Item No.Editable";

                    trigger OnValidate()
                    begin
                        if not Item.Get("Magazine Item No.") then
                            Clear(Item);
                    end;
                }
                field(Close; Close)
                {
                    ApplicationArea = Basic;
                }
                field(MagazineCode; Item."Magazine Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Magazine Code';
                    Editable = false;
                    TableRelation = "Sub Product";
                }
                field(VolumeNo; Item."Volume No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Volume No.';
                    Editable = false;
                    TableRelation = Volume;
                }
                field(IssueNo; Item."Issue No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue No.';
                    Editable = false;
                    TableRelation = "Issue No.";
                }
                field(IssueDate; Item."Issue Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue Date';
                    Editable = false;
                }
            }
            part(ContentBookingLines; "Content Index Subform")
            {
                Editable = ContentBookingLinesEditable;
                SubPageLink = "Content List No." = field("No.");
                ApplicationArea = basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Report")
            {
                Caption = '&Report';
                action(ContentIndexList)
                {
                    ApplicationArea = Basic;
                    Caption = 'Content &Index List';

                    trigger OnAction()
                    var
                        ContentIndexHdr: Record "Content Index Header";
                    begin
                        ContentIndexHdr.SetRange("No.", "No.");
                        Report.Run(Report::"Content Index List", true, false, ContentIndexHdr);
                    end;
                }
                action(ContentExpenseReport)
                {
                    ApplicationArea = Basic;
                    Caption = 'Content &Expense Report';

                    trigger OnAction()
                    var
                        ContentIndexHdr: Record "Content Index Header";
                    begin
                        ContentIndexHdr.SetRange("No.", "No.");
                        Report.Run(Report::"Content Expense Report", true, false, ContentIndexHdr);
                    end;
                }
            }
        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action(CopyContent)
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy &Content';

                    trigger OnAction()
                    var
                        CopyContentIndex: Report "Copy Content Index";
                    begin
                        TestField("Magazine Item No.");
                        Clear(CopyContentIndex);
                        CopyContentIndex.InitRequest(Rec);
                        CopyContentIndex.RunModal;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        ContentBookingLinesEditable := true;
        "Magazine Item No.Editable" := true;
        "Creation DateEditable" := true;
        "No.Editable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        Item: Record Item;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        "Creation DateEditable": Boolean;
        [InDataSet]
        "Magazine Item No.Editable": Boolean;
        [InDataSet]
        ContentBookingLinesEditable: Boolean;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if not Item.Get("Magazine Item No.") then
            Clear(Item);

        "No.Editable" := not Close;
        "Creation DateEditable" := not Close;
        "Magazine Item No.Editable" := not Close;
        ContentBookingLinesEditable := not Close;
    end;
}

