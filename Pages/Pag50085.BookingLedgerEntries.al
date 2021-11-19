page 50085 "Booking Ledger Entries"
{

    ApplicationArea = All;
    Caption = 'Booking Ledger Entries';
    PageType = List;
    SourceTable = "Booking Ledger Entry";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field';
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field';
                    ApplicationArea = All;
                }
                field("Deal No."; Rec."Deal No.")
                {
                    ToolTip = 'Specifies the value of the Deal No. field';
                    ApplicationArea = All;
                }
                field("Sub Deal No."; Rec."Sub Deal No.")
                {
                    ToolTip = 'Specifies the value of the Sub Deal No. field';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field("GL Acc No."; Rec."GL Acc No.")
                {
                    ToolTip = 'Specifies the value of the GL Acc No. field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
