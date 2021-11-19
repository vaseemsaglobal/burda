TableExtension 50041 tableextension50041 extends "VAT Entry"
{
    fields
    {
        field(50000; "Real Customer/Vendor Name"; Text[150])
        {
        }
        field(50001; "Tax Invoice No."; Code[20])
        {
        }
        field(50002; "Tax Invoice Date"; Date)
        {
        }
        field(50005; "Line No."; Integer)
        {
        }
        field(50006; "Submit Date"; Date)
        {
            Caption = 'Submit Date';
        }
        field(50100; "Use Average VAT"; Boolean)
        {
        }
        field(50101; "Average VAT Year"; Integer)
        {
        }
        field(50102; "VAT Claim Percentage"; Decimal)
        {
        }
    }
    keys
    {

        key(Key3; "Tax Invoice Date", "Tax Invoice No.", "Submit Date")
        {
        }
    }

}

