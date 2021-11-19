PageExtension 50069 pageextension50069 extends "Purchases & Payables Setup"
{
    Caption = 'Purchases & Payables Setup';
    layout
    {
        modify("Post Dated Checks")
        {
            Caption = 'Post Dated Checks';
        }
        addafter("Default Qty. to Receive")
        {
            field("Average VAT Varience Account"; "Average VAT Varience Account")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Enable Vendor GST Amount (ACY)")
        {
            field("Allow WHT Difference"; "Allow WHT Difference")
            {
                ApplicationArea = Basic;
            }
            field("Allow Manual WHT Cert. No."; "Allow Manual WHT Cert. No.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("WHT Certificate No. Series")
        {
            field("WHT3 Certificate No. Series"; "WHT3 Certificate No. Series")
            {
                ApplicationArea = All;
            }
            field("WHT53 Certificate No. Series"; "WHT53 Certificate No. Series")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Print WHT Docs. on Pay. Post"; "Print WHT Docs. on Credit Memo")
        moveafter("Print WHT Docs. on Credit Memo"; "GST Prod. Posting Group")
    }
}

