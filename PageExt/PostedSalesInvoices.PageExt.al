PageExtension 50046 pageextension50046 extends "Posted Sales Invoices"
{
    layout
    {

        //Unsupported feature: Property Deletion (Visible) on ""Posting Date"(Control 109)".

        addafter("Sell-to Customer Name")
        {
            field("No. Series"; "No. Series")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter("Amount Including VAT")
        {
            field(RemainingAmt; RemainingAmt)
            {
                ApplicationArea = Basic;
                Caption = 'Remaining Amount';
            }
            field("Posting Description"; "Posting Description")
            {
                ApplicationArea = basic;

            }
        }
        moveafter("Sell-to Customer Name"; "Posting Date")
        moveafter("Location Code"; "Document Date")
    }

    actions
    {


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
        CirReceiptHeader: Record "Circulation Receipt Header";
        CustLedgEntry: Record "Cust. Ledger Entry";
        SalesPost: Codeunit CU80Ext;
        GetValueFromCirReceipt: Boolean;
        RemainingAmt: Decimal;
        CustLedgEntry2: Record "Cust. Ledger Entry";
        SalesInvHeader: Record "Sales Invoice Header";

    trigger OnAfterGetRecord()
    begin

        //KKE : #001
        RemainingAmt := 0;
        CustLedgEntry.RESET;
        CustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        CustLedgEntry.SETRANGE("Customer No.", "Bill-to Customer No.");
        CustLedgEntry.SETRANGE("Document No.", "No.");
        CustLedgEntry.SETRANGE("Posting Date", "Posting Date");
        IF CustLedgEntry.FIND('-') THEN BEGIN
            CustLedgEntry.CALCFIELDS("Remaining Amount");
            RemainingAmt := CustLedgEntry."Remaining Amount";
        END;

    end;


    //Unsupported feature: Code Insertion on "OnQueryClosePage".

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        IF CloseAction = Action::LookupOK THEN
            LookupOKOnPush;

    end;

    procedure GetFromCirReceipt(_CirReceiptHeader: Record "Circulation Receipt Header")
    begin
        //KKE : #001
        GetValueFromCirReceipt := true;
        CirReceiptHeader := _CirReceiptHeader;
    end;

    procedure InsertCirReceiptLine(var _SalesInvHeader: Record "Sales Invoice Header")
    var
        SalesInvLine: Record "Sales Invoice Line";
        CirReceiptLine: Record "Circulation Receipt Line";
        DetailCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CloseByCustLedgEntry: Record "Cust. Ledger Entry";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        LineNo: Integer;
    begin
        //KKE : #001
        if _SalesInvHeader.Find('-') then begin
            CirReceiptLine.SetRange("Circulation Receipt No.", CirReceiptHeader."No.");
            if CirReceiptLine.FindLast then
                LineNo := CirReceiptLine."Line No.";
            repeat
                SalesInvLine.SetRange("Document No.", _SalesInvHeader."No.");
                //  SalesInvLine.SETRANGE("Circulation Receipt No.",'');
                if SalesInvLine.Find('-') then
                    repeat
                        LineNo += 10000;
                        CirReceiptLine.Init;
                        CirReceiptLine."Circulation Receipt No." := CirReceiptHeader."No.";
                        CirReceiptLine."Line No." := LineNo;
                        CirReceiptLine."Document Type" := CirReceiptLine."document type"::Invoice;
                        CirReceiptLine."Document No." := SalesInvLine."Document No.";
                        CirReceiptLine."Document Line No." := SalesInvLine."Line No.";
                        CirReceiptLine."Posting Date" := _SalesInvHeader."Posting Date";
                        CirReceiptLine.Type := SalesInvLine.Type;
                        CirReceiptLine."No." := SalesInvLine."No.";
                        CirReceiptLine.Description := SalesInvLine.Description;
                        CirReceiptLine."Description 2" := SalesInvLine."Description 2";
                        CirReceiptLine.Quantity := SalesInvLine.Quantity;
                        CirReceiptLine."Unit Price" := SalesInvLine."Unit Price";
                        CirReceiptLine.Discount := SalesInvLine."Line Discount Amount" + SalesInvLine."Inv. Discount Amount";
                        //CirReceiptLine."Line Amount" := SalesInvLine."Line Amount";
                        //TSA
                        CustLedgEntry2.Reset;
                        CustLedgEntry2.SetRange("Document Type", CustLedgEntry2."document type"::Invoice);
                        CustLedgEntry2.SetRange("Document No.", SalesInvLine."Document No.");
                        CustLedgEntry2.SetRange("Customer No.", "Bill-to Customer No.");
                        if CustLedgEntry2.Find('-') then begin
                            //CustLedgEntry2.CALCFIELDS("Remaining Amt. (LCY)","Amount (LCY)");
                            //CirReceiptLine."Line Amount Incl. VAT" := CustLedgEntry2."Remaining Amt. (LCY)";
                            //KKE : #002 +
                            CustLedgEntry2.CalcFields("Remaining Amt. (LCY)", "Amount (LCY)");
                            CirReceiptLine."Line Amount Incl. VAT" :=
                              ROUND(SalesInvLine."Amount Including VAT" * CustLedgEntry2."Remaining Amt. (LCY)" /
                              CustLedgEntry2."Amount (LCY)");
                            //KKE : #002 -
                        end;
                        //CirReceiptLine."Line Amount Incl. VAT" := SalesInvLine."Amount Including VAT";
                        //TSA
                        CirReceiptLine.Insert;

                        SalesPost.UpdateSalesInvLineCirReceipt(
                          SalesInvLine."Document No.",
                          SalesInvLine."Line No.",
                          CirReceiptHeader."No.");
                        Clear(SalesPost);
                    until SalesInvLine.Next = 0;

                //Get CN which it closed by this invoice
                CustLedgEntry.Reset;
                CustLedgEntry.SetCurrentkey("Document No.", "Document Type", "Customer No.");
                CustLedgEntry.SetRange("Customer No.", "Bill-to Customer No.");
                CustLedgEntry.SetRange("Document No.", "No.");
                CustLedgEntry.SetRange("Posting Date", "Posting Date");
                if CustLedgEntry.Find('-') then begin
                    CloseByCustLedgEntry.Reset;
                    CloseByCustLedgEntry.SetCurrentkey("Closed by Entry No.");
                    CloseByCustLedgEntry.SetRange("Closed by Entry No.", CustLedgEntry."Entry No.");
                    CloseByCustLedgEntry.SetRange("Document Type", CloseByCustLedgEntry."document type"::"Credit Memo");
                    if CloseByCustLedgEntry.Find('-') then
                        repeat
                            SalesCrMemoLine.SetRange("Document No.", CloseByCustLedgEntry."Document No.");
                            SalesCrMemoLine.SetRange("Circulation Receipt No.", '');
                            if SalesCrMemoLine.Find('-') then
                                repeat
                                    LineNo += 10000;
                                    SalesCrMemoHeader.Get(SalesCrMemoLine."Document No.");
                                    CirReceiptLine.Init;
                                    CirReceiptLine."Circulation Receipt No." := CirReceiptHeader."No.";
                                    CirReceiptLine."Line No." := LineNo;
                                    CirReceiptLine."Document Type" := CirReceiptLine."document type"::"Credit Memo";
                                    CirReceiptLine."Document No." := SalesCrMemoLine."Document No.";
                                    CirReceiptLine."Document Line No." := SalesCrMemoLine."Line No.";
                                    CirReceiptLine."Posting Date" := SalesCrMemoHeader."Posting Date";
                                    CirReceiptLine.Type := SalesCrMemoLine.Type;
                                    CirReceiptLine."No." := SalesCrMemoLine."No.";
                                    CirReceiptLine.Description := SalesCrMemoLine.Description;
                                    CirReceiptLine."Description 2" := SalesCrMemoLine."Description 2";
                                    CirReceiptLine.Quantity := -SalesCrMemoLine.Quantity;
                                    CirReceiptLine."Unit Price" := SalesCrMemoLine."Unit Price";
                                    CirReceiptLine.Discount := -(SalesCrMemoLine."Line Discount Amount" + SalesCrMemoLine."Inv. Discount Amount");
                                    //CirReceiptLine."Line Amount" := -SalesCrMemoLine."Line Amount";
                                    //TSA
                                    CustLedgEntry2.Reset;
                                    CustLedgEntry2.SetRange("Document Type", CustLedgEntry2."document type"::"Credit Memo");
                                    CustLedgEntry2.SetRange("Document No.", SalesCrMemoLine."Document No.");
                                    CustLedgEntry2.SetRange("Customer No.", "Bill-to Customer No.");
                                    if CustLedgEntry2.Find('-') then begin
                                        //CustLedgEntry2.CALCFIELDS("Remaining Amt. (LCY)");
                                        //CirReceiptLine."Line Amount Incl. VAT" := CustLedgEntry2."Remaining Amt. (LCY)";
                                        //KKE : #002 +
                                        CustLedgEntry2.CalcFields("Remaining Amt. (LCY)", "Amount (LCY)");
                                        CirReceiptLine."Line Amount Incl. VAT" :=
                                          ROUND(SalesCrMemoLine."Amount Including VAT" * CustLedgEntry2."Remaining Amt. (LCY)" /
                                          CustLedgEntry2."Amount (LCY)");
                                        //KKE : #002 -
                                    end;
                                    //TSA
                                    //CirReceiptLine."Line Amount Incl. VAT" := -SalesCrMemoLine."Amount Including VAT";
                                    CirReceiptLine.Insert;

                                    SalesPost.UpdateSalesCrMemoCirReceipt(
                                      SalesCrMemoLine."Document No.",
                                      SalesCrMemoLine."Line No.",
                                      CirReceiptHeader."No.");
                                    Clear(SalesPost);
                                until SalesCrMemoLine.Next = 0;

                        until CloseByCustLedgEntry.Next = 0;
                end;
            until _SalesInvHeader.Next = 0;
        end;
    end;

    local procedure LookupOKOnPush()
    begin
        //KKE : #001
        if GetValueFromCirReceipt then begin
            CurrPage.SetSelectionFilter(Rec);
            InsertCirReceiptLine(Rec);
            Commit;
            CurrPage.Close;
        end;
    end;
}

