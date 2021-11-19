page 50095 "Settle Cash Advance"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.

    Caption = 'Settle Cash Advance';
    PageType = Document;
    SourceTable = "Settle Cash Advance Header";
    RefreshOnActivate = true;

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
                field("Cash Advance Vendor No."; "Cash Advance Vendor No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CashAdvanceVendorNoOnAfterVali;
                    end;
                }
                field("Cash Advance Name"; "Cash Advance Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Invoice Description"; "Payment Invoice Description")
                {
                    ApplicationArea = Basic;
                }
                field("Settle Account Type"; "Settle Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Settle Account No."; "Settle Account No.")
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
                field(BalanceSettle; BalanceSettle)
                {
                    ApplicationArea = Basic;
                    Caption = 'Balance Settle';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(SettleCashAdvanceSubform; 50096)
            {
                ApplicationArea = Basic;
                SubPageLink = "Settle Cash Advance No." = FIELD("No.");
            }
            group(Cheque)
            {
                Caption = 'Cheque';
                field("Bank Payment Type"; "Bank Payment Type")
                {
                    ApplicationArea = Basic;
                }
                field("Paid to Vendor Name"; "Paid to Vendor Name")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Printed"; "Cheque Printed")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Settle")
            {
                Caption = '&Settle';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Cash Advance Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Petty Cash Comment Sheet";
                    RunPageLink = "Document Type" = CONST(Settle), "No." = FIELD("No.");
                }
            }
            group("&Payments")
            {
                Caption = '&Payments';
                action("P&review Check")
                {
                    ApplicationArea = Basic;
                    Caption = 'P&review Check';
                    RunObject = Page "Check Preview - Cash Advance";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Print Check")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print Check';
                    Ellipsis = true;
                    Image = PrintCheck;

                    trigger OnAction()
                    var
                        SettleCashAdvHdr: Record "Settle Cash Advance Header";
                        CheckCashAdv: Report "Check - Cash Advance";
                    begin
                        SettleCashAdvHdr.RESET;
                        SettleCashAdvHdr.SETRANGE("No.", "No.");
                        CheckCashAdv.SETTABLEVIEW(SettleCashAdvHdr);
                        CheckCashAdv.RUNMODAL;
                        CLEAR(CheckCashAdv);
                    end;
                }
                action("Void Check")
                {
                    ApplicationArea = Basic;
                    Caption = 'Void Check';
                    Image = VoidCheck;

                    trigger OnAction()
                    begin
                        TESTFIELD("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                        TESTFIELD("Cheque Printed", TRUE);
                        IF CONFIRM(Text000, FALSE, "Cheque No.") THEN;
                        CheckManagementExt.VoidCheckCashAdv(Rec); //VAH
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Get Vendor Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Get Vendor Ledger Entries';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Cash Adv. - Get Vend. Ledge", Rec);
                    end;
                }
                separator(separator)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        Rec.Release;
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        Rec.Reopen;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    ApplicationArea = Basic;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    var
                        SettleCashAdvHdr: Record "Settle Cash Advance Header";
                    begin
                        SettleCashAdvHdr.RESET;
                        SettleCashAdvHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Settle Cash Advance - Test", TRUE, FALSE, SettleCashAdvHdr);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = Basic;
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 55051;
                    ShortCutKey = 'F9';
                }
                action("Post and &Print")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    var
                        SettleCashAdvPost: Codeunit "Settle Cash Advance - Post";
                    begin
                        SettleCashAdvPost.CheckPostAndPrint(TRUE);
                        SettleCashAdvPost.RUN(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group("P&rint")
            {
                Caption = 'P&rint';
                action("Payment Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Voucher';

                    trigger OnAction()
                    var
                        SettleCashAdvHdr: Record "Settle Cash Advance Header";
                    begin
                        SettleCashAdvHdr.RESET;
                        SettleCashAdvHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Payment Voucher - Cash Advance", TRUE, FALSE, SettleCashAdvHdr);
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

    trigger OnOpenPage()
    begin
        FILTERGROUP(2);
        SETFILTER("Date Filter", '..%1', "Posting Date");
        FILTERGROUP(0);
        SETRANGE("No.");
    end;

    var
        CheckManagement: Codeunit CheckManagement;
        CheckManagementExt: Codeunit Cu367Ext;
        BalanceSettle: Decimal;
        Text000: Label 'Void Check %1?';

    local procedure CashAdvanceVendorNoOnAfterVali()
    begin
        IF ("Cash Advance Vendor No." <> xRec."Cash Advance Vendor No.") AND
           ("Cash Advance Vendor No." <> '')
        THEN BEGIN
            FILTERGROUP(2);
            SETFILTER("Date Filter", '..%1', "Posting Date");
            FILTERGROUP(0);
        END ELSE
            SETRANGE("Date Filter");
        CurrPage.UPDATE;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        FILTERGROUP(2);
        SETFILTER("Date Filter", '..%1', "Posting Date");
        FILTERGROUP(0);
        CALCFIELDS("Balance Settle", "Balance Amount");
        BalanceSettle := "Balance Settle";
    end;
}

