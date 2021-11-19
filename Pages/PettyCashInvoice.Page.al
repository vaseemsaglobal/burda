page 50071 "Petty Cash Invoice"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.

    Caption = 'Petty Cash Invoice';
    PageType = Document;
    SourceTable = "Petty Cash Header";
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
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = Basic;
                }
                field("Invoice Description"; "Invoice Description")
                {
                    ApplicationArea = Basic;
                }
                field("Printing WHT Slip (Doc:WHT)"; "Printing WHT Slip (Doc:WHT)")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                    end;
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
                        DtldVendLedgEntry.SETRANGE("Vendor No.", "Petty Cash Vendor No.");
                        VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                    end;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(PettyCashLines; 50072)
            {
                ApplicationArea = Basic;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {

                Caption = 'Invoicing';
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
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("WHT Business Posting Group"; "WHT Business Posting Group")
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
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50078;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
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
                    RunPageLink = "Document Type" = CONST(Invoice), "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
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
                        PettyCashHdr: Record "Petty Cash Header";
                    begin
                        PettyCashHdr.RESET;
                        PettyCashHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Petty Cash Test", TRUE, FALSE, PettyCashHdr);
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
                    RunObject = Codeunit 55000;
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
                        PettyCashPost: Codeunit "Petty Cash - Post";
                    begin
                        PettyCashPost.CheckPostAndPrint(TRUE);
                        PettyCashPost.RUN(Rec);
                        CurrPage.UPDATE(FALSE);
                        CLEAR(PettyCashPost);
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Petty Cash Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Petty Cash Voucher';

                    trigger OnAction()
                    var
                        PettyCashHdr: Record "Petty Cash Header";
                    begin
                        PettyCashHdr.RESET;
                        PettyCashHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Petty Cash Voucher", TRUE, FALSE, PettyCashHdr);
                    end;
                }
                action("WHT Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'WHT Slip';
                    Visible = false;
                    trigger OnAction()
                    var
                        PettyCashHdr: Record "Petty Cash Header";
                    begin
                        TESTFIELD(Status, Status::Released);
                        PettyCashHdr.RESET;
                        PettyCashHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Form 50 BIS -Petty Cash", TRUE, FALSE, PettyCashHdr);
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
        ChangeExchangeRate: Page "Change Exchange Rate";
        TotalAmount: Decimal;

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

    local procedure PostingDateOnAfterValidate()
    begin
        FILTERGROUP(2);
        SETFILTER("Date Filter", '..%1', "Posting Date");
        FILTERGROUP(0);
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PettyCashLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PettyCashLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        FILTERGROUP(2);
        SETFILTER("Date Filter", '..%1', "Posting Date");
        FILTERGROUP(0);
    end;
}

