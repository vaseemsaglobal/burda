TableExtension 50008 tableextension50008 extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Unrealized WHT Amount"; Decimal)
        {
            CalcFormula = sum("WHT Entry"."Unrealized Amount" where("Bill-to/Pay-to No." = field("Vendor No."),
                                                                     "Transaction No." = field("Transaction No.")));
            Caption = 'Unrealized WHT Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Unrealized WHT Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("WHT Entry"."Unrealized Amount (LCY)" where("Bill-to/Pay-to No." = field("Vendor No."),
                                                                           "Transaction No." = field("Transaction No.")));
            Caption = 'Unrealized WHT Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
    }

}

