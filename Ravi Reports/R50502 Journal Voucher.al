report 50502 "Journal Voucher"
{
    // 
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // GKU : Goragot Kuanmuang
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.12.2005   KKE   -Journal Voucher Report.
    //                          -Accounting user would like to add description on journal line into description in Journal voucher.
    //                          -User would like to show footer on every page.
    // Project: Burda
    // 002   31.08.2007   GKU   -Edit Format report
    //                          -Add word total amount
    //                          -Edit footer Description use "Gen. Journal Line".description2
    // 003   17.09.2007   KKE   -add criteria to group data by description. (request by p'Nok)
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JournalVoucher.rdl';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.") WHERE("Account No." = FILTER(<> ''));
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Document No.";

            //Company Info
            column(CaptionTaxID; CaptionTaxID)
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
            column(CaptionToday; Format(Today, 0, 4))
            {
            }
            //Company Info
            column(JBN; GenJnlLine."Journal Batch Name")
            {
            }
            column(DocNo; "Gen. Journal Line"."Document No.")
            {
            }
            column(PosDate; format("Gen. Journal Line"."Posting Date", 0, 4))
            {
            }
            column(Remark1; Remark[1])
            {
            }
            column(Remark2; Remark[2])
            {
            }
            column(Remark3; Remark[3])
            {
            }
            column(DocumentNo; DocumentNo)
            {
            }
            dataitem(DebitDetail; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                column(DebitAccNo_Num; DebitAccNo[Number])
                {
                }
                column(DebitName; DebitAccName[Number])
                {
                }
                column(DebitAccNameDes; DebitAccNameDes[Number])
                {
                }
                column(DebitDimValu1; DebitDimValue1[Number])
                {
                }
                column(DebitDimValu2; DebitDimValue2[Number])
                {
                }
                column(DebitDimValu3; DebitDimValue3[Number])
                {
                }
                column(DebitDimValu4; DebitDimValue4[Number])
                {
                }
                column(DebitAmount; DebitAmount[Number])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IF DebitAccNo[Number] = '' THEN
                        CurrReport.BREAK
                    ELSE
                        Line += 1;
                end;

                trigger OnPreDataItem()
                begin
                end;
            }
            dataitem(CreditDetail; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                column(CreditAccNo_Num; CreditAccNo[Number])
                {
                }
                column(CreditName; CreditAccName[Number])
                {
                }
                column(CreditAccNameDesc; CreditAccNameDesc[Number])
                {
                }
                column(CreditDimValu1; CreditDimValue1[Number])
                {
                }
                column(CreditDimValu2; CreditDimValue2[Number])
                {
                }
                column(CreditDimValu3; CreditDimValue3[Number])
                {
                }
                column(CreditDimValu4; CreditDimValue4[Number])
                {
                }
                column(CreditAmount; CreditAmount[Number])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IF CreditAccNo[Number] = '' THEN
                        CurrReport.BREAK
                    ELSE
                        Line := Line + 1;
                end;
            }
            dataitem(LineLoop; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                column(Numb; Number)
                {
                }
                column(Number_LineLoop; LineLoop.Number)
                {
                }
                trigger OnPreDataItem()
                begin
                    TotalLine := 0;
                    if Line < 27 then
                        TotalLine := Line + (27 - (Line mod 27))
                    else
                        TotalLine := Line + (28 - (Line mod 28))
                end;

                trigger OnAfterGetRecord()
                begin
                    IF Line + Number > TotalLine THEN CurrReport.Break();
                end;
            }
            trigger OnPreDataItem()
            begin
                SetLanguageCaption;
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
                    if TaxIDThai <> '' then CompanyAddr[8] := TaxIDThai + ' ' + CompanyInfo."VAT Registration No.";
                end;
                CompressArray(CompanyAddr);
                //VR
            end;

            trigger OnAfterGetRecord()
            begin
                if DocumentNo <> "Document No." then Line := 0;
                IF ("Document No." <> GenJnlLine."Document No.") and (Line <> 0) THEN begin
                    CurrReport.NewPage();
                    Line := 0;
                    DocumentNo := "Document No.";
                end;
                IF "Document No." = GenJnlLine."Document No." THEN begin
                    CurrReport.Skip();
                    Line := 0;
                    DocumentNo := "Document No.";
                end
                ELSE
                    GenJnlLine := "Gen. Journal Line";
                CLEAR(DebitType);
                CLEAR(DebitAccNo);
                CLEAR(DebitAccName);
                CLEAR(DebitAccNameDes);
                CLEAR(DebitDimValue1);
                CLEAR(DebitDimValue2);
                CLEAR(DebitDimValue3);
                CLEAR(DebitDimValue4);
                CLEAR(DebitDimValue5);
                CLEAR(DebitAmount);
                CLEAR(CreditType);
                CLEAR(CreditAccNo);
                CLEAR(CreditAccName);
                CLEAR(CreditAccNameDesc);
                CLEAR(CreditDimValue1);
                CLEAR(CreditDimValue2);
                CLEAR(CreditDimValue3);
                CLEAR(CreditDimValue4);
                CLEAR(CreditDimValue5);
                CLEAR(CreditAmount);
                CLEAR(Remark);
                IF Remark[1] = '' THEN
                    Remark[1] := Comment
                else
                    if Remark[2] = '' then
                        Remark[2] := Comment
                    else
                        if Remark[3] = '' then Remark[3] := Comment;
                GenJnlLine2.RESET;
                GenJnlLine2.SETRANGE("Journal Template Name", "Journal Template Name");
                GenJnlLine2.SETRANGE("Journal Batch Name", "Journal Batch Name");
                GenJnlLine2.SETRANGE("Document No.", "Document No.");
                IF GenJnlLine2.FIND('-') THEN
                    REPEAT
                        WITH GenJnlLine2 DO BEGIN
                            //VAT Calculation
                            CLEAR(VATAmount);
                            CLEAR(BalVATAmount);
                            CLEAR(GenJnlPostLine);
                            IF GLEntryTemp.COUNT <> 0 THEN GLEntryTemp.DELETEALL;
                            GenJnlPostLine.CheckVATGLEntry(GenJnlLine2, GLEntryTemp);
                            IF GLEntryTemp.FIND('-') THEN
                                REPEAT
                                    IF GLEntryTemp."Entry No." = 1 THEN
                                        VATAmount := GLEntryTemp.Amount
                                    ELSE
                                        BalVATAmount := GLEntryTemp.Amount;
                                UNTIL GLEntryTemp.NEXT = 0;
                            //Get Dimension3-5
                            CLEAR(ShortcutDim3Code);
                            CLEAR(ShortcutDim4Code);
                            CLEAR(ShortcutDim5Code);
                            //Ravi
                            //IF JournalLineDim.GET(83,"Journal Template Name","Journal Batch Name","Line No.",0,ShortcutDimCode[3]) THEN
                            //      ShortcutDim3Code := JournalLineDim."Dimension Value Code";
                            //    IF JournalLineDim.GET(Gen. Journal Line,"Journal Template Name","Journal Batch Name","Line No.",0,ShortcutDimCode[4]) THEN
                            //      ShortcutDim4Code := JournalLineDim."Dimension Value Code";
                            //    IF JournalLineDim.GET(Gen. Journal Line,"Journal Template Name","Journal Batch Name","Line No.",0,ShortcutDimCode[5]) THEN
                            //      ShortcutDim5Code := JournalLineDim."Dimension Value Code";
                            //Insert Line
                            IF "Debit Amount" <> 0 THEN BEGIN
                                I := 0;
                                MatchAcc := FALSE;
                                REPEAT
                                    I := I + 1;
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
                                        //TSA001
                                        "Account Type"::"Fixed Asset":
                                            BEGIN
                                                FADepreciationBook.RESET;
                                                FADepreciationBook.SETRANGE("FA No.", "Account No.");
                                                IF FADepreciationBook.FIND('-') THEN BEGIN
                                                    FAPostingGroup.GET(FADepreciationBook."FA Posting Group");
                                                    CreditAccount := FAPostingGroup."Accum. Depreciation Account";
                                                END;
                                            END;
                                        //TSA001
                                        //RS001
                                        "Account Type"::Employee:
                                            BEGIN
                                                Employee.RESET;
                                                Employee.SETRANGE("No.", "Account No.");
                                                IF Employee.FIND('-') THEN BEGIN
                                                    EmployeePostingGroup.GET(Employee."Employee Posting Group");
                                                    CreditAccount := EmployeePostingGroup."Payables Account";
                                                END;
                                            END;
                                    //RS001
                                    END;
                                    IF ((DebitAccNo[I] = DebitAccount) AND (DebitAccName[I] = Description) AND //KKE : #003
 (DebitDimValue1[I] = "Shortcut Dimension 1 Code") AND (DebitDimValue2[I] = "Shortcut Dimension 2 Code") AND (DebitDimValue3[I] = ShortcutDim3Code) AND (DebitDimValue4[I] = ShortcutDim4Code) AND (DebitDimValue5[I] = ShortcutDim5Code)) OR (DebitAccNo[I] = '') THEN BEGIN
                                        DebitAccNo[I] := DebitAccount;
                                        IF GLAcc.GET(DebitAccNo[I]) THEN;
                                        DebitAccName[I] := GLAcc.Name;
                                        //DebitAccName[I] := Description; //KKE: #003
                                        DebitAccNameDes[I] := Description;
                                        //DebitAmount[I] := DebitAmount[I] + "Debit Amount";
                                        IF VATAmount > 0 THEN
                                            DebitAmount[I] := DebitAmount[I] + ABS("Amount (LCY)" - VATAmount)
                                        ELSE
                                            DebitAmount[I] := DebitAmount[I] + ABS("Amount (LCY)");
                                        DebitDimValue1[I] := "Shortcut Dimension 1 Code";
                                        DebitDimValue2[I] := "Shortcut Dimension 2 Code";
                                        DebitDimValue3[I] := ShortcutDim3Code;
                                        DebitDimValue4[I] := ShortcutDim4Code;
                                        DebitDimValue5[I] := ShortcutDim5Code;
                                        MatchAcc := TRUE;
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
                                            //TSA001
                                            "Bal. Account Type"::"Fixed Asset":
                                                BEGIN
                                                    FADepreciationBook.RESET;
                                                    FADepreciationBook.SETRANGE("FA No.", "Bal. Account No.");
                                                    IF FADepreciationBook.FIND('-') THEN BEGIN
                                                        FAPostingGroup.GET(FADepreciationBook."FA Posting Group");
                                                        CreditAccount := FAPostingGroup."Accum. Depreciation Account";
                                                    END;
                                                END;
                                            //TSA001
                                            //RS001
                                            "Bal. Account Type"::Employee:
                                                BEGIN
                                                    Employee.RESET;
                                                    Employee.SETRANGE("No.", "Bal. Account No.");
                                                    IF Employee.FIND('-') THEN BEGIN
                                                        EmployeePostingGroup.GET(Employee."Employee Posting Group");
                                                        CreditAccount := EmployeePostingGroup."Payables Account";
                                                    END;
                                                END;
                                        //RS001
                                        END;
                                        IF ((CreditAccNo[I] = CreditAccount) AND (CreditAccName[I] = Description) AND //KKE : #003
 (CreditDimValue1[I] = "Shortcut Dimension 1 Code") AND (CreditDimValue2[I] = "Shortcut Dimension 2 Code") AND (CreditDimValue3[I] = ShortcutDim3Code) AND (CreditDimValue4[I] = ShortcutDim4Code) AND (CreditDimValue5[I] = ShortcutDim5Code)) OR (CreditAccNo[I] = '') THEN BEGIN
                                            CreditAccNo[I] := CreditAccount;
                                            GLAcc.GET(CreditAccNo[I]);
                                            CreditAccName[I] := GLAcc.Name;
                                            CreditAccNameDesc[I] := Description; //KKE : #003
                                            //CreditAmount[I] := CreditAmount[I] + "Debit Amount";
                                            IF BalVATAmount < 0 THEN
                                                CreditAmount[I] := CreditAmount[I] + ABS("Amount (LCY)" + BalVATAmount)
                                            ELSE
                                                CreditAmount[I] := CreditAmount[I] + ABS("Amount (LCY)");
                                            CreditDimValue1[I] := "Shortcut Dimension 1 Code";
                                            CreditDimValue2[I] := "Shortcut Dimension 2 Code";
                                            CreditDimValue3[I] := ShortcutDim3Code;
                                            CreditDimValue4[I] := ShortcutDim4Code;
                                            CreditDimValue5[I] := ShortcutDim5Code;
                                            MatchAcc := TRUE;
                                        END;
                                    END;
                                UNTIL (I >= 300) OR MatchAcc;
                            END
                            ELSE
                                IF "Credit Amount" <> 0 THEN BEGIN
                                    I := 0;
                                    MatchAcc := FALSE;
                                    REPEAT
                                        I := I + 1;
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
                                            //TSA001
                                            "Account Type"::"Fixed Asset":
                                                BEGIN
                                                    FADepreciationBook.RESET;
                                                    FADepreciationBook.SETRANGE("FA No.", "Account No.");
                                                    IF FADepreciationBook.FIND('-') THEN BEGIN
                                                        FAPostingGroup.GET(FADepreciationBook."FA Posting Group");
                                                        CreditAccount := FAPostingGroup."Accum. Depreciation Account";
                                                    END;
                                                END;
                                            //TSA001
                                            //RS001
                                            "Account Type"::Employee:
                                                BEGIN
                                                    Employee.RESET;
                                                    Employee.SETRANGE("No.", "Account No.");
                                                    IF Employee.FIND('-') THEN BEGIN
                                                        EmployeePostingGroup.GET(Employee."Employee Posting Group");
                                                        CreditAccount := EmployeePostingGroup."Payables Account";
                                                    END;
                                                END;
                                        //RS001
                                        END;
                                        IF ((CreditAccNo[I] = CreditAccount) AND (CreditAccName[I] = Description) AND //KKE : #003
 (CreditDimValue1[I] = "Shortcut Dimension 1 Code") AND (CreditDimValue2[I] = "Shortcut Dimension 2 Code") AND (CreditDimValue3[I] = ShortcutDim3Code) AND (CreditDimValue4[I] = ShortcutDim4Code) AND (CreditDimValue5[I] = ShortcutDim5Code)) OR (CreditAccNo[I] = '') THEN BEGIN
                                            CreditAccNo[I] := CreditAccount;
                                            GLAcc.GET(CreditAccNo[I]);
                                            CreditAccName[I] := GLAcc.Name;
                                            CreditAccNameDesc[I] := Description; //KKE : #003
                                            //CreditAmount[I] := CreditAmount[I] + "Credit Amount";
                                            IF VATAmount < 0 THEN
                                                CreditAmount[I] := CreditAmount[I] + ABS("Amount (LCY)" - VATAmount)
                                            ELSE
                                                CreditAmount[I] := CreditAmount[I] + ABS("Amount (LCY)");
                                            CreditDimValue1[I] := "Shortcut Dimension 1 Code";
                                            CreditDimValue2[I] := "Shortcut Dimension 2 Code";
                                            CreditDimValue3[I] := ShortcutDim3Code;
                                            CreditDimValue4[I] := ShortcutDim4Code;
                                            CreditDimValue5[I] := ShortcutDim5Code;
                                            MatchAcc := TRUE;
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
                                                //TSA001
                                                "Bal. Account Type"::"Fixed Asset":
                                                    BEGIN
                                                        FADepreciationBook.RESET;
                                                        FADepreciationBook.SETRANGE("FA No.", "Bal. Account No.");
                                                        IF FADepreciationBook.FIND('-') THEN BEGIN
                                                            FAPostingGroup.GET(FADepreciationBook."FA Posting Group");
                                                            CreditAccount := FAPostingGroup."Accum. Depreciation Account";
                                                        END;
                                                    END;
                                            //TSA001
                                            END;
                                            IF ((DebitAccNo[I] = DebitAccount) AND (DebitAccName[I] = Description) AND //KKE : #003
 (DebitDimValue1[I] = "Shortcut Dimension 1 Code") AND (DebitDimValue2[I] = "Shortcut Dimension 2 Code") AND (DebitDimValue3[I] = ShortcutDim3Code) AND (DebitDimValue4[I] = ShortcutDim4Code) AND (DebitDimValue5[I] = ShortcutDim5Code)) OR (DebitAccNo[I] = '') THEN BEGIN
                                                DebitAccNo[I] := DebitAccount;
                                                GLAcc.GET(DebitAccNo[I]);
                                                DebitAccName[I] := GLAcc.Name;
                                                DebitAccNameDes[I] := Description; //KKE : #003
                                                //DebitAmount[I] := DebitAmount[I] + "Credit Amount";
                                                IF BalVATAmount > 0 THEN
                                                    DebitAmount[I] := DebitAmount[I] + ABS("Amount (LCY)" + BalVATAmount)
                                                ELSE
                                                    DebitAmount[I] := DebitAmount[I] + ABS("Amount (LCY)");
                                                DebitDimValue1[I] := "Shortcut Dimension 1 Code";
                                                DebitDimValue2[I] := "Shortcut Dimension 2 Code";
                                                DebitDimValue3[I] := ShortcutDim3Code;
                                                DebitDimValue4[I] := ShortcutDim4Code;
                                                DebitDimValue5[I] := ShortcutDim5Code;
                                                MatchAcc := TRUE;
                                            END;
                                        END;
                                    UNTIL (I >= 300) OR MatchAcc;
                                END;
                            //Insert VAT Line
                            IF GLEntryTemp.FIND('-') THEN
                                REPEAT
                                    IF (GLEntryTemp."G/L Account No." <> '') AND (GLEntryTemp.Amount > 0) THEN BEGIN
                                        I := 0;
                                        MatchAcc := FALSE;
                                        REPEAT
                                            I := I + 1;
                                            DebitAccount := GLEntryTemp."G/L Account No.";
                                            IF ((DebitAccNo[I] = DebitAccount) AND (DebitDimValue1[I] = "Shortcut Dimension 1 Code") AND (DebitDimValue2[I] = "Shortcut Dimension 2 Code") AND (DebitDimValue3[I] = ShortcutDim3Code) AND (DebitDimValue4[I] = ShortcutDim4Code) AND (DebitDimValue5[I] = ShortcutDim5Code)) OR (DebitAccNo[I] = '') THEN BEGIN
                                                DebitAccNo[I] := DebitAccount;
                                                GLAcc.GET(DebitAccNo[I]);
                                                DebitAccName[I] := GLAcc.Name;
                                                DebitAmount[I] := DebitAmount[I] + GLEntryTemp.Amount;
                                                DebitDimValue1[I] := "Shortcut Dimension 1 Code";
                                                DebitDimValue2[I] := "Shortcut Dimension 2 Code";
                                                DebitDimValue3[I] := ShortcutDim3Code;
                                                DebitDimValue4[I] := ShortcutDim4Code;
                                                DebitDimValue5[I] := ShortcutDim5Code;
                                                MatchAcc := TRUE;
                                            END;
                                        UNTIL (I >= 300) OR MatchAcc;
                                    END;
                                    IF (GLEntryTemp."G/L Account No." <> '') AND (GLEntryTemp.Amount < 0) THEN BEGIN
                                        I := 0;
                                        MatchAcc := FALSE;
                                        REPEAT
                                            I := I + 1;
                                            CreditAccount := GLEntryTemp."G/L Account No.";
                                            IF ((CreditAccNo[I] = CreditAccount) AND (CreditDimValue1[I] = "Shortcut Dimension 1 Code") AND (CreditDimValue2[I] = "Shortcut Dimension 2 Code") AND (CreditDimValue3[I] = ShortcutDim3Code) AND (CreditDimValue4[I] = ShortcutDim4Code) AND (CreditDimValue5[I] = ShortcutDim5Code)) OR (CreditAccNo[I] = '') THEN BEGIN
                                                CreditAccNo[I] := CreditAccount;
                                                GLAcc.GET(CreditAccNo[I]);
                                                CreditAccName[I] := GLAcc.Name;
                                                CreditAmount[I] := CreditAmount[I] - GLEntryTemp.Amount;
                                                CreditDimValue1[I] := "Shortcut Dimension 1 Code";
                                                CreditDimValue2[I] := "Shortcut Dimension 2 Code";
                                                CreditDimValue3[I] := ShortcutDim3Code;
                                                CreditDimValue4[I] := ShortcutDim4Code;
                                                CreditDimValue5[I] := ShortcutDim5Code;
                                                MatchAcc := TRUE;
                                            END;
                                        UNTIL (I >= 300) OR MatchAcc;
                                    END;
                                UNTIL GLEntryTemp.NEXT = 0;
                        END;
                    UNTIL GenJnlLine2.NEXT = 0;
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
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPreReport()
    begin
        DebitTotalLCY := 0;
        CreditTotalLCY := 0;
        // Ravi GLSetup.GetShortcutDimCode(ShortcutDimCode);
    end;

    local procedure SetLanguageCaption()
    var
        LanguageCaption: Record "Language Caption";
    begin
        LanguageCaption.Reset();
        LanguageCaption.SetRange("Report ID", 50502);
        if LanguageCaption.FindSet() then begin
            repeat
                case LanguageCaption."Caption Code" of
                    'TaxID':
                        begin
                            //CaptionNo := LanguageCaption."Caption in English";
                            TaxIDThai := LanguageCaption."Caption in Thai";
                        end;
                    else
                end;
            until LanguageCaption.Next() = 0;
        end;
    end;

    var
        DocumentNo: Code[20];
        CompanyAddr: array[8] of Text[250];
        TaxIDThai: Text;
        CompanyInfo: Record "Company Information";
        //JournalLineDim:Record joun        Vendor: Record Vendor;
        VendPostingGroup: Record "Vendor Posting Group";
        Customer: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustPostingGroup: Record "Customer Posting Group";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        BankAcc: Record "Bank Account";
        BankAccPostingGroup: Record "Bank Account Posting Group";
        SalesInvLine: Record "Sales Invoice Line";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GLEntryTemp: Record "G/L Entry" temporary;
        //GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlPostLine: Codeunit CU12Ext;
        DebitTotalLCY: Decimal;
        CreditTotalLCY: Decimal;
        Remark: array[3] of Text[250];
        Line: Integer;
        DebitType: array[30] of Code[1];
        CreditType: array[30] of Code[1];
        DebitAccount: Code[20];
        CreditAccount: Code[20];
        DebitAccNo: array[300] of Code[20];
        CreditAccNo: array[300] of Code[20];
        DebitAccName: array[300] of Text[100];
        DebitAccNameDes: array[300] of Text[100];
        CreditAccName: array[300] of Text[100];
        CreditAccNameDesc: array[300] of Text[100];
        DebitAmount: array[300] of Decimal;
        CreditAmount: array[300] of Decimal;
        DebitDimValue1: array[300] of Code[20];
        DebitDimValue2: array[300] of Code[20];
        DebitDimValue3: array[300] of Code[20];
        DebitDimValue4: array[300] of Code[20];
        DebitDimValue5: array[300] of Code[20];
        CreditDimValue1: array[300] of Code[20];
        CreditDimValue2: array[300] of Code[20];
        CreditDimValue3: array[300] of Code[20];
        CreditDimValue4: array[300] of Code[20];
        CreditDimValue5: array[300] of Code[20];
        MatchAcc: Boolean;
        I: Integer;
        ShortcutDimCode: array[8] of Code[20];
        ShortcutDim3Code: Code[20];
        ShortcutDim4Code: Code[20];
        ShortcutDim5Code: Code[20];
        VATAmount: Decimal;
        BalVATAmount: Decimal;
        FixedAsset: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        FADepreciationBook: Record "FA Depreciation Book";
        LanguageCaption: Record "Language Caption";
        CaptionTaxID: Text;
        TotalLine: Integer;
        Employee: Record Employee;
        EmployeePostingGroup: Record "Employee Posting Group";
}
