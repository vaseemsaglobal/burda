PageExtension 50068 pageextension50068 extends "Sales & Receivables Setup"
{
    Caption = 'Sales & Receivables Setup';
    layout
    {
        modify("Post Dated Checks")
        {
            Caption = 'Post Dated Checks';
        }
        addafter("Posted Prepmt. Inv. Nos.")
        {
            field("Complaint Nos."; "Complaint Nos.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("Sales Tax Invoice Nos."; "Sales Tax Invoice Nos.")
            {
                ApplicationArea = Basic;
            }
            field("Issued Tax Invoice/Receipt Nos"; "Issued Tax Invoice/Receipt Nos")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Default Cancel Reason Code")
        {
            field("Subject To"; Rec."Subject To")
            {
                ApplicationArea = all;
            }
        }
    }
}

