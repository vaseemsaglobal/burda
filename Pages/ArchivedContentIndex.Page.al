Page 50061 "Archived Content Index"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New form for "Content List" - Editorial Module

    Editable = false;
    PageType = Document;
    SourceTable = "Archived Content Index Header";
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
                    Editable = false;
                }
                field(CreationDate; "Creation Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MagazineItemNo; "Magazine Item No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;

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
            part(ContentBookingLines; "Archived Content Index Subform")
            {
                SubPageLink = "Content List No." = field("No.");
                ApplicationArea = bsic;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        Item: Record Item;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if not Item.Get("Magazine Item No.") then
            Clear(Item);
    end;
}

