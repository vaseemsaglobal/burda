report 50505 "Account Payable Voucher"
{
    // 
    // 
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   14.09.2006   KKE   ;-New report 'Account Payable Voucher' (before posted).
    //                          -Show G/L entries related to cost of inventory. These entries are posted
    //                           automatically by the system when user does not input job code on purchase line.
    //                          -Account Payable for Credit memo need to show debit,credit g/l account correctly.
    // 002   08.12.2006   KKE   -For the Type = Item, The Purchase Account and Direct Cost Account is not showed.
    //                          -Add column Shortcut Dimension 2 Code (Department).
    // 003   25.09.2007   KKE   -add criteria to group data by description. (request by p'Nok)
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Account Payable Voucher Report1';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AccountPayableVoucher.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "Document Type", "No.";

            column(Document_Type; "Document Type")
            {
            }
            column(TotalCrAmount; TotalCrAmount)
            {
            }
            column(Purch_No; "No.")
            {
            }
            column(TotalDrAmount; TotalDrAmount)
            {
            }
            column(PurDetails; "Purchase Header"."Pay-to Vendor No." + ' ' + "Purchase Header"."Pay-to Name" + '' + "Purchase Header"."Pay-to Name 2")
            {
            }
            column(totalCurrCode; TtoalCurrCode)
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(VendName; vendor.Name + ' ' + Vendor."Name (Thai)")
            {
            }
            column(Description; Descriptionlbs)
            {
            }
            column(PayeeName; vendor."No." + ' ' + Vendor.Name)
            {
            }
            column(DocumentNo; "Purchase Header"."No.")
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
            column(LineAmountPay; "Purchase Header".Amount)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE(Type = FILTER(<> ' '));

                column(Description_ExternalDocumentNo; "Purchase Line".Description)
                {
                }
                column(VATAmtTmp; AbS("Purchase Line".Amount - "Amount Including VAT"))
                {
                }
                column(GoodService; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(total; "Purchase Line"."Direct Unit Cost" + AbS("Purchase Line".Amount - "Amount Including VAT"))
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
                        Type::Item:
                            BEGIN
                                GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                            END;
                        Type::"Fixed Asset":
                            BEGIN
                                FALedgEntry.INIT;
                                CASE "FA Posting Type" OF
                                    "FA Posting Type"::"Acquisition Cost":
                                        FALedgEntry."FA Posting Type" := FALedgEntry."FA Posting Type"::"Acquisition Cost";
                                END;
                                FALedgEntry."FA Posting Group" := "Posting Group";
                                AccountNo := FAGetGLAccNo.GetAccNo(FALedgEntry);
                            END;
                        ELSE
                            EXIT;
                    END;
                    IF NOT GLAcc.GET(AccountNo) THEN GLAcc.INIT;
                    ShortcutDim3Code := '';
                    ShortcutDim4Code := '';
                    ShortcutDim5Code := '';
                    i := 0;
                    MatchAcc := FALSE;
                    REPEAT
                        i := i + 1;
                        IF ((AccCode[i] = AccountNo) AND (AccName[i] = Description) AND //KKE : #003
 (Dimension1Code[i] = "Shortcut Dimension 1 Code") AND (Dimension2Code[i] = "Shortcut Dimension 2 Code") AND (Dimension3Code[i] = ShortcutDim3Code) AND (Dimension4Code[i] = ShortcutDim4Code) AND (Dimension5Code[i] = ShortcutDim5Code)) OR (AccCode[i] = '') THEN
                            MatchAcc := TRUE;
                    UNTIL (i = 27) OR MatchAcc;
                    AccCode[i] := AccountNo;
                    //AccName[i] := GLAcc.Name;
                    AccName[i] := Description; //KKE : #003
                    Dimension1Code[i] := "Shortcut Dimension 1 Code";
                    Dimension2Code[i] := "Shortcut Dimension 2 Code";
                    Dimension3Code[i] := ShortcutDim3Code;
                    Dimension4Code[i] := ShortcutDim4Code;
                    Dimension5Code[i] := ShortcutDim5Code;
                    /*
                    IF "Qty. to Invoice" = Quantity THEN
                      VATBaseAmt := "VAT Base Amount"
                    ELSE
                      VATBaseAmt := ROUND("VAT Base Amount" * "Qty. to Invoice" / Quantity);
                    */
                    //change code for rounding amount by using line discount - 20.03.2007
                    /*
                       IF "Qty. to Invoice" = Quantity THEN
                         VATBaseAmt := "VAT Base Amount" - "Line Discount Amount"
                       ELSE
                         VATBaseAmt := ROUND("VAT Base Amount" * "Qty. to Invoice" / Quantity) - "Line Discount Amount";
                       */
                    //29.03.2007
                    //KKE : xxx
                    IF "Avg. VAT Amount" <> 0 THEN BEGIN
                        IF "Qty. to Invoice" = Quantity THEN
                            VATBaseAmt := "Amount Including VAT" - "Avg. VAT Amount"
                        ELSE
                            VATBaseAmt := ROUND(("Amount Including VAT" - "Avg. VAT Amount") * "Qty. to Invoice" / Quantity);
                    END
                    ELSE BEGIN
                        //KKE : xxx
                        IF "Qty. to Invoice" = Quantity THEN
                            VATBaseAmt := Amount
                        ELSE
                            VATBaseAmt := ROUND(Amount * "Qty. to Invoice" / Quantity);
                    END;
                    //HKK : #002 +
                    /* Remark By KK
                    IF "Qty. to Invoice" * "Unit Cost (LCY)" >= 0 THEN
                      DrAmount[i] := DrAmount[i] + "Qty. to Invoice" * "Unit Cost (LCY)"
                    ELSE
                      CrAmount[i] := CrAmount[i] - "Qty. to Invoice" * "Unit Cost (LCY)";
                    */
                    IF AccountNo <> '' THEN BEGIN
                        IF VATBaseAmt >= 0 THEN
                            DrAmount[i] := DrAmount[i] + VATBaseAmt
                        ELSE
                            CrAmount[i] := CrAmount[i] - VATBaseAmt;
                    END;
                    //HKK : #002 -
                    // VAT
                    CLEAR(AccountNo);
                    VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                    IF VATPostingSetup."Purch. VAT Unreal. Account" <> '' THEN
                        AccountNo := VATPostingSetup."Purch. VAT Unreal. Account"
                    ELSE
                        AccountNo := VATPostingSetup."Purchase VAT Account";
                    IF NOT GLAcc.GET(AccountNo) THEN GLAcc.INIT;
                    i := 0;
                    MatchAcc := FALSE;
                    REPEAT
                        i := i + 1;
                        IF ((AccCode[i] = AccountNo) AND (Dimension1Code[i] = "Shortcut Dimension 1 Code") AND (Dimension2Code[i] = "Shortcut Dimension 2 Code") AND (Dimension3Code[i] = ShortcutDim3Code) AND (Dimension4Code[i] = ShortcutDim4Code) AND (Dimension5Code[i] = ShortcutDim5Code)) OR (AccCode[i] = '') THEN MatchAcc := TRUE;
                    UNTIL (i = 27) OR MatchAcc;
                    AccCode[i] := AccountNo;
                    // AccName[i] := GLAcc.Name;
                    AccName[i] := Description;
                    Dimension1Code[i] := "Shortcut Dimension 1 Code";
                    Dimension2Code[i] := "Shortcut Dimension 2 Code";
                    Dimension3Code[i] := ShortcutDim3Code;
                    Dimension4Code[i] := ShortcutDim4Code;
                    Dimension5Code[i] := ShortcutDim5Code;
                    //VATAmt := ROUND("Qty. to Invoice" * "Direct Unit Cost") * "VAT %" /100 + "VAT Difference";
                    //VATAmt := VATBaseAmt * "VAT %" /100 + "VAT Difference";
                    //KKE : xxx
                    IF "Avg. VAT Amount" <> 0 THEN
                        VATAmt := "Avg. VAT Amount"
                    ELSE
                        //KKE : xxx
                        VATAmt := "Amount Including VAT" - Amount; //04.06.2007
                    //IF VATAmt  >= 0 THEN  //KKE : 26.03.2007
                    IF DrAmount[i] + VATAmt >= 0 THEN
                        DrAmount[i] := DrAmount[i] + VATAmt
                    ELSE
                        CrAmount[i] := CrAmount[i] - VATAmt;
                    // WHT
                    WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group");
                    IF WHTPostingSetup."WHT %" <> 0 THEN BEGIN
                        i := 0;
                        MatchAcc := FALSE;
                        REPEAT
                            i := i + 1;
                            IF (WHTProd[i] = "WHT Product Posting Group") OR (WHTProd[i] = '') THEN MatchAcc := TRUE;
                        UNTIL (i = 200) OR MatchAcc;
                        WHTCode[i] := 'WHT';
                        WHTProd[i] := "WHT Product Posting Group";
                        IF "WHT Absorb Base" = 0 THEN
                            WHTCrAmount[i] += ROUND("Qty. to Invoice" * "Unit Cost (LCY)" * WHTPostingSetup."WHT %" / 100)
                        ELSE
                            WHTCrAmount[i] += ROUND("WHT Absorb Base" * WHTPostingSetup."WHT %" / 100);
                        if "Purchase Header"."Currency Factor" > 0 then WHTCrAmount[i] := WHTCrAmount[i] * "Purchase Header"."Currency Factor"; //RAVI
                    END;
                    WHTAmtHeader += WHTCrAmount[i];
                    //Direct Inventory post cost
                    IF ("Job No." = '') AND (Type = Type::Item) THEN BEGIN
                        IF InventoryPostingSetup.GET("Location Code", "Posting Group") THEN BEGIN
                            AccountNo := InventoryPostingSetup."Inventory Account";
                            IF NOT GLAcc.GET(AccountNo) THEN GLAcc.INIT;
                            MatchAcc := FALSE;
                            i := 0;
                            REPEAT
                                i := i + 1;
                                IF ((AccCode[i] = AccountNo) AND (Dimension1Code[i] = "Shortcut Dimension 1 Code") AND (Dimension2Code[i] = "Shortcut Dimension 2 Code") AND (Dimension3Code[i] = ShortcutDim3Code) AND (Dimension4Code[i] = ShortcutDim4Code) AND (Dimension5Code[i] = ShortcutDim5Code)) OR (AccCode[i] = '') THEN MatchAcc := TRUE;
                            UNTIL (i = 27) OR MatchAcc;
                            AccCode[i] := AccountNo;
                            AccName[i] := GLAcc.Name;
                            Dimension1Code[i] := "Shortcut Dimension 1 Code";
                            Dimension2Code[i] := "Shortcut Dimension 2 Code";
                            Dimension3Code[i] := ShortcutDim3Code;
                            Dimension4Code[i] := ShortcutDim4Code;
                            Dimension5Code[i] := ShortcutDim5Code;
                            //DrAmount[i] := DrAmount[i] + "Qty. to Invoice" * "Direct Unit Cost";
                            DrAmount[i] := DrAmount[i] + VATBaseAmt;
                        END;
                    END;
                end;
            }
            dataitem(Detail; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                column(DebitAmountNumber; DrAmount[Number])
                {
                }
                column(DebitAccNoNumber; AccCode[Number])
                {
                }
                column(DebitAccNameNumber; AccName[Number])
                {
                }
                column(DebitVATNameNumber; '')
                {
                }
                column(DebitVATAmtNumber; DebitVATAmtNumber)
                {
                }
                column(Dim2; Dimension2Code[Number])
                {
                }
                column(Dim1; Dimension1Code[Number])
                {
                }
                column(CrAmounts; CrAmount[Number])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IF AccCode[Number] = '' THEN CurrReport.BREAK;
                    IF (DrAmount[Number] = 0) AND (CrAmount[Number] = 0) THEN CurrReport.SKIP;
                    CntLine += 1;
                    //Ravi Sinha+
                    DebitTotalLCY := DebitTotalLCY + DrAmount[Number];
                    //>>VAH
                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(TextAmount, Abs(DebitTotalLCY), "Purchase Header"."Currency Code");
                    if TextAmount[1] <> '' then
                        TextAmount[1] := '(' + TextAmount[1] + ' ' + TtoalCurrCode + ')';
                    //if CrAmount[Number] <> 0 then  CurrReport.Skip;
                    CreditTotalLCY := CreditTotalLCY + CrAmount[Number];

                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(TextAmount, Abs(CreditTotalLCY), "Purchase Header"."Currency Code");
                    if TextAmount[1] <> ''
                    then
                        TextAmount[1] := '(' + TextAmount[1] + ' ' + TtoalCurrCode + ')';
                    //  Message('%1', TextAmount[1]);
                    //Ravi Sinha-
                end;

                trigger OnPreDataItem()
                begin
                    VendPostingGrp.GET("Purchase Header"."Vendor Posting Group");
                    IF NOT GLAcc.GET(VendPostingGrp."Payables Account") THEN GLAcc.INIT;
                    ShortcutDim3Code := '';
                    ShortcutDim4Code := '';
                    ShortcutDim5Code := '';
                    MatchAcc := FALSE;
                    i := 0;
                    REPEAT
                        i := i + 1;
                        IF ((AccCode[i] = VendPostingGrp."Payables Account") AND (Dimension1Code[i] = "Purchase Header"."Shortcut Dimension 1 Code") AND (Dimension2Code[i] = "Purchase Header"."Shortcut Dimension 2 Code") AND (Dimension3Code[i] = ShortcutDim3Code) AND (Dimension4Code[i] = ShortcutDim4Code) AND (Dimension5Code[i] = ShortcutDim5Code)) OR (AccCode[i] = '') THEN MatchAcc := TRUE UNTIL (i = 27) OR MatchAcc;
                    AccCode[i] := VendPostingGrp."Payables Account";
                    AccName[i] := GLAcc.Name;
                    Dimension1Code[i] := "Purchase Header"."Shortcut Dimension 1 Code";
                    Dimension2Code[i] := "Purchase Header"."Shortcut Dimension 2 Code";
                    Dimension3Code[i] := ShortcutDim3Code;
                    Dimension4Code[i] := ShortcutDim4Code;
                    Dimension5Code[i] := ShortcutDim5Code;
                    FOR j := 1 TO 27 DO BEGIN
                        IF i <> j THEN
                            CrAmount[i] := CrAmount[i] + DrAmount[j] - CrAmount[j]
                        ELSE
                            CrAmount[i] := CrAmount[i] + DrAmount[j];
                    END;
                    IF CrAmount[i] < 0 THEN BEGIN
                        DrAmount[i] := -CrAmount[i];
                        CrAmount[i] := 0;
                    END;
                    //Incase Purchase Credit Memo.
                    IF "Purchase Header"."Document Type" = "Purchase Header"."Document Type"::"Credit Memo" THEN BEGIN
                        i := 27;
                        j := 0;
                        REPEAT
                            IF AccCode[i] <> '' THEN BEGIN
                                j := j + 1;
                                CrMemoAccCode[j] := AccCode[i];
                                CrMemoAccName[j] := AccName[i];
                                CrMemoDim1Code[i] := Dimension1Code[i];
                                CrMemoDim2Code[i] := Dimension2Code[i];
                                CrMemoDim3Code[i] := Dimension3Code[i];
                                CrMemoDim4Code[i] := Dimension4Code[i];
                                CrMemoDim5Code[i] := Dimension5Code[i];
                                IF CrAmount[i] <> 0 THEN
                                    CrMemoDrAmount[j] := CrAmount[i]
                                ELSE
                                    CrMemoCrAmount[j] := DrAmount[i];
                            END;
                            i := i - 1;
                        UNTIL i = 0;
                        CLEAR(AccCode);
                        CLEAR(AccName);
                        CLEAR(DrAmount);
                        CLEAR(CrAmount);
                        FOR i := 1 TO j DO BEGIN
                            AccCode[i] := CrMemoAccCode[i];
                            AccName[i] := CrMemoAccName[i];
                            Dimension1Code[i] := CrMemoDim1Code[i];
                            Dimension2Code[i] := CrMemoDim2Code[i];
                            Dimension3Code[i] := CrMemoDim3Code[i];
                            Dimension4Code[i] := CrMemoDim4Code[i];
                            Dimension5Code[i] := CrMemoDim5Code[i];
                            DrAmount[i] := CrMemoDrAmount[i];
                            CrAmount[i] := CrMemoCrAmount[i];
                        END;
                    END;
                end;
            }
            dataitem(WHT; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                column(CreditAccNameNumber; '')
                {
                }
                column(CreditVATNameNumber; '')
                {
                }
                column(CreditWHTAmt; CreditWHTAmt)
                {
                }
                column(CreditVATNoNumber; '')
                {
                }
                column(CreditAccNoNumber; '')
                {
                }
                column(CreditVATAmtNumber; '')
                {
                }
                column(CreditAmountNumber; '')
                {
                }
                column(WHTAccountName; WHTProd[Number])
                {
                }
                column(WHTAccountNo; WHTCode[Number])
                {
                }
                column(WHTAmt; WHTCrAmount[Number])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IF WHTCode[Number] = '' THEN CurrReport.BREAK;
                    CntLine += 1;
                end;
            }
            dataitem(Description1; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                column(Vendor_Invoice_No_; Vendor_Invoice_No_[Number])
                {
                }
                column(Vendor_Invoice_No_Caption; Vendor_Invoice_No_Caption)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CntLine += 1;
                end;
            }
            dataitem(LineLoop; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                column(Number_LineLoop; LineLoop.Number)
                {
                }
                column(TextAmount1; TextAmount[1])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IF CntLine + Line + Number > 22 THEN CurrReport.BREAK;
                end;

                trigger OnPreDataItem()
                begin
                    IF CntLine + Line + Number > 22 THEN CurrReport.BREAK;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(Descriptionlbs);
                CLEAR(AccCode);
                CLEAR(AccName);
                Clear(WHTAmtHeader);
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
                CLEAR(WHTCrAmount);
                Clear(Vendor_Invoice_No_);
                Description := "Ship-to Name (Thai)";
                PostingDate := "Posting Date";
                DocumentNo := "No.";
                if "Vendor Invoice No." <> '' then begin
                    Vendor_Invoice_No_[1] := "Vendor Invoice No.";
                    Vendor_Invoice_No_Caption := 'Vendor Invoice No.';
                end
                else begin
                    if "Vendor Cr. Memo No." <> '' then begin
                        Vendor_Invoice_No_[1] := "Vendor Cr. Memo No.";
                        Vendor_Invoice_No_Caption := 'Vendor Cr. Memo No.';
                    end;
                end;
                CntLine := 0;
                Line := 0;
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
                if "Invoice Description" <> '' then
                    Descriptionlbs := "Invoice Description"
                else
                    Descriptionlbs := "Posting Description";
                LanguageCaption.Reset();
                LanguageCaption.SetRange("Report ID", 50505);
                LanguageCaption.SetRange("Caption Code", 'TaxID');
                if LanguageCaption.FindFirst() then CaptionTaxID := LanguageCaption."Caption in Thai";
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
                    if CaptionTaxID <> '' then CompanyAddr[8] := CaptionTaxID + ' ' + CompanyInfo."VAT Registration No.";
                end;
                CompressArray(CompanyAddr);
            end;

            trigger OnPreDataItem()
            begin
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
        CaptionTaxID: Text;
        LanguageCaption: Record "Language Caption";
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        CreditWHTAmt: Decimal;
        // CreditWHTAmt: Decimal;
        Vendor: Record Vendor;
        CompanyInfo: Record "Company Information";
        VendPostingGrp: Record "Vendor Posting Group";
        GenPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        PurchLine: Record "Purchase line";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        DebitVATAmtNumber: Decimal;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Description: Text[250];
        DocumentNo: Code[20];
        PostingDate: Date;
        AccountNo: Code[20];
        AccCode: array[27] of Code[20];
        AccName: array[27] of Text[50];
        DrAmount: array[27] of Decimal;
        CrAmount: array[27] of Decimal;
        TotalDrAmount: Decimal;
        TotalCrAmount: Decimal;
        MatchAcc: Boolean;
        i: Integer;
        j: Integer;
        WHTCode: array[200] of Code[20];
        WHTCrAmount: array[200] of Decimal;
        CrMemoAccCode: array[27] of Code[20];
        CrMemoAccName: array[27] of Text[50];
        CrMemoDrAmount: array[27] of Decimal;
        CrMemoCrAmount: array[27] of Decimal;
        Dimension1Code: array[27] of Code[20];
        Dimension2Code: array[27] of Code[20];
        Dimension3Code: array[27] of Code[20];
        Dimension4Code: array[27] of Code[20];
        Dimension5Code: array[27] of Code[20];
        ShortcutDimCode: array[8] of Code[20];
        ShortcutDim1Code: Code[20];
        ShortcutDim2Code: Code[20];
        ShortcutDim3Code: Code[20];
        ShortcutDim4Code: Code[20];
        ShortcutDim5Code: Code[20];
        CrMemoDim1Code: array[27] of Code[20];
        CrMemoDim2Code: array[27] of Code[20];
        CrMemoDim3Code: array[27] of Code[20];
        CrMemoDim4Code: array[27] of Code[20];
        CrMemoDim5Code: array[27] of Code[20];
        CntLine: Integer;
        FALedgEntry: Record "FA Ledger Entry";
        FAGetGLAccNo: Codeunit "FA Get G/L Account No.";
        FormatAddr: Codeunit "Format Address";
        VATBaseAmt: Decimal;
        VATAmt: Decimal;
        CheckReport: Report Check;
        TextAmount: array[2] of Text[250];
        WHTProd: array[200] of Code[20];
        WHTPostingSetup: Record "WHT Posting Setup";
        CurrCode: Code[10];
        TtoalCurrCode: Code[50];
        Line: Integer;
        LineSpace: Integer;
        DebitTotalLCY: Decimal;
        CreditTotalLCY: Decimal;
        WHTAmtHeader: Decimal;
        CompanyAddr: array[8] of Text[250];
        TaxIDThai: Text;
        VisibleVendorInv: Boolean;
        Vendor_Invoice_No_: array[1] of Text[250];
        Vendor_Invoice_No_Caption: Text[50];
        Descriptionlbs: Text;
}
