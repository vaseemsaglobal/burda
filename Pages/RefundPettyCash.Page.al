page 50070 "Refund Petty Cash"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization Demo TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.08.2006   KKE   -Petty Cash
    // 002   10.08.2006   KKE   -Modify program to be able to manual input WHT Certificate No.
    UsageCategory = Tasks;
    ApplicationArea = all;
    AutoSplitKey = true;
    Caption = 'Refund Petty Cash';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Gen. Journal Line";

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Basic;
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(repeater)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Tax Invoice No."; "Tax Invoice No.")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Invoice Date"; "Tax Invoice Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                    end;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Vendor: Record "Vendor";
                        GLAcc: Record "G/L Account";
                        Cust: Record "customer";
                        Bank: Record "Bank Account";
                        FA: Record "Fixed Asset";
                        ICPartner: Record "IC Partner";
                    begin
                        CASE "Account Type" OF
                            "Account Type"::Vendor:
                                BEGIN
                                    Vendor.SETRANGE("Petty Cash", TRUE);
                                    IF PAGE.RUNMODAL(0, Vendor) = ACTION::LookupOK THEN BEGIN
                                        Text := Vendor."No.";
                                        EXIT(TRUE);
                                    END;
                                END;
                            "Account Type"::"G/L Account":
                                BEGIN
                                    IF PAGE.RUNMODAL(0, GLAcc) = ACTION::LookupOK THEN BEGIN
                                        Text := GLAcc."No.";
                                        EXIT(TRUE);
                                    END;
                                END;
                            "Account Type"::Customer:
                                BEGIN
                                    IF PAGE.RUNMODAL(0, Cust) = ACTION::LookupOK THEN BEGIN
                                        Text := Cust."No.";
                                        EXIT(TRUE);
                                    END;
                                END;
                            "Account Type"::"Bank Account":
                                BEGIN
                                    IF PAGE.RUNMODAL(0, Bank) = ACTION::LookupOK THEN BEGIN
                                        Text := Bank."No.";
                                        EXIT(TRUE);
                                    END;
                                END;
                            "Account Type"::"Fixed Asset":
                                BEGIN
                                    IF PAGE.RUNMODAL(0, FA) = ACTION::LookupOK THEN BEGIN
                                        Text := FA."No.";
                                        EXIT(TRUE);
                                    END;
                                END;
                            "Account Type"::"IC Partner":
                                BEGIN
                                    IF PAGE.RUNMODAL(0, ICPartner) = ACTION::LookupOK THEN BEGIN
                                        Text := ICPartner.Code;
                                        EXIT(TRUE);
                                    END;
                                END;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Dummy Vendor"; "Dummy Vendor")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Registration No.(Dummy)"; "VAT Registration No.(Dummy)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Payee Name"; "Payee Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Branch"; "Bank Branch")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Real Customer/Vendor Name"; "Real Customer/Vendor Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("WHT Business Posting Group"; "WHT Business Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("WHT Product Posting Group"; "WHT Product Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Campaign No."; "Campaign No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Gen. Posting Type"; "Gen. Posting Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("WHT Payment"; "WHT Payment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Skip WHT"; "Skip WHT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("One Doc. Per WHT Slip"; "One Doc. Per WHT Slip")
                {
                    ApplicationArea = Basic;
                }
                field("WHT Certificate No."; "WHT Certificate No.")
                {
                    ApplicationArea = Basic;
                    Editable = "WHT Certificate No.Editable";
                }
                field("Certificate Printed"; "Certificate Printed")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount"; "VAT Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Difference"; "VAT Difference")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Vendor Exchange Rate (ACY)"; "Vendor Exchange Rate (ACY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. VAT Amount"; "Bal. VAT Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. VAT Difference"; "Bal. VAT Difference")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Bal. Gen. Posting Type"; "Bal. Gen. Posting Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. Gen. Bus. Posting Group"; "Bal. Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. Gen. Prod. Posting Group"; "Bal. Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. VAT Bus. Posting Group"; "Bal. VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bal. VAT Prod. Posting Group"; "Bal. VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Payment Type"; "Bank Payment Type")
                {
                    ApplicationArea = Basic;
                }
                field("Check Printed"; "Check Printed")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group(Batch)
            {
                field(AccName; AccName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                    Editable = false;
                }
                field(BalAccName; BalAccName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Bal. Account Name';
                    Editable = false;
                }
                field(Balance; Balance + "Balance (LCY)" - xRec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Visible = BalanceVisible;
                }
                field(TotalBalance; TotalBalance + "Balance (LCY)" - xRec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Total Balance';
                    Editable = false;
                    Visible = TotalBalanceVisible;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedIsBig = true;
                    //PromotedCategory = Category10;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                        CurrPage.SaveRecord;
                    end;
                }
            }
            group("A&ccount")
            {
                Caption = 'A&ccount';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Codeunit 15;
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    RunObject = Codeunit 14;
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group("&Payments")
            {
                Caption = '&Payments';
                action("Suggest Vendor Payments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Vendor Payments';
                    Ellipsis = true;
                    Image = SuggestVendorPayments;

                    trigger OnAction()
                    begin
                        CreateVendorPmtSuggestion.SetGenJnlLine(Rec);
                        CreateVendorPmtSuggestion.RUNMODAL;
                        CLEAR(CreateVendorPmtSuggestion);
                    end;
                }
                action("P&review Check")
                {
                    ApplicationArea = Basic;
                    Caption = 'P&review Check';
                    RunObject = Page 404;
                    RunPageLink = "Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" = FIELD("Journal Batch Name"), "Line No." = FIELD("Line No.");
                }
                action("Print Check")
                {
                    ApplicationArea = Basic;

                    Caption = 'Print Check';
                    Ellipsis = true;
                    Image = PrintCheck;

                    trigger OnAction()
                    begin
                        GenJnlLine.RESET;
                        GenJnlLine.COPY(Rec);
                        GenJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                        GenJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                        DocPrint.PrintCheck(GenJnlLine);
                        CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance", Rec);
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
                        TESTFIELD("Check Printed", TRUE);
                        IF CONFIRM(Text000, FALSE, "Document No.") THEN
                            CheckManagement.VoidCheck(Rec);
                    end;
                }
                action("Void &All Checks")
                {
                    ApplicationArea = Basic;
                    Caption = 'Void &All Checks';

                    trigger OnAction()
                    begin
                        IF CONFIRM(Text001, FALSE) THEN BEGIN
                            GenJnlLine.RESET;
                            GenJnlLine.COPY(Rec);
                            GenJnlLine.SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                            GenJnlLine.SETRANGE("Check Printed", TRUE);
                            IF GenJnlLine.FIND('-') THEN
                                REPEAT
                                    GenJnlLine2 := GenJnlLine;
                                    CheckManagement.VoidCheck(GenJnlLine2);
                                UNTIL GenJnlLine.NEXT = 0;
                        END;
                    end;
                }
            }
        }
        area(processing)
        {
            group("P&rint")
            {
                Caption = 'P&rint';
                action("Payment Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Voucher';

                    trigger OnAction()
                    begin
                        GenJnlLine.RESET;
                        GenJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                        GenJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                        GenJnlLine.SETRANGE("Document No.", "Document No.");
                        REPORT.RUN(REPORT::"Payment Voucher", TRUE, FALSE, GenJnlLine);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Apply Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    RunObject = Codeunit 225;
                    ShortCutKey = 'Shift+F11';
                }
                action("Insert Conv. LCY Rndg. Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insert Conv. LCY Rndg. Lines';
                    RunObject = Codeunit 407;
                }
                separator(separator)
                {
                }
                action("Cancel Post Dated Check")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Post Dated Check';

                    trigger OnAction()
                    begin
                        CancelCheck(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Reconcile)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    ShortCutKey = 'Ctrl+F11';

                    trigger OnAction()
                    begin
                        GLReconcile.SetGenJnlLine(Rec);
                        GLReconcile.RUN;
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Basic;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintGenJnlLine(Rec);
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
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        COMMIT;
                        CurrPage.UPDATE(FALSE);
                    end;
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
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        COMMIT;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        //KKE : #002 +
        IF "Certificate Printed" THEN
            "WHT Certificate No.Editable" := FALSE
        ELSE BEGIN
            GenJnlBatch.GET("Journal Template Name", "Journal Batch Name");
            "WHT Certificate No.Editable" := GenJnlBatch."Allow Manual WHT Cert. No.";
        END;
        //KKE : #002 -
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        TotalBalanceVisible := TRUE;
        BalanceVisible := TRUE;
        "WHT Certificate No.Editable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateBalance;
        SetUpNewLine(xRec, Balance, BelowxRec);
        CLEAR(ShortcutDimCode);

        "Account Type" := "Account Type"::Vendor;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        GenJnlManagement.TemplateSelection(PAGE::"Refund Petty Cash", 8, FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        Text000: Label 'Void Check %1?';
        Text001: Label 'Void all printed checks?';
        ChangeExchangeRate: Page "Change Exchange Rate";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GLReconcile: Page "Reconciliation";
        CreateVendorPmtSuggestion: Report "Suggest Vendor Payments";
        GenJnlManagement: Codeunit "GenJnlManagement";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        CheckManagement: Codeunit "CheckManagement";
        WHTManagement: Codeunit "WHTManagement";
        PostDatedCheckMgt: Codeunit "PostDatedCheckMgt";
        CurrentJnlBatchName: Code[10];
        AccName: Text[50];
        BalAccName: Text[50];
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        TType: Option Vendor,Customer;
        C_0001: Label 'Do you want to get WHT from petty cash?';
        C_0002: Label 'Successfully Inserted.';
        C_0003: Label 'WHT Entries does not exists.';
        GenJnlBatch: Record "Gen. Journal Batch";
        [InDataSet]
        "WHT Certificate No.Editable": Boolean;
        [InDataSet]
        BalanceVisible: Boolean;
        [InDataSet]
        TotalBalanceVisible: Boolean;
        PostDatedCheck: Record "Post Dated Check Line";
        Text1500004: Label 'Cancelled from Payment Journal.';
        Text1500002: Label 'Are you sure you want to cancel the post dated check?';
        LineNumber: Integer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        Text1500003: Label 'Cancelled from Cash Receipt Journal.';
        Text1500001: Label 'Journal Template %1, Batch Name %2, Line Number %3 was not a Post Dated Check Entry.';

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcBalance(
          Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance;
    end;

    procedure CancelCheck(var GenJnlLine: Record "Gen. Journal Line")
    begin
        if not GenJnlLine."Post Dated Check" then
            Error(Text1500001, GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name", GenJnlLine."Line No.");
        if not Confirm(Text1500002, false) then
            exit;
        PostDatedCheck.Reset();
        PostDatedCheck.SetCurrentKey("Line Number");
        if PostDatedCheck.FindLast then
            LineNumber := PostDatedCheck."Line Number"
        else
            LineNumber := 0;
        case GenJnlLine."Account Type" of
            GenJnlLine."Account Type"::"G/L Account":
                PostDatedCheck.SetRange("Account Type", PostDatedCheck."Account Type"::"G/L Account");
            GenJnlLine."Account Type"::Customer:
                PostDatedCheck.SetRange("Account Type", PostDatedCheck."Account Type"::Customer);
            GenJnlLine."Account Type"::Vendor:
                PostDatedCheck.SetRange("Account Type", PostDatedCheck."Account Type"::Vendor);
        end;

        PostDatedCheck.Init();
        case GenJnlLine."Account Type" of
            GenJnlLine."Account Type"::"G/L Account":
                PostDatedCheck.Validate("Account Type", PostDatedCheck."Account Type"::"G/L Account");
            GenJnlLine."Account Type"::Customer:
                PostDatedCheck.Validate("Account Type", PostDatedCheck."Account Type"::Customer);
            GenJnlLine."Account Type"::Vendor:
                PostDatedCheck.Validate("Account Type", PostDatedCheck."Account Type"::Vendor);
        end;
        PostDatedCheck.Validate("Batch Name", GenJnlLine."Journal Batch Name");
        PostDatedCheck.Validate("Account No.", GenJnlLine."Account No.");
        PostDatedCheck."Check Date" := GenJnlLine."Document Date";
        PostDatedCheck."Line Number" := LineNumber + 10000;
        PostDatedCheck.Validate("Currency Code", GenJnlLine."Currency Code");
        PostDatedCheck."Date Received" := WorkDate;
        PostDatedCheck."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type";
        PostDatedCheck."Applies-to Doc. No." := GenJnlLine."Applies-to Doc. No.";
        PostDatedCheck.Validate(Amount, GenJnlLine.Amount);
        PostDatedCheck."Check No." := GenJnlLine."Check No.";
        PostDatedCheck."Bank Payment Type" := GenJnlLine."Bank Payment Type";
        PostDatedCheck."Check Printed" := GenJnlLine."Check Printed";
        PostDatedCheck."Interest Amount" := GenJnlLine."Interest Amount";
        PostDatedCheck."Interest Amount (LCY)" := GenJnlLine."Interest Amount (LCY)";
        PostDatedCheck."Dimension Set ID" := GenJnlLine."Dimension Set ID";
        PostDatedCheck."Document No." := GenJnlLine."Document No.";
        PostDatedCheck."Bank Account" := GenJnlLine."Bal. Account No.";
        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer then begin
            if GenJnlLine."Applies-to ID" <> '' then begin
                CustLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
                if CustLedgEntry.FindSet then
                    repeat
                        CustLedgEntry."Applies-to ID" := PostDatedCheck."Document No.";
                        CustLedgEntry.Modify();
                    until CustLedgEntry.Next = 0;
                PostDatedCheck."Applies-to ID" := PostDatedCheck."Document No.";
            end;
        end else
            if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor then begin
                if GenJnlLine."Applies-to ID" <> '' then begin
                    VendLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
                    if VendLedgEntry.FindSet then
                        repeat
                            VendLedgEntry."Applies-to ID" := PostDatedCheck."Document No.";
                            VendLedgEntry.Modify();
                        until VendLedgEntry.Next = 0;
                    PostDatedCheck."Applies-to ID" := PostDatedCheck."Document No.";
                end;
            end;
        if GenJnlLine."Check Printed" then begin
            PostDatedCheck."Bank Account" := GenJnlLine."Bal. Account No.";
            PostDatedCheck."Document No." := GenJnlLine."Document No.";
        end;

        if PostDatedCheck."Account Type" = PostDatedCheck."Account Type"::Customer then
            PostDatedCheck.Comment := Text1500003
        else
            if PostDatedCheck."Account Type" = PostDatedCheck."Account Type"::Vendor then
                PostDatedCheck.Comment := Text1500004;

        PostDatedCheck.Insert();
        if GenJnlLine.Find then
            GenJnlLine.Delete();
    end;



}

