PageExtension 50037 pageextension50037 extends "Posted Sales Invoice"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   01.02.2006   KKE   Add new fields for localization.
      Burda
      002   19.10.2007   KKE   Update Bill-to Name (thai)
      003   03.12.2007   KKE   Allow user to edit "PO No."
    */
    layout
    {

        //Unsupported feature: Property Insertion (Importance) on ""Sell-to County"(Control 1500000)".
        modify("Work Description")
        {
            Editable = true;
        }
        addafter("Sell-to Address 2")
        {
            field("Sell-to Address 3"; "Sell-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        addafter("Sell-to Contact")
        {
            field("Posting Description"; "Posting Description")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("No. Printed")
        {
            field("PO No."; "PO No.")
            {
                ApplicationArea = Basic;
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
        addafter("Shipping and Billing")
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
                }
                field("Bill-to Address (Thai)"; "Bill-to Address (Thai)")
                {
                    ApplicationArea = Basic;
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
                field(Brand; "Product (Ads. Invoice)")
                {
                    ApplicationArea = Basic;
                }
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

        /*
                addafter("F&unctions")
                {
                    group(PrintReports)
                    {
                        Caption = 'Print Reports';

                        action("Invoice - &Combine Ads. Sales")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Invoice - &Combine Ads. Sales';
                            Visible = false;
                            trigger OnAction()
                            begin
                                CurrPage.SetSelectionFilter(SalesInvHeader);
                                Report.Run(Report::"Sales - Invoice Combine", true, false, SalesInvHeader);
                            end;
                        }
                        action("Invoice - &Ads. Sales")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Invoice';

                            trigger OnAction()
                            begin
                                CurrPage.SetSelectionFilter(SalesInvHeader);
                                SalesInvHeader.PrintRecords(true);
                            end;
                        }
                        action("Invoice - &Circulation")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Invoice Circulation';

                            trigger OnAction()
                            var
                                DocumentSendingProfile: Record "Document Sending Profile";
                                DummyReportSelections: Record "Report Selections";
                            begin
                                CurrPage.SetSelectionFilter(SalesInvHeader);
                                //Report.Run(Report::"Inv & Tax Invoice (TH)", true, false, SalesInvHeader);
                                DocumentSendingProfile.TrySendToPrinter(
                                DummyReportSelections.Usage::"Invoice Ciculation".AsInteger(), SalesInvHeader, SalesInvHeader.FieldNo("Bill-to Customer No."), true);
                            end;
                        }
                        action("&Receipt - Subscription")
                        {
                            ApplicationArea = Basic;
                            Caption = '&Receipt Subscription';

                            trigger OnAction()
                            var
                                DocumentSendingProfile: Record "Document Sending Profile";
                                DummyReportSelections: Record "Report Selections";
                            begin
                                CurrPage.SetSelectionFilter(SalesInvHeader);
                                DocumentSendingProfile.TrySendToPrinter(
                                DummyReportSelections.Usage::"Receipt Subscription".AsInteger(), SalesInvHeader, SalesInvHeader.FieldNo("Bill-to Customer No."), true);
                                //Report.Run(Report::"Receipt Subsription", true, false, SalesInvHeader);
                            end;
                        }
                        separator(Action1000000032)
                        {
                        }
                        action("Receipt - &Other Sales")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Receipt - &Other Sales';
                            Visible = false;
                            trigger OnAction()
                            var
                                ReceiptOtherSales: Report "Receipt_TH";
                                DocumentSendingProfile: Record "Document Sending Profile";
                                DummyReportSelections: Record "Report Selections";
                            begin
                                CurrPage.SetSelectionFilter(SalesInvHeader);
                                //REPORT.RUN(REPORT::"Receipt - Other Sales",TRUE,FALSE,SalesInvHeader);
                                Clear(ReceiptOtherSales);
                                CurrPage.SetSelectionFilter(SalesInvHeader);
                                Report.Run(Report::"Receipt_TH", true, false, SalesInvHeader);
                                //ReceiptOtherSales.InitRequest(Rec); //VAH
                                //ReceiptOtherSales.RunModal;
                            end;
                        }
                        action("Receipt/Tax Invoice - Other Sales")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Receipt';

                            trigger OnAction()
                            var
                                DocumentSendingProfile: Record "Document Sending Profile";
                                DummyReportSelections: Record "Report Selections";
                            begin
                                CurrPage.SetSelectionFilter(SalesInvHeader);
                                DocumentSendingProfile.TrySendToPrinter(
                               DummyReportSelections.Usage::Receipt.AsInteger(), SalesInvHeader, SalesInvHeader.FieldNo("Bill-to Customer No."), true);

                                //Report.Run(Report::"Receipt_TH", true, false, SalesInvHeader);
                            end;
                        }
                        action("Invoice/Tax Invoice for Other Sales")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Tax Invoice';

                            trigger OnAction()
                            var
                                DocumentSendingProfile: Record "Document Sending Profile";
                                DummyReportSelections: Record "Report Selections";
                            begin
                                CurrPage.SetSelectionFilter(SalesInvHeader);
                                DocumentSendingProfile.TrySendToPrinter(
                                                       DummyReportSelections.Usage::"Tax Invoice".AsInteger(), SalesInvHeader, SalesInvHeader.FieldNo("Bill-to Customer No."), true);

                                //Report.Run(Report::"Inv & Tax Invoice (TH)", true, false, SalesInvHeader);
                            end;
                        }
                    }
                }
                */
        addafter(AttachAsPDF)
        {
            group(PrintReports1)
            {
                Caption = 'Print Reports';

                action("Invoice - &Combine Ads. Sales1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Invoice - &Combine Ads. Sales';
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Report;
                    Image = Print;
                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(SalesInvHeader);
                        Report.Run(Report::"Sales - Invoice Combine", true, false, SalesInvHeader);
                    end;
                }
                action("Invoice - &Ads. Sales1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Invoice';
                    Promoted = true;
                    PromotedCategory = Report;
                    Image = Print;
                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(SalesInvHeader);
                        SalesInvHeader.PrintRecords(true);
                    end;
                }
                action("Invoice - &Circulation1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Invoice Circulation';
                    Promoted = true;
                    PromotedCategory = Report;
                    Image = Print;
                    trigger OnAction()
                    var
                        DocumentSendingProfile: Record "Document Sending Profile";
                        DummyReportSelections: Record "Report Selections";
                    begin
                        CurrPage.SetSelectionFilter(SalesInvHeader);
                        //Report.Run(Report::"Inv & Tax Invoice (TH)", true, false, SalesInvHeader);
                        DocumentSendingProfile.TrySendToPrinter(
                        DummyReportSelections.Usage::"Invoice Ciculation".AsInteger(), SalesInvHeader, SalesInvHeader.FieldNo("Bill-to Customer No."), true);
                    end;
                }
                action("&Receipt - Subscription1")
                {
                    ApplicationArea = Basic;
                    Caption = '&Receipt Subscription';
                    Promoted = true;
                    PromotedCategory = Report;
                    Image = Print;
                    trigger OnAction()
                    var
                        DocumentSendingProfile: Record "Document Sending Profile";
                        DummyReportSelections: Record "Report Selections";
                    begin
                        CurrPage.SetSelectionFilter(SalesInvHeader);
                        DocumentSendingProfile.TrySendToPrinter(
                        DummyReportSelections.Usage::"Receipt Subscription".AsInteger(), SalesInvHeader, SalesInvHeader.FieldNo("Bill-to Customer No."), true);
                        //Report.Run(Report::"Receipt Subsription", true, false, SalesInvHeader);
                    end;
                }
                separator(Action10000000321)
                {
                }
                action("Receipt - &Other Sales1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipt - &Other Sales';
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Report;
                    Image = Print;
                    trigger OnAction()
                    var
                        ReceiptOtherSales: Report "Receipt_TH";
                        DocumentSendingProfile: Record "Document Sending Profile";
                        DummyReportSelections: Record "Report Selections";
                    begin
                        CurrPage.SetSelectionFilter(SalesInvHeader);
                        //REPORT.RUN(REPORT::"Receipt - Other Sales",TRUE,FALSE,SalesInvHeader);
                        Clear(ReceiptOtherSales);
                        CurrPage.SetSelectionFilter(SalesInvHeader);
                        Report.Run(Report::"Receipt_TH", true, false, SalesInvHeader);
                        //ReceiptOtherSales.InitRequest(Rec); //VAH
                        //ReceiptOtherSales.RunModal;
                    end;
                }
                action("Receipt/Tax Invoice - Other Sales1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipt';
                    Promoted = true;
                    PromotedCategory = Report;
                    Image = Print;
                    trigger OnAction()
                    var
                        DocumentSendingProfile: Record "Document Sending Profile";
                        DummyReportSelections: Record "Report Selections";
                    begin
                        CurrPage.SetSelectionFilter(SalesInvHeader);
                        DocumentSendingProfile.TrySendToPrinter(
                       DummyReportSelections.Usage::Receipt.AsInteger(), SalesInvHeader, SalesInvHeader.FieldNo("Bill-to Customer No."), true);

                        //Report.Run(Report::"Receipt_TH", true, false, SalesInvHeader);
                    end;
                }
                action("Invoice/Tax Invoice for Other Sales1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax Invoice';
                    Promoted = true;
                    PromotedCategory = Report;
                    Image = Print;
                    trigger OnAction()
                    var
                        DocumentSendingProfile: Record "Document Sending Profile";
                        DummyReportSelections: Record "Report Selections";
                    begin
                        CurrPage.SetSelectionFilter(SalesInvHeader);
                        DocumentSendingProfile.TrySendToPrinter(
                                               DummyReportSelections.Usage::"Tax Invoice".AsInteger(), SalesInvHeader, SalesInvHeader.FieldNo("Bill-to Customer No."), true);

                        //Report.Run(Report::"Inv & Tax Invoice (TH)", true, false, SalesInvHeader);
                    end;
                }
            }
        }
    }

    var
        SalesInvHeader: Record "Sales Invoice Header";
    //Unsupported feature: Code Insertion on "OnModifyRecord".

    trigger OnModifyRecord(): Boolean
    var
        SalesPost: Codeunit CU80Ext;
    begin

        //KKE : #001 +
        IF ("Bill-to Name (Thai)" <> xRec."Bill-to Name (Thai)") OR
           ("Bill-to Address (Thai)" <> xRec."Bill-to Address (Thai)")
        THEN BEGIN
            SalesPost.UpdateBilltoOnSalesInvHdr(Rec);
        END;
        //KKE : #001 -
        //KKE : #003 +
        IF ("PO No." <> xRec."PO No.") OR
           ("Remark 1" <> xRec."Remark 1") OR
           ("Remark 2" <> xRec."Remark 2") OR
           ("Product (Ads. Invoice)" <> xRec."Product (Ads. Invoice)")
        THEN
            SalesPost.SalesInvHdrEdit(Rec);

        EXIT(FALSE);
        //KKE : #003 -

    end;
}

