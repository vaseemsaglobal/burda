TableExtension 50044 tableextension50044 extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; "Statement Check"; Boolean)
        {
            Description = '#001 To show if the amount is reconciled';
        }
        field(50001; "Applied Check"; Boolean)
        {
            Description = '#001 To show if the amount is reconciled';
        }
        field(50002; "Outstanding Check"; Boolean)
        {
            Description = '#001 To Show on report outstanding check';
        }
    }


}

