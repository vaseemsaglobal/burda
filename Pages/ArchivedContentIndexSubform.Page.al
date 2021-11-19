Page 50062 "Archived Content Index Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   18.05.2007   KKE   New form for "Archived Content Index Subform" - Editorial Module

    AutoSplitKey = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Archived Content Index Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(ContentCode; "Content Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Description2; "Description 2")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ColumnName; "Column Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(ContentType; "Content Type")
                {
                    ApplicationArea = Basic;
                }
                field(ContentSubType; "Content Sub Type")
                {
                    ApplicationArea = Basic;
                }
                field(NoofPage; "No. of Page")
                {
                    ApplicationArea = Basic;
                }
                field(Size; Size)
                {
                    ApplicationArea = Basic;
                }
                field(Position; Position)
                {
                    ApplicationArea = Basic;
                }
                field(AuthorName; "Author Name")
                {
                    ApplicationArea = Basic;
                }
                field(SourceofInformation; "Source of Information")
                {
                    ApplicationArea = Basic;
                }
                field(CostLCY; "Cost (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(ContentReceiptDate; "Content Receipt Date")
                {
                    ApplicationArea = Basic;
                }
                field(ActualPageNo; "Actual Page No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Line)
            {
                Caption = '&Line';
                action(PhotoExpense)
                {
                    ApplicationArea = Basic;
                    Caption = '&Photo Expense';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50061. Unsupported part was commented. Please check it.
                        /*CurrPage.ContentBookingLines.PAGE.*/
                        _ShowPhotoExpense;

                    end;
                }
                action(ContentCost)
                {
                    ApplicationArea = Basic;
                    Caption = 'Content &Cost';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50061. Unsupported part was commented. Please check it.
                        /*CurrPage.ContentBookingLines.PAGE.*/
                        _ShowContentCost;

                    end;
                }
            }
        }
    }


    procedure _ShowPhotoExpense()
    begin
        Rec.ShowPhotoExpense;
    end;


    procedure ShowPhotoExpense()
    begin
        Rec.ShowPhotoExpense;
    end;


    procedure _ShowContentCost()
    begin
        Rec.ShowContentCost;
    end;


    procedure ShowContentCost()
    begin
        Rec.ShowContentCost;
    end;
}

