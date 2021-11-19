PageExtension 50018 pageextension50018 extends "Sales Invoice"
{
    layout
    {


        addafter("Sell-to Address 2")
        {
            field("Sell-to Address 3"; "Sell-to Address 3")
            {
                ApplicationArea = Basic;
            }
        }

        addafter("Assigned User ID")
        {
            field("PO No."; "PO No.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Bill-to Contact")
        {
            field("Posting No. Series"; "Posting No. Series")
            {
                ApplicationArea = Basic;
            }
        }
        addbefore("Work Description")
        {
            field("Remark From Accountant"; "Remark from Accountant")
            {
                ApplicationArea = Basic;
                MultiLine = true;

            }
            field(Brand; Brand)
            {
                ApplicationArea = All;

            }
        }
        addafter(Application)
        {
            group("Address (Thai)")
            {
                Caption = 'Address (Thai)';
                field("Sell-to Name (Thai)"; "Sell-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Address (Thai)"; "Sell-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Bill-to Name (Thai)"; "Bill-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Address (Thai)"; "Bill-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Ship-to Name (Thai)"; "Ship-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Address (Thai)"; "Ship-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
            }
            group(Remark)
            {
                Caption = 'Remark';
                field("Remark 1"; "Remark 1")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Remark 2"; "Remark 2")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }

            }
        }
    }

}

