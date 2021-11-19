TableExtension 50046 tableextension50046 extends "Sales & Receivables Setup"
{
    Caption = 'Sales & Receivables Setup';
    fields
    {
        modify("Post Dated Check Template")
        {
            Caption = 'Post Dated Check Template';
        }
        modify("Post Dated Check Batch")
        {
            Caption = 'Post Dated Check Batch';
        }
        field(50000; "Complaint Nos."; Code[10])
        {
            Caption = 'Complaint Nos.';
            Description = 'Burda1.00';
            TableRelation = "No. Series";
        }
        field(50001; "Sales Tax Invoice Nos."; Code[10])
        {
            Description = 'Burda1.00';
            TableRelation = "No. Series";
        }
        field(50002; "Issued Tax Invoice/Receipt Nos"; Code[10])
        {
            Description = 'Burda1.00';
            TableRelation = "No. Series";
        }
        field(50011; "Subject To"; Text[100])
        {
            Description = 'Burda1.00';
        }
    }
}

