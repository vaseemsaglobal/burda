page 50080 "Settle Petty Cash"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.

    Caption = 'Settle Petty Cash';
    PageType = Document;
    SourceTable = "Settle Petty Cash Header";
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
                field("Petty Cash Vendor No."; "Petty Cash Vendor No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        PettyCashVendorNoOnAfterValida;
                    end;
                }
                field("Petty Cash Name"; "Petty Cash Name")
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
                field("Petty Cash Amount"; "Petty Cash Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Amount"; "Balance Amount")
                {
                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    var
                        VendLedgEntry: Record "Vendor Ledger Entry";
                        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                    begin
                        VendLedgEntry.RESET;
                        VendLedgEntry.SETRANGE("Vendor No.", "Petty Cash Vendor No.");
                        VendLedgEntry.SETFILTER("Posting Date", '..%1', "Posting Date");
                        VendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
                        PAGE.RUN(0, VendLedgEntry);
                    end;
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
            part(SettlePettyCashSubform; 50081)
            {
                ApplicationArea = Basic;
                SubPageLink = "Settle Petty Cash No." = FIELD("No.");
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
                    RunPageLink = "No." = FIELD("Petty Cash Vendor No.");
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
                    RunObject = Page "Check Preview - Petty Cash";
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
                        SettlePettyCashHdr: Record "Settle Petty Cash Header";
                        CheckPettyCash: Report "Check - Petty Cash";
                    begin
                        SettlePettyCashHdr.RESET;
                        SettlePettyCashHdr.SETRANGE("No.", "No.");
                        CheckPettyCash.SETTABLEVIEW(SettlePettyCashHdr);
                        CheckPettyCash.RUNMODAL;
                        CLEAR(CheckPettyCash);

                        //CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance",Rec);
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
                        CheckManagementExt.VoidCheckPettyCash(Rec); //VAH
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Suggest Petty Cash Line")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Petty Cash Line';

                    trigger OnAction()
                    var
                        SettlePettyCashHdr: Record "Settle Petty Cash Header";
                        SuggestPettyCashLine: Report "Suggest Petty Cash Line";
                    begin
                        SettlePettyCashHdr.SETRANGE("No.", "No.");
                        SuggestPettyCashLine.SETTABLEVIEW(SettlePettyCashHdr);
                        SuggestPettyCashLine.RUNMODAL;
                        CLEAR(SuggestPettyCashLine);
                    end;
                }
                separator(Separator)
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
                        SettlePettyCashHdr: Record "Settle Petty Cash Header";
                    begin
                        SettlePettyCashHdr.RESET;
                        SettlePettyCashHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Settle Petty Cash - Test", TRUE, FALSE, SettlePettyCashHdr);
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
                    RunObject = Codeunit 55001;
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
                        SettlePettyCashPost: Codeunit "Settle Petty Cash - Post";
                    begin
                        SettlePettyCashPost.CheckPostAndPrint(TRUE);
                        SettlePettyCashPost.RUN(Rec);
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
                        SettlePettyCashHdr: Record "Settle Petty Cash Header";
                    begin
                        SettlePettyCashHdr.RESET;
                        SettlePettyCashHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Payment Voucher - Petty Cash", TRUE, FALSE, SettlePettyCashHdr);
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

    local procedure PettyCashVendorNoOnAfterValida()
    begin
        IF ("Petty Cash Vendor No." <> xRec."Petty Cash Vendor No.") AND
           ("Petty Cash Vendor No." <> '')
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

