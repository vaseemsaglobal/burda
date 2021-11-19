Page 50020 "PO Type Setup"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "PO Type";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(POTypeCode;"PO Type Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(NosforPO;"Nos. for PO")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

