PageExtension 50079 pageextension50079 extends "Fixed Asset Card"
{
    layout
    {
        addafter(Maintenance)
        {
            group(Burda)
            {
                Caption = 'Burda';
                field("Purchase Value"; "Purchase Value")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount"; "VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Portion"; "VAT Portion")
                {
                    ApplicationArea = Basic;
                }
                field("Cost Portion"; "Cost Portion")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt/Tax invoice"; "Receipt/Tax invoice")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}

