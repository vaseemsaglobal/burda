Report 50503 "Payment Voucher"
{
    //ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PaymentVoucher.rdl';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "Shortcut Dimension 1 Code");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Document No.";
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

            column(CaptionTaxID; CaptionTaxID)
            {
            }
            column(CompanyInfo_CompanyNameThai; CompanyInfo."Company Name (Thai)")
            {
            }
            column(CompanyInfo_CompanyAddressThai; CompanyInfo."Company Address (Thai)")
            {
            }
            column(CompanyInfo_CompanyAddress2Thai_PostCode; CompanyInfo."Company Address 2 (Thai)")
            {
            }
            column(CompanyInfo_AddressCompanyInfo_Address2; CompanyInfo.Address + CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_Address3CompanyInfo_PostCode; CompanyInfo."Address 3" + ' ' + CompanyInfo."Post Code")
            {
            }
            column(TelCompanyInfo_PhoneNoFaxVATRegCompanyInfo_FaxNo; 'Tel: ' + CompanyInfo."Phone No." + ' Fax: ' + CompanyInfo."Fax No." + ' Tax ID: ' + CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_VATRegistrationNo; CompanyInfo."VAT Registration No.")
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
            column(Description; Description)
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
            column(LineNo_GenJournalLine; "Gen. Journal Line"."Line No.")
            {
            }
            column(ShortcutDimension1Code_GenJournalLine; "Gen. Journal Line"."Shortcut Dimension 1 Code")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(totalCurrCode; TtoalCurrCode)
            {
            }
            dataitem(VendLedgerEntrybuffer2; "Vendor Ledger Entry")
            {
                DataItemTableView = sorting("Entry No.");

                column(EntryNo_VendLedgerEntrybuffer2; VendLedgerEntrybuffer2."Entry No.")
                {
                }
                column(Description_ExternalDocumentNo; Description + '   #' + "External Document No.")
                {
                }
                column(VendLedgerEntrybuffe2_AmounttoApplyCreditVATAmtTmp; -VendLedgerEntrybuffer2."Amount to Apply" - CreditVATAmtTmp)
                {
                }
                column(CreditVATAmtTmp; CreditVATAmtTmp)
                {
                }
                column(VendLedgerEntrybuffe2_AmounttoApply; -VendLedgerEntrybuffer2."Amount to Apply")
                {
                }
                column(WHTAmtHeader; WHTAmtHeader)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VendLedgerEntrybuffer2.CalcFields("Amount (LCY)", "Remaining Amt. (LCY)", "Remaining Amount", "Original Amt. (LCY)");
                    CreditAppliedVATAmtTmp := 0;
                    CreditVATAmtTmp := 0;
                    PayPer := 1;
                    VATEntry.Reset;
                    VATEntry.SetCurrentkey("Document No.", "Posting Date");
                    VATEntry.SetRange("Posting Date", VendLedgerEntrybuffer2."Posting Date");
                    VATEntry.SetRange("Document No.", VendLedgerEntrybuffer2."Document No.");
                    //VATEntry.SETFILTER("Remaining Unrealized Amount",'<>0');
                    if VATEntry.Find('-') then
                        repeat
                            if VATEntry.Amount <> 0 then begin
                                CreditVATAmtTmp := CreditVATAmtTmp + VATEntry.Amount;
                                CreditAppliedVATAmtTmp := 0;
                            end;
                            if VATEntry."Remaining Unrealized Amount" <> 0 then begin
                                CreditVATAmtTmp := CreditVATAmtTmp + VATEntry."Remaining Unrealized Amount";
                                CreditAppliedVATAmtTmp := 0;
                            end;
                        until VATEntry.Next = 0;
                    CreditMemoVendLedgerEntry.SetRange("Closed by Entry No.", VendLedgerEntrybuffer2."Entry No.");
                    if CreditMemoVendLedgerEntry.Find('-') then
                        repeat
                            VATEntry.Reset;
                            VATEntry.SetCurrentkey("Document No.", "Posting Date");
                            VATEntry.SetRange("Posting Date", CreditMemoVendLedgerEntry."Posting Date");
                            VATEntry.SetRange("Document No.", CreditMemoVendLedgerEntry."Document No.");
                            if VATEntry.Find('-') then
                                repeat
                                    if VATEntry.Amount <> 0 then begin
                                        CreditVATAmtTmp := CreditVATAmtTmp + VATEntry.Amount;
                                        CreditAppliedVATAmtTmp := 0;
                                    end;
                                    if VATEntry."Remaining Unrealized Amount" <> 0 then begin
                                        CreditVATAmtTmp := CreditVATAmtTmp + VATEntry."Remaining Unrealized Amount";
                                        CreditAppliedVATAmtTmp := 0;
                                    end;
                                until VATEntry.Next = 0;
                        until CreditMemoVendLedgerEntry.Next = 0;
                    //totAmounttoApply += (-1) * VendLedgerEntrybuffer2."Original Amt. (LCY)" ;
                    totAmounttoApply += (-1) * VendLedgerEntrybuffer2."Amount to Apply";
                    totCreditVATAmtTmp := totCreditVATAmtTmp + CreditVATAmtTmp;
                    //body section
                    if CntLine > 25 then
                        CntLine := 1
                    else
                        CntLine += 1;
                end;

                trigger OnPreDataItem()
                begin
                    //TSA
                    VendLedgerEntrybuffer.MarkedOnly(true);
                    if VendLedgerEntrybuffer.Find('-') then
                        repeat
                            VendLedgerEntrybuffer2 := VendLedgerEntrybuffer;
                            VendLedgerEntrybuffer2.Mark(true);
                        until VendLedgerEntrybuffer.Next = 0
                    else
                        ShowBlank := true;
                    MarkedOnly(true);
                    //TSA
                    totCreditVATAmtTmp := 0;
                    totAmounttoApply := 0;
                end;
            }
            dataitem(VendLEFooter; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                dataitem(DebitDetail; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                    column(DebitAccNoNumber; DebitAccNo[Number])
                    {
                    }
                    column(DebitAccNameNumber; DebitAccName[Number])
                    {
                    }
                    column(DebitAmountNumber; DebitAmount[Number])
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if DebitAccNo[Number] = '' then
                            CurrReport.Break
                        else
                            Line := Line + 1;
                        if DebitAmount[Number] <= 0 then CurrReport.Skip;
                        DebitTotalLCY := DebitTotalLCY + DebitAmount[Number];
                    end;

                    trigger OnPreDataItem()
                    begin
                        //Clear credit amount less than zero.
                        I := 0;
                        repeat
                            I := I + 1;
                            if CreditAmount[I] < 0 then begin
                                MatchAcc := false;
                                J := 0;
                                repeat
                                    J := J + 1;
                                    if DebitAccNo[J] = '' then MatchAcc := true;
                                until (J >= 300) or MatchAcc;
                                if MatchAcc then begin
                                    DebitAccNo[J] := CreditAccNo[I];
                                    DebitAccName[J] := CreditAccName[I];
                                    DebitAmount[J] := -CreditAmount[I];
                                    DebitDimValue[J] := CreditDimValue[I];
                                    CreditAmount[I] := 0;
                                end;
                            end;
                        until (I >= 300) or (CreditAccNo[I] = '');
                        //Clear debit amount less than zero.
                        I := 0;
                        repeat
                            I := I + 1;
                            if DebitAmount[I] < 0 then begin
                                MatchAcc := false;
                                J := 0;
                                repeat
                                    J := J + 1;
                                    if CreditAccNo[J] = '' then MatchAcc := true;
                                until (J >= 300) or MatchAcc;
                                if MatchAcc then begin
                                    CreditAccNo[J] := DebitAccNo[I];
                                    CreditAccName[J] := DebitAccName[I];
                                    CreditAmount[J] := -DebitAmount[I];
                                    CreditDimValue[J] := DebitDimValue[I];
                                    DebitAmount[I] := 0;
                                end;
                            end;
                        until (I >= 300) or (DebitAccNo[I] = '');
                        //Check balance debit/credit with same g/l account.
                        I := 0;
                        repeat
                            I := I + 1;
                            if DebitAmount[I] > 0 then begin
                                MatchAcc := false;
                                J := 0;
                                repeat
                                    J := J + 1;
                                    if DebitAccNo[I] = CreditAccNo[J] then MatchAcc := true;
                                until (J >= 300) or MatchAcc;
                                if MatchAcc then begin
                                    if DebitAmount[I] >= CreditAmount[J] then begin
                                        DebitAmount[I] := DebitAmount[I] - CreditAmount[J];
                                        CreditAmount[J] := 0;
                                    end
                                    else begin
                                        CreditAmount[J] := CreditAmount[J] - DebitAmount[I];
                                        DebitAmount[I] := 0;
                                    end;
                                end;
                            end;
                        until (I >= 300) or (DebitAccNo[I] = '');
                    end;
                }
                dataitem(DebitVATDetail; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                    column(DebitVATNoNumber; DebitVATNo[Number])
                    {
                    }
                    column(DebitVATNameNumber; DebitVATName[Number])
                    {
                    }
                    column(DebitVATAmtNumber; DebitVATAmt[Number])
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if DebitVATNo[Number] = '' then
                            CurrReport.Break
                        else
                            Line := Line + 1;
                        DebitTotalLCY := DebitTotalLCY + DebitVATAmt[Number];
                    end;
                }
                dataitem(WHTDetail; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));

                    column(WHTAccountNo; WHTAccountNo)
                    {
                    }
                    column(WHTAccountName; WHTAccountName)
                    {
                    }
                    column(WHTAmt; WHTAmt)
                    {
                    }
                    column(CreditWHTAmt; CreditWHTAmt)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        //KKE : #004 +
                        if SkipWHT then begin
                            WHTAmt := 0;
                            CreditWHTAmt := 0;
                        end;
                        //KKE : #004 -
                        /*if WHTAmt <> 0 then begin
                            Line := Line + 1;
                            DebitTotalLCY := DebitTotalLCY + WHTAmt;
                        end; */
                        //VAH
                        if CreditWHTAmt > 0 then begin
                            Line := Line + 1;
                            //DebitTotalLCY := DebitTotalLCY + CreditWHTAmt; //VAH no need
                        end;
                        if CreditWHTAmt < 0 then begin
                            Line := Line + 1;
                            CreditTotalLCY := CreditTotalLCY - CreditWHTAmt;
                        end;
                        //>>VAH
                        //Message(Format(DebitTotalLCY) + 'II');
                        CheckReport.InitTextVariable;
                        CheckReport.FormatNoText(TextAmount, Abs(DebitTotalLCY), "Gen. Journal Line"."Currency Code");
                        if TextAmount[1] <> '' then TextAmount[1] := '(' + TextAmount[1] + ' ' + TtoalCurrCode + ')';
                        //<<VAH
                    end;
                }
                dataitem(CreditVATDetail; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                    column(CreditVATNoNumber; CreditVATNo[Number])
                    {
                    }
                    column(CreditVATNameNumber; CreditVATName[Number])
                    {
                    }
                    column(CreditVATAmtNumber; CreditVATAmt[Number])
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if CreditVATNo[Number] = '' then
                            CurrReport.Break
                        else
                            Line := Line + 1;
                        CreditTotalLCY := CreditTotalLCY + CreditVATAmt[Number];
                    end;
                }
                dataitem(CreditDetail; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                    column(CreditAccNoNumber; CreditAccNo[Number])
                    {
                    }
                    column(CreditAccNameNumber; CreditAccName[Number])
                    {
                    }
                    column(CreditAmountNumber; CreditAmount[Number])
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if Number >= 300 then CurrReport.Break;
                        if CreditAmount[Number] <= 0 then CurrReport.Skip;
                        if CreditAccNo[Number] = '' then
                            CurrReport.Break
                        else begin
                            if not MatchAcc then begin
                                //CreditAmount[Number] := CreditAmount[Number] + CreditWHTAmt; //VAH
                                CreditAmount[Number] := CreditAmount[Number] - CreditWHTAmt; //VAH
                                MatchAcc := true;
                            end;
                            Line := Line + 1;
                        end;
                        //CreditTotalLCY := CreditTotalLCY + CreditAmount[Number];//VAH
                        CreditTotalLCY := CreditTotalLCY - CreditAmount[Number]; //VAH
                    end;

                    trigger OnPreDataItem()
                    begin
                        I := 0;
                        MatchAcc := false;
                        repeat
                            I := I + 1;
                            if (CreditAccNo[I] = BankAccNo) and (CreditAmount[I] <> 0) then begin
                                //CreditAmount[I] := CreditAmount[I] + CreditWHTAmt;//VAH
                                CreditAmount[I] := CreditAmount[I] - CreditWHTAmt; //VAH
                                MatchAcc := true;
                            end;
                        until (I >= 300) or MatchAcc;
                    end;
                }
                dataitem(LineLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                    column(TextAmount1; TextAmount[1])
                    {
                    }
                    column(Number_LineLoop; LineLoop.Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if CntLine + Line + Number > 9 then
                            CurrReport.Break;
                    end;

                    trigger OnPreDataItem()
                    begin
                        /*GenJnlLine3.COPY("Gen. Journal Line");
                        IF GenJnlLine3.NEXT <> 0 THEN
                        IF (GenJnlLine3."Document No." = GenJnlLine2."Document No.") THEN
                          CurrReport.BREAK;  */
                        if CurrReport.PageNo = 1 then
                            LineSpace := 15
                        else
                            LineSpace := 25;
                    end;
                }
            }
            trigger OnAfterGetRecord()
            var
                Vend: Record Vendor;
                VendCode: Code[20];
            begin
                if Vend.get("Gen. Journal Line"."Account No.") then VendCode := Vend."No.";
                if "Document No." = GenJnlLine."Document No." then
                    CurrReport.Skip
                else
                    GenJnlLine := "Gen. Journal Line";
                clear(CntLine);//VAH
                Clear(Line);//VAH
                if "Gen. Journal Line"."Currency Code" <> '' then
                    CurrCode := "Gen. Journal Line"."Currency Code"
                else begin
                    GeneralLedgerSetup.Get;
                    CurrCode := GeneralLedgerSetup."LCY Code";
                end;
                if "Gen. Journal Line"."Currency Code" <> '' then begin
                    if Currency.get("Gen. Journal Line"."Currency Code") then
                        TtoalCurrCode := Currency.Description
                    else
                        TtoalCurrCode := "Gen. Journal Line"."Currency Code";
                end
                else begin
                    GeneralLedgerSetup.Get;
                    TtoalCurrCode := GeneralLedgerSetup."Local Currency Description";
                end;
                LanguageCaption.Reset();
                LanguageCaption.SetRange("Report ID", 50503);
                LanguageCaption.SetRange("Caption Code", 'TaxID');
                if LanguageCaption.FindFirst() then CaptionTaxID := LanguageCaption."Caption in Thai";
                Clear(DebitAccNo);
                Clear(DebitAccName);
                Clear(DebitDimValue);
                Clear(DebitVATDimValue);
                Clear(DebitAmount);
                Clear(CreditAccNo);
                Clear(CreditAccName);
                Clear(CreditDimValue);
                Clear(CreditVATDimValue);
                Clear(CreditAmount);
                Clear(BankAccNo);
                Clear(WHTAmt);
                Clear(CreditWHTAmt);
                Clear(DebitVATNo);
                Clear(CreditVATNo);
                Clear(DebitVATName);
                Clear(CreditVATName);
                Clear(DebitVATAmt);
                Clear(CreditVATAmt);
                Clear(WHTAmtHeader);
                //CLEAR(DocNoFilter);
                //CLEAR(DocNoFilter2);
                SkipWHT := false; //KKE : #004
                CntLine := 0;
                Clear(VendLedgerEntrybuffer);
                GenJnlLine2.Reset;
                GenJnlLine2.SetCurrentkey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "Shortcut Dimension 1 Code");
                GenJnlLine2.SetRange("Journal Template Name", "Journal Template Name");
                GenJnlLine2.SetRange("Journal Batch Name", "Journal Batch Name");
                GenJnlLine2.SetRange("Document No.", "Document No.");
                if GenJnlLine2.Find('-') then
                    repeat
                        with GenJnlLine2 do begin
                            //KKE : #004 +
                            if "Skip WHT" then SkipWHT := true;
                            //KKE : #004 -
                            if "Debit Amount" <> 0 then begin
                                //xxx +
                                Clear(VATAccount);
                                Clear(VATAmount);
                                //xxx -
                                Clear(DebitAccount);
                                case "Account Type" of
                                    "account type"::"G/L Account":
                                        begin
                                            DebitAccount := "Account No.";
                                            //xxx +
                                            if VATPostSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then begin
                                                VATAccount := VATPostSetup."Purchase VAT Account";
                                                //VATAmount := ROUND(VATPostSetup."VAT %" * (100 + VATPostSetup."VAT %") / "Debit Amount");
                                                VATAmount := ROUND(VATPostSetup."VAT %" * "Debit Amount" / (100 + VATPostSetup."VAT %"));
                                            end;
                                            //xxx -
                                        end;
                                    "account type"::Customer:
                                        begin
                                            CustPostingGroup.Get("Posting Group");
                                            DebitAccount := CustPostingGroup."Receivables Account";
                                        end;
                                    "account type"::Vendor:
                                        begin
                                            VendPostingGroup.Get("Posting Group");
                                            DebitAccount := VendPostingGroup."Payables Account";
                                        end;
                                    "account type"::"Bank Account":
                                        begin
                                            BankAcc.Get("Account No.");
                                            BankAccPostingGroup.Get(BankAcc."Bank Acc. Posting Group");
                                            DebitAccount := BankAccPostingGroup."G/L Bank Account No.";
                                        end;
                                end;
                                I := 0;
                                MatchAcc := false;
                                repeat
                                    I := I + 1;
                                    if ((DebitAccNo[I] = DebitAccount)) //AND (DebitDimValue[I] = "Shortcut Dimension 1 Code"))
 or (DebitAccNo[I] = '') then begin
                                        DebitAccNo[I] := DebitAccount;
                                        GLAcc.Get(DebitAccNo[I]);
                                        DebitAccName[I] := GLAcc.Name;
                                        DebitAccNo[I] := GLAcc."No."; //VAH
                                        DebitAmount[I] := DebitAmount[I] + Abs("Amount (LCY)");
                                        DebitDimValue[I] := "Shortcut Dimension 1 Code";
                                        MatchAcc := true;
                                        //xxx +
                                        if VATAccount <> '' then begin
                                            DebitAmount[I] := DebitAmount[I] - VATAmount;
                                            GLAcc.Get(VATAccount);
                                            DebitVATName[I] := GLAcc.Name;
                                            DebitVATNo[I] := VATAccount;
                                            DebitVATAmt[I] += VATAmount;
                                        end;
                                        //xxx -
                                    end;
                                until (I >= 300) or MatchAcc;
                                if "Bal. Account No." <> '' then begin
                                    //xxx +
                                    Clear(VATAccount);
                                    Clear(VATAmount);
                                    //xxx -
                                    Clear(CreditAccount);
                                    case "Bal. Account Type" of
                                        "bal. account type"::"G/L Account":
                                            begin
                                                CreditAccount := "Bal. Account No.";
                                                //xxx +
                                                if VATPostSetup.Get("Bal. VAT Bus. Posting Group", "Bal. VAT Prod. Posting Group") then begin
                                                    VATAccount := VATPostSetup."Purchase VAT Account";
                                                    //VATAmount := ROUND(VATPostSetup."VAT %" * (100 + VATPostSetup."VAT %") / "Debit Amount");
                                                    VATAmount := ROUND(VATPostSetup."VAT %" * "Debit Amount" / (100 + VATPostSetup."VAT %"));
                                                end;
                                                //xxx -
                                            end;
                                        "bal. account type"::Customer:
                                            begin
                                                CustPostingGroup.Get("Posting Group");
                                                CreditAccount := CustPostingGroup."Receivables Account";
                                            end;
                                        "bal. account type"::Vendor:
                                            begin
                                                VendPostingGroup.Get("Posting Group");
                                                CreditAccount := VendPostingGroup."Payables Account";
                                            end;
                                        "bal. account type"::"Bank Account":
                                            begin
                                                BankAcc.Get("Bal. Account No.");
                                                BankAccPostingGroup.Get(BankAcc."Bank Acc. Posting Group");
                                                CreditAccount := BankAccPostingGroup."G/L Bank Account No.";
                                            end;
                                    end;
                                    I := 0;
                                    MatchAcc := false;
                                    repeat
                                        I := I + 1;
                                        if "Bal. Account Type" = "bal. account type"::"Bank Account" then begin
                                            if (CreditAccNo[I] = CreditAccount) or (CreditAccNo[I] = '') then begin
                                                CreditAccNo[I] := CreditAccount;
                                                GLAcc.Get(CreditAccNo[I]);
                                                CreditAccName[I] := GLAcc.Name;
                                                CreditAmount[I] := CreditAmount[I] + Abs("Amount (LCY)");
                                                BankAccNo := CreditAccount;
                                                MatchAcc := true;
                                            end;
                                        end
                                        else begin
                                            if ((CreditAccNo[I] = CreditAccount)) //AND (CreditDimValue[I] = "Shortcut Dimension 1 Code"))
 or (CreditAccNo[I] = '') then begin
                                                CreditAccNo[I] := CreditAccount;
                                                GLAcc.Get(CreditAccNo[I]);
                                                CreditAccName[I] := GLAcc.Name;
                                                CreditAmount[I] := CreditAmount[I] + Abs("Amount (LCY)");
                                                BankAccNo := CreditAccount;
                                                CreditDimValue[I] := "Shortcut Dimension 1 Code";
                                                MatchAcc := true;
                                                //xxx +
                                                if VATAccount <> '' then begin
                                                    CreditAmount[I] := CreditAmount[I] - VATAmount;
                                                    GLAcc.Get(VATAccount);
                                                    CreditVATName[I] := GLAcc.Name;
                                                    CreditVATNo[I] := VATAccount;
                                                    CreditVATAmt[I] += VATAmount;
                                                end;
                                                //xxx -
                                            end;
                                        end;
                                    until (I >= 300) or MatchAcc;
                                end;
                            end
                            else
                                if "Credit Amount" <> 0 then begin
                                    //xxx +
                                    Clear(VATAccount);
                                    Clear(VATAmount);
                                    //xxx -
                                    Clear(CreditAccount);
                                    case "Account Type" of
                                        "account type"::"G/L Account":
                                            begin
                                                CreditAccount := "Account No.";
                                                //xxx +
                                                if VATPostSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then begin
                                                    VATAccount := VATPostSetup."Purchase VAT Account";
                                                    //VATAmount := ROUND(VATPostSetup."VAT %" * (100 + VATPostSetup."VAT %") / "Credit Amount");
                                                    VATAmount := ROUND(VATPostSetup."VAT %" * "Credit Amount" / (100 + VATPostSetup."VAT %"));
                                                end;
                                                //xxx -
                                            end;
                                        "account type"::Customer:
                                            begin
                                                CustPostingGroup.Get("Posting Group");
                                                CreditAccount := CustPostingGroup."Receivables Account";
                                            end;
                                        "account type"::Vendor:
                                            begin
                                                VendPostingGroup.Get("Posting Group");
                                                CreditAccount := VendPostingGroup."Payables Account";
                                                // DebitAccount := VendPostingGroup."Payables Account"; //vvv
                                            end;
                                        "account type"::"Bank Account":
                                            begin
                                                BankAcc.Get("Account No.");
                                                BankAccPostingGroup.Get(BankAcc."Bank Acc. Posting Group");
                                                CreditAccount := BankAccPostingGroup."G/L Bank Account No.";
                                            end;
                                    end;
                                    I := 0;
                                    MatchAcc := false;
                                    /*
                                    REPEAT
                                      I := I + 1;
                                      IF ((DebitAccNo[I] = DebitAccount)) //AND (DebitDimValue[I] = "Shortcut Dimension 1 Code"))
                                         OR (DebitAccNo[I] = '')
                                      THEN BEGIN
                                        DebitAccNo[I] := DebitAccount;
                                        GLAcc.GET(DebitAccNo[I]);
                                        DebitAccName[I] := GLAcc.Name;
                                        DebitAmount[I] := DebitAmount[I] - ABS("Amount (LCY)");
                                        DebitDimValue[I] := "Shortcut Dimension 1 Code";
                                        MatchAcc := TRUE;
                                        //xxx +
                                        IF VATAccount <> '' THEN BEGIN
                                          CreditAmount[I] := CreditAmount[I] - VATAmount;
                                          GLAcc.GET(VATAccount);
                                          CreditVATName[I] := GLAcc.Name;
                                          CreditVATNo[I] := VATAccount;
                                          CreditVATAmt[I] += VATAmount;
                                        END;
                                        //xxx -
                                      END;
                                    UNTIL (I>=300) OR MatchAcc;
                                    */
                                    //{
                                    repeat
                                        I := I + 1;
                                        if ((CreditAccNo[I] = CreditAccount)) //AND (CreditDimValue[I] = "Shortcut Dimension 1 Code"))
 or (CreditAccNo[I] = '') then begin
                                            CreditAccNo[I] := CreditAccount;
                                            GLAcc.Get(CreditAccNo[I]);
                                            CreditAccName[I] := GLAcc.Name;
                                            CreditAmount[I] := CreditAmount[I] + Abs("Amount (LCY)");
                                            CreditDimValue[I] := "Shortcut Dimension 1 Code";
                                            MatchAcc := true;
                                            //xxx +
                                            if VATAccount <> '' then begin
                                                CreditAmount[I] := CreditAmount[I] - VATAmount;
                                                GLAcc.Get(VATAccount);
                                                CreditVATName[I] := GLAcc.Name;
                                                CreditVATNo[I] := VATAccount;
                                                CreditVATAmt[I] += VATAmount;
                                            end;
                                            //xxx -
                                        end;
                                    until (I >= 300) or MatchAcc;
                                    //}
                                    if "Bal. Account No." <> '' then begin
                                        //xxx +
                                        Clear(VATAccount);
                                        Clear(VATAmount);
                                        //xxx -
                                        Clear(DebitAccount);
                                        case "Bal. Account Type" of
                                            "bal. account type"::"G/L Account":
                                                begin
                                                    DebitAccount := "Bal. Account No.";
                                                    //xxx +
                                                    if VATPostSetup.Get("Bal. VAT Bus. Posting Group", "Bal. VAT Prod. Posting Group") then begin
                                                        VATAccount := VATPostSetup."Purchase VAT Account";
                                                        //VATAmount := ROUND(VATPostSetup."VAT %" * (100 + VATPostSetup."VAT %") / "Credit Amount");
                                                        VATAmount := ROUND(VATPostSetup."VAT %" * "Credit Amount" / (100 + VATPostSetup."VAT %"));
                                                    end;
                                                    //xxx -
                                                end;
                                            "bal. account type"::Customer:
                                                begin
                                                    CustPostingGroup.Get("Posting Group");
                                                    DebitAccount := CustPostingGroup."Receivables Account";
                                                end;
                                            "bal. account type"::Vendor:
                                                begin
                                                    VendPostingGroup.Get("Posting Group");
                                                    DebitAccount := VendPostingGroup."Payables Account";
                                                end;
                                            "bal. account type"::"Bank Account":
                                                begin
                                                    BankAcc.Get("Bal. Account No.");
                                                    BankAccPostingGroup.Get(BankAcc."Bank Acc. Posting Group");
                                                    DebitAccount := BankAccPostingGroup."G/L Bank Account No.";
                                                end;
                                        end;
                                        I := 0;
                                        MatchAcc := false;
                                        repeat
                                            I := I + 1;
                                            if ((CreditAccNo[I] = DebitAccount)) //AND (CreditDimValue[I] = "Shortcut Dimension 1 Code"))
 or (CreditAccNo[I] = '') then begin
                                                CreditAccNo[I] := DebitAccount;
                                                GLAcc.Get(CreditAccNo[I]);
                                                CreditAccName[I] := GLAcc.Name;
                                                CreditAmount[I] := CreditAmount[I] - Abs("Amount (LCY)") + VATAmount; //xxx
                                                CreditDimValue[I] := "Shortcut Dimension 1 Code";
                                                MatchAcc := true;
                                            end;
                                        until (I >= 300) or MatchAcc;
                                        //xxx +
                                        if MatchAcc and (VATAccount <> '') then begin
                                            I := 0;
                                            MatchAcc := false;
                                            repeat
                                                I := I + 1;
                                                if (DebitVATNo[I] = VATAccount) or (DebitVATNo[I] = '') then begin
                                                    GLAcc.Get(VATAccount);
                                                    DebitVATName[I] := GLAcc.Name;
                                                    DebitVATNo[I] := VATAccount;
                                                    DebitVATAmt[I] += VATAmount;
                                                    MatchAcc := true;
                                                end;
                                            until (I >= 300) or MatchAcc;
                                        end;
                                        //xxx -
                                    end;
                                end;
                            if ("Applies-to Doc. No." <> '') or ("Applies-to ID" <> '') then begin
                                WHTEntry.Reset;
                                WHTEntry.SetCurrentkey("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.");
                                if "Applies-to Doc. Type" = "applies-to doc. type"::Invoice then WHTEntry.SetRange("Document Type", WHTEntry."document type"::Invoice);
                                if "Applies-to Doc. Type" = "applies-to doc. type"::"Credit Memo" then WHTEntry.SetRange("Document Type", WHTEntry."document type"::"Credit Memo");
                                //WHTEntry.SETRANGE("Document No.","Applies-to Doc. No.");
                                if "Applies-to Doc. No." <> '' then
                                    WHTEntry.SetRange("Document No.", "Applies-to Doc. No.")
                                else begin
                                    if "Applies-to ID" <> '' then begin
                                        /*---
                                        VendLedgEntry.RESET;
                                        VendLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
                                        IF VendLedgEntry.FIND('-') THEN
                                        REPEAT
                                          IF DocNoFilter = '' THEN
                                            DocNoFilter := VendLedgEntry."Document No."
                                          ELSE BEGIN
                                            IF STRLEN(DocNoFilter + '|' + VendLedgEntry."Document No.") <= 250 THEN
                                              DocNoFilter := DocNoFilter + '|' + VendLedgEntry."Document No."
                                            ELSE
                                              DocNoFilter2 := DocNoFilter2 + '|' + VendLedgEntry."Document No.";
                                          END;
                                        UNTIL VendLedgEntry.NEXT=0;
                                        IF DocNoFilter <> '' THEN BEGIN
                                          IF DocNoFilter2 = '' THEN
                                            WHTEntry.SETFILTER("Document No.",DocNoFilter)
                                          ELSE
                                            WHTEntry.SETFILTER("Document No.",'%1|%2',DocNoFilter,DocNoFilter2);
                                        END;
                                        ---*/
                                        WHTEntry.SetFilter("Applies-to ID", "Applies-to ID"); //KKE : #003
                                    end;
                                    if "Account Type" = "account type"::Vendor then
                                        WHTEntry.SetRange("Bill-to/Pay-to No.", "Account No.")
                                    else
                                        if "Bal. Account Type" = "bal. account type"::Vendor then WHTEntry.SetRange("Bill-to/Pay-to No.", "Bal. Account No.");
                                end;
                                if WHTEntry.Find('-') then
                                    repeat
                                        if WHTPostingSetup.Get(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group") then begin
                                            if GLAcc.Get(WHTPostingSetup."Payable WHT Account Code") then begin //GKU : #005
                                                WHTAccountNo := WHTPostingSetup."Payable WHT Account Code";
                                                WHTAccountName := GLAcc.Name;
                                            end;
                                        end;
                                    /*PayPer := 0;
                                    IF WHTEntry."Base Amount Inc. VAT (LCY)" <> 0 THEN
                                      PayPer := ABS("Amount (LCY)"/ WHTEntry."Base Amount Inc. VAT (LCY)");
                                    IF PayPer > 1 THEN
                                      PayPer := 1;
                                    //CreditWHTAmt := CreditWHTAmt + -(WHTEntry."WHT Amount (LCY)" * PayPer);
                                    */
                                    until WHTEntry.Next = 0;
                                if "WHT Payment" then begin
                                    if "Account Type" = "account type"::Customer then begin
                                        CustLedgEntry.Reset;
                                        CustLedgEntry.SetCurrentkey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                                        CustLedgEntry.SetRange("Customer No.", "Account No.");
                                        if "Applies-to ID" <> '' then CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                                        if ("Applies-to Doc. Type" <> 0) and ("Applies-to Doc. No." <> '') then begin
                                            CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                                            CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                                        end;
                                        if CustLedgEntry.Find('-') then begin
                                            SalesInvLine.Reset;
                                            SalesInvLine.SetRange("Document No.", CustLedgEntry."Document No.");
                                            SalesInvLine.SetFilter("WHT Product Posting Group", '<>%1', '');
                                            if SalesInvLine.Find('-') then
                                                if WHTPostingSetup.Get(SalesInvLine."WHT Business Posting Group", SalesInvLine."WHT Product Posting Group") then begin
                                                    WHTAccountNo := WHTPostingSetup."Prepaid WHT Account Code";
                                                    if GLAcc.Get(WHTAccountNo) then WHTAccountName := GLAcc.Name;
                                                end;
                                        end;
                                    end
                                    else
                                        if "bal. account type"::Customer = "bal. account type"::Customer then begin
                                            CustLedgEntry.Reset;
                                            CustLedgEntry.SetCurrentkey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                                            CustLedgEntry.SetRange("Customer No.", "Bal. Account No.");
                                            if "Applies-to ID" <> '' then CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                                            if ("Applies-to Doc. Type" <> 0) and ("Applies-to Doc. No." <> '') then begin
                                                CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                                                CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                                            end;
                                            if CustLedgEntry.Find('-') then begin
                                                SalesInvLine.Reset;
                                                SalesInvLine.SetRange("Document No.", CustLedgEntry."Document No.");
                                                SalesInvLine.SetFilter("WHT Product Posting Group", '<>%1', '');
                                                if SalesInvLine.Find('-') then
                                                    if WHTPostingSetup.Get(SalesInvLine."WHT Business Posting Group", SalesInvLine."WHT Product Posting Group") then begin
                                                        WHTAccountNo := WHTPostingSetup."Prepaid WHT Account Code";
                                                        if GLAcc.Get(WHTAccountNo) then WHTAccountName := GLAcc.Name;
                                                    end;
                                            end;
                                        end;
                                    WHTAmt := Abs(Amount);
                                    //WHTAmtHeader := Abs(Amount); //VAH
                                end;
                                //CreditWHTAmt := CreditWHTAmt + ABS(WHTManagement.WHTAmountJournal(GenJnlLine2,FALSE));
                                Clear(WHTManagement);
                                GenJnlLine3 := GenJnlLine2;
                                GenJnlLine3.Validate(Amount, -GenJnlLine3.Amount);
                                CreditWHTAmt := CreditWHTAmt + WHTManagement.WHTAmountJournal(GenJnlLine3, false);
                            end;
                            // Unrealize VAT
                            //KKE +
                            ApplyCreditAmount := 0;
                            ApplyInvoiceAmount := 0;
                            if "Applies-to ID" <> '' then begin
                                VendLedgEntry.Reset;
                                VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                                VendLedgEntry.SetRange("Document Type", VendLedgEntry."document type"::"Credit Memo");
                                if VendLedgEntry.Find('-') then
                                    repeat
                                        VendLedgEntry.CalcFields("Amount (LCY)", "Remaining Amt. (LCY)");
                                        ApplyCreditAmount := ApplyCreditAmount + VendLedgEntry."Remaining Amt. (LCY)";
                                    until VendLedgEntry.Next = 0;
                                VendLedgEntry.Reset;
                                VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                                VendLedgEntry.SetFilter("Document Type", '<>%1', VendLedgEntry."document type"::"Credit Memo");
                                if VendLedgEntry.Find('-') then
                                    repeat
                                        VendLedgEntry.CalcFields("Amount (LCY)", "Remaining Amt. (LCY)");
                                        ApplyInvoiceAmount := ApplyInvoiceAmount + VendLedgEntry."Remaining Amt. (LCY)";
                                    until VendLedgEntry.Next = 0;
                            end;
                            if (ApplyInvoiceAmount <> 0) and (ApplyCreditAmount <> 0) then
                                PaymentAmount := Abs("Amount (LCY)") + ApplyCreditAmount
                            else
                                PaymentAmount := "Amount (LCY)";
                            //KKE -
                            if ("Applies-to Doc. No." <> '') or ("Applies-to ID" <> '') then begin
                                VendLedgEntry.Reset;
                                if "Applies-to Doc. No." <> '' then
                                    VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.")
                                else
                                    if "Applies-to ID" <> '' then VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                                if VendLedgEntry.Find('-') then
                                    repeat
                                        PayPer := 0;
                                        VendLedgEntry.CalcFields("Amount (LCY)", "Remaining Amt. (LCY)", "Remaining Amount");
                                        if VendLedgEntry."Remaining Amt. (LCY)" <> 0 then
                                            if VendLedgEntry."Amount to Apply" <> VendLedgEntry."Remaining Amount" then begin
                                                g_intPatial := 9;
                                                g_decRatioPatial := VendLedgEntry."Amount to Apply" / VendLedgEntry."Remaining Amount";
                                                PayPer := VendLedgEntry."Amount to Apply" / VendLedgEntry."Remaining Amount";
                                            end
                                            else
                                                PayPer := Abs(PaymentAmount / VendLedgEntry."Remaining Amt. (LCY)");
                                        if PayPer > 1 then PayPer := 1;
                                        //VAT unrealize for applied entry  ESG-19.02.04 Start
                                        DebitAppliedVATAmt := 0;
                                        CreditAppliedVATAmt := 0;
                                        if VendLedgEntry."Amount (LCY)" <> VendLedgEntry."Remaining Amt. (LCY)" then begin
                                            VendLedgEntry2.Reset;
                                            VendLedgEntry2.SetCurrentkey("Closed by Entry No.");
                                            VendLedgEntry2.SetRange("Closed by Entry No.", VendLedgEntry."Entry No.");
                                            if VendLedgEntry2.Find('-') then
                                                repeat
                                                    VATEntry.Reset;
                                                    VATEntry.SetCurrentkey("Document No.", "Posting Date");
                                                    VATEntry.SetRange("Posting Date", VendLedgEntry2."Posting Date");
                                                    VATEntry.SetRange("Document No.", VendLedgEntry2."Document No.");
                                                    VATEntry.SetFilter("Remaining Unrealized Amount", '<>0');
                                                    if VATEntry.Find('-') then
                                                        repeat
                                                            DebitAppliedVATAmt := DebitAppliedVATAmt + VATEntry."Remaining Unrealized Amount";
                                                            CreditAppliedVATAmt := CreditAppliedVATAmt + VATEntry."Remaining Unrealized Amount";
                                                        until VATEntry.Next = 0;
                                                until VendLedgEntry2.Next = 0;
                                        end;
                                        //VAT unrealize for applied entry  ESG-19.02.04 End.
                                        VATEntry.Reset;
                                        VATEntry.SetCurrentkey("Document No.", "Posting Date");
                                        VATEntry.SetRange("Posting Date", VendLedgEntry."Posting Date");
                                        VATEntry.SetRange("Document No.", VendLedgEntry."Document No.");
                                        VATEntry.SetFilter("Remaining Unrealized Amount", '<>0');
                                        if VATEntry.Find('-') then
                                            repeat
                                                VATPostSetup.Get(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group");
                                                DebitAccount := VATPostSetup."Purchase VAT Account";
                                                CreditAccount := VATPostSetup."Purch. VAT Unreal. Account";
                                                I := 0;
                                                MatchAcc := false;
                                                repeat
                                                    I := I + 1;
                                                    if ((DebitVATNo[I] = DebitAccount)) //AND (DebitVATDimValue[I] = "Shortcut Dimension 1 Code"))
 or (DebitVATNo[I] = '') then begin
                                                        DebitVATNo[I] := DebitAccount;
                                                        GLAcc.Get(DebitVATNo[I]);
                                                        DebitVATName[I] := GLAcc.Name;
                                                        /*---
                                                         IF g_intPatial = 9 THEN
                                                           DebitVATAmt[I] := DebitVATAmt[I] +
                                                                (VATEntry."Remaining Unrealized Amount" + DebitAppliedVATAmt) * g_decRatioPatial
                                                         ELSE
                                                         ---*/
                                                        DebitVATAmt[I] := DebitVATAmt[I] + (VATEntry."Remaining Unrealized Amount" + DebitAppliedVATAmt) * PayPer;
                                                        DebitAppliedVATAmt := 0;
                                                        DebitVATDimValue[I] := "Shortcut Dimension 1 Code";
                                                        MatchAcc := true;
                                                    end;
                                                    if ((CreditVATNo[I] = CreditAccount)) //AND (CreditVATDimValue[I] = "Shortcut Dimension 1 Code"))
 or (CreditVATNo[I] = '') then begin
                                                        CreditVATNo[I] := CreditAccount;
                                                        GLAcc.Get(CreditVATNo[I]);
                                                        CreditVATName[I] := GLAcc.Name;
                                                        /*---
                                                        IF g_intPatial = 9 THEN
                                                          CreditVATAmt[I] := CreditVATAmt[I] +
                                                              (VATEntry."Remaining Unrealized Amount" + CreditAppliedVATAmt) * g_decRatioPatial
                                                        ELSE
                                                        ---*/
                                                        CreditVATAmt[I] := CreditVATAmt[I] + (VATEntry."Remaining Unrealized Amount" + CreditAppliedVATAmt) * PayPer;
                                                        CreditAppliedVATAmt := 0;
                                                        CreditVATDimValue[I] := "Shortcut Dimension 1 Code";
                                                        MatchAcc := true;
                                                    end;
                                                until (I >= 300) or MatchAcc;
                                            until VATEntry.Next = 0;
                                    until VendLedgEntry.Next = 0;
                            end;
                            //Applies to ID
                            if "Applies-to ID" <> '' then begin
                                VendLedgerEntry.Reset;
                                VendLedgerEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                                if "Account Type" = "account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", "Account No.");
                                if "Bal. Account Type" = "bal. account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", "Bal. Account No.");
                                VendLedgerEntry.SetRange("Applies-to ID", "Applies-to ID");
                                if VendLedgerEntry.Find('-') then
                                    repeat
                                        VendLedgerEntrybuffer := VendLedgerEntry;
                                        VendLedgerEntrybuffer.Mark(true);
                                    //>>VAH WHT
                                    /* WHTEntryNew.Reset();
                                     WHTEntryNew.SetRange("Document No.", VendLedgerEntry."Document No.");
                                     WHTEntrynew.SetRange("Document Type", VendLedgEntry."Document Type");
                                     if WHTEntryNew.FindFirst() then
                                         WHTAmtHeader += WHTEntryNew."Rem Realized Amount (LCY)";*/
                                    //<< VAH WHT
                                    until VendLedgerEntry.Next = 0;
                            end;
                            //Clear(WHTAmtHeader);//VAH WHT
                            //Apply to Doc no.
                            if "Applies-to Doc. No." <> '' then begin
                                VendLedgerEntry.Reset;
                                VendLedgerEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                                if "Account Type" = "account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", "Account No.");
                                if "Bal. Account Type" = "bal. account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", "Bal. Account No.");
                                VendLedgerEntry.SetRange("Document Type", "Applies-to Doc. Type");
                                VendLedgerEntry.SetRange("Document No.", "Applies-to Doc. No.");
                                if VendLedgerEntry.Find('-') then
                                    repeat
                                        VendLedgerEntrybuffer := VendLedgerEntry;
                                        VendLedgerEntrybuffer.Mark(true);
                                    //>>VAH WHT
                                    /*WHTEntryNew.Reset();
                                    WHTEntryNew.SetRange("Document No.", VendLedgerEntry."Document No.");
                                    WHTEntrynew.SetRange("Document Type", VendLedgEntry."Document Type");
                                    if WHTEntryNew.FindFirst() then
                                        WHTAmtHeader += WHTEntryNew."Rem Realized Amount (LCY)";*/
                                    //<< VAH WHT
                                    until VendLedgerEntry.Next = 0;
                            end;
                        end;
                        CalculateWHTAmt;
                    until GenJnlLine2.Next = 0;
                if "Check Printed" then begin
                    DocumentNo := "External Document No.";
                    CheckNo := "Document No.";
                    CheckDate := "Posting Date";
                end
                else begin
                    DocumentNo := "Document No.";
                    CheckNo := StartingChequeNo;
                    CheckDate := 0D;
                    if StartingChequeNo <> '' then CheckDate := "Posting Date";
                end;
                //group header
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
                            if (xGenJnlLine."Account Type" = xGenJnlLine."account type"::Vendor) or (xGenJnlLine."Bal. Account Type" = xGenJnlLine."bal. account type"::Vendor) then begin
                                if not Vendor.Get(xGenJnlLine."Account No.") then if not Vendor.Get(xGenJnlLine."Bal. Account No.") then Clear(Vendor);
                                if Vendor."Name (Thai)" <> '' then
                                    VendName := Vendor."Name (Thai)"
                                else
                                    VendName := Vendor."No." + ' ' + Vendor.Name + Vendor."Name 2";
                                PayeeName := "Payee Name";
                                //Message('1' + Vendor."No.");

                            end
                            else begin
                                VendName := "Payee Name";
                                PayeeName := "Payee Name";
                                //Message('2' + Vendor."No.");
                            end;
                            if xGenJnlLine."Account Type" = xGenJnlLine."account type"::"Bank Account" then begin
                                BankName := xGenJnlLine."Account No.";
                                BankAcc.Get(xGenJnlLine."Account No.");
                                BankBranch := BankAcc."Bank Branch No.";
                            end;
                            if xGenJnlLine."Bal. Account Type" = xGenJnlLine."bal. account type"::"Bank Account" then begin
                                BankName := xGenJnlLine."Bal. Account No.";
                                BankAcc.Get(xGenJnlLine."Bal. Account No.");
                                BankBranch := BankAcc."Bank Branch No.";
                            end;
                        end;
                    until xGenJnlLine.Next = 0;
                    if DebitAmt = 0 then
                        TotalAmt := CreditAmt - CreditWHTAmt + WHTAmt //VAH reverse sign of CreditWHTAmt 
                    else
                        TotalAmt := (DebitAmt - CreditAmt) - CreditWHTAmt + WHTAmt; //VAH reverse sign of CreditWHTAmt
                    DebitAmt := 0;
                    CreditAmt := 0;
                end;
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(TextAmount, Abs(TotalAmt), "Currency Code");
                if TextAmount[1] <> '' then TextAmount[1] := Format(Abs(TotalAmt), 0, '<Precision,2:2><Standard Format,0>') + '   (' + TextAmount[1] + ' ' + TtoalCurrCode + ')';
                //group footer
                // CheckReport.InitTextVariable;
                // CheckReport.FormatNoText(TextAmount,ABS(DebitTotalLCY),"Currency Code");
                //
                // IF TextAmount[1] <> '' THEN
                //  TextAmount[1] := '(' + TextAmount[1] + ')';
            end;

            trigger OnPreDataItem()
            begin
                SetLanguageCaption;//VR
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
                    if TaxIDThai <> '' then
                        CompanyAddr[8] := TaxIDThai + ' ' + CompanyInfo."VAT Registration No.";
                end;
                CompressArray(CompanyAddr);
                //VR

                if "Gen. Journal Line"."Currency Code" <> '' then
                    CurrCode := "Gen. Journal Line"."Currency Code"
                else begin
                    GeneralLedgerSetup.Get;
                    CurrCode := GeneralLedgerSetup."LCY Code";
                end;
                if "Gen. Journal Line"."Currency Code" <> '' then begin
                    if Currency.get("Gen. Journal Line"."Currency Code") then
                        TtoalCurrCode := Currency.Description
                    else
                        TtoalCurrCode := "Gen. Journal Line"."Currency Code";
                end
                else begin
                    GeneralLedgerSetup.Get;
                    TtoalCurrCode := GeneralLedgerSetup."Local Currency Description";
                end;
                case true of
                    Cash:
                        xCash := 'P';
                    Cheque:
                        xCheque := 'P';
                end;
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
        CompanyInfo.Get;
    end;

    trigger OnPreReport()
    begin
        DebitTotalLCY := 0;
        CreditTotalLCY := 0;
        //KKE : #006 +
        VendEntryEdit.ResetAppliestoIDOnCloseEntry;
        Clear(VendEntryEdit);
        //KKE : #006 -
    end;

    local procedure CalculateWHTAmt()
    var
        myInt: Integer;
    begin
        with GenJnlLine2 do begin
            if "Applies-to ID" <> '' then begin
                VendLedgerEntry.Reset;
                VendLedgerEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                if "Account Type" = "account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", "Account No.");
                if "Bal. Account Type" = "bal. account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", "Bal. Account No.");
                VendLedgerEntry.SetRange("Applies-to ID", "Applies-to ID");
                if VendLedgerEntry.Find('-') then
                    repeat
                        VendLedgerEntrybuffer := VendLedgerEntry;
                        VendLedgerEntrybuffer.Mark(true);
                        //>>VAH WHT
                        WHTEntryNew.Reset();
                        WHTEntryNew.SetRange("Document No.", VendLedgerEntry."Document No.");
                        WHTEntrynew.SetRange("Document Type", VendLedgEntry."Document Type");
                        WHTEntryNew.CalcSums("Rem Unrealized Amount (LCY)");
                        WHTAmtHeader += WHTEntryNew."Rem Unrealized Amount (LCY)";
                    //if WHTEntryNew.FindFirst() then WHTAmtHeader += WHTEntryNew."Rem Unrealized Amount (LCY)";
                    //<< VAH WHT
                    until VendLedgerEntry.Next = 0;
            end;
            //Clear(WHTAmtHeader);//VAH WHT
            //Apply to Doc no.
            if "Applies-to Doc. No." <> '' then begin
                VendLedgerEntry.Reset;
                VendLedgerEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                if "Account Type" = "account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", "Account No.");
                if "Bal. Account Type" = "bal. account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", "Bal. Account No.");
                VendLedgerEntry.SetRange("Document Type", "Applies-to Doc. Type");
                VendLedgerEntry.SetRange("Document No.", "Applies-to Doc. No.");
                if VendLedgerEntry.Find('-') then
                    repeat
                        VendLedgerEntrybuffer := VendLedgerEntry;
                        VendLedgerEntrybuffer.Mark(true);
                        //>>VAH WHT
                        WHTEntryNew.Reset();
                        WHTEntryNew.SetCurrentKey("Document Type", "Document No.");
                        WHTEntryNew.SetRange("Document No.", VendLedgerEntry."Document No.");
                        WHTEntrynew.SetRange("Document Type", VendLedgEntry."Document Type");
                        WHTEntryNew.CalcSums("Rem Unrealized Amount (LCY)");
                        WHTAmtHeader += WHTEntryNew."Rem Unrealized Amount (LCY)";
                    //if WHTEntryNew.FindFirst() then WHTAmtHeader += WHTEntryNew."Rem Unrealized Amount (LCY)";
                    //<< VAH WHT
                    until VendLedgerEntry.Next = 0;
            end;
        end;
    end;

    local procedure SetLanguageCaption()
    var
        LanguageCaption: Record "Language Caption";
    begin
        LanguageCaption.Reset();
        LanguageCaption.SetRange("Report ID", 50503);
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
        I: Integer;
        J: Integer;
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
        WHTEntryNew: Record "WHT Entry";
        CompanyAddr: array[8] of Text[250];
        TaxIDThai: Text;
}
