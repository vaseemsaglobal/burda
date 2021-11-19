PageExtension 50017 pageextension50017 extends "Sales Order"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   01.02.2006   KKE   Add new fields for localization.
      002   30.11.2007   PTH   Add new MenuItem 'Subscriber Label' for subscriber report.
    */
    layout
    {


        addafter("Sell-to Address 2")
        {
            field("Sell-to Address 3"; "Sell-to Address 3")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("No. of Archived Versions")
        {
            field("PO No."; "PO No.")
            {
                ApplicationArea = Basic;
            }
            field("Posting No. Series"; "Posting No. Series")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Bill-to Address 2")
        {
            field("Bill-to Address 3"; "Bill-to Address 3")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Ship-to Address 2")
        {
            field("Ship-to Address 3"; "Ship-to Address 3")
            {
                ApplicationArea = Basic;
            }
        }
        addafter(Control1900201301)
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
    actions
    {


        addafter("Pick Instruction")
        {
            action("Subscriber Label")
            {
                ApplicationArea = Basic;
                Caption = 'Subscriber Label';

                trigger OnAction()
                begin
                    //#002 : PTH +
                    SalesLine.SetCurrentkey("Document Type", "Document No.", "Line No.");
                    SalesLine.SetRange("Document Type", SalesLine."document type"::Order);
                    SalesLine.SetRange("Document No.", "No.");
                    Report.RunModal(Report::"Subscriber Contract - Labels", true, false, SalesLine);
                    //#002 : PTH -
                end;
            }
        }
    }

    var
        SalesLine: Record "Sales Line";
}

