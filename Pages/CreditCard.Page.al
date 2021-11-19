Page 50011 "Credit Card"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Credit Card";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Bank; Bank)
                {
                    ApplicationArea = Basic;
                }
                field(CreditCardType; "Credit Card Type")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeFeeCust; "% Charge Fee (Cust.)")
                {
                    ApplicationArea = Basic;
                }
                field(VATforChargeFee; "VAT % for Charge Fee")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeFeeBank; "% Charge Fee (Bank)")
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

