PageExtension 50039 pageextension50039 extends "Posted Sales Credit Memo"
{
    layout
    {


        addafter("Sell-to Address 2")
        {
            field("Sell-to Address 3"; "Sell-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("No. Printed")
        {
            field("Applied-to Tax Invoice"; "Applied-to Tax Invoice")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Bill-to Address 2")
        {
            field("Bill-to Address 3"; "Bill-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Ship-to Address 2")
        {
            field("Ship-to Address 3"; "Ship-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Adjustment Details")
        {
            group("Address (Thai)")
            {
                Caption = 'Address (Thai)';
                field("Sell-to Name (Thai)"; "Sell-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sell-to Address (Thai)"; "Sell-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Bill-to Name (Thai)"; "Bill-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bill-to Address (Thai)"; "Bill-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Ship-to Name (Thai)"; "Ship-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ship-to Address (Thai)"; "Ship-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
            }
            group(Remark)
            {
                Caption = 'Remark';
                field("Remark 1"; "Remark 1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Remark 2"; "Remark 2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {



        addafter("F&unctions")
        {
            group("&Print")
            {
                Caption = '&Print';
                action("&Credit Note")
                {
                    ApplicationArea = Basic;
                    Caption = '&Credit Note';

                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(SalesCrMemoHeader);
                        SalesCrMemoHeader.PrintRecords(true);
                    end;
                }
                action("Credit Note/&Invoice")
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Note/&Invoice';

                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(SalesCrMemoHeader);
                        Report.Run(Report::"Sales - Credit Note / Invoice", true, false, SalesCrMemoHeader);
                    end;
                }
            }
        }
    }
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
}

