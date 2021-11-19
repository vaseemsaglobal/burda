Page 50057 "Circulation Receipt"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.04.2007   KKE   New form for Circulation Receipt - Circulation Module
    // 002   18.09.2007   KKE   Add Calc. Payment

    PageType = Document;
    SourceTable = "Circulation Receipt Header";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; "No.")
                {
                    ApplicationArea = Basic;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(CustomerNo; "Customer No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if not Cust.Get("Customer No.") then
                            Clear(Cust);
                    end;
                }
                label(Control1000000015)
                {
                    ApplicationArea = Basic;
                    CaptionClass = FORMAT(Cust.Name);
                    Editable = false;
                }
                field(Contact; Contact)
                {
                    ApplicationArea = Basic;
                }
                field(DocumentDate; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(NoPrinted; "No. Printed")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000008; "Circulation Receipt Subform")
            {
                SubPageLink = "Circulation Receipt No." = field("No.");
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action(GetPostedInvoiceLine)
                {
                    ApplicationArea = Basic;
                    Caption = 'Get Posted Invoice Line';

                    trigger OnAction()
                    var
                        SalesInvHeader: Record "Sales Invoice Header";
                        FormPostedSalesInvs: Page "Posted Sales Invoices";
                    begin
                        SalesInvHeader.FilterGroup(2);
                        SalesInvHeader.SetRange("Bill-to Customer No.", "Customer No.");
                        SalesInvHeader.SetFilter("Posting Date", '<=%1', "Document Date");
                        //SalesInvHeader.SETRANGE("Get by Circulation Receipt",FALSE);
                        //SalesInvHeader.SETRANGE(Open,TRUE);
                        SalesInvHeader.SetRange("No. of Circulation Receipt", 0);
                        SalesInvHeader.FilterGroup(0);
                        Clear(FormPostedSalesInvs);
                        FormPostedSalesInvs.LookupMode := true;
                        FormPostedSalesInvs.GetFromCirReceipt(Rec);
                        FormPostedSalesInvs.SetTableview(SalesInvHeader);
                        FormPostedSalesInvs.SetRecord(SalesInvHeader);
                        FormPostedSalesInvs.RunModal;
                    end;
                }
                action(GetPostedCreditMemoLine)
                {
                    ApplicationArea = Basic;
                    Caption = 'Get Posted Credit Memo Line';

                    trigger OnAction()
                    var
                        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                        FormPostedSalesCrMemos: Page "Posted Sales Credit Memos";
                    begin
                        SalesCrMemoHeader.FilterGroup(2);
                        SalesCrMemoHeader.SetRange("Bill-to Customer No.", "Customer No.");
                        SalesCrMemoHeader.SetFilter("Posting Date", '<=%1', "Document Date");
                        SalesCrMemoHeader.SetRange("Get by Circulation Receipt", false);
                        SalesCrMemoHeader.SetRange(Open, true);
                        SalesCrMemoHeader.FilterGroup(0);
                        Clear(FormPostedSalesCrMemos);
                        FormPostedSalesCrMemos.LookupMode := true;
                        FormPostedSalesCrMemos.GetFromCirReceipt(Rec);
                        FormPostedSalesCrMemos.SetTableview(SalesCrMemoHeader);
                        FormPostedSalesCrMemos.RunModal;
                    end;
                }
                separator(Action1000000021)
                {
                }
                action(CalcPayment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Calc. Payment';

                    trigger OnAction()
                    begin
                        Rec.CalcPayment;  //KKE: #002
                    end;
                }
            }
            group(Print)
            {
                Caption = '&Print';
                action(Receipt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipt';

                    trigger OnAction()
                    var
                        CirReceiptHeader: Record "Circulation Receipt Header";
                    begin
                        CirReceiptHeader.Reset;
                        CirReceiptHeader.SetRange("No.", "No.");
                        Report.RunModal(Report::"Circulation Receipt", true, false, CirReceiptHeader);
                    end;
                }
                action("Receipt50ßí")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipt 50% first';

                    trigger OnAction()
                    var
                        CirReceiptHeader: Record "Circulation Receipt Header";
                        CirculationReceipt: Report "Circulation Receipt";
                    begin
                        CirReceiptHeader.Reset;
                        CirReceiptHeader.SetRange("No.", "No.");
                        CirculationReceipt.SetTableview(CirReceiptHeader);
                        CirculationReceipt.InitRequest(true);
                        CirculationReceipt.RunModal;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        Cust: Record Customer;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if not Cust.Get("Customer No.") then
            Clear(Cust);
    end;
}

