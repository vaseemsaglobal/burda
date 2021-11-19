report 50511 "Cheque Printing"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Cheque Printing';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ChequePrint.rdl';
    Permissions = TableData "Bank Account" = m;

    dataset
    {
        dataitem(VoidGenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Posting Date";

            trigger OnAfterGetRecord()
            begin
                CheckManagement.VoidCheck(VoidGenJnlLine);
            end;

            trigger OnPreDataItem()
            begin

                IF CurrReport.PREVIEW THEN
                    ERROR(Text000);

                //KKE : #002 +
                IF ManualCheck THEN
                    CurrReport.BREAK;
                //KKE : #002 -

                IF UseCheckNo = '' THEN
                    ERROR(Text001);

                IF TestPrint THEN
                    CurrReport.BREAK;

                IF NOT ReprintChecks THEN
                    CurrReport.BREAK;

                IF (GETFILTER("Line No.") <> '') OR (GETFILTER("Document No.") <> '') THEN
                    ERROR(
                      Text002, FIELDCAPTION("Line No."), FIELDCAPTION("Document No."));
                SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                SETRANGE("Check Printed", TRUE);
            end;

        }
        dataitem(GenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            column(JournalTempName_GenJnlLine; "Journal Template Name")
            {
            }
            column(JournalBatchName_GenJnlLine; "Journal Batch Name")
            {
            }
            column(LineNo_GenJnlLine; "Line No.")
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(BANKCODE; BANKCODE)
            {

            }
            dataitem(CheckPages; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(CheckToAddr1; CheckToAddr[1])
                {
                }
                column(CheckDateText; CheckDateText)
                {
                }
                column(CheckNoText; CheckNoText)
                {
                }
                column(FirstPage; FirstPage)
                {
                }
                column(PreprintedStub; PreprintedStub)
                {
                }
                column(CheckNoTextCaption; CheckNoTextCaptionLbl)
                {
                }
                dataitem(PrintSettledLoop; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 30;
                    column(NetAmount; NetAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineDiscountLineDiscount; TotalLineDiscount - LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineAmountLineAmount; TotalLineAmount - LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineAmountLineAmount2; TotalLineAmount - LineAmount2)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount; LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineDiscount; LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmountLineDiscount; LineAmount + LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(DocNo; DocNo)
                    {
                    }
                    column(DocDate; DocDate)
                    {
                    }
                    column(CurrencyCode2; CurrencyCode2)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(CurrentLineAmount; CurrentLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(ExtDocNo; ExtDocNo)
                    {
                    }
                    column(LineAmountCaption; LineAmountCaptionLbl)
                    {
                    }
                    column(LineDiscountCaption; LineDiscountCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(DocNoCaption; DocNoCaptionLbl)
                    {
                    }
                    column(DocDateCaption; DocDateCaptionLbl)
                    {
                    }
                    column(CurrencyCodeCaption; CurrencyCodeCaptionLbl)
                    {
                    }
                    column(YourDocNoCaption; YourDocNoCaptionLbl)
                    {
                    }
                    column(TransportCaption; TransportCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        GenJnlLine1: Record "Gen. Journal Line";
                    begin

                        IF NOT TestPrint THEN BEGIN
                            IF FoundLast THEN BEGIN
                                IF RemainingAmount <> 0 THEN BEGIN
                                    DocType := Text015;
                                    DocNo := '';
                                    ExtDocNo := '';
                                    LineAmount := RemainingAmount;
                                    LineAmount2 := RemainingAmount;
                                    LineDiscount := 0;
                                    RemainingAmount := 0;
                                    LineWHT := 0;
                                END ELSE
                                    CurrReport.BREAK;
                            END ELSE BEGIN
                                CASE ApplyMethod OF
                                    ApplyMethod::OneLineOneEntry:
                                        BEGIN
                                            CASE BalancingType OF
                                                BalancingType::Customer:
                                                    BEGIN
                                                        CustLedgEntry.RESET;
                                                        CustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                                                        CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                        CustLedgEntry.FIND('-');
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                    END;
                                                BalancingType::Vendor:
                                                    BEGIN
                                                        VendLedgEntry.RESET;
                                                        VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                                                        VendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                        VendLedgEntry.FIND('-');
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                    END;
                                            END;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                            FoundLast := TRUE;
                                        END;
                                    ApplyMethod::OneLineID:
                                        BEGIN
                                            CASE BalancingType OF
                                                BalancingType::Customer:
                                                    BEGIN
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                        FoundLast := (CustLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                        IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                            CustLedgEntry.SETRANGE(Positive, FALSE);
                                                            FoundLast := NOT CustLedgEntry.FIND('-');
                                                            FoundNegative := TRUE;
                                                        END;
                                                    END;
                                                BalancingType::Vendor:
                                                    BEGIN
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                        FoundLast := (VendLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                        IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                            VendLedgEntry.SETRANGE(Positive, FALSE);
                                                            FoundLast := NOT VendLedgEntry.FIND('-');
                                                            FoundNegative := TRUE;
                                                        END;
                                                    END;
                                            END;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                        END;
                                    ApplyMethod::MoreLinesOneEntry:
                                        BEGIN
                                            CurrentLineAmount := GenJnlLine2.Amount;
                                            LineAmount2 := CurrentLineAmount;
                                            GenJnlLine2.TESTFIELD("Check Printed", FALSE);
                                            GenJnlLine2.TESTFIELD("Bank Payment Type", GenJnlLine2."Bank Payment Type"::"Computer Check");
                                            IF GenJnlLine2."Applies-to Doc. No." = '' THEN BEGIN
                                                DocType := Text015;
                                                DocNo := '';
                                                ExtDocNo := '';
                                                LineAmount := CurrentLineAmount;
                                                LineDiscount := 0;
                                            END ELSE BEGIN
                                                CASE BalancingType OF
                                                    BalancingType::"G/L Account":
                                                        BEGIN
                                                            DocType := FORMAT(GenJnlLine2."Document Type");
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                        END;
                                                    BalancingType::Customer:
                                                        BEGIN
                                                            CustLedgEntry.RESET;
                                                            CustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                                                            CustLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            CustLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                            CustLedgEntry.FIND('-');
                                                            CustUpdateAmounts(CustLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        END;
                                                    BalancingType::Vendor:
                                                        BEGIN
                                                            VendLedgEntry.RESET;
                                                            VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                                                            VendLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                            VendLedgEntry.FIND('-');
                                                            VendUpdateAmounts(VendLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        END;
                                                    BalancingType::"Bank Account":
                                                        BEGIN
                                                            DocType := FORMAT(GenJnlLine2."Document Type");
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                        END;
                                                END;
                                            END;
                                            FoundLast := GenJnlLine2.NEXT = 0;
                                        END;
                                END;
                            END;
                            GenJnlLine1.COPY(GenJnlLine);
                            IF (GenJnlLine1."Interest Amount" <> 0) THEN
                                GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount - GenJnlLine1."Interest Amount");
                            IF NOT WHTSkip THEN BEGIN
                                //KKE : #001 +
                                IF OneCheckPrVendor THEN BEGIN
                                    LineWHT := 0;
                                    xGenJnlLine2.COPYFILTERS(GenJnlLine2);
                                    IF xGenJnlLine2.FIND('-') THEN
                                        REPEAT
                                            xGenJnlLine2.VALIDATE(Amount, -xGenJnlLine2.Amount); //KKE
                                            LineWHT := LineWHT + WHTManagement.WHTAmountJournal(xGenJnlLine2, FALSE);
                                        UNTIL xGenJnlLine2.NEXT = 0;
                                END ELSE BEGIN
                                    //KKE : #001 -
                                    xGenJnlLine2 := GenJnlLine1;
                                    xGenJnlLine2.VALIDATE(Amount, -GenJnlLine1.Amount); //KKE
                                    LineWHT := WHTManagement.WHTAmountJournal(xGenJnlLine2, FALSE);
                                END;
                            END ELSE
                                LineWHT := 0;
                            //TotWHTAmount := LineWHT;
                            TotWHTAmount := -LineWHT;  //KKE : #001
                            TotalLineAmount := TotalLineAmount + LineAmount2;
                            TotalLineDiscount := TotalLineDiscount + LineDiscount;
                        END ELSE BEGIN
                            IF FoundLast THEN
                                CurrReport.BREAK;
                            FoundLast := TRUE;
                            DocType := Text018;
                            DocNo := Text010;
                            ExtDocNo := Text010;
                            LineAmount := 0;
                            LineDiscount := 0;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin

                        IF NOT TestPrint THEN
                            IF FirstPage THEN BEGIN
                                FoundLast := TRUE;
                                CASE ApplyMethod OF
                                    ApplyMethod::OneLineOneEntry:
                                        FoundLast := FALSE;
                                    ApplyMethod::OneLineID:
                                        CASE BalancingType OF
                                            BalancingType::Customer:
                                                BEGIN
                                                    CustLedgEntry.RESET;
                                                    CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                                    CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                    CustLedgEntry.SETRANGE(Open, TRUE);
                                                    CustLedgEntry.SETRANGE(Positive, TRUE);
                                                    CustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := NOT CustLedgEntry.FIND('-');
                                                    IF FoundLast THEN BEGIN
                                                        CustLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT CustLedgEntry.FIND('-');
                                                        FoundNegative := TRUE;
                                                    END ELSE
                                                        FoundNegative := FALSE;
                                                END;
                                            BalancingType::Vendor:
                                                BEGIN
                                                    VendLedgEntry.RESET;
                                                    VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                                                    VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                    VendLedgEntry.SETRANGE(Open, TRUE);
                                                    VendLedgEntry.SETRANGE(Positive, TRUE);
                                                    VendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := NOT VendLedgEntry.FIND('-');
                                                    IF FoundLast THEN BEGIN
                                                        VendLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT VendLedgEntry.FIND('-');
                                                        FoundNegative := TRUE;
                                                    END ELSE
                                                        FoundNegative := FALSE;
                                                END;
                                        END;
                                    ApplyMethod::MoreLinesOneEntry:
                                        FoundLast := FALSE;
                                END;
                            END
                            ELSE
                                FoundLast := FALSE;
                    end;
                }
                dataitem(PrintCheck; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(CheckAmountText; CheckAmountText)
                    {
                    }
                    column(CheckDateTextControl2; CheckDateText)
                    {
                    }
                    column(DescriptionLine2; DescriptionLine[2])
                    {
                    }
                    column(DescriptionLine1; DescriptionLine[1])
                    {
                    }
                    column(CheckToAddr1Control7; CheckToAddr[1])
                    {
                    }
                    column(CheckToAddr2; CheckToAddr[2])
                    {
                    }
                    column(CheckToAddr4; CheckToAddr[4])
                    {
                    }
                    column(CheckToAddr3; CheckToAddr[3])
                    {
                    }
                    column(CheckToAddr5; CheckToAddr[5])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(DocumentDate; FORMAT(GenJnlLine."Document Date", 0, '<Day,2>-<Month Text>-<Year4>'))
                    {
                    }
                    column(CompanyAddr8; CompanyAddr[8])
                    {
                    }
                    column(CompanyAddr7; CompanyAddr[7])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CheckNoTextControl21; CheckNoText)
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(TotalLineAmount; TotalLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(VoidText; VoidText)
                    {
                    }
                    column(CheckLedgEntryAmt; FORMAT(CheckLedgEntry.Amount, 0, '<Precision,2:2><Standard Format,0>'))
                    {
                    }
                    column(DocDDMMYY1; DocDDMMYY[1])
                    {

                    }
                    column(DocDDMMYY2; DocDDMMYY[2])
                    {
                    }
                    column(DocDDMMYY3; DocDDMMYY[3])
                    {
                    }
                    column(DocDDMMYY4; DocDDMMYY[4])
                    {
                    }
                    column(DocDDMMYY5; DocDDMMYY[5])
                    {
                    }
                    column(DocDDMMYY6; DocDDMMYY[6])
                    {
                    }
                    column(DocDDMMYY7; DocDDMMYY[7])
                    {
                    }
                    column(DocDDMMYY8; DocDDMMYY[8])
                    {
                    }

                    column(VendorName; VendorName)//
                    {
                    }

                    column(TextAmount_; TextAmount[1])//
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        Decimals: Decimal;
                        CheckLedgEntryAmount: Decimal;
                    begin
                        //
                        IF NOT TestPrint THEN BEGIN
                            WITH GenJnlLine DO BEGIN
                                CheckLedgEntry.INIT;
                                CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                                CheckLedgEntry."Posting Date" := "Posting Date";
                                CheckLedgEntry."Document Type" := "Document Type";
                                CheckLedgEntry."Document No." := UseCheckNo;
                                CheckLedgEntry.Description := Description;
                                CheckLedgEntry."Bank Payment Type" := "Bank Payment Type";
                                CheckLedgEntry."Bal. Account Type" := BalancingType;
                                CheckLedgEntry."Bal. Account No." := BalancingNo;
                                CheckLedgEntry."WHT Amount" := TotWHTAmount;
                                CheckLedgEntry."PDC Check No." := "Check No.";
                                CheckLedgEntry."Interest Amount" := InterestAmount;
                                IF FoundLast THEN BEGIN
                                    IF TotalLineAmount < 0 THEN
                                        ERROR(
                                          Text020,
                                          UseCheckNo, TotalLineAmount - TotWHTAmount);
                                    CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Printed;
                                    CheckLedgEntry.Amount := TotalLineAmount - TotWHTAmount;
                                END ELSE BEGIN
                                    CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Voided;
                                    CheckLedgEntry.Amount := 0;
                                END;
                                CheckLedgEntry."Check Date" := "Posting Date";
                                CheckLedgEntry."Check No." := UseCheckNo;
                                //GKU:005+
                                DocDateText := FORMAT(GenJnlLine."Document Date", 0, '<Day,2><Month,2><Year4>');
                                DocDDMMYY[1] := COPYSTR(DocDateText, 1, 1);
                                DocDDMMYY[2] := COPYSTR(DocDateText, 2, 1);
                                DocDDMMYY[3] := COPYSTR(DocDateText, 3, 1);
                                DocDDMMYY[4] := COPYSTR(DocDateText, 4, 1);
                                DocDDMMYY[5] := COPYSTR(DocDateText, 5, 1);
                                DocDDMMYY[6] := COPYSTR(DocDateText, 6, 1);
                                DocDDMMYY[7] := COPYSTR(DocDateText, 7, 1);
                                DocDDMMYY[8] := COPYSTR(DocDateText, 8, 1);
                                //GKU:005-
                                IF NOT ManualCheck THEN  //KKE : #002
                                    CheckManagement.InsertCheck(CheckLedgEntry, RecordId);

                                IF FoundLast THEN BEGIN
                                    CheckAmountText := FORMAT(CheckLedgEntry.Amount, 0);
                                    i := STRPOS(CheckAmountText, '.');
                                    CASE TRUE OF
                                        i = 0:
                                            CheckAmountText := CheckAmountText + '.00';
                                        i = STRLEN(CheckAmountText) - 1:
                                            CheckAmountText := CheckAmountText + '0';
                                        i > STRLEN(CheckAmountText) - 2:
                                            CheckAmountText := COPYSTR(CheckAmountText, 1, i + 2);
                                    END;
                                    FormatNoText(DescriptionLine, CheckLedgEntry.Amount, BankAcc2."Currency Code");
                                    VoidText := '';
                                END ELSE BEGIN
                                    CLEAR(CheckAmountText);
                                    CLEAR(DescriptionLine);
                                    DescriptionLine[1] := Text021;
                                    DescriptionLine[2] := DescriptionLine[1];
                                    VoidText := Text022;
                                END;
                            END;
                        END ELSE BEGIN
                            WITH GenJnlLine DO BEGIN
                                CheckLedgEntry.INIT;
                                CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                                CheckLedgEntry."Posting Date" := "Posting Date";
                                CheckLedgEntry."Document No." := UseCheckNo;
                                CheckLedgEntry.Description := Text023;
                                CheckLedgEntry."Bank Payment Type" := "Bank Payment Type"::"Computer Check";
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::"Test Print";
                                CheckLedgEntry."Check Date" := "Posting Date";
                                CheckLedgEntry."Check No." := UseCheckNo;

                                IF NOT ManualCheck THEN  //KKE : #002
                                    CheckManagement.InsertCheck(CheckLedgEntry, RecordId);

                                CheckAmountText := Text024;
                                DescriptionLine[1] := Text025;
                                DescriptionLine[2] := DescriptionLine[1];
                                VoidText := Text022;
                            END;
                        END;
                        CheckReport.InitTextVariable;
                        CheckReport.FormatNoText(TextAmount, Abs(CheckLedgEntry.Amount), GenJnlLine."Currency Code");
                        TextAmount[1] := TextAmount[1];
                        ChecksPrinted := ChecksPrinted + 1;
                        FirstPage := FALSE;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    IF FoundLast THEN
                        CurrReport.BREAK;
                    UseCheckNo := INCSTR(UseCheckNo);
                    IF NOT TestPrint THEN
                        CheckNoText := UseCheckNo
                    ELSE
                        CheckNoText := Text011;
                    TotWHTAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT TestPrint THEN BEGIN
                        IF UseCheckNo <> GenJnlLine."Document No." THEN BEGIN
                            GenJnlLine3.RESET;
                            GenJnlLine3.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GenJnlLine3.SETRANGE("Posting Date", GenJnlLine."Posting Date");
                            GenJnlLine3.SETRANGE("Document No.", UseCheckNo);
                            IF GenJnlLine3.FIND('-') THEN
                                GenJnlLine3.FIELDERROR("Document No.", STRSUBSTNO(Text013, UseCheckNo));
                        END;

                        IF ApplyMethod <> ApplyMethod::MoreLinesOneEntry THEN BEGIN
                            GenJnlLine3 := GenJnlLine;
                            GenJnlLine3.TESTFIELD("Posting No. Series", '');

                            //KKE : #001 +
                            IF GenJnlLine."Document No." <> '' THEN BEGIN
                                IF NOT ReprintChecks THEN
                                    GenJnlLine3."External Document No." := GenJnlLine."Document No.";
                            END;
                            //KKE : #001 -

                            GenJnlLine3."Document No." := UseCheckNo;
                            GenJnlLine3."Check Printed" := TRUE;
                            IF NOT ManualCheck THEN //KKE : #002
                                GenJnlLine3.MODIFY;
                        END ELSE BEGIN
                            IF GenJnlLine2.FIND('-') THEN BEGIN
                                HighestLineNo := GenJnlLine2."Line No.";
                                REPEAT
                                    IF GenJnlLine2."Line No." > HighestLineNo THEN
                                        HighestLineNo := GenJnlLine2."Line No.";
                                    GenJnlLine3 := GenJnlLine2;
                                    GenJnlLine3.TESTFIELD("Posting No. Series", '');
                                    // {---
                                    // GenJnlLine3."Bal. Account No." := '';
                                    //                             GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::" ";
                                    // ---}

                                    //KKE : #001 +
                                    IF GenJnlLine."Document No." <> '' THEN BEGIN
                                        IF NOT ReprintChecks THEN
                                            GenJnlLine3."External Document No." := GenJnlLine."Document No.";
                                    END;
                                    //KKE : #001 -

                                    GenJnlLine3."Document No." := UseCheckNo;
                                    GenJnlLine3."Check Printed" := TRUE;
                                    GenJnlLine3.VALIDATE(Amount);
                                    IF NOT ManualCheck THEN //KKE : #002
                                        GenJnlLine3.MODIFY;
                                UNTIL GenJnlLine2.NEXT = 0;
                            END;
                            /*
                              {---
                                GenJnlLine3.RESET;
                                                        GenJnlLine3 := GenJnlLine;
                                                        GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                                                        GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                                                        GenJnlLine3."Line No." := HighestLineNo;
                                                        IF GenJnlLine3.NEXT = 0 THEN
                                                            GenJnlLine3."Line No." := HighestLineNo + 10000
                                                        ELSE BEGIN
                                                            WHILE GenJnlLine3."Line No." = HighestLineNo + 1 DO BEGIN
                                                                HighestLineNo := GenJnlLine3."Line No.";
                                                                IF GenJnlLine3.NEXT = 0 THEN
                                                                    GenJnlLine3."Line No." := HighestLineNo + 20000;
                                                            END;
                                                            GenJnlLine3."Line No." := (GenJnlLine3."Line No." + HighestLineNo) DIV 2;
                                                        END;
                                                        GenJnlLine3.INIT;
                                                        GenJnlLine3.VALIDATE("Posting Date", GenJnlLine."Posting Date");
                                                        GenJnlLine3."Document Type" := GenJnlLine."Document Type";
                                                        GenJnlLine3."Document No." := UseCheckNo;
                                                        GenJnlLine3."Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                                                        GenJnlLine3.VALIDATE("Account No.", BankAcc2."No.");
                                                        IF BalancingType <> BalancingType::"G/L Account" THEN
                                                            GenJnlLine3.Description := STRSUBSTNO(Text014, SELECTSTR(BalancingType + 1, Text062), BalancingNo);
                                                        GenJnlLine3.VALIDATE(Amount, -TotalLineAmount);
                                                        GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::"Computer Check";
                                                        GenJnlLine3."Check Printed" := TRUE;
                                                        GenJnlLine3."Source Code" := GenJnlLine."Source Code";
                                                        GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
                                                        GenJnlLine3."Allow Zero-Amount Posting" := TRUE;
                                                        GenJnlLine3.INSERT;
                              ---}  //KKE : #001
                              */
                        END;
                    END;

                    IF NOT ManualCheck THEN BEGIN //KKE : #002
                        BankAcc2."Last Check No." := UseCheckNo;
                        BankAcc2.MODIFY;
                    END;

                    COMMIT;
                    CLEAR(CheckManagement);
                end;

                trigger OnPreDataItem()
                begin
                    FirstPage := TRUE;
                    FoundLast := FALSE;
                    TotalLineAmount := 0;
                    TotalLineDiscount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF OneCheckPrVendor AND (GenJnlLine."Currency Code" <> '') AND
                   (GenJnlLine."Currency Code" <> Currency.Code)
                THEN BEGIN
                    Currency.GET(GenJnlLine."Currency Code");
                    Currency.TESTFIELD("Conv. LCY Rndg. Debit Acc.");
                    Currency.TESTFIELD("Conv. LCY Rndg. Credit Acc.");
                END;
                WHTSkip := GenJnlLine."Skip WHT";
                InterestAmount := GenJnlLine."Interest Amount";
                InterestAmountLCY := GenJnlLine."Interest Amount (LCY)";
                IF NOT TestPrint THEN BEGIN//
                    IF Amount = 0 THEN
                        CurrReport.SKIP;

                    TESTFIELD("Bal. Account Type", "Bal. Account Type"::"Bank Account");
                    if CopyStr("Bal. Account No.", 1, 5) = 'DBANK' then
                        BANKCODE := 'DBANK'
                    else
                        if CopyStr("Bal. Account No.", 1, 5) = 'KBANK' then
                            BANKCODE := 'KBANK';

                    IF "Bal. Account No." <> BankAcc2."No." THEN
                        CurrReport.SKIP;

                    IF ("Account No." <> '') AND ("Bal. Account No." <> '') THEN BEGIN
                        BalancingType := "Account Type";
                        BalancingNo := "Account No.";
                        RemainingAmount := Amount;
                        IF OneCheckPrVendor THEN BEGIN
                            ApplyMethod := ApplyMethod::MoreLinesOneEntry;
                            GenJnlLine2.RESET;
                            GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine2.SETRANGE("Journal Template Name", "Journal Template Name");
                            GenJnlLine2.SETRANGE("Journal Batch Name", "Journal Batch Name");
                            GenJnlLine2.SETRANGE("Posting Date", "Posting Date");
                            GenJnlLine2.SETRANGE("Document No.", "Document No.");
                            GenJnlLine2.SETRANGE("Account Type", "Account Type");
                            GenJnlLine2.SETRANGE("Account No.", "Account No.");
                            GenJnlLine2.SETRANGE("Bal. Account Type", "Bal. Account Type");
                            GenJnlLine2.SETRANGE("Bal. Account No.", "Bal. Account No.");
                            GenJnlLine2.SETRANGE("Bank Payment Type", "Bank Payment Type");
                            GenJnlLine2.FIND('-');
                            RemainingAmount := 0;
                        END ELSE
                            IF "Applies-to Doc. No." <> '' THEN
                                ApplyMethod := ApplyMethod::OneLineOneEntry
                            ELSE
                                IF "Applies-to ID" <> '' THEN
                                    ApplyMethod := ApplyMethod::OneLineID
                                ELSE
                                    ApplyMethod := ApplyMethod::Payment;
                    END
                    ELSE
                        IF "Account No." = '' THEN
                            FIELDERROR("Account No.", Text004)
                        ELSE
                            FIELDERROR("Bal. Account No.", Text004);

                    CLEAR(CheckToAddr);
                    ContactText := '';
                    CLEAR(SalesPurchPerson);
                    CASE BalancingType OF
                        BalancingType::"G/L Account":
                            BEGIN
                                CheckToAddr[1] := GenJnlLine.Description;
                            END;
                        BalancingType::Customer:
                            BEGIN
                                Cust.GET(BalancingNo);
                                IF Cust.Blocked = Cust.Blocked::All THEN
                                    ERROR(Text064, Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, Cust."No.");
                                Cust.Contact := '';
                                FormatAddr.Customer(CheckToAddr, Cust);
                                IF BankAcc2."Currency Code" <> "Currency Code" THEN
                                    ERROR(Text005);
                                IF Cust."Salesperson Code" <> '' THEN BEGIN
                                    ContactText := Text006;
                                    SalesPurchPerson.GET(Cust."Salesperson Code");
                                END;
                            END;
                        BalancingType::Vendor:
                            BEGIN
                                Vend.GET(BalancingNo);
                                IF Vend.Blocked IN [Vend.Blocked::All, Vend.Blocked::Payment] THEN
                                    ERROR(Text064, Vend.FIELDCAPTION(Blocked), Vend.Blocked, Vend.TABLECAPTION, Vend."No.");
                                Vend.Contact := '';
                                FormatAddr.Vendor(CheckToAddr, Vend);
                                IF BankAcc2."Currency Code" <> "Currency Code" THEN
                                    ERROR(Text005);
                                IF Vend."Purchaser Code" <> '' THEN BEGIN
                                    ContactText := Text007;
                                    SalesPurchPerson.GET(Vend."Purchaser Code");
                                END;
                                //KKE : #004 +
                                IF "Payee Name" <> '' THEN
                                    VendorName := "Payee Name"
                                ELSE
                                    //KKE : #004 -
                                    //KKE : #001 +
                                    IF Vend."Name (Thai)" <> '' THEN
                                        VendorName := Vend."Name (Thai)"
                                    ELSE
                                        VendorName := Vend.Name + Vend."Name 2";
                                //KKE : #001 -
                            END;
                        BalancingType::"Bank Account":
                            BEGIN
                                BankAcc.GET(BalancingNo);
                                BankAcc.TESTFIELD(Blocked, FALSE);
                                BankAcc.Contact := '';
                                FormatAddr.BankAcc(CheckToAddr, BankAcc);
                                IF BankAcc2."Currency Code" <> BankAcc."Currency Code" THEN
                                    ERROR(Text008);
                                IF BankAcc."Our Contact Code" <> '' THEN BEGIN
                                    ContactText := Text009;
                                    SalesPurchPerson.GET(BankAcc."Our Contact Code");
                                END;
                            END;
                    END;
                    CheckDateText := FORMAT("Posting Date", 0, 4);
                END ELSE BEGIN
                    IF ChecksPrinted > 0 THEN
                        CurrReport.BREAK;
                    BalancingType := BalancingType::Vendor;
                    BalancingNo := Text010;
                    CLEAR(CheckToAddr);
                    FOR i := 1 TO 5 DO
                        CheckToAddr[i] := Text003;
                    ContactText := '';
                    CLEAR(SalesPurchPerson);
                    CheckNoText := Text011;
                    CheckDateText := Text012;
                END;

            end;

            trigger OnPreDataItem()
            begin
                GenJnlLine.COPY(VoidGenJnlLine);
                CompanyInfo.GET;
                IF NOT TestPrint THEN BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    BankAcc2.GET(BankAcc2."No.");
                    BankAcc2.TESTFIELD(Blocked, FALSE);
                    COPY(VoidGenJnlLine);
                    //KKE : #002 +
                    IF ManualCheck THEN
                        SETRANGE("Bank Payment Type", "Bank Payment Type"::"Manual Check")
                    ELSE BEGIN
                        //KKE : #002 -
                        SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                        SETRANGE("Check Printed", FALSE);
                    END;
                END ELSE BEGIN
                    CLEAR(CompanyAddr);
                    FOR i := 1 TO 5 DO
                        CompanyAddr[i] := Text003;
                END;
                ChecksPrinted := 0;
                SETRANGE("Account Type", GenJnlLine."Account Type"::"Fixed Asset");
                IF FIND('-') THEN
                    GenJnlLine.FIELDERROR("Account Type");
                SETRANGE("Account Type");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(BankAccount; BankAcc2."No.")
                    {
                        Caption = 'Bank Account';
                        TableRelation = "Bank Account";
                        ApplicationArea = all;

                        trigger OnValidate()
                        begin
                            InputBankAccount;
                        end;
                    }
                    field(LastCheckNo; UseCheckNo)
                    {
                        Caption = 'Last Check No.';
                        ApplicationArea = all;
                    }
                    field(OneCheckPerVendorPerDocumentNo; OneCheckPrVendor)
                    {
                        Caption = 'One Check per Vendor per Document No.';
                        MultiLine = true;
                        ApplicationArea = all;
                    }
                    field(ReprintChecks; ReprintChecks)
                    {
                        Caption = 'Reprint Checks';
                        ApplicationArea = all;
                    }
                    field(TestPrinting; TestPrint)
                    {
                        Caption = 'Test Print';
                        ApplicationArea = all;
                    }
                    field(PreprintedStub; PreprintedStub)
                    {
                        Caption = 'Preprinted Stub';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF BankAcc2."No." <> '' THEN
                IF BankAcc2.GET(BankAcc2."No.") THEN
                    UseCheckNo := BankAcc2."Last Check No."
                ELSE BEGIN
                    BankAcc2."No." := '';
                    UseCheckNo := '';
                END;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        InitTextVariable;
    end;

    var
        BANKCODE: Text;
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006: Label 'Salesperson';
        Text007: Label 'Purchaser';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text009: Label 'Our Contact';
        Text010: Label 'XXXXXXXXXX';
        WHTSkip: Boolean;
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text015: Label 'Payment';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\must not be activated when Applies-to ID is specified in the journal lines.';
        Text018: Label 'XXX';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        DocDDMMYY: array[8] of Text[30];
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        CompanyInfo: Record "Company Information";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        DocDateText: Text[30];
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        CheckLedgEntry: Record "Check Ledger Entry";
        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
        CheckManagement: Codeunit CheckManagement;
        CheckManagement2: Codeunit Cu367Ext;
        CompanyAddr: array[8] of Text[50];
        CheckToAddr: array[8] of Text[50];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo: Code[20];
        ContactText: Text[30];
        CheckNoText: Text[30];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[250];
        InterestAmount: Decimal;
        InterestAmountLCY: Decimal;
        LineWHT: Decimal;
        WHTManagement: Codeunit WHTManagement;
        DocType: Text[30];
        DocNo: Text[30];
        ExtDocNo: Text[35];
        VoidText: Text[30];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        xGenJnlLine2: Record "Gen. Journal Line";
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        UseCheckNo: Code[20];
        FoundLast: Boolean;
        ReprintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        TextAmount: array[2] of Text[250];
        PreprintedStub: Boolean;
        TotalText: Text[10];
        DocDate: Date;
        i: Integer;
        TotWHTAmount: Decimal;

        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        LineAmount2: Decimal;
        Text063: Label 'Net Amount %1';
        GLSetup: Record "General Ledger Setup";
        Text064: Label '%1 must not be %2 for %3 %4.';
        CheckReport: Report Check;
        Text065: Label 'Subtotal';
        CheckNoTextCaptionLbl: Label 'Check No.';
        LineAmountCaptionLbl: Label 'Net Amount';
        LineDiscountCaptionLbl: Label 'Discount';
        AmountCaptionLbl: Label 'Amount';
        DocNoCaptionLbl: Label 'Document No.';
        DocDateCaptionLbl: Label 'Document Date';
        CurrencyCodeCaptionLbl: Label 'Currency Code';
        YourDocNoCaptionLbl: Label 'Your Doc. No.';
        TransportCaptionLbl: Label 'Transport';

        ManualCheck: Boolean;

        VendorName: Text[150];

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        //  NoText[1] := '**';
        // if CurrencyCode = '' then
        //     NoText[1] := 'Bath'
        // else
        NoText[1] := '';

        GLSetup.GET;

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;

        // AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        // DecimalPosition := GetAmtDecimalPosition;
        // AddToNoText(NoText, NoTextIndex, PrintExponent, (FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));

        //KKE : #001 +
        IF No * 100 <= 0 THEN BEGIN
            IF CurrencyCode = '' THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, 'Baht Only')
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, 'Only');
        END ELSE BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
            AddToNoText(NoText, NoTextIndex, PrintExponent, FORMAT(ROUND(No * 100, 1)) + '/100');
        END;
        //KKE : #001 -

        IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    local procedure CustUpdateAmounts(var CustLedgEntry2: Record "Cust. Ledger Entry"; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Customer);
            GenJnlLine3.SETRANGE("Account No.", CustLedgEntry2."Customer No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", CustLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", CustLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            IF CustLedgEntry2."Document Type" <> CustLedgEntry2."Document Type"::" " THEN
                IF GenJnlLine3.FIND('-') THEN
                    GenJnlLine3.FIELDERROR(
                      "Applies-to Doc. No.",
                      STRSUBSTNO(
                        Text030,
                        CustLedgEntry2."Document Type", CustLedgEntry2."Document No.",
                        CustLedgEntry2."Customer No."));
        END;

        DocType := FORMAT(CustLedgEntry2."Document Type");
        DocNo := CustLedgEntry2."Document No.";
        ExtDocNo := CustLedgEntry2."External Document No.";
        DocDate := CustLedgEntry2."Posting Date";
        CurrencyCode2 := CustLedgEntry2."Currency Code";

        CustLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount :=
          -ABSMin(
            CustLedgEntry2."Remaining Amount" -
            CustLedgEntry2."Remaining Pmt. Disc. Possible" -
            CustLedgEntry2."Accepted Payment Tolerance",
            CustLedgEntry2."Amount to Apply");
        LineAmount2 :=
          ROUND(
            ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        IF ((CustLedgEntry2."Document Type" IN [CustLedgEntry2."Document Type"::Invoice,
                                                CustLedgEntry2."Document Type"::"Credit Memo"]) AND
            (CustLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) AND
            (CustLedgEntry2."Posting Date" <= CustLedgEntry2."Pmt. Discount Date")) OR
           CustLedgEntry2."Accepted Pmt. Disc. Tolerance"
        THEN BEGIN
            LineDiscount := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
            IF CustLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - CustLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            IF RemainingAmount2 >=
               ROUND(
                 -ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                   CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision")
            THEN
                LineAmount2 :=
                  ROUND(
                    -ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision")
            ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(CustLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                      LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2: Record "Vendor Ledger Entry"; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Vendor);
            GenJnlLine3.SETRANGE("Account No.", VendLedgEntry2."Vendor No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", VendLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", VendLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            IF VendLedgEntry2."Document Type" <> VendLedgEntry2."Document Type"::" " THEN
                IF GenJnlLine3.FIND('-') THEN
                    GenJnlLine3.FIELDERROR(
                      "Applies-to Doc. No.",
                      STRSUBSTNO(
                        Text031,
                        VendLedgEntry2."Document Type", VendLedgEntry2."Document No.",
                        VendLedgEntry2."Vendor No."));
        END;

        DocType := FORMAT(VendLedgEntry2."Document Type");
        DocNo := VendLedgEntry2."Document No.";
        ExtDocNo := VendLedgEntry2."External Document No.";
        DocDate := VendLedgEntry2."Posting Date";
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount :=
          -ABSMin(
            VendLedgEntry2."Remaining Amount" -
            VendLedgEntry2."Remaining Pmt. Disc. Possible" -
            VendLedgEntry2."Accepted Payment Tolerance",
            VendLedgEntry2."Amount to Apply");

        LineAmount2 :=
          ROUND(
            ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        IF ((VendLedgEntry2."Document Type" IN [VendLedgEntry2."Document Type"::Invoice,
                                                VendLedgEntry2."Document Type"::"Credit Memo"]) AND
            (VendLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) AND
            (GenJnlLine."Posting Date" <= VendLedgEntry2."Pmt. Discount Date")) OR
           VendLedgEntry2."Accepted Pmt. Disc. Tolerance"
        THEN BEGIN
            LineDiscount := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
            IF VendLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - VendLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            IF ABS(RemainingAmount2) >=
               ABS(ROUND(
                   ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                     VendLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision"))
            THEN BEGIN
                LineAmount2 :=
                  ROUND(
                    -(ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                        VendLedgEntry2."Amount to Apply")), Currency."Amount Rounding Precision");
                LineAmount :=
                  ROUND(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                      LineAmount2), Currency."Amount Rounding Precision");
            END ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                      LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    procedure InitializeRequest(BankAcc: Code[20]; LastCheckNo: Code[20]; NewOneCheckPrVend: Boolean; NewReprintChecks: Boolean; NewTestPrint: Boolean; NewPreprintedStub: Boolean)
    begin
        IF BankAcc <> '' THEN
            IF BankAcc2.GET(BankAcc) THEN BEGIN
                UseCheckNo := LastCheckNo;
                OneCheckPrVendor := NewOneCheckPrVend;
                ReprintChecks := NewReprintChecks;
                TestPrint := NewTestPrint;
                PreprintedStub := NewPreprintedStub;
            END;
    end;

    local procedure ExchangeAmt(PostingDate: Date; CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal
    begin
        IF (CurrencyCode <> '') AND (CurrencyCode2 = '') THEN
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtLCYToFCY(
                PostingDate, CurrencyCode, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode))
        ELSE
            IF (CurrencyCode = '') AND (CurrencyCode2 <> '') THEN
                Amount2 :=
                  CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    PostingDate, CurrencyCode2, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode2))
            ELSE
                IF (CurrencyCode <> '') AND (CurrencyCode2 <> '') AND (CurrencyCode <> CurrencyCode2) THEN
                    Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate, CurrencyCode2, CurrencyCode, Amount)
                ELSE
                    Amount2 := Amount;
    end;

    local procedure ABSMin(Decimal1: Decimal; Decimal2: Decimal): Decimal
    begin
        IF ABS(Decimal1) < ABS(Decimal2) THEN
            EXIT(Decimal1);
        EXIT(Decimal2);
    end;

    procedure InputBankAccount()
    begin
        IF BankAcc2."No." <> '' THEN BEGIN
            BankAcc2.GET(BankAcc2."No.");
            BankAcc2.TESTFIELD("Last Check No.");
            UseCheckNo := BankAcc2."Last Check No.";
        END;
    end;

    local procedure GetAmtDecimalPosition(): Decimal
    var
        Currency: Record Currency;
    begin
        IF GenJnlLine."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE BEGIN
            Currency.GET(GenJnlLine."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        END;
        EXIT(1 / Currency."Amount Rounding Precision");
    end;
}

