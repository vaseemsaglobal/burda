page 50106 "Sales Tax Invoice/Receipt"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   15.05.2007   KKE   -Sales Tax Invoice/Receipt.

    Caption = 'Sales Tax Invoice/Receipt';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Tax Invoice/Rec. Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidate(rec, xRec);
                        CurrPage.Update;
                    end;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = basic;
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Address 3"; "Sell-to Address 3")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sell-to Post Code/City';
                }
                field("Sell-to City"; "Sell-to City")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to County"; "Sell-to County")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Country Code"; "Sell-to Country Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sell-to County/Country Code';
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    ApplicationArea = Basic;
                }
                field("Invoice Description"; "Invoice Description")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Tax Invoice/Receipt"; "Issued Tax Invoice/Receipt")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Tax Invoice/Receipt No."; "Issued Tax Invoice/Receipt No.")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date / Time"; "Issued Date / Time")
                {
                    ApplicationArea = Basic;
                }
                field("Issued by"; "Issued by")
                {
                    ApplicationArea = Basic;
                }
                field("Cancel Tax Invoice"; "Cancel Tax Invoice")
                {
                    ApplicationArea = Basic;
                }
                field("Cancelled Date / Time"; "Cancelled Date / Time")
                {
                    ApplicationArea = Basic;
                }
                field("Cancelled by"; "Cancelled by")
                {
                    ApplicationArea = Basic;
                }
                field("Prepaid WHT"; "Prepaid WHT")
                {
                    ApplicationArea = Basic;
                }
                field("Work Description"; "Work Description")
                {
                    ApplicationArea = All;

                }
                field(Brand; Brand)
                {
                    ApplicationArea = All;

                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;

                }
            }
            part(SalesTaxInvLines; 50107)
            {
                ApplicationArea = Basic;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidate(rec, xRec);
                        CurrPage.Update();
                    end;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Address 3"; "Bill-to Address 3")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bill-to Post Code/City';
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to County"; "Bill-to County")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Country Code"; "Bill-to Country Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bill-to County/Country Code';
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    ApplicationArea = Basic;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = Basic;
                }
                field("Prices Including VAT"; "Prices Including VAT")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        //PricesIncludingVATOnAfterValidate;
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("Customer Order No."; "Customer Order No.")
                {
                    ApplicationArea = Basic;
                }
                field("No. Printed"; "No. Printed")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
            }
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
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Tax Invoice")
            {
                Caption = '&Tax Invoice';
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50109;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Issued Tax Invoice"), "No." = FIELD("No.");
                }
                action(Invoices)
                {
                    ApplicationArea = Basic;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page 143;
                    Visible = false;
                }
                /*action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page 547;
                                    RunPageLink = "Table ID"=CONST(50054),"Document No."=FIELD("No."),Line No.=CONST(0);
                }*/
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    //PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                action(LineDimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        CurrPage.SalesTaxInvLines.PAGE.ShowDimensions;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Copy Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesTaxInvHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Cancel Tax Invoice1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Tax Invoice';

                    trigger OnAction()
                    begin
                        Rec.CancelTaxInvoice;
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Tax Invoice")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax Invoice';

                    trigger OnAction()
                    var
                        SalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header";
                        SalesTaxInvoiceReceipt: Report "Receipt & Tax Inv (TH)";
                    begin
                        TESTFIELD("Cancel Tax Invoice", FALSE);
                        IF NOT CONFIRM(Text001, FALSE) THEN
                            EXIT;
                        SalesTaxInvHeader.RESET;
                        SalesTaxInvHeader.SETRANGE("No.", "No.");
                        SalesTaxInvoiceReceipt.SETTABLEVIEW(SalesTaxInvHeader);
                        SalesTaxInvoiceReceipt.RUNMODAL;
                        CLEAR(SalesTaxInvoiceReceipt);
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        //EXIT(ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            FILTERGROUP(0);
        END;
    end;

    var
        CopySalesDoc: Report "Copy Sales Tax Invoice";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit "ArchiveManagement";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesSetup: Record "Sales & Receivables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        UserMgt: Codeunit "User Setup Management";
        Text000: Label 'Unable to execute this function while in view only mode.';
        Text001: Label 'Please double check the information before printing Tax Invoice. Would you like to continue the transaction? (กรุณาตรวจสอบข้อมูลให้เรียบร้อยก่อนทำการพิมพ์ Tax Invoice คุณต้องการทำรายการต่อหรือไม่?).';

    [Scope('Internal')]
    procedure UpdateAllowed(): Boolean
    begin
        IF CurrPage.EDITABLE = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    /*local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesTaxInvLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesTaxInvLines.PAGE.UpdateForm(TRUE);
    end;*/

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

}

