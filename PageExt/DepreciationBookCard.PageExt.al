PageExtension 50081 pageextension50081 extends "Depreciation Book Card"
{
    layout
    {
        addafter("Subtract Disc. in Purch. Inv.")
        {
            field("No. of Days in Fiscal Year"; "No. of Days in Fiscal Year")
            {
                ApplicationArea = Basic;
            }
        }
    }

}

