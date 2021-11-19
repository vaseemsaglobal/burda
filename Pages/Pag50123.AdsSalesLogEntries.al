page 50123 "Ads. Sales Log Entries"
{

    ApplicationArea = All;
    Caption = 'Ads. Sales Log Entries';
    PageType = List;
    SourceTable = "Ads. Sales Log Entry";
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Creation Date Time"; Rec."Creation Date Time")
                {
                    ToolTip = 'Specifies the value of the Creation Date Time field';
                    ApplicationArea = All;
                }
                field("Deal No."; Rec."Deal No.")
                {
                    ToolTip = 'Specifies the value of the Deal No. field';
                    ApplicationArea = All;
                }
                field(Deleted; Rec.Deleted)
                {
                    ToolTip = 'Specifies the value of the Deleted field';
                    ApplicationArea = All;
                }
                field("Deleted By"; Rec."Deleted By")
                {
                    ToolTip = 'Specifies the value of the Deleted By field';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                }
                field("Documnet Type"; Rec."Documnet Type")
                {
                    ToolTip = 'Specifies the value of the Documnet Type field';
                    ApplicationArea = All;
                }
                field("Remark From Accountant"; Rec."Remark From Accountant")
                {
                    ToolTip = 'Specifies the value of the Remark From Accountant field';
                    ApplicationArea = All;
                }
                field("Sub Deal No."; Rec."Sub Deal No.")
                {
                    ToolTip = 'Specifies the value of the Sub Deal No. field';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field';
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field';
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field';
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field';
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field';
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
