Page 50112 "Average VAT Setup"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Average VAT Setup";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Year; Year)
                {
                    ApplicationArea = Basic;
                }
                field(FromDate; "From Date")
                {
                    ApplicationArea = Basic;
                }
                field(ToDate; "To Date")
                {
                    ApplicationArea = Basic;
                }
                field(VATClaim; "VAT Claim %")
                {
                    ApplicationArea = Basic;
                }
                field(VATUnclaim; "VAT Unclaim %")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; "User ID")
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

