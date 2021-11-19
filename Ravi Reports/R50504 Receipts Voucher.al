report 50504 "Receipts Voucher Report"
{
    // 
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.12.2005   KKE   -Receipt Voucher Report.
    // Burda
    // 002   11.07.2007   KKE   -Amount on Header get value from bank.
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ReceiptsVoucherReport.rdl';
    Caption = 'Receipt Voucher Report';
    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "Shortcut Dimension 1 Code");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Document No.";
            column(ShortcutDimension1Code_GenJournalLine; "Gen. Journal Line"."Shortcut Dimension 1 Code")
            {
            }
            column(totalCurrCode; TtoalCurrCode)
            {
            }
            column(DocNo; "Gen. Journal Line"."Document No.")
            {
            }
            column(CurrCode; TtoalCurrCode)
            {
            }
            column(Description; Description)
            {
            }
            column(PayeeName; PayeeName)
            {
            }
            column(CustName; CustName)
            {
            }
            column(DocumentNo; DocumentNo)
            {
            }
            column(PostingDate; FORMAT("Posting Date", 0, 4))
            {
            }
            column(CaptionToday; FORMAT(TODAY, 0, 4))
            {
            }
            column(CaptionTaxID; CaptionTaxID)
            {
            }
            dataitem(CustLedgerEntrybuffer2; "Cust. Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                column(Description_ExternalDocumentNo; Description + '   #' + "External Document No.")
                {
                }
                column(CreditVATAmtTmp; CreditVATAmtTmp)
                {
                }
                column(CustLedgerEntrybuffe2_AmounttoApplyCreditVATAmtTmp; CustLedgerEntrybuffer2."Amount to Apply" - CreditVATAmtTmp)
                {
                }
                column(CustLedgerEntrybuffe2_AmounttoApply; CustLedgerEntrybuffer2."Amount to Apply")
                {
                }
                column(WHTAmtHeader; WHTAmtHeader)
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
                trigger OnAfterGetRecord()
                begin
                    CustLedgerEntrybuffer2.CALCFIELDS("Amount (LCY)", "Remaining Amt. (LCY)", "Remaining Amount", "Original Amt. (LCY)");
                    CreditAppliedVATAmtTmp := 0;
                    CreditVATAmtTmp := 0;
                    PayPer := 1;
                    VATEntry.RESET;
                    VATEntry.SETCURRENTKEY("Document No.", "Posting Date");
                    VATEntry.SETRANGE("Posting Date", CustLedgerEntrybuffer2."Posting Date");
                    VATEntry.SETRANGE("Document No.", CustLedgerEntrybuffer2."Document No.");
                    //VATEntry.SETFILTER("Remaining Unrealized Amount",'<>0');
                    IF VATEntry.FIND('-') THEN
                        REPEAT
                            IF VATEntry.Amount <> 0 THEN BEGIN
                                CreditVATAmtTmp := CreditVATAmtTmp + VATEntry.Amount;
                                CreditAppliedVATAmtTmp := 0;
                            END;
                            IF VATEntry."Remaining Unrealized Amount" <> 0 THEN BEGIN
                                CreditVATAmtTmp := CreditVATAmtTmp + VATEntry."Remaining Unrealized Amount";
                                CreditAppliedVATAmtTmp := 0;
                            END;

                        UNTIL VATEntry.NEXT = 0;
                    CreditMemoCustLedgerEntry.SETRANGE("Closed by Entry No.", CustLedgerEntrybuffer2."Entry No.");
                    IF CreditMemoCustLedgerEntry.FIND('-') THEN
                        REPEAT
                            VATEntry.RESET;
                            VATEntry.SETCURRENTKEY("Document No.", "Posting Date");
                            VATEntry.SETRANGE("Posting Date", CreditMemoCustLedgerEntry."Posting Date");
                            VATEntry.SETRANGE("Document No.", CreditMemoCustLedgerEntry."Document No.");
                            IF VATEntry.FIND('-') THEN
                                REPEAT
                                    IF VATEntry.Amount <> 0 THEN BEGIN
                                        CreditVATAmtTmp := CreditVATAmtTmp + VATEntry.Amount;
                                        CreditAppliedVATAmtTmp := 0;
                                    END;
                                    IF VATEntry."Remaining Unrealized Amount" <> 0 THEN BEGIN
                                        CreditVATAmtTmp := CreditVATAmtTmp + VATEntry."Remaining Unrealized Amount";
                                        CreditAppliedVATAmtTmp := 0;
                                    END;
                                UNTIL VATEntry.NEXT = 0;
                        UNTIL CreditMemoCustLedgerEntry.NEXT = 0;
                    CreditVATAmtTmp := ABS(CreditVATAmtTmp);
                    totAmounttoApply += CustLedgerEntrybuffer2."Amount to Apply";
                    totCreditVATAmtTmp := totCreditVATAmtTmp + CreditVATAmtTmp;

                    // if CntLine > 25 then
                    //     CntLine := 1
                    // else
                    //     CntLine += 1;
                end;

                trigger OnPreDataItem()
                begin
                    //TSA
                    CustLedgerEntrybuffer.MARKEDONLY(TRUE);
                    IF CustLedgerEntrybuffer.FIND('-') THEN
                        REPEAT
                            CustLedgerEntrybuffer2 := CustLedgerEntrybuffer;
                            CustLedgerEntrybuffer2.MARK(TRUE);
                        UNTIL CustLedgerEntrybuffer.NEXT = 0
                    ELSE
                        ShowBlank := TRUE;
                    MARKEDONLY(TRUE);
                    //TSA
                    totCreditVATAmtTmp := 0;
                    totAmounttoApply := 0;
                end;
            }

            dataitem(CustLEFooter; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
            }
            dataitem(DataItem4; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                dataitem(DebitDetail; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(DebitAmountNumber; DebitAmount[Number])
                    {
                    }
                    column(DebitAccNoNumber; DebitAccNo[Number])
                    {
                    }
                    column(DebitAccNameNumber; DebitAccName[Number])
                    {
                    }
                    column(DebitVATNameNumber; DebitVATNameNumber)
                    {
                    }
                    column(DebitVATAmtNumber; DebitVATAmtNumber)
                    {
                    }
                    column(DebitDimValueNumber; DebitDimValue[Number])
                    {
                    }
                    column(CreditAmountNumber1; CreditAmount[Number])
                    {
                    }
                    column(CreditAmountname1; CreditAccName[Number])
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        IF DebitAccNo[Number] = '' THEN
                            CurrReport.BREAK
                        ELSE
                            IF DebitAmount[Number] = 0 THEN
                                CurrReport.SKIP
                            ELSE
                                Line := Line + 1;

                        if DebitAmount[Number] <= 0 then
                            CurrReport.Skip;

                        DebitTotalLCY := DebitTotalLCY + DebitAmount[Number];
                        //>>VAH
                        CheckReport.InitTextVariable;
                        CheckReport.FormatNoText(TextAmount, Abs(DebitTotalLCY), "Gen. Journal Line"."Currency Code");
                        if TextAmount[1] <> '' then
                            TextAmount[1] := '(' + TextAmount[1] + ' ' + TtoalCurrCode + ')';

                    end;

                    trigger OnPreDataItem()
                    begin

                        I := 0;
                        MatchAcc := FALSE;
                        REPEAT
                            I := I + 1;
                            IF (DebitAccNo[I] = BankAccNo) AND (DebitAmount[I] <> 0) THEN BEGIN
                                DebitAmount[I] := DebitAmount[I] - CreditWHTAmt;
                                MatchAcc := TRUE;
                            END;
                        UNTIL (I >= 100) OR MatchAcc;
                    end;
                }
                dataitem(CreditDetail; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(CreditAccNameNumber; CreditAccName[Number])
                    {
                    }
                    column(CreditDimValueNumber; CreditDimValue[Number])
                    {
                    }

                    column(CreditVATNameNumber; CreditVATNameNumber)
                    {
                    }
                    column(CreditWHTAmt; CreditWHTAmt)
                    {
                    }
                    column(CreditVATNoNumber; CreditVATNo[Number])
                    {
                    }
                    column(CreditAccNoNumber; CreditAccNo[Number])
                    {
                    }

                    column(CreditVATAmtNumber; CreditVATAmtNumber)
                    {
                    }

                    column(CreditAmountNumber; CreditAmount[Number])
                    {
                    }
                    trigger OnPreDataItem()
                    begin
                        I := 0;
                        MatchAcc := FALSE;
                        REPEAT
                            I := I + 1;
                            IF (CreditAccNo[I] <> '') AND (CreditAmount[I] <> 0) THEN BEGIN
                                CreditAmount[I] := CreditAmount[I] - CreditWHTAmt;
                                MatchAcc := TRUE;
                            END;
                        UNTIL (I >= 100) OR MatchAcc;

                    end;

                    trigger OnAfterGetRecord()
                    begin

                        IF CreditAccNo[Number] = '' THEN
                            CurrReport.BREAK
                        ELSE
                            IF CreditAmount[Number] = 0 THEN
                                CurrReport.SKIP
                            ELSE
                                Line := Line + 1;
                        if CreditAmount[Number] <= 0 then
                            CurrReport.Skip;

                        if CreditAccNo[Number] = '' then
                            CurrReport.Break

                        else begin
                            if not MatchAcc then begin
                                CreditAmount[Number] := CreditAmount[Number] + CreditWHTAmt;
                                MatchAcc := true;
                            end;
                            Line := Line + 1;
                        end;
                        CreditTotalLCY := CreditTotalLCY + CreditAmount[Number];

                    end;
                }
                dataitem(WHTDetail; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(WHTAccountName; WHTAccountName)
                    {
                    }
                    column(WHTAccountNo; WHTAccountNo)
                    {
                    }
                    column(WHTAmt; CreditWHTAmt)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        IF CreditWHTAmt = 0 THEN
                            CurrReport.SKIP
                        else
                            Line += 1;
                    end;
                }
                dataitem(LineLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(Number_LineLoop; LineLoop.Number)
                    {
                    }
                    column(TextAmount1; TextAmount[1])
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        CLEAR(CreditVATNo);
                        if CntLine + Line + Number > 16
                        then
                            CurrReport.Break;

                    end;
                }
                trigger OnPreDataItem()
                begin
                    if CurrReport.PageNo = 1 then
                        LineSpace := 15
                    else
                        LineSpace := 25;
                end;
            }

            trigger OnPreDataItem()
            begin
                CLEAR(CustName);
                CASE TRUE OF
                    Cash:
                        xCash := 'P';
                    Cheque:
                        xCheque := 'P';
                END;
            end;

            trigger OnAfterGetRecord()
            var
                CustCode: text[100];
                CustomeRec: Record Customer;
            begin
                if CustomeRec.get("Gen. Journal Line"."Account No.") then begin
                    CustCode := CustomeRec."No." + '' + Customer.Name;
                    CustName := Customer.Name + Customer."Name 2";
                end else begin
                    if CustomeRec.get("Gen. Journal Line"."Bal. Account No.") then begin
                        CustCode := CustomeRec."No." + '' + Customer.Name;
                        CustName := Customer.Name + Customer."Name 2";
                    end;
                end;

                IF "Document No." = GenJnlLine."Document No." THEN
                    CurrReport.SKIP
                ELSE
                    GenJnlLine := "Gen. Journal Line";

                clear(CntLine); //VAH
                Clear(Line); //VAH

                if "Gen. Journal Line"."Currency Code" <> '' then begin
                    if Currency.get("Gen. Journal Line"."Currency Code") then
                        TtoalCurrCode := Currency.Description
                    else
                        TtoalCurrCode := "Gen. Journal Line"."Currency Code";
                end else begin
                    GeneralLedgerSetup.Get;
                    TtoalCurrCode := GeneralLedgerSetup."Local Currency Description";
                end;
                //VR
                LanguageCaption.Reset();
                LanguageCaption.SetRange("Report ID", 50504);
                LanguageCaption.SetRange("Caption Code", 'TaxID');
                if LanguageCaption.FindFirst() then
                    CaptionTaxID := LanguageCaption."Caption in Thai";

                TaxIDThai := CaptionTaxID;
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
                    if TaxIDThai <> '' then
                        CompanyAddr[8] := TaxIDThai + ' ' + CompanyInfo."VAT Registration No.";
                end;
                CompressArray(CompanyAddr);
                //VR

                VATAmt := 0;
                CreditVATAmt := 0;

                CLEAR(Bank);
                CLEAR(DebitAccNo);
                CLEAR(DebitAccName);
                CLEAR(DebitDimValue);
                CLEAR(DebitAmount);
                CLEAR(CreditAccNo);
                CLEAR(CreditAccName);
                CLEAR(CreditDimValue);
                CLEAR(CreditAmount);
                CLEAR(VATAccountNo);
                CLEAR(VATAccountName);
                CLEAR(BankAccNo);
                CLEAR(CustLedgerEntrybuffer);
                I := 0;
                // SkipWHT := false; //KKE : #004
                CntLine := 0;
                IF "Check Printed" THEN BEGIN
                    DocumentNo := "External Document No.";
                END
                ELSE BEGIN
                    DocumentNo := "Document No.";
                END;

                GenJnlLine2.RESET;
                GenJnlLine2.SETRANGE("Journal Template Name", "Journal Template Name");
                GenJnlLine2.SETRANGE("Journal Batch Name", "Journal Batch Name");
                GenJnlLine2.SETRANGE("Document No.", "Document No.");
                IF GenJnlLine2.FIND('-') THEN BEGIN
                    REPEAT
                        WITH GenJnlLine2 DO BEGIN
                            IF "Debit Amount" <> 0 THEN BEGIN
                                CLEAR(DebitAccount);
                                CASE "Account Type" OF
                                    "Account Type"::"G/L Account":
                                        BEGIN
                                            DebitAccount := "Account No.";
                                        END;
                                    "Account Type"::Customer:
                                        BEGIN
                                            CustPostingGroup.GET("Posting Group");
                                            DebitAccount := CustPostingGroup."Receivables Account";
                                        END;
                                    "Account Type"::Vendor:
                                        BEGIN
                                            VendPostingGroup.GET("Posting Group");
                                            DebitAccount := VendPostingGroup."Payables Account";
                                        END;
                                    "Account Type"::"Bank Account":
                                        BEGIN
                                            BankAcc.GET("Account No.");
                                            BankAccPostingGroup.GET(BankAcc."Bank Acc. Posting Group");
                                            DebitAccount := BankAccPostingGroup."G/L Bank Account No.";
                                        END;
                                END;
                                I := 0;
                                MatchAcc := FALSE;
                                IF DebitAccount <> '' THEN BEGIN
                                    REPEAT
                                        I := I + 1;
                                        IF ((DebitAccNo[I] = DebitAccount) AND (DebitDimValue[I] = "Shortcut Dimension 1 Code"))
                                           OR (DebitAccNo[I] = '')
                                        THEN BEGIN
                                            DebitAccNo[I] := DebitAccount;
                                            GLAcc.GET(DebitAccNo[I]);
                                            DebitAccName[I] := GLAcc.Name;
                                            //DebitAmount[I] := DebitAmount[I] + "Debit Amount";
                                            DebitAmount[I] := DebitAmount[I] + ABS("Amount (LCY)");

                                            DebitDimValue[I] := "Shortcut Dimension 1 Code";
                                            MatchAcc := TRUE;
                                            IF "Account Type" = "Account Type"::"Bank Account" THEN
                                                BankAccNo := DebitAccount;
                                            MatchAcc := true;
                                        END;
                                    UNTIL (I >= 100) OR MatchAcc;
                                END;

                                IF "Bal. Account No." <> '' THEN BEGIN
                                    CLEAR(CreditAccount);
                                    CASE "Bal. Account Type" OF
                                        "Bal. Account Type"::"G/L Account":
                                            BEGIN
                                                CreditAccount := "Bal. Account No.";
                                            END;
                                        "Bal. Account Type"::Customer:
                                            BEGIN
                                                CustPostingGroup.GET("Posting Group");
                                                CreditAccount := CustPostingGroup."Receivables Account";
                                            END;
                                        "Bal. Account Type"::Vendor:
                                            BEGIN
                                                VendPostingGroup.GET("Posting Group");
                                                CreditAccount := VendPostingGroup."Payables Account";
                                            END;
                                        "Bal. Account Type"::"Bank Account":
                                            BEGIN
                                                BankAcc.GET("Bal. Account No.");
                                                BankAccPostingGroup.GET(BankAcc."Bank Acc. Posting Group");
                                                CreditAccount := BankAccPostingGroup."G/L Bank Account No.";
                                            END;
                                    END;
                                    I := 0;
                                    MatchAcc := FALSE;
                                    IF CreditAccount <> '' THEN BEGIN
                                        REPEAT
                                            I := I + 1;
                                            IF ((CreditAccNo[I] = CreditAccount) AND
                                                 (CreditDimValue[I] = "Shortcut Dimension 1 Code"))
                                               OR (CreditAccNo[I] = '')
                                            THEN BEGIN
                                                CreditAccNo[I] := CreditAccount;
                                                GLAcc.GET(CreditAccNo[I]);
                                                CreditAccName[I] := GLAcc.Name;
                                                //CreditAmount[I] := CreditAmount[I] + "Debit Amount";
                                                CreditAmount[I] := CreditAmount[I] + ABS("Amount (LCY)");

                                                CreditDimValue[I] := "Shortcut Dimension 1 Code";
                                                MatchAcc := TRUE;
                                                IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN
                                                    BankAccNo := CreditAccount;
                                            END;
                                        UNTIL (I >= 100) OR MatchAcc;
                                    END;
                                END;
                            END ELSE
                                IF "Credit Amount" <> 0 THEN BEGIN
                                    CLEAR(CreditAccount);
                                    CASE "Account Type" OF
                                        "Account Type"::"G/L Account":
                                            BEGIN
                                                CreditAccount := "Account No.";
                                            END;
                                        "Account Type"::Customer:
                                            BEGIN
                                                CustPostingGroup.GET("Posting Group");
                                                CreditAccount := CustPostingGroup."Receivables Account";
                                            END;
                                        "Account Type"::Vendor:
                                            BEGIN
                                                VendPostingGroup.GET("Posting Group");
                                                CreditAccount := VendPostingGroup."Payables Account";
                                            END;
                                        "Account Type"::"Bank Account":
                                            BEGIN
                                                BankAcc.GET("Account No.");
                                                BankAccPostingGroup.GET(BankAcc."Bank Acc. Posting Group");
                                                CreditAccount := BankAccPostingGroup."G/L Bank Account No.";
                                            END;
                                    END;
                                    I := 0;
                                    MatchAcc := FALSE;
                                    IF CreditAccount <> '' THEN BEGIN //Ravi
                                                                      //   IF "Bal. Account No." <> '' THEN BEGIN
                                        REPEAT
                                            I := I + 1;
                                            IF ((CreditAccNo[I] = CreditAccount) AND (CreditDimValue[I] = "Shortcut Dimension 1 Code"))
                                               OR (CreditAccNo[I] = '')
                                             THEN BEGIN
                                                CreditAccNo[I] := CreditAccount;

                                                GLAcc.GET(CreditAccNo[I]);
                                                CreditAccName[I] := GLAcc.Name;

                                                //CreditAmount[I] := CreditAmount[I] + "Credit Amount";
                                                CreditAmount[I] := CreditAmount[I] + ABS("Amount (LCY)");
                                                //Message('credit amount1 %1  i value %2', CreditAmount[i], i);

                                                CreditDimValue[I] := "Shortcut Dimension 1 Code";
                                                IF "Account Type" = "Account Type"::"Bank Account" THEN
                                                    BankAccNo := CreditAccount;
                                                MatchAcc := TRUE;
                                            END;
                                        UNTIL (I >= 100) OR MatchAcc;
                                    END;

                                    IF "Bal. Account No." <> '' THEN BEGIN
                                        CLEAR(DebitAccount);
                                        CASE "Bal. Account Type" OF
                                            "Bal. Account Type"::"G/L Account":
                                                BEGIN
                                                    DebitAccount := "Bal. Account No.";
                                                END;
                                            "Bal. Account Type"::Customer:
                                                BEGIN
                                                    CustPostingGroup.GET("Posting Group");
                                                    DebitAccount := CustPostingGroup."Receivables Account";
                                                END;
                                            "Bal. Account Type"::Vendor:
                                                BEGIN
                                                    VendPostingGroup.GET("Posting Group");
                                                    DebitAccount := VendPostingGroup."Payables Account";
                                                END;
                                            "Bal. Account Type"::"Bank Account":
                                                BEGIN
                                                    BankAcc.GET("Bal. Account No.");
                                                    BankAccPostingGroup.GET(BankAcc."Bank Acc. Posting Group");
                                                    DebitAccount := BankAccPostingGroup."G/L Bank Account No.";
                                                END;
                                        END;
                                        I := 0;
                                        MatchAcc := FALSE;
                                        IF DebitAccount <> '' THEN BEGIN
                                            REPEAT
                                                I := I + 1;
                                                IF ((DebitAccNo[I] = DebitAccount) AND (DebitDimValue[I] = "Shortcut Dimension 1 Code"))
                                                   OR (DebitAccNo[I] = '')
                                                THEN BEGIN
                                                    DebitAccNo[I] := DebitAccount;
                                                    GLAcc.GET(DebitAccNo[I]);
                                                    DebitAccName[I] := GLAcc.Name;
                                                    //DebitAmount[I] := DebitAmount[I] + "Credit Amount";
                                                    DebitAmount[I] := DebitAmount[I] + ABS("Amount (LCY)");
                                                    // ravi   CreditAmount[I] := CreditAmount[I] + ABS("Credit Amount");
                                                    DebitDimValue[I] := "Shortcut Dimension 1 Code";
                                                    MatchAcc := TRUE;
                                                    IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN
                                                        BankAccNo := DebitAccount;
                                                END;
                                            UNTIL (I >= 100) OR MatchAcc;
                                        END;
                                    END;
                                END;
                            //Applies to ID
                            IF "Applies-to ID" <> '' THEN BEGIN
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                                IF "Account Type" = "Account Type"::Customer THEN
                                    CustLedgerEntry.SETRANGE("Customer No.", "Account No.");
                                IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                                    CustLedgerEntry.SETRANGE("Customer No.", "Bal. Account No.");
                                CustLedgerEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                                IF CustLedgerEntry.FIND('-') THEN
                                    REPEAT
                                        CustLedgerEntrybuffer := CustLedgerEntry;
                                        CustLedgerEntrybuffer.MARK(TRUE);
                                    UNTIL CustLedgerEntry.NEXT = 0;
                            END;

                            //Apply to Doc no.
                            IF "Applies-to Doc. No." <> '' THEN BEGIN
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                                IF "Account Type" = "Account Type"::Customer THEN
                                    CustLedgerEntry.SETRANGE("Customer No.", "Account No.");
                                IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                                    CustLedgerEntry.SETRANGE("Customer No.", "Bal. Account No.");
                                CustLedgerEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
                                CustLedgerEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                                IF CustLedgerEntry.FIND('-') THEN
                                    REPEAT
                                        CustLedgerEntrybuffer := CustLedgerEntry;
                                        CustLedgerEntrybuffer.MARK(TRUE);
                                    UNTIL CustLedgerEntry.NEXT = 0;
                            END;

                        END;
                    UNTIL GenJnlLine2.NEXT = 0;

                    // Unrealized VAT
                    //Applies-to ID
                    GenJnlLine3.COPYFILTERS(GenJnlLine2);
                    GenJnlLine3.SETFILTER("Applies-to ID", '<>%1', '');
                    IF GenJnlLine3.FIND('-') THEN
                        REPEAT
                            WITH GenJnlLine3 DO BEGIN
                                CustLedgEntry.RESET;
                                CustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                                IF "Account Type" = "Account Type"::Customer THEN
                                    CustLedgEntry.SETRANGE("Customer No.", "Account No.");
                                IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                                    CustLedgEntry.SETRANGE("Customer No.", "Bal. Account No.");
                                CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                                IF CustLedgEntry.FIND('-') THEN
                                    REPEAT
                                        RemAmtVAT := 0;
                                        RemAmtBase := 0;
                                        VATEntry.RESET;
                                        VATEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
                                        VATEntry.SETRANGE("Posting Date", CustLedgEntry."Posting Date");
                                        VATEntry.SETFILTER("Remaining Unrealized Amount", '<>%1', 0);
                                        IF VATEntry.FIND('-') THEN
                                            REPEAT
                                                RemAmtVAT := RemAmtVAT + VATEntry."Remaining Unrealized Amount";
                                                RemAmtBase := RemAmtBase + VATEntry."Remaining Unrealized Base";
                                            UNTIL VATEntry.NEXT = 0;
                                        PayPer := 1;
                                        IF VATPostingSetup.GET(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group") AND
                                           (VATPostingSetup."Unrealized VAT Type" <> VATPostingSetup."Unrealized VAT Type"::" ")
                                        THEN BEGIN
                                            VATAccountNo := VATPostingSetup."Sales VAT Unreal. Account";
                                            VATAccountNo2 := VATPostingSetup."Sales VAT Account";
                                            IF (ABS(Amount) < ABS(RemAmtBase + RemAmtVAT)) AND
                                               (RemAmtBase + RemAmtVAT <> 0)
                                            THEN BEGIN
                                                PayPer := ABS(Amount / (RemAmtBase + RemAmtVAT));
                                                IF PayPer > 1 THEN
                                                    PayPer := 1;
                                            END;
                                            VATAmt := -RemAmtVAT * PayPer;
                                            //VAT Unreal
                                            I := 0;
                                            MatchAcc := FALSE;
                                            REPEAT
                                                I := I + 1;
                                                IF (DebitAccNo[I] = VATAccountNo) OR (DebitAccNo[I] = '') THEN BEGIN
                                                    DebitAccNo[I] := VATAccountNo;
                                                    IF GLAcc.GET(VATAccountNo) THEN
                                                        DebitAccName[I] := GLAcc.Name;
                                                    DebitAmount[I] := DebitAmount[I] + VATAmt;
                                                    MatchAcc := TRUE;
                                                END;
                                            UNTIL (I >= 100) OR MatchAcc;
                                            //VAT Real
                                            I := 0;
                                            MatchAcc := FALSE;
                                            REPEAT
                                                I := I + 1;
                                                IF (CreditAccNo[I] = VATAccountNo2) OR (CreditAccNo[I] = '') THEN BEGIN
                                                    CreditAccNo[I] := VATAccountNo2;
                                                    IF GLAcc.GET(VATAccountNo2) THEN
                                                        CreditAccName[I] := GLAcc.Name;
                                                    CreditAmount[I] := CreditAmount[I] + VATAmt;
                                                    MatchAcc := TRUE;
                                                END;
                                            UNTIL (I >= 100) OR MatchAcc;
                                        END;
                                    //UNTIL VATEntry.NEXT=0;
                                    UNTIL CustLedgEntry.NEXT = 0;
                            END;
                        UNTIL GenJnlLine3.NEXT = 0;

                    //Applies-to Doc No.
                    GenJnlLine3.COPYFILTERS(GenJnlLine2);
                    GenJnlLine3.SETFILTER("Applies-to Doc. No.", '<>%1', '');
                    IF GenJnlLine3.FIND('-') THEN
                        REPEAT
                            WITH GenJnlLine3 DO BEGIN
                                CustLedgEntry.RESET;
                                CustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                                IF "Account Type" = "Account Type"::Customer THEN
                                    CustLedgEntry.SETRANGE("Customer No.", "Account No.");
                                IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                                    CustLedgEntry.SETRANGE("Customer No.", "Bal. Account No.");
                                CustLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
                                CustLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                                IF CustLedgEntry.FIND('-') THEN
                                    REPEAT
                                        RemAmtVAT := 0;
                                        RemAmtBase := 0;
                                        VATEntry.RESET;
                                        VATEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
                                        VATEntry.SETRANGE("Posting Date", CustLedgEntry."Posting Date");
                                        VATEntry.SETFILTER("Remaining Unrealized Amount", '<>%1', 0);
                                        IF VATEntry.FIND('-') THEN
                                            REPEAT
                                                RemAmtVAT := RemAmtVAT + VATEntry."Remaining Unrealized Amount";
                                                RemAmtBase := RemAmtBase + VATEntry."Remaining Unrealized Base";
                                            UNTIL VATEntry.NEXT = 0;
                                        PayPer := 1;
                                        IF VATPostingSetup.GET(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group") THEN BEGIN
                                            VATAccountNo := VATPostingSetup."Sales VAT Unreal. Account";
                                            VATAccountNo2 := VATPostingSetup."Sales VAT Account";
                                            IF (ABS(Amount) < ABS(RemAmtBase + RemAmtVAT)) AND
                                               (RemAmtBase + RemAmtVAT <> 0)
                                            THEN BEGIN
                                                PayPer := ABS(Amount / (RemAmtBase + RemAmtVAT));
                                                IF PayPer > 1 THEN
                                                    PayPer := 1;
                                            END;
                                            VATAmt := -RemAmtVAT * PayPer;
                                            //VAT Unreal
                                            I := 0;
                                            MatchAcc := FALSE;
                                            REPEAT
                                                I := I + 1;
                                                IF (DebitAccNo[I] = VATAccountNo) OR (DebitAccNo[I] = '') THEN BEGIN
                                                    DebitAccNo[I] := VATAccountNo;
                                                    IF GLAcc.GET(VATAccountNo) THEN
                                                        DebitAccName[I] := GLAcc.Name;
                                                    DebitAmount[I] := DebitAmount[I] + VATAmt;
                                                    MatchAcc := TRUE;
                                                END;
                                            UNTIL (I >= 100) OR MatchAcc;
                                            //VAT Real
                                            I := 0;
                                            MatchAcc := FALSE;
                                            REPEAT
                                                I := I + 1;
                                                IF (CreditAccNo[I] = VATAccountNo2) OR (CreditAccNo[I] = '') THEN BEGIN
                                                    CreditAccNo[I] := VATAccountNo2;
                                                    IF GLAcc.GET(VATAccountNo2) THEN
                                                        CreditAccName[I] := GLAcc.Name;
                                                    CreditAmount[I] := CreditAmount[I] + VATAmt;
                                                    MatchAcc := TRUE;
                                                END;
                                            UNTIL (I >= 100) OR MatchAcc;
                                        END;
                                    //UNTIL VATEntry.NEXT=0;
                                    UNTIL CustLedgEntry.NEXT = 0;
                            END;
                        UNTIL GenJnlLine3.NEXT = 0;


                    //CalcWHT
                    IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN BEGIN
                        WHTEntry.RESET;
                        WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
                        IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice THEN
                            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Credit Memo");
                        IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::"Credit Memo" THEN
                            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::"Finance Charge Memo");
                        //WHTEntry.SETRANGE("Document No.","Applies-to Doc. No.");
                        IF "Applies-to Doc. No." <> '' THEN
                            WHTEntry.SETRANGE("Document No.", "Applies-to Doc. No.")
                        ELSE BEGIN
                            IF "Applies-to ID" <> '' THEN BEGIN
                                /*
                                {---
                                CustLedgEntry.RESET;
                                CustLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
                                IF CustLedgEntry.FIND('-') THEN
                                REPEAT
                                  IF DocNoFilter = '' THEN
                                    DocNoFilter := CustLedgEntry."Document No."
                                  ELSE BEGIN
                                    IF STRLEN(DocNoFilter + '|' + CustLedgEntry."Document No.") <= 250 THEN
                                      DocNoFilter := DocNoFilter + '|' + CustLedgEntry."Document No."
                                    ELSE
                                      DocNoFilter2 := DocNoFilter2 + '|' + CustLedgEntry."Document No.";
                                  END;
                                UNTIL CustLedgEntry.NEXT=0;
                                IF DocNoFilter <> '' THEN BEGIN
                                  IF DocNoFilter2 = '' THEN
                                    WHTEntry.SETFILTER("Document No.",DocNoFilter)
                                  ELSE
                                    WHTEntry.SETFILTER("Document No.",'%1|%2',DocNoFilter,DocNoFilter2);
                                END;
                                ---}
                                */
                                WHTEntry.SETFILTER("Applies-to ID", "Applies-to ID");  //KKE : #003
                            END;
                            IF "Account Type" = "Account Type"::Customer THEN
                                WHTEntry.SETRANGE("Bill-to/Pay-to No.", "Account No.")
                            ELSE
                                IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                                    WHTEntry.SETRANGE("Bill-to/Pay-to No.", "Bal. Account No.");
                        END;
                        IF WHTEntry.FIND('-') THEN
                            REPEAT
                                IF WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group") THEN BEGIN
                                    WHTAccountNo := WHTPostingSetup."Prepaid WHT Account Code";
                                    IF GLAcc.GET(WHTAccountNo) THEN
                                        WHTAccountName := GLAcc.Name;
                                END;
                            /*
                            {
                                PayPer := 0;
                            IF WHTEntry."Base Amount Inc. VAT (LCY)" <> 0 THEN
                              PayPer := ABS("Amount (LCY)"/ WHTEntry."Base Amount Inc. VAT (LCY)");
                            IF PayPer > 1 THEN
                              PayPer := 1;
                            //CreditWHTAmt := CreditWHTAmt + -(WHTEntry."WHT Amount (LCY)" * PayPer);
                            }
                            */
                            UNTIL WHTEntry.NEXT = 0;

                        IF "WHT Payment" THEN BEGIN
                            IF "Account Type" = "Account Type"::Customer THEN BEGIN
                                CustLedgEntry.RESET;
                                CustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                                CustLedgEntry.SETRANGE("Customer No.", "Account No.");
                                IF "Applies-to ID" <> '' THEN
                                    CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                                IF ("Applies-to Doc. Type" <> 0) AND ("Applies-to Doc. No." <> '') THEN BEGIN
                                    CustLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
                                    CustLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                                END;
                                IF CustLedgEntry.FIND('-') THEN BEGIN
                                    SalesInvLine.RESET;
                                    SalesInvLine.SETRANGE("Document No.", CustLedgEntry."Document No.");
                                    SalesInvLine.SETFILTER("WHT Product Posting Group", '<>%1', '');
                                    IF SalesInvLine.FIND('-') THEN
                                        IF WHTPostingSetup.GET(SalesInvLine."WHT Business Posting Group", SalesInvLine."WHT Product Posting Group") THEN BEGIN
                                            WHTAccountNo := WHTPostingSetup."Prepaid WHT Account Code";
                                            IF GLAcc.GET(WHTAccountNo) THEN
                                                WHTAccountName := GLAcc.Name;
                                        END;
                                END;
                            END ELSE
                                IF "Bal. Account Type"::Customer = "Bal. Account Type"::Customer THEN BEGIN
                                    CustLedgEntry.RESET;
                                    CustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                                    CustLedgEntry.SETRANGE("Customer No.", "Bal. Account No.");
                                    IF "Applies-to ID" <> '' THEN
                                        CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                                    IF ("Applies-to Doc. Type" <> 0) AND ("Applies-to Doc. No." <> '') THEN BEGIN
                                        CustLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
                                        CustLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                                    END;
                                    IF CustLedgEntry.FIND('-') THEN BEGIN
                                        SalesInvLine.RESET;
                                        SalesInvLine.SETRANGE("Document No.", CustLedgEntry."Document No.");
                                        SalesInvLine.SETFILTER("WHT Product Posting Group", '<>%1', '');
                                        IF SalesInvLine.FIND('-') THEN
                                            IF WHTPostingSetup.GET(SalesInvLine."WHT Business Posting Group", SalesInvLine."WHT Product Posting Group")
                                            THEN BEGIN
                                                WHTAccountNo := WHTPostingSetup."Prepaid WHT Account Code";
                                                IF GLAcc.GET(WHTAccountNo) THEN
                                                    WHTAccountName := GLAcc.Name;
                                            END;
                                    END;
                                END;
                            WHTAmt := ABS(Amount);
                            //  WHTAmtHeader := Abs(Amount); //VAH
                        END;
                        //CreditWHTAmt := CreditWHTAmt + ABS(WHTManagement.WHTAmountJournal(GenJnlLine2,FALSE));
                        CLEAR(WHTManagement);
                        GenJnlLine3 := GenJnlLine2;
                        GenJnlLine3.VALIDATE(Amount, -GenJnlLine3.Amount);
                        //CreditWHTAmt := CreditWHTAmt - WHTManagement.ApplyCustCalcWHT(GenJnlLine3);
                        // /    TotalAmt := "Gen. Journal Line"."Credit Amount" + "Gen. Journal Line"."Debit Amount";
                        //VAH
                        DebitAmt := 0;
                        CreditAmt := 0;
                        xGenJnlLine.Reset;
                        xGenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                        xGenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        xGenJnlLine.SetRange("Document No.", "Document No.");
                        if xGenJnlLine.Find('-') then begin
                            repeat
                                if (xGenJnlLine."Account Type" = xGenJnlLine."account type"::"Bank Account") or ((xGenJnlLine."Bal. Account Type" = xGenJnlLine."bal. account type"::"Bank Account") and (xGenJnlLine."Bal. Account No." <> '')) then begin
                                    DebitAmt := DebitAmt + xGenJnlLine."Debit Amount";
                                    CreditAmt := CreditAmt + xGenJnlLine."Credit Amount";
                                end;
                                if (xGenJnlLine."Account Type" = xGenJnlLine."account type"::Customer) or (xGenJnlLine."Bal. Account Type" = xGenJnlLine."bal. account type"::Customer) then begin

                                    if not Customer.Get(xGenJnlLine."Account No.") then
                                        if not Customer.Get(xGenJnlLine."Bal. Account No.") then
                                            Clear(Customer);
                                    if Customer."Name (Thai)" <> '' then
                                        CustName := Customer."Name (Thai)"
                                    else
                                        CustName := Customer.Name + Customer."Name 2";

                                    PayeeName := CustCode + ' ' + "Payee Name";
                                end
                                else begin
                                    CustName := "Payee Name";
                                    PayeeName := CustCode + ' ' + "Payee Name";
                                end;

                            until xGenJnlLine.Next = 0;

                        end;
                        if DebitAmt = 0 then
                            TotalAmt := CreditAmt + CreditWHTAmt + WHTAmt
                        else
                            TotalAmt := (DebitAmt - CreditAmt) + CreditWHTAmt + WHTAmt;
                        //TotalAmt := DebitAmount[I] + ABS("Amount (LCY)");
                        CheckReport.InitTextVariable;
                        CheckReport.FormatNoText(TextAmount, Abs(TotalAmt), "Currency Code");
                        TextAmount[1] := Format(Abs(TotalAmt), 0, '<Precision,2:2><Standard Format,0>') + '   (' + TextAmount[1] + ' ' + TtoalCurrCode + ')';
                        if CustomeRec.get("Gen. Journal Line"."Account No.") then begin
                            PayeeName := CustomeRec."No." + ' ' + CustomeRec.Name;
                            CustName := CustomeRec.Name + ' ' + CustomeRec."Name 2";
                        end else begin
                            if CustomeRec.get("Gen. Journal Line"."Bal. Account No.") then begin
                                PayeeName := CustomeRec."No." + ' ' + CustomeRec.Name;
                                CustName := CustomeRec.Name + ' ' + CustomeRec."Name 2";
                            end;
                        end;
                        //VAH
                    END;
                end;
            end;
        }
    }

    requestpage
    {

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

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
    end;

    var
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        WHTManagement: Codeunit WHTManagement;
        CompanyInfo: Record "Company Information";
        VendPostingGroup: Record "Vendor Posting Group";
        Customer: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntrybuffer: Record "Cust. Ledger Entry";
        CreditMemoCustLedgerEntry: Record "Cust. Ledger Entry";
        GLAcc: Record "G/L Account";
        BankAcc: Record "Bank Account";
        BankAccPostingGroup: Record "Bank Account Posting Group";
        SalesInvLine: Record "Sales Invoice Line";
        VATEntry: Record "VAT Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        xGenJnlLine: Record "Gen. Journal Line";
        CheckReport: Report Check;
        VATAccountNo: Code[20];
        VATAccountName: Text[150];
        VATAccountNo2: Code[20];
        VATAccountName2: Text[150];
        DebitTotalLCY: Decimal;
        CreditTotalLCY: Decimal;
        VATAmt: Decimal;
        Bank: Text[30];
        Cash: Boolean;
        Cheque: Boolean;
        xCash: Text[1];
        xCheque: Text[1];
        ChequeNo: Code[20];
        ChequeDate: Date;
        CustName: Text[150];
        DebitVATAmt: Decimal;
        CreditVATAmt: Decimal;
        TextAmount: array[2] of Text[250];
        TotalVATAmt: array[20] of Decimal;
        TotalAmt: Decimal;
        Line: Integer;
        DebitAccount: Code[20];
        CreditAccount: Code[20];
        DebitAccNo: array[100] of Code[20];
        CreditAccNo: array[100] of Code[20];
        DebitAccName: array[100] of Text[150];
        CreditAccName: array[100] of Text[150];
        DebitAmount: array[100] of Decimal;
        CreditAmount: array[100] of Decimal;
        DebitDimValue: array[100] of Code[20];
        CreditDimValue: array[100] of Code[20];
        MatchAcc: Boolean;
        I: Integer;
        PayPer: Decimal;
        RemAmtVAT: Decimal;
        RemAmtBase: Decimal;
        AmountLangA: array[2] of Text[80];
        WHTPostingSetup: Record "WHT Posting Setup";
        WHTEntry: Record "WHT Entry";
        WHTAccountNo: Code[20];
        WHTAccountName: Text[150];
        WHTAmt: Decimal;
        WHTBaseAmt: Decimal;
        CreditWHTAmt: Decimal;
        CreditWHTBaseAmt: Decimal;
        BankAccNo: Code[20];
        BankBranchNo: Text[50];
        ShowBlank: Boolean;
        CreditVATAmtTmp: Decimal;
        totAmounttoApply: Decimal;
        totCreditVATAmtTmp: Decimal;
        TotalItemText: Text[30];
        CreditAppliedVATAmtTmp: Decimal;
        TextPageNo: Text[30];
        CaptionTaxID: Text;
        DocumentNo: Code[20];
        PayeeName: text[100];
        WHTAmtHeader: Decimal;
        CurrCode: Code[10];
        GeneralLedgerSetup: Record "General Ledger Setup";
        TtoalCurrCode: Code[50];
        Currency: Record Currency;
        CreditVATNo: array[300] of Code[20];
        DebitAmountNumber: Decimal;
        DebitAccNoNumber: Decimal;
        DebitAccNameNumber: Decimal;
        DebitVATNameNumber: Decimal;
        DebitVATAmtNumber: Decimal;
        CreditAccNameNumber: Decimal;
        CreditVATNameNumber: Decimal;
        CreditAccNoNumber: Decimal;
        CreditVATAmtNumber: Decimal;
        CreditAmountNumber: Decimal;
        LanguageCaption: Record "Language Caption";
        DecVar: Decimal;
        CntLine: Integer;
        CompanyAddr: array[8] of Text[250];
        TaxIDThai: Text;
        LineSpace: Integer;
}

