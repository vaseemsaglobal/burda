TableExtension 50040 tableextension50040 extends "Source Code Setup" 
{
    Caption = 'Source Code Setup';
    fields
    {
        field(55000;"Petty Cash";Code[10])
        {
            Description = 'Petty Cash';
            TableRelation = "Source Code";
        }
        field(55050;"Cash Advance";Code[10])
        {
            Description = 'Cash Advance';
            TableRelation = "Source Code";
        }
    }
}

