PageExtension 50049 pageextension50049 extends "Posted Purchase Credit Memos"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Vendor Cr. Memo No."; "Vendor Cr. Memo No.")
            {
                ApplicationArea = Basic;
                Caption = '<Vendor Cr. Memo No.>';
            }
        }
    }

}

