Report 50509 "Clear Advance"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ClearAdvance.rdl';

    //     Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut

    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   16.08.2006   KKE   Petty Cash
    // Burda
    // 002   30.08.2007   KKE   Average VAT

    dataset
    {
        dataitem("Cash Advance Header"; "Cash Advance Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Posting Date";
            column(CaptionTaxID; CaptionTaxID)
            {
            }

            column(DocumentNo; DocumentNo)
            {
            }
            column(CaptionToday; Format(Today, 0, 4))
            {
            }
            column(VendName; VendName)
            {
            }
            column(Description; "Cash Advance Header"."Invoice Description")
            {
            }
            column(xCash; xCash)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankBranch; BankBranch)
            {
            }
            column(PayeeName; PayeeName)
            {
            }
            column(PostingDate; Format("Posting Date", 0, 4))
            {
            }
            column(CheckNo; CheckNo)
            {
            }
            column(CheckDate; CheckDate)
            {
            }
            column(xCheque; xCheque)
            {
            }
            column(LineNo_GenJournalLine; 0)
            {
            }
            column(ShortcutDimension1Code_GenJournalLine; "Shortcut Dimension 1 Code")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(totalCurrCode; TtoalCurrCode)
            {
            }
            column(CompAddr1; CompanyAddr[1] + ' ' + CompanyInfo.Branch)
            {
            }
            column(CompAddr2; CompanyAddr[2])
            {
            }
            column(CompAddr3; CompanyAddr[3])
            {
            }
            column(CompAddr4; CompanyAddr[4])
            {
            }
            column(CompAddr5; CompanyAddr[5])
            {
            }
            column(CompAddr6; CompanyAddr[6])
            {
            }
            column(CompAddr7; CompanyAddr[7])
            {
            }
            column(CompAddr8; CompanyAddr[8])
            {
            }

            dataitem("Cash Advance Line"; "Cash Advance Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.") WHERE(Type = FILTER(<> " "));
                DataItemLink = "Document no." = FIELD("No.");
                column(EntryNo_VendLedgerEntrybuffer2; "Cash Advance Line"."Line No.")
                {
                }
                column(Description_ExternalDocumentNo; "Cash Advance Line".Description + '   #' + "Cash Advance Line"."External Document No.")
                {
                }
                column(VendLedgerEntrybuffe2_AmounttoApplyCreditVATAmtTmp; -"Cash Advance Line"."Amount Incl. VAT" - CreditVATAmtTmp)
                {
                }
                column(CreditVATAmtTmp; CreditVATAmtTmp)
                {
                }
                column(VendLedgerEntrybuffe2_AmounttoApply; -"Cash Advance Line"."Amount Incl. VAT")
                {
                }
                column(WHTAmtHeader; WHTAmtHeader)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CLEAR(AccountNo);
                    CASE Type OF
                        Type::"G/L Account":
                            BEGIN
                                AccountNo := "No.";
                            END;
                        ELSE
                            EXIT;
                    END;

                    IF NOT GLAcc.GET(AccountNo) THEN
                        GLAcc.INIT;

                    ShortcutDim3Code := '';
                    ShortcutDim4Code := '';
                    ShortcutDim5Code := '';
                    //Ravi-->Start
                    // IF DocumentDim.GET(
                    //     DATABASE::Table55002,
                    //     DocumentDim."Document Type"::Invoice,
                    //     "Document No.", "Line No.",
                    //     ShortcutDimCode[3])
                    // THEN
                    //     ShortcutDim3Code := DocumentDim."Dimension Value Code";
                    // IF DocumentDim.GET(
                    //     DATABASE::Table55002,
                    //     DocumentDim."Document Type"::Invoice,
                    //     "Document No.", "Line No.",
                    //     ShortcutDimCode[4])
                    // THEN
                    //     ShortcutDim4Code := DocumentDim."Dimension Value Code";
                    // IF DocumentDim.GET(
                    //     DATABASE::Table55002,
                    //     DocumentDim."Document Type"::Invoice,
                    //     "Document No.", "Line No.",
                    //     ShortcutDimCode[5])
                    // THEN
                    //     ShortcutDim5Code := DocumentDim."Dimension Value Code";
                    //Ravi--<End
                    i := 0;
                    MatchAcc := FALSE;
                    REPEAT
                        i := i + 1;
                        IF ((AccCode[i] = AccountNo) AND
                            (LineDescription[i] = Description) AND
                            (Dimension1Code[i] = "Shortcut Dimension 1 Code") AND
                            (Dimension2Code[i] = "Shortcut Dimension 2 Code") AND
                            (Dimension3Code[i] = ShortcutDim3Code) AND
                            (Dimension4Code[i] = ShortcutDim4Code) AND
                            (Dimension5Code[i] = ShortcutDim5Code))
                           OR (AccCode[i] = '')
                        THEN
                            MatchAcc := TRUE;
                    UNTIL (i = 200) OR MatchAcc;

                    AccCode[i] := AccountNo;
                    AccName[i] := "Cash Advance Line".Description;
                    LineDescription[i] := Description;
                    Dimension1Code[i] := "Shortcut Dimension 1 Code";
                    Dimension2Code[i] := "Shortcut Dimension 2 Code";
                    Dimension3Code[i] := ShortcutDim3Code;
                    Dimension4Code[i] := ShortcutDim4Code;
                    Dimension5Code[i] := ShortcutDim5Code;
                    //KKE : #002 +
                    IF "Avg. VAT Amount" <> 0 THEN BEGIN
                        IF "Amount Incl. VAT" - "Avg. VAT Amount" >= 0 THEN
                            DrAmount[i] := DrAmount[i] + "Amount Incl. VAT" - "Avg. VAT Amount"
                        ELSE
                            CrAmount[i] := CrAmount[i] - ("Amount Incl. VAT" - "Avg. VAT Amount");
                    END ELSE BEGIN
                        //KKE : #002 -
                        IF "VAT Base Amount (LCY)" >= 0 THEN
                            DrAmount[i] := DrAmount[i] + "VAT Base Amount (LCY)"
                        ELSE
                            CrAmount[i] := CrAmount[i] - "VAT Base Amount (LCY)";
                    END;

                    // VAT
                    CLEAR(AccountNo);
                    VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                    IF VATPostingSetup."Purch. VAT Unreal. Account" <> '' THEN
                        AccountNo := VATPostingSetup."Purch. VAT Unreal. Account"
                    ELSE
                        AccountNo := VATPostingSetup."Purchase VAT Account";
                    IF NOT GLAcc.GET(AccountNo) THEN
                        GLAcc.INIT;

                    i := 0;
                    MatchAcc := FALSE;
                    REPEAT
                        i := i + 1;
                        IF ((AccCode[i] = AccountNo) AND
                            (Dimension1Code[i] = "Shortcut Dimension 1 Code") AND
                            (Dimension2Code[i] = "Shortcut Dimension 2 Code") AND
                            (Dimension3Code[i] = ShortcutDim3Code) AND
                            (Dimension4Code[i] = ShortcutDim4Code) AND
                            (Dimension5Code[i] = ShortcutDim5Code))
                           OR (AccCode[i] = '')
                        THEN
                            MatchAcc := TRUE;
                    UNTIL (i = 200) OR MatchAcc;
                    AccCode[i] := AccountNo;
                    AccName[i] := GLAcc.Name;
                    Dimension1Code[i] := "Shortcut Dimension 1 Code";
                    Dimension2Code[i] := "Shortcut Dimension 2 Code";
                    Dimension3Code[i] := ShortcutDim3Code;
                    Dimension4Code[i] := ShortcutDim4Code;
                    Dimension5Code[i] := ShortcutDim5Code;
                    //KKE : #002 +
                    IF "Avg. VAT Amount" <> 0 THEN BEGIN
                        IF "Avg. VAT Amount" >= 0 THEN
                            DrAmount[i] := DrAmount[i] + "Avg. VAT Amount"
                        ELSE
                            CrAmount[i] := CrAmount[i] - "Avg. VAT Amount";
                    END ELSE BEGIN
                        //KKE : #002 -
                        IF "VAT Amount (LCY)" + "VAT Difference" >= 0 THEN
                            DrAmount[i] := DrAmount[i] + "VAT Amount (LCY)" + "VAT Difference"
                        ELSE
                            CrAmount[i] := CrAmount[i] - ("VAT Amount (LCY)" + "VAT Difference");
                    END;

                    // WHT
                    IF NOT "Skip WHT" THEN BEGIN
                        WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group");
                        IF WHTPostingSetup."WHT %" <> 0 THEN BEGIN
                            WHTPostingSetup.TESTFIELD("Payable WHT Account Code");
                            AccountNo := WHTPostingSetup."Payable WHT Account Code";
                            IF NOT GLAcc.GET(AccountNo) THEN
                                GLAcc.INIT;
                            i := 0;
                            MatchAcc := FALSE;
                            REPEAT
                                i := i + 1;
                                IF (WHTCode[i] = AccountNo) OR (WHTCode[i] = '') THEN
                                    MatchAcc := TRUE;
                            UNTIL (i = 200) OR MatchAcc;
                            WHTCode[i] := AccountNo;
                            WHTName[i] := GLAcc.Name;
                            IF "WHT Absorb Base" = 0 THEN
                                WHTCrAmount[i] := WHTCrAmount[i] + ROUND("VAT Base Amount (LCY)" * WHTPostingSetup."WHT %" / 100)
                            ELSE
                                WHTCrAmount[i] := WHTCrAmount[i] + ROUND("WHT Absorb Base" * WHTPostingSetup."WHT %" / 100);
                        END;
                    END;
                    if "Currency Code" <> '' then
                        CurrCode := "Currency Code"
                    else begin
                        GeneralLedgerSetup.Get;
                        CurrCode := GeneralLedgerSetup."LCY Code";
                    end;
                    if "Currency Code" <> '' then begin
                        if Currency.get("Currency Code") then
                            TtoalCurrCode := Currency.Description
                        else
                            TtoalCurrCode := "Currency Code";
                    end
                    else begin
                        GeneralLedgerSetup.Get;
                        TtoalCurrCode := GeneralLedgerSetup."Local Currency Description";
                    end;
                end;

                trigger OnPreDataItem()
                begin
                end;
            }
            dataitem(Detail; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));// ..
                column(DebitAccNoNumber; AccCode[Number])
                {

                }
                column(DebitAccNameNumber; AccName[Number])
                {

                }
                column(DebitAmountNumber; DrAmount[Number])
                {


                }
                column(CreditAmountNumber; CrAmount[Number])
                {

                }
                column(CreditWHTAmt; CreditWHTAmt)
                {

                }
                column(DebitVATNameNumber; CreditWHTAmt)
                {

                }
                column(Dimension1Code; Dimension1Code[Number])
                {

                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    Vendor.GET("Cash Advance Header"."Cash Advance Vendor No.");
                    VendPostingGrp.GET(Vendor."Vendor Posting Group");
                    IF NOT GLAcc.GET(VendPostingGrp."Payables Account") THEN
                        GLAcc.INIT;


                    //Ravi
                    ShortcutDim3Code := '';
                    ShortcutDim4Code := '';
                    ShortcutDim5Code := '';
                    MatchAcc := FALSE;
                    i := 0;
                    REPEAT
                        i := i + 1;
                        IF ((AccCode[i] = VendPostingGrp."Payables Account") AND
                            (Dimension1Code[i] = "Cash Advance Header"."Shortcut Dimension 1 Code") AND
                            (Dimension2Code[i] = "Cash Advance Header"."Shortcut Dimension 2 Code") AND
                            (Dimension3Code[i] = ShortcutDim3Code) AND
                            (Dimension4Code[i] = ShortcutDim4Code) AND
                            (Dimension5Code[i] = ShortcutDim5Code))
                           OR (AccCode[i] = '')
                        THEN
                            MatchAcc := TRUE
                    UNTIL (i = 200) OR MatchAcc;

                    AccCode[i] := (VendPostingGrp."Payables Account");
                    AccName[i] := "Cash Advance Header"."Invoice Description";

                    if AccCode[i] <> '' then
                        Line += 1;
                    //Ravi
                    Dimension1Code[i] := "Cash Advance Header"."Shortcut Dimension 1 Code";
                    Dimension2Code[i] := "Cash Advance Header"."Shortcut Dimension 2 Code";
                    Dimension3Code[i] := ShortcutDim3Code;
                    Dimension4Code[i] := ShortcutDim4Code;
                    Dimension5Code[i] := ShortcutDim5Code;

                    FOR j := 1 TO 200 DO BEGIN
                        IF i <> j THEN
                            CrAmount[i] := CrAmount[i] + DrAmount[j] - CrAmount[j] - WHTCrAmount[j]
                        ELSE
                            CrAmount[i] := CrAmount[i] + DrAmount[j];
                    END;
                    IF CrAmount[i] < 0 THEN BEGIN
                        DrAmount[i] := -CrAmount[i];
                        CrAmount[i] := 0;
                    END;
                end;


                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    IF AccCode[Number] = '' THEN
                        CurrReport.BREAK;

                    IF (DrAmount[Number] = 0) AND (CrAmount[Number] = 0) THEN
                        CurrReport.SKIP;

                    CntLine += 1;
                    DebitTotalLCY := DebitTotalLCY + DrAmount[Number];
                    //>>VAH
                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(TextAmount, Abs(DebitTotalLCY), "Cash Advance Header"."Currency Code");
                    if TextAmount[1] <> '' then
                        TextAmount[1] := '(' + TextAmount[1] + ' ' + TtoalCurrCode + ')';
                    if CrAmount[Number] <> 0 then
                        CreditTotalLCY := CreditTotalLCY + CrAmount[Number];

                end;
            }

            dataitem(WHT; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));//..

                column(WHTAccountNo; WHTCode[Number])
                {
                }
                column(WHTAccountName; WHTName[Number])
                {
                }
                column(WHTAmt; WHTAmt)
                {
                }
                column(DebitVATAmtNumber; WHTCrAmount[Number])
                {
                }
                column(CreditVATNoNumber; WHTCode[Number])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IF WHTCode[Number] = '' THEN
                        CurrReport.BREAK;
                    CntLine += 1;
                end;
            }
            dataitem(Description1; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = filter(1));


                column(CreditVATNameNumber; CreditWHTAmt)
                {
                }
                column(CreditVATAmtNumber; CreditWHTAmt)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if CreditWHTAmt <> 0 then
                        CntLine += 1;
                end;
            }
            dataitem("Line Loop"; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                column(CreditAccNoNumber; CreditWHTAmt)
                {
                }
                column(CreditAccNameNumber; CreditWHTAmt)
                {
                }

                column(Number_LineLoop; "Line Loop".Number)
                {
                }

                column(TextAmount1; TextAmount[1])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if CntLine + Line + Number > 23
                    then
                        CurrReport.Break;
                end;

                trigger OnPreDataItem()
                begin
                    if CntLine + Line + Number > 23
                    then
                        CurrReport.Break;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Vend: Record Vendor;
                VendCode: Code[20];
            begin
                CLEAR(AccCode);
                CLEAR(AccName);
                CLEAR(Dimension1Code);
                CLEAR(Dimension2Code);
                CLEAR(Dimension3Code);
                CLEAR(Dimension4Code);
                CLEAR(Dimension5Code);
                CLEAR(DrAmount);
                CLEAR(CrAmount);
                CLEAR(TotalDrAmount);
                CLEAR(TotalCrAmount);
                CLEAR(WHTCode);
                CLEAR(WHTName);
                CLEAR(WHTCrAmount);
                if "Cash Advance Header"."Name (Thai)" <> '' then
                    VendName := "Cash Advance Header"."Cash Advance Vendor No." + ' ' + "Cash Advance Header"."Name (Thai)"
                else
                    VendName := "Cash Advance Header"."Cash Advance Vendor No." + ' ' + "Cash Advance Header".Name;

                if "Cash Advance Header"."Name 2" <> '' then
                    PayeeName := "Cash Advance Header"."Name 2"
                else
                    PayeeName := "Cash Advance Header".Name;

                InvDescription := "Invoice Description";
                InvDescription := "Invoice Description";
                PostingDate := "Posting Date";
                DocumentNo := "No.";
                CntLine := 0;
                Line := 0;
                LanguageCaption.Reset();
                LanguageCaption.SetRange("Report ID", 50509);
                LanguageCaption.SetRange("Caption Code", 'TaxID');
                if LanguageCaption.FindFirst() then
                    CaptionTaxID := LanguageCaption."Caption in Thai";
                //VR
                CompanyAddr[1] := CompanyInfo.Name;
                CompanyAddr[2] := CompanyInfo."Company Name (Thai)";
                CompanyAddr[3] := CompanyInfo.Address + CompanyInfo."Address 2";
                CompanyAddr[4] := CompanyInfo."Address 3";
                CompanyAddr[5] := CompanyInfo."Company Address (Thai)";
                CompanyAddr[6] := CompanyInfo."Company Address 2 (Thai)";
                IF CompanyInfo."Phone No." <> '' then CompanyAddr[7] := 'Tel: ' + CompanyInfo."Phone No." + '  ';
                IF CompanyInfo."Fax No." <> '' Then CompanyAddr[7] += 'Fax: ' + CompanyInfo."Fax No." + '  ';
                if CompanyInfo."VAT Registration No." <> '' then begin
                    CompanyAddr[7] += 'Tax ID: ' + CompanyInfo."VAT Registration No.";
                    if CaptionTaxID <> '' then
                        CompanyAddr[8] := CaptionTaxID + ' ' + CompanyInfo."VAT Registration No.";
                end;
                CompressArray(CompanyAddr);
                //VR
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    END;

    trigger OnPreReport()
    begin

    end;

    var

        CompanyAddr: array[8] of Text[250];
        TaxIDThai: Text;
        i: Integer;
        j: Integer;
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        Vendor: Record Vendor;
        VendPostingGroup: Record "Vendor Posting Group";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry2: Record "Vendor Ledger Entry";
        VendLedgerEntrybuffer: Record "Vendor Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        CreditMemoVendLedgerEntry: Record "Vendor Ledger Entry";
        Customer: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GLAcc: Record "G/L Account";
        BankAcc: Record "Bank Account";
        BankAccPostingGroup: Record "Bank Account Posting Group";
        WHTPostingSetup: Record "WHT Posting Setup";
        WHTEntry: Record "WHT Entry";
        SalesInvLine: Record "Sales Invoice Line";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        xGenJnlLine: Record "Gen. Journal Line";
        VATEntry: Record "VAT Entry";
        VATPostSetup: Record "VAT Posting Setup";
        CheckReport: Report Check;
        WHTManagement: Codeunit WHTManagement;
        DebitAccount: Code[20];
        CreditAccount: Code[20];
        DebitAccNo: array[300] of Code[20];
        CreditAccNo: array[300] of Code[20];
        DebitAccName: array[300] of Text[150];
        CreditAccName: array[300] of Text[150];
        DebitAmount: array[300] of Decimal;
        CreditAmount: array[300] of Decimal;
        DebitDimValue: array[300] of Code[20];
        CreditDimValue: array[300] of Code[20];
        DebitVATDimValue: array[300] of Code[20];
        CreditVATDimValue: array[300] of Code[20];
        DebitVATNo: array[300] of Code[20];
        CreditVATNo: array[300] of Code[20];
        DebitVATName: array[300] of Text[150];
        CreditVATName: array[300] of Text[150];
        DebitVATAmt: array[300] of Decimal;
        CreditVATAmt: array[300] of Decimal;
        VATAccountNo: Code[20];
        VATAccountName: Text[150];
        WHTAccountNo: Code[20];
        WHTAccountName: Text[150];
        DebitTotalLCY: Decimal;
        CreditTotalLCY: Decimal;
        VendName: Text[150];
        DimentionValue: Code[20];
        TextAmount: array[2] of Text[250];
        WHTAmt: Decimal;
        WHTBaseAmt: Decimal;
        CreditWHTAmt: Decimal;
        CreditWHTBaseAmt: Decimal;
        TotalAmt: Decimal;
        CntLine: Integer;
        Line: Integer;
        DocumentNo: Code[20];
        Cash: Boolean;
        Cheque: Boolean;
        xCash: Text[1];
        xCheque: Text[1];
        BankAccNo: Code[20];
        BankName: Text[50];
        BankBranch: Text[30];
        StartingChequeNo: Code[20];
        CheckNo: Code[20];
        CheckDate: Date;
        PayPer: Decimal;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        DebitAmt2: Decimal;
        CreditAmt2: Decimal;
        MatchAcc: Boolean;

        DebitAppliedVATAmt: Decimal;
        CreditAppliedVATAmt: Decimal;
        PayeeName: Text[250];
        PaymentAmount: Decimal;
        ApplyCreditAmount: Decimal;
        ApplyInvoiceAmount: Decimal;
        g_intPatial: Integer;
        g_decRatioPatial: Decimal;
        g_decVATApplCrd: Decimal;
        FlagStatus: Integer;
        VATAccount: Code[20];
        VATAmount: Decimal;
        CreditVATAmtTmp: Decimal;
        CreditAppliedVATAmtTmp: Decimal;
        totCreditVATAmtTmp: Decimal;
        AmounttoApply: Decimal;
        totAmounttoApply: Decimal;
        ShowBlank: Boolean;
        TotalItemText: Text[30];
        LineSpace: Integer;

        TextPageNo: Text[30];
        SkipWHT: Boolean;
        VendEntryEdit: Codeunit CU113Ext;
        WHTAmtHeader: Decimal;
        CurrCode: Code[10];
        TtoalCurrCode: Code[50];
        GeneralLedgerSetup: Record "General Ledger Setup";
        LanguageCaption: Record "Language Caption";
        CaptionTaxID: Text;
        Currency: Record Currency;
        VendLedgerEntrybuffer2: Record "Vendor Ledger Entry" temporary;
        AccCode: array[27] of Code[20];
        AccName: array[27] of Text[50];
        Dimension1Code: array[27] of Code[20];
        Dimension2Code: array[27] of Code[20];
        Dimension3Code: array[27] of Code[20];
        Dimension4Code: array[27] of Code[20];
        Dimension5Code: array[27] of Code[20];
        DrAmount: array[200] of Decimal;
        CrAmount: array[200] of Decimal;
        TotalDrAmount: Decimal;
        TotalCrAmount: Decimal;

        WHTCode: array[27] of Code[20];
        WHTName: array[27] of Text[50];
        // WHTCrAmount: Decimal;
        InvDescription: Text[250];
        PostingDate: Date;
        AccountNo: Code[20];
        ShortcutDim3Code: Code[20];
        ShortcutDim4Code: Code[20];
        ShortcutDim5Code: Code[20];
        //  DocumentDim: Record "Document Dimension";

        LineDescription: array[200] of Text[50];

        VendPostingGrp: Record "Vendor Posting Group";
        WHTCrAmount: array[200] of Decimal;
        VATPostingSetup: Record "VAT Posting Setup";
}
