PageExtension 50050 pageextension50050 extends "Apply Customer Entries"
{
    layout
    {


        addafter("ApplyingCustLedgEntry.""Remaining Amount""")
        {
            field("Applying Entry"; "Applying Entry")
            {
                ApplicationArea = Basic;
            }
        }
        addfirst(Control1)
        {
            field(Control1000000000; "Applying Entry")
            {
                ApplicationArea = Basic;
            }
        }
    }


}

