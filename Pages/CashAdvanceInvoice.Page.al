page 50086 "Cash Advance Invoice"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.
    UsageCategory = Documents;
    ApplicationArea = all;
    Caption = 'Cash Advance Invoice';
    PageType = Document;
    SourceTable = "Cash Advance Header";
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
                    Caption = 'No.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Cash Advance Vendor No."; "Cash Advance Vendor No.")
                {
                    Caption = 'Cash Advance Vendor';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CashAdvanceVendorNoOnAfterVali;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = All;
                }
                field("Invoice Description"; "Invoice Description")
                {
                    ApplicationArea = All;
                }
                field("Printing WHT Slip (Doc:WHT)"; "Printing WHT Slip (Doc:WHT)")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                    end;
                }
                field("Balance Amount"; "Balance Amount")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        VendLedgEntry: Record "Vendor Ledger Entry";
                        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                    begin
                        DtldVendLedgEntry.SETRANGE("Vendor No.", "Cash Advance Vendor No.");
                        VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                    end;
                }
                field("Balance Amount Settle"; "Balance Amount Settle")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }

            group(Invoicing)
            {
                Caption = 'Invoicing';

                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = basic;
                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("WHT Business Posting Group"; "WHT Business Posting Group")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;

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
            part(CashAdvLines; "Cash Advance Invoice Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = Basic, Suite;
                UpdatePropagation = Both;

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
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Cash Advance Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Cash Advance Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Cash Advance Comment Sheet";
                    RunPageLink = "Document Type" = CONST(Invoice), "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    var
                        CashAdvHdr: Record "Cash Advance Header";
                    begin
                        CashAdvHdr.RESET;
                        CashAdvHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Cash Advance Test", TRUE, FALSE, CashAdvHdr);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Cash Advance - Post";
                    ShortCutKey = 'F9';
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    var
                        CashAdvancePost: Codeunit "Cash Advance - Post";
                    begin
                        CashAdvancePost.CheckPostAndPrint(TRUE);
                        CashAdvancePost.RUN(Rec);
                        CurrPage.UPDATE(FALSE);
                        CLEAR(CashAdvancePost);
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Clear Advance")
                {
                    ApplicationArea = All;
                    Caption = 'Clear Advance';

                    trigger OnAction()
                    var
                        CashAdvHdr: Record "Cash Advance Header";
                    begin
                        CashAdvHdr.RESET;
                        CashAdvHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Clear Advance", TRUE, FALSE, CashAdvHdr);
                    end;
                }
                action("WHT Slip")
                {
                    ApplicationArea = All;
                    Caption = 'WHT Slip';
                    visible = false;
                    trigger OnAction()
                    var
                        CashAdvHdr: Record "Cash Advance Header";
                    begin
                        TESTFIELD(Status, Status::Released);
                        CashAdvHdr.RESET;
                        CashAdvHdr.SETRANGE("No.", "No.");
                        REPORT.RUN(REPORT::"Form 50 BIS -Cash Advance", TRUE, FALSE, CashAdvHdr);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        /*FILTERGROUP(2);
        SETFILTER("Date Filter", '..%1', "Posting Date");
        FILTERGROUP(0);
        SETRANGE("No.");*/
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        TotalAmount: Decimal;

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

    local procedure PostingDateOnAfterValidate()
    begin
        FILTERGROUP(2);
        SETFILTER("Date Filter", '..%1', "Posting Date");
        FILTERGROUP(0);
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.CashAdvLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.CashAdvLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        FILTERGROUP(2);
        SETFILTER("Date Filter", '..%1', "Posting Date");
        FILTERGROUP(0);
    end;
}

