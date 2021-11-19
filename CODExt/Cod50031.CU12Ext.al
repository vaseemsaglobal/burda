codeunit 50031 CU12Ext
{
    Permissions = tabledata 254 = rimd;
    trigger OnRun()
    begin
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertVAT', '', false, false)]
    local procedure OnBeforeInsertVATEntry_Subscriber(var GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; var UnrealizedVAT: Boolean; var AddCurrencyCode: Code[10]; var VATPostingSetup: Record "VAT Posting Setup"; var GLEntryAmount: Decimal; var GLEntryVATAmount: Decimal; var GLEntryBaseAmount: Decimal; var SrcCurrCode: Code[10]; var SrcCurrGLEntryAmt: Decimal; var SrcCurrGLEntryVATAmt: Decimal; var SrcCurrGLEntryBaseAmt: Decimal)
    var
        SalesTaxInvReceiptHdr: Record "Sales Tax Invoice/Rec. Header";
        SalesTaxInvReceiptLine: Record "Sales Tax Invoice/Rec. Line";
    begin
        WITH GenJournalLine DO BEGIN //<< RJ1.00
                                     //TSA001
            VATEntry."Use Average VAT" := "Use Average VAT";
            VATEntry."Average VAT Year" := GenJournalLine."Average VAT Year";
            VATEntry."VAT Claim Percentage" := "VAT Claim %";
            //TSA001
            VATEntry."Line No." := VATLineNo;  //KKE : #001
                                               //KKE : #003 +
            IF ("Tax Invoice Date" <> 0D) AND ("Tax Invoice No." <> '') THEN BEGIN
                VATEntry."Submit Date" := "Tax Invoice Date";
                VATEntry."Tax Invoice No." := "Tax Invoice No.";
                VATEntry."Tax Invoice Date" := "Tax Invoice Date";
            END ELSE BEGIN
                VATEntry."Submit Date" := "Posting Date";
                VATEntry."Tax Invoice Date" := "Document Date";
                IF "External Document No." = '' THEN
                    VATEntry."Tax Invoice No." := "Document No."
                ELSE
                    VATEntry."Tax Invoice No." := "External Document No.";
            END;
            //KKE : #003 -
            VATEntry."Real Customer/Vendor Name" := "Real Customer/Vendor Name";  //KKE : #002
                                                                                  //KKE : #003 +
            VATEntry."Tax Invoice No." := "Tax Invoice No.";
            VATEntry."Tax Invoice Date" := "Tax Invoice Date";
            IF ("Tax Invoice Date" <> 0D) AND ("Tax Invoice No." <> '') THEN
                VATEntry."Submit Date" := "Tax Invoice Date"
            ELSE
                VATEntry."Submit Date" := "Posting Date";
            //KKE : #003 -
        END; //>> RJ1.00
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInitCustLedgEntry', '', false, false)]
    local procedure OnBeforeInitCustLedgEntry_Subscriber(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        CustLedgEntry2: Record "Cust. Ledger Entry";
        VATEntry2: Record "VAT Entry";
    begin
        WITH GenJournalLine DO BEGIN
            //Update Tax Invoice No. on VAT Entry
            //KKE :#011 +
            IF ("Tax Invoice No." <> '') AND ("Tax Invoice Date" <> 0D) THEN
                IF "Applies-to ID" <> '' THEN BEGIN
                    CustLedgEntry2.RESET;
                    CustLedgEntry2.SETRANGE("Applies-to ID", "Applies-to ID");
                    IF CustLedgEntry2.FIND('-') THEN
                        REPEAT
                            VATEntry2.RESET;
                            VATEntry2.SETRANGE("Document Type", CustLedgEntry2."Document Type");
                            VATEntry2.SETRANGE("Document No.", CustLedgEntry2."Document No.");
                            VATEntry2.SETRANGE("Posting Date", CustLedgEntry2."Posting Date");
                            IF VATEntry2.FIND('-') THEN
                                REPEAT
                                    VATEntry2."Tax Invoice No." := "Tax Invoice No.";
                                    VATEntry2."Tax Invoice Date" := "Tax Invoice Date";
                                    VATEntry2.MODIFY;
                                UNTIL VATEntry2.NEXT = 0;
                        UNTIL CustLedgEntry2.NEXT = 0;
                END ELSE
                    IF "Applies-to Doc. No." <> '' THEN BEGIN
                        CustLedgEntry2.RESET;
                        CustLedgEntry2.SETRANGE("Document Type", "Applies-to Doc. Type");
                        CustLedgEntry2.SETRANGE("Document No.", "Applies-to Doc. No.");
                        IF CustLedgEntry2.FIND('-') THEN
                            REPEAT
                                VATEntry2.RESET;
                                VATEntry2.SETRANGE("Document Type", CustLedgEntry2."Document Type");
                                VATEntry2.SETRANGE("Document No.", CustLedgEntry2."Document No.");
                                VATEntry2.SETRANGE("Posting Date", CustLedgEntry2."Posting Date");
                                IF VATEntry2.FIND('-') THEN
                                    REPEAT
                                        VATEntry2."Tax Invoice No." := "Tax Invoice No.";
                                        VATEntry2."Tax Invoice Date" := "Tax Invoice Date";
                                        VATEntry2.MODIFY;
                                    UNTIL VATEntry2.NEXT = 0;
                            UNTIL CustLedgEntry2.NEXT = 0;
                    END;
            //KKE :#011 -
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitBankAccLedgEntry', '', false, false)]
    local procedure OnAfterInitBankAccLedgEntry_Subscriber(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        WITH GenJournalLine DO BEGIN
            //KKE : #051 +
            BankAccountLedgerEntry."Vendor Bank Account No." := "Bank Account No.";
            BankAccountLedgerEntry."Vendor Bank Branch No." := "Bank Branch No.";
            BankAccountLedgerEntry."Customer/Vendor Bank" := "Customer/Vendor Bank";
            //KKE : #051 -
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertGlobalGLEntry', '', false, false)]
    local procedure OnBeforeInsertGlobalGLEntry_Subscriber(var GlobalGLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        GlobalGLEntry."Create Date" := TODAY;  //KKE : #007
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntry_Subscriber(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        WITH GenJournalLine DO BEGIN
            //KKE : #008 +
            IF "Is WHT" AND ("WHT Transaction No." <> 0) THEN
                GLEntry."Transaction No." := "WHT Transaction No.";
            //KKE : #008 -
            //GLEntry.Comment := "Description 2";  //KKE : #053
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertGLEntryBuffer', '', false, false)]
    local procedure OnBeforeInsertGLEntryBuffer_Subscriber(var TempGLEntryBuf: Record "G/L Entry" temporary; var GenJournalLine: Record "Gen. Journal Line"; var BalanceCheckAmount: Decimal; var BalanceCheckAmount2: Decimal; var BalanceCheckAddCurrAmount: Decimal; var BalanceCheckAddCurrAmount2: Decimal; var NextEntryNo: Integer)
    begin
        TempGLEntryBuf."Create Date" := TODAY;  //KKE : #007
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertPostUnrealVATEntry', '', false, false)]
    local procedure OnBeforeInsertPostUnrealVATEntry_Subscriber(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line"; var VATEntry2: Record "VAT Entry")
    var
        SalesTaxInvReceiptHdr: Record "Sales Tax Invoice/Rec. Header";
        SalesTaxInvReceiptLine: Record "Sales Tax Invoice/Rec. Line";
    begin
        WITH GenJournalLine DO BEGIN
            //KKE : #002 +
            IF GenJournalLine."Real Customer/Vendor Name" = '' THEN
                VATEntry."Real Customer/Vendor Name" := VATEntry2."Real Customer/Vendor Name"
            ELSE
                VATEntry."Real Customer/Vendor Name" := GenJournalLine."Real Customer/Vendor Name";
            //KKE : #002 -

            //KKE : #003 +
            IF (GenJournalLine."Tax Invoice Date" <> 0D) AND (GenJournalLine."Tax Invoice No." <> '') THEN BEGIN
                VATEntry."Tax Invoice No." := GenJournalLine."Tax Invoice No.";
                VATEntry."Tax Invoice Date" := GenJournalLine."Tax Invoice Date";
                VATEntry."Submit Date" := GenJournalLine."Tax Invoice Date";
            END ELSE BEGIN
                //KKE : #054 +
                SalesTaxInvReceiptHdr.INIT;
                SalesTaxInvReceiptLine.RESET;
                SalesTaxInvReceiptLine.SETRANGE("Posted Document No.", VATEntry2."Document No.");
                IF SalesTaxInvReceiptLine.FIND('-') THEN
                    REPEAT
                        SalesTaxInvReceiptHdr.GET(SalesTaxInvReceiptLine."Document No.");
                    UNTIL (SalesTaxInvReceiptLine.NEXT = 0) OR (NOT SalesTaxInvReceiptHdr."Cancel Tax Invoice");
                IF SalesTaxInvReceiptHdr."Issued Tax Invoice/Receipt No." <> '' THEN BEGIN
                    VATEntry."Tax Invoice No." := SalesTaxInvReceiptHdr."Issued Tax Invoice/Receipt No.";
                    VATEntry."Tax Invoice Date" := SalesTaxInvReceiptHdr."Posting Date";
                    //KKE : #054 -
                END ELSE BEGIN
                    VATEntry."Tax Invoice No." := VATEntry2."Tax Invoice No.";
                    VATEntry."Tax Invoice Date" := VATEntry2."Tax Invoice Date";
                END;
                VATEntry."Submit Date" := GenJournalLine."Posting Date";
            END;
            //KKE : #003 -
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostBankAccOnBeforeBankAccLedgEntryInsert', '', false, false)]
    local procedure OnPostBankAccOnBeforeBankAccLedgEntryInsert_Subscriber(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account")
    begin
        WITH GenJournalLine DO BEGIN
            //KKE : #051 +
            BankAccountLedgerEntry."Vendor Bank Account No." := "Bank Account No.";
            BankAccountLedgerEntry."Vendor Bank Branch No." := "Bank Branch No.";
            BankAccountLedgerEntry."Customer/Vendor Bank" := "Customer/Vendor Bank";
            //KKE : #051 -
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitVAT', '', false, false)]
    local procedure OnAfterInitVAT_Subscriber(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var VATPostingSetup: Record "VAT Posting Setup"; var AddCurrGLEntryVATAmt: Decimal)
    var
        GLSetup: Record "General Ledger Setup";
        GenJnlTemplate: Record "Gen. Journal Template";
    begin
        GLSetup.get();
        WITH GenJournalLine DO
            IF (("Gen. Posting Type" <> 0) AND
                ("Gen. Posting Type" <> "Gen. Posting Type"::Settlement) AND
                (GLSetup.GSTEnabled("Document Date"))) OR
               (("Gen. Posting Type" <> 0) AND
                (NOT GLSetup.GSTEnabled("Document Date")))
            THEN BEGIN
                CASE "VAT Posting" OF
                    "VAT Posting"::"Manual VAT Entry":
                        BEGIN
                            //KKE : #052 +
                            IF GenJnlTemplate.GET("Journal Template Name") THEN
                                IF ("Document Type" = "Document Type"::Invoice) AND
                                  (GenJnlTemplate.Type = GenJnlTemplate.Type::Purchases) AND
                                  ("VAT Claim %" <> 0) AND "Use Average VAT"
                                THEN BEGIN
                                    GLEntry.Amount := GenJournalLine."VAT Base Amount (LCY)";
                                END;
                            //KKE : #052 -
                        END;
                END;
            END;
    end;

    //[Scope('Internal')]
    procedure CheckVATGLEntry(l_recGenJnlLine: Record "Gen. Journal Line"; var l_recGLEntry: Record "G/L Entry")
    var
        TaxDetail2: Record "Tax Detail";
        VATAmount: Decimal;
        VATAmount2: Decimal;
        VATBase: Decimal;
        VATBase2: Decimal;
        SrcCurrVATAmount: Decimal;
        SrcCurrVATBase: Decimal;
        SrcCurrSalesTaxBaseAmount: Decimal;
        RemSrcCurrVATAmount: Decimal;
        TaxDetailFound: Boolean;
        //GenJnlLine: Record "Gen. Journal Line";
        AddCurrGLEntryVATAmt: Decimal;
        NextConnectionNo: Integer;
        SalesTaxBaseAmount: Decimal;
        TaxDetail: Record "Tax Detail";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        //GLEntry: Record "G/L Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        ExchAccGLJnlLine: Codeunit "Exchange Acc. G/L Journal Line";
        GenJnlPostLine: Codeunit "gen. jnl.-post Line";
    begin
        //KKE : #010 -
        GenJnlLine := l_recGenJnlLine;
        GLEntry := l_recGLEntry;
        InitVAT(GenJnlLine, GLEntry, VATPostingSetup);  //VAH check
        WITH l_recGenJnlLine DO BEGIN
            //08.06.2011 +
            IF ("VAT %" = 0) AND ("Bal. VAT %" = 0) THEN
                EXIT;
            //08.06.2011 -
            // Post VAT
            // VAT for VAT entry
            CASE "VAT Calculation Type" OF
                "VAT Calculation Type"::"Normal VAT",
                "VAT Calculation Type"::"Reverse Charge VAT",
                "VAT Calculation Type"::"Full VAT":
                    BEGIN
                        IF "VAT Posting" = "VAT Posting"::"Automatic VAT Entry" THEN
                            "VAT Base Amount (LCY)" := GLEntry.Amount; //<< Change in Code
                        IF "Gen. Posting Type" = "Gen. Posting Type"::Settlement THEN
                            AddCurrGLEntryVATAmt := "Source Curr. VAT Amount";
                        CheckInsertVAT(
                          GLEntry.Amount, GLEntry."VAT Amount", "VAT Base Amount (LCY)", "Source Currency Code",
                          GLEntry."Additional-Currency Amount", AddCurrGLEntryVATAmt, "Source Curr. VAT Base Amount");
                        NextConnectionNo := NextConnectionNo + 1;
                    END;
                "VAT Calculation Type"::"Sales Tax":
                    BEGIN
                        CASE "VAT Posting" OF
                            "VAT Posting"::"Automatic VAT Entry":
                                SalesTaxBaseAmount := GLEntry.Amount;
                            "VAT Posting"::"Manual VAT Entry":
                                SalesTaxBaseAmount := "VAT Base Amount (LCY)";
                        END;
                        IF ("VAT Posting" = "VAT Posting"::"Manual VAT Entry") AND
                           ("Gen. Posting Type" = "Gen. Posting Type"::Settlement)
                        THEN BEGIN
                            TaxDetail."Tax Jurisdiction Code" := "Tax Area Code";
                            "Tax Area Code" := '';
                            CheckInsertVAT(
                              GLEntry.Amount, GLEntry."VAT Amount", "VAT Base Amount (LCY)", "Source Currency Code",
                              "Source Curr. VAT Base Amount", "Source Curr. VAT Amount", "Source Curr. VAT Base Amount");
                        END ELSE BEGIN
                            CLEAR(SalesTaxCalculate);
                            SalesTaxCalculate.InitSalesTaxLines(
                              "Tax Area Code", "Tax Group Code", "Tax Liable",
                              SalesTaxBaseAmount, Quantity, "Posting Date", GLEntry."VAT Amount");
                            SrcCurrVATAmount := 0;
                            SrcCurrSalesTaxBaseAmount := CalcLCYToAddCurr(SalesTaxBaseAmount);
                            RemSrcCurrVATAmount := AddCurrGLEntryVATAmt;
                            TaxDetailFound := FALSE;
                            WHILE SalesTaxCalculate.GetSalesTaxLine(TaxDetail2, VATAmount, VATBase) DO BEGIN
                                RemSrcCurrVATAmount := RemSrcCurrVATAmount - SrcCurrVATAmount;
                                IF TaxDetailFound THEN
                                    CheckInsertVAT(
                                      SalesTaxBaseAmount, VATAmount2, VATBase2, "Source Currency Code",
                                      SrcCurrSalesTaxBaseAmount, SrcCurrVATAmount, SrcCurrVATBase);
                                TaxDetailFound := TRUE;
                                TaxDetail := TaxDetail2;
                                VATAmount2 := VATAmount;
                                VATBase2 := VATBase;
                                SrcCurrVATAmount := CalcLCYToAddCurr(VATAmount);
                                SrcCurrVATBase := CalcLCYToAddCurr(VATBase);
                            END;
                            IF TaxDetailFound THEN
                                CheckInsertVAT(
                                  SalesTaxBaseAmount, VATAmount2, VATBase2, "Source Currency Code",
                                  SrcCurrSalesTaxBaseAmount, RemSrcCurrVATAmount, SrcCurrVATBase);
                            InsertSummarizedVAT(GenJnlLine);
                        END;
                    END;
            END;
        END;
        l_recGLEntry := GLEntry;
        l_recGLEntry."Entry No." := 1;
        l_recGLEntry.INSERT;

        //Balance
        GenJnlLine := l_recGenJnlLine;
        IF GenJnlLine."Bal. Account No." = '' THEN
            EXIT;

        CLEAR(GLEntry);
        ExchAccGLJnlLine.RUN(GenJnlLine);
        InitVAT(GenJnlLine, GLEntry, VATPostingSetup);//VAH check
        WITH l_recGenJnlLine DO BEGIN
            // Post VAT
            // VAT for VAT entry
            CASE "VAT Calculation Type" OF
                "VAT Calculation Type"::"Normal VAT",
                "VAT Calculation Type"::"Reverse Charge VAT",
                "VAT Calculation Type"::"Full VAT":
                    BEGIN
                        IF "VAT Posting" = "VAT Posting"::"Automatic VAT Entry" THEN
                            "VAT Base Amount (LCY)" := GLEntry.Amount;
                        IF "Gen. Posting Type" = "Gen. Posting Type"::Settlement THEN
                            AddCurrGLEntryVATAmt := "Source Curr. VAT Amount";
                        CheckInsertVAT(
                          GLEntry.Amount, GLEntry."VAT Amount", "VAT Base Amount (LCY)", "Source Currency Code",
                          GLEntry."Additional-Currency Amount", AddCurrGLEntryVATAmt, "Source Curr. VAT Base Amount");
                        NextConnectionNo := NextConnectionNo + 1;
                    END;
                "VAT Calculation Type"::"Sales Tax":
                    BEGIN
                        CASE "VAT Posting" OF
                            "VAT Posting"::"Automatic VAT Entry":
                                SalesTaxBaseAmount := GLEntry.Amount;
                            "VAT Posting"::"Manual VAT Entry":
                                SalesTaxBaseAmount := "VAT Base Amount (LCY)";
                        END;
                        IF ("VAT Posting" = "VAT Posting"::"Manual VAT Entry") AND
                           ("Gen. Posting Type" = "Gen. Posting Type"::Settlement)
                        THEN BEGIN
                            TaxDetail."Tax Jurisdiction Code" := "Tax Area Code";
                            "Tax Area Code" := '';
                            CheckInsertVAT(
                              GLEntry.Amount, GLEntry."VAT Amount", "VAT Base Amount (LCY)", "Source Currency Code",
                              "Source Curr. VAT Base Amount", "Source Curr. VAT Amount", "Source Curr. VAT Base Amount");
                        END ELSE BEGIN
                            CLEAR(SalesTaxCalculate);
                            SalesTaxCalculate.InitSalesTaxLines(
                              "Tax Area Code", "Tax Group Code", "Tax Liable",
                              SalesTaxBaseAmount, Quantity, "Posting Date", GLEntry."VAT Amount");
                            SrcCurrVATAmount := 0;
                            SrcCurrSalesTaxBaseAmount := CalcLCYToAddCurr(SalesTaxBaseAmount);
                            RemSrcCurrVATAmount := AddCurrGLEntryVATAmt;
                            TaxDetailFound := FALSE;
                            WHILE SalesTaxCalculate.GetSalesTaxLine(TaxDetail2, VATAmount, VATBase) DO BEGIN
                                RemSrcCurrVATAmount := RemSrcCurrVATAmount - SrcCurrVATAmount;
                                IF TaxDetailFound THEN
                                    CheckInsertVAT(
                                      SalesTaxBaseAmount, VATAmount2, VATBase2, "Source Currency Code",
                                      SrcCurrSalesTaxBaseAmount, SrcCurrVATAmount, SrcCurrVATBase);
                                TaxDetailFound := TRUE;
                                TaxDetail := TaxDetail2;
                                VATAmount2 := VATAmount;
                                VATBase2 := VATBase;
                                SrcCurrVATAmount := CalcLCYToAddCurr(VATAmount);
                                SrcCurrVATBase := CalcLCYToAddCurr(VATBase);
                            END;
                            IF TaxDetailFound THEN
                                CheckInsertVAT(
                                  SalesTaxBaseAmount, VATAmount2, VATBase2, "Source Currency Code",
                                  SrcCurrSalesTaxBaseAmount, RemSrcCurrVATAmount, SrcCurrVATBase);
                            InsertSummarizedVAT(GenJnlLine);
                        END;
                    END;
            END;
        END;
        l_recGLEntry := GLEntry;
        l_recGLEntry."Entry No." := 2;
        l_recGLEntry.INSERT;
        //KKE : #010 -
    end;

    procedure CheckInsertVAT(GLEntryAmount: Decimal; GLEntryVATAmount: Decimal; GLEntryBaseAmount: Decimal; SrcCurrCode: Code[10]; SrcCurrGLEntryAmt: Decimal; SrcCurrGLEntryVATAmt: Decimal; SrcCurrGLEntryBaseAmt: Decimal)
    var
        VATAmount: Decimal;
        VATBase: Decimal;
        UnrealizedVAT: Boolean;
        SrcCurrVATAmount: Decimal;
        SrcCurrVATBase: Decimal;
        VATDifferenceLCY: Decimal;
        SrcCurrVATDifference: Decimal;
        //GLEntry: Record "G/L Entry";
        ///GenJnlLine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        //GenJnlPostLine : Codeunit "Gen. Jnl.-Post Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
    begin
        GLSetup.Get();
        GetCurrencyExchRate(GenJnlLine);//VAH check
        //KKE : #010 +
        WITH GenJnlLine DO BEGIN
            //26.02.2009
            //DimMgt.CopyJnlLineDimToJnlLineDim(JnlLineDim,TempJnlLineDim);
            //26.02.2009

            // VAT for G/L entry/entries
            //TaxJurisdiction.get()  //VAH temp
            VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
            IF (GLEntryVATAmount <> 0) OR
               ((SrcCurrGLEntryVATAmt <> 0) AND (SrcCurrCode = GLSetup."Additional Reporting Currency"))
            THEN BEGIN
                CASE "Gen. Posting Type" OF
                    "Gen. Posting Type"::Purchase:
                        CASE VATPostingSetup."VAT Calculation Type" OF
                            VATPostingSetup."VAT Calculation Type"::"Normal VAT",
                            VATPostingSetup."VAT Calculation Type"::"Full VAT":
                                BEGIN
                                    IF UnrealizedVAT THEN BEGIN
                                        VATPostingSetup.TESTFIELD("Purch. VAT Unreal. Account");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          VATPostingSetup."Purch. VAT Unreal. Account",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        GenJnlPostLine.InsertGLEntry(GenJnlLine, GLEntry, TRUE);//VAH
                                    END ELSE BEGIN
                                        VATPostingSetup.TESTFIELD("Purchase VAT Account");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          VATPostingSetup."Purchase VAT Account",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        GenJnlPostLine.InsertGLEntry(GenJnlLine, GLEntry, TRUE);//VAH
                                    END;
                                END;
                            VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                                BEGIN
                                    IF UnrealizedVAT THEN BEGIN
                                        VATPostingSetup.TESTFIELD("Purch. VAT Unreal. Account");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          VATPostingSetup."Purch. VAT Unreal. Account",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        GenJnlPostLine.InsertGLEntry(GenJnlLine, GLEntry, TRUE);//VAH
                                        VATPostingSetup.TESTFIELD("Reverse Chrg. VAT Unreal. Acc.");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          VATPostingSetup."Reverse Chrg. VAT Unreal. Acc.",
                          -GLEntryVATAmount, -SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        GenJnlPostLine.InsertGLEntry(GenJnlLine, GLEntry, TRUE);//VAH
                                    END ELSE BEGIN
                                        VATPostingSetup.TESTFIELD("Purchase VAT Account");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          VATPostingSetup."Purchase VAT Account",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        GenJnlPostLine.InsertGLEntry(GenJnlLine, GLEntry, TRUE);//VAH
                                        VATPostingSetup.TESTFIELD("Reverse Chrg. VAT Acc.");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          VATPostingSetup."Reverse Chrg. VAT Acc.",
                          -GLEntryVATAmount, -SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        GenJnlPostLine.InsertGLEntry(GenJnlLine, GLEntry, TRUE);//VAH
                                    END;
                                END;
                            VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                                IF "Use Tax" THEN BEGIN
                                    IF UnrealizedVAT THEN BEGIN
                                        TaxJurisdiction.TESTFIELD("Unreal. Tax Acc. (Purchases)");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          TaxJurisdiction."Unreal. Tax Acc. (Purchases)",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        SummarizeVAT(
                                                          GLSetup."Summarize G/L Entries", GLEntry);
                                        TaxJurisdiction.TESTFIELD("Unreal. Rev. Charge (Purch.)");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          TaxJurisdiction."Unreal. Rev. Charge (Purch.)",
                          -GLEntryVATAmount, -SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        SummarizeVAT(
                                                          GLSetup."Summarize G/L Entries", GLEntry);
                                    END ELSE BEGIN
                                        TaxJurisdiction.TESTFIELD("Tax Account (Purchases)");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          TaxJurisdiction."Tax Account (Purchases)",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        SummarizeVAT(
                                                          GLSetup."Summarize G/L Entries", GLEntry);
                                        TaxJurisdiction.TESTFIELD("Reverse Charge (Purchases)");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          TaxJurisdiction."Reverse Charge (Purchases)",
                          -GLEntryVATAmount, -SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                        SummarizeVAT(
                                                          GLSetup."Summarize G/L Entries", GLEntry);
                                    END;
                                END ELSE BEGIN
                                    IF UnrealizedVAT THEN BEGIN
                                        TaxJurisdiction.TESTFIELD("Unreal. Tax Acc. (Purchases)");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          TaxJurisdiction."Unreal. Tax Acc. (Purchases)",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                    END ELSE BEGIN
                                        TaxJurisdiction.TESTFIELD("Tax Account (Purchases)");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          TaxJurisdiction."Tax Account (Purchases)",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                    END;
                                    SummarizeVAT(
                                                    GLSetup."Summarize G/L Entries", GLEntry);
                                END;
                        END;
                    "Gen. Posting Type"::Sale:
                        CASE VATPostingSetup."VAT Calculation Type" OF
                            VATPostingSetup."VAT Calculation Type"::"Normal VAT",
                            VATPostingSetup."VAT Calculation Type"::"Full VAT":
                                BEGIN
                                    IF UnrealizedVAT THEN BEGIN
                                        VATPostingSetup.TESTFIELD("Sales VAT Unreal. Account");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          VATPostingSetup."Sales VAT Unreal. Account",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                    END ELSE BEGIN
                                        VATPostingSetup.TESTFIELD("Sales VAT Account");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          VATPostingSetup."Sales VAT Account",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                    END;
                                    GenJnlPostLine.InsertGLEntry(GenJnlLine, GLEntry, TRUE);//VAH
                                END;
                            VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                                ;
                            VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                                BEGIN
                                    IF UnrealizedVAT THEN BEGIN
                                        TaxJurisdiction.TESTFIELD("Unreal. Tax Acc. (Sales)");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          TaxJurisdiction."Unreal. Tax Acc. (Sales)",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                    END ELSE BEGIN
                                        TaxJurisdiction.TESTFIELD("Tax Account (Sales)");
                                        GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry,
                          TaxJurisdiction."Tax Account (Sales)",
                          GLEntryVATAmount, SrcCurrGLEntryVATAmt, TRUE, TRUE);
                                    END;
                                    SummarizeVAT(GLSetup."Summarize G/L Entries", GLEntry);
                                END;
                        END;
                END;
            END;
        END;
        //KKE : #010 -
    end;

    local procedure SummarizeVAT(SummarizeGLEntries: Boolean; GLEntry: Record "G/L Entry")
    var
        InsertedTempVAT: Boolean;

    begin
        InsertedTempVAT := FALSE;
        IF SummarizeGLEntries THEN
            IF TempGLEntryVAT.FINDSET THEN
                REPEAT
                    IF (TempGLEntryVAT."G/L Account No." = GLEntry."G/L Account No.") AND
                       (TempGLEntryVAT."Bal. Account No." = GLEntry."Bal. Account No.")
                    THEN BEGIN
                        TempGLEntryVAT.Amount := TempGLEntryVAT.Amount + GLEntry.Amount;
                        TempGLEntryVAT."Additional-Currency Amount" :=
                          TempGLEntryVAT."Additional-Currency Amount" + GLEntry."Additional-Currency Amount";
                        TempGLEntryVAT.MODIFY;
                        InsertedTempVAT := TRUE;
                    END;
                UNTIL (TempGLEntryVAT.NEXT = 0) OR InsertedTempVAT;
        IF NOT InsertedTempVAT OR NOT SummarizeGLEntries THEN BEGIN
            TempGLEntryVAT := GLEntry;
            TempGLEntryVAT."Entry No." :=
              TempGLEntryVAT."Entry No." + InsertedTempGLEntryVAT;
            TempGLEntryVAT.INSERT;
            InsertedTempGLEntryVAT := InsertedTempGLEntryVAT + 1;
        END;
    end;

    local procedure InitVAT(var GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var VATPostingSetup: Record "VAT Posting Setup")
    var
        LCYCurrency: Record "Currency";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
        AddCurrGLEntryVATAmt: Decimal;


        UseVendExchRate: Boolean;
    begin
        LCYCurrency.InitRoundingPrecision;
        GLSetup.get();//VAH
        WITH GenJnlLine DO
            IF (("Gen. Posting Type" <> 0) AND
                ("Gen. Posting Type" <> "Gen. Posting Type"::Settlement) AND
                GLSetup.GSTEnabled("Document Date")) OR
               (("Gen. Posting Type" <> 0) AND
                (NOT GLSetup.GSTEnabled("Document Date")))
            THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                IsHandled := FALSE;

                IF NOT IsHandled THEN
                    TESTFIELD("VAT Calculation Type", VATPostingSetup."VAT Calculation Type");
                CASE "VAT Posting" OF
                    "VAT Posting"::"Automatic VAT Entry":
                        BEGIN
                            GLEntry.CopyPostingGroupsFromGenJnlLine(GenJnlLine);
                            CASE "VAT Calculation Type" OF
                                "VAT Calculation Type"::"Normal VAT":
                                    IF ("VAT Difference" <> 0) OR ("VAT Difference (ACY)" <> 0) THEN BEGIN
                                        GLEntry.Amount := "VAT Base Amount (LCY)";
                                        GLEntry."VAT Amount" := "Amount (LCY)" - GLEntry.Amount;
                                        IF "VAT Base (ACY)" = 0 THEN
                                            GLEntry."Additional-Currency Amount" := "Source Curr. VAT Base Amount"
                                        ELSE
                                            GLEntry."Additional-Currency Amount" := "VAT Base (ACY)";
                                        IF "VAT Base (ACY)" <> 0 THEN
                                            AddCurrGLEntryVATAmt := "Amount Including VAT (ACY)" - "VAT Base (ACY)"
                                        ELSE BEGIN
                                            IF "Source Currency Code" = AddCurrencyCode THEN
                                                AddCurrGLEntryVATAmt := "Source Curr. VAT Amount"
                                            ELSE
                                                AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                        END;
                                    END ELSE BEGIN
                                        GLEntry."VAT Amount" :=
                                          ROUND(
                                            "Amount (LCY)" * VATPostingSetup."VAT %" / (100 + VATPostingSetup."VAT %"),
                                            LCYCurrency."Amount Rounding Precision", LCYCurrency.VATRoundingDirection);
                                        GLEntry.Amount := "Amount (LCY)" - GLEntry."VAT Amount";
                                        IF "VAT Base (ACY)" = 0 THEN
                                            GLEntry."Additional-Currency Amount" :=
                                              ROUND(
                                                "Source Currency Amount" / (1 + VATPostingSetup."VAT %" / 100),
                                                AddCurrency."Amount Rounding Precision")
                                        ELSE
                                            GLEntry."Additional-Currency Amount" := "VAT Base (ACY)";
                                        IF "VAT Base (ACY)" <> 0 THEN
                                            AddCurrGLEntryVATAmt := "Amount Including VAT (ACY)" - "VAT Base (ACY)"
                                        ELSE BEGIN
                                            IF "Source Currency Code" = AddCurrencyCode THEN
                                                AddCurrGLEntryVATAmt :=
                                                  ROUND(
                                                    "Source Currency Amount" * VATPostingSetup."VAT %" / (100 + VATPostingSetup."VAT %"),
                                                    AddCurrency."Amount Rounding Precision", AddCurrency.VATRoundingDirection)
                                            ELSE
                                                AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                            GLEntry."Additional-Currency Amount" := "Source Currency Amount" - AddCurrGLEntryVATAmt;
                                        END;
                                    END;
                                "VAT Calculation Type"::"Reverse Charge VAT":
                                    CASE "Gen. Posting Type" OF
                                        "Gen. Posting Type"::Purchase:
                                            IF "VAT Difference" <> 0 THEN BEGIN
                                                GLEntry."VAT Amount" := "VAT Amount (LCY)";
                                                IF "Source Currency Code" = AddCurrencyCode THEN
                                                    AddCurrGLEntryVATAmt := "Source Curr. VAT Amount"
                                                ELSE
                                                    AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                            END ELSE BEGIN
                                                GLEntry."VAT Amount" :=
                                                  ROUND(
                                                    GLEntry.Amount * VATPostingSetup."VAT %" / 100,
                                                    LCYCurrency."Amount Rounding Precision", LCYCurrency.VATRoundingDirection);
                                                IF "Source Currency Code" = AddCurrencyCode THEN
                                                    AddCurrGLEntryVATAmt :=
                                                      ROUND(
                                                        GLEntry."Additional-Currency Amount" * VATPostingSetup."VAT %" / 100,
                                                        AddCurrency."Amount Rounding Precision", AddCurrency.VATRoundingDirection)
                                                ELSE
                                                    AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                            END;
                                        "Gen. Posting Type"::Sale:
                                            BEGIN
                                                GLEntry."VAT Amount" := 0;
                                                AddCurrGLEntryVATAmt := 0;
                                            END;
                                    END;
                                "VAT Calculation Type"::"Full VAT":
                                    BEGIN
                                        IsHandled := FALSE;
                                        IF NOT IsHandled THEN
                                            CASE "Gen. Posting Type" OF
                                                "Gen. Posting Type"::Sale:
                                                    TESTFIELD("Account No.", VATPostingSetup.GetSalesAccount(FALSE));
                                                "Gen. Posting Type"::Purchase:
                                                    TESTFIELD("Account No.", VATPostingSetup.GetPurchAccount(FALSE));
                                            END;
                                        GLEntry.Amount := 0;
                                        GLEntry."Additional-Currency Amount" := 0;
                                        GLEntry."VAT Amount" := "Amount (LCY)";
                                        IF "Source Currency Code" = AddCurrencyCode THEN
                                            AddCurrGLEntryVATAmt := "Source Currency Amount"
                                        ELSE
                                            AddCurrGLEntryVATAmt := CalcLCYToAddCurr("Amount (LCY)");
                                    END;
                                "VAT Calculation Type"::"Sales Tax":
                                    BEGIN
                                        IF ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) AND
                                           "Use Tax"
                                        THEN BEGIN
                                            GLEntry."VAT Amount" :=
                                              ROUND(
                                                SalesTaxCalculate.CalculateTax(
                                                  "Tax Area Code", "Tax Group Code", "Tax Liable",
                                                  "Posting Date", "Amount (LCY)", Quantity, 0));
                                            GLEntry.Amount := "Amount (LCY)";
                                        END ELSE BEGIN
                                            GLEntry.Amount :=
                                              ROUND(
                                                SalesTaxCalculate.ReverseCalculateTax(
                                                  "Tax Area Code", "Tax Group Code", "Tax Liable",
                                                  "Posting Date", "Amount (LCY)", Quantity, 0));
                                            GLEntry."VAT Amount" := "Amount (LCY)" - GLEntry.Amount;
                                        END;
                                        GLEntry."Additional-Currency Amount" := "Source Currency Amount";
                                        IF "Source Currency Code" = AddCurrencyCode THEN
                                            AddCurrGLEntryVATAmt := "Source Curr. VAT Amount"
                                        ELSE
                                            AddCurrGLEntryVATAmt := CalcLCYToAddCurr(GLEntry."VAT Amount");
                                    END;
                            END;
                        END;
                    "VAT Posting"::"Manual VAT Entry":
                        IF "Gen. Posting Type" <> "Gen. Posting Type"::Settlement THEN BEGIN
                            GLEntry.CopyPostingGroupsFromGenJnlLine(GenJnlLine);
                            GLEntry."VAT Amount" := "VAT Amount (LCY)";
                            IF ("Vendor Exchange Rate (ACY)" <> 0) OR
                               (("Vendor Exchange Rate (ACY)" = 1) AND
                                ("Source Currency Code" <> AddCurrencyCode))
                            THEN BEGIN
                                GLEntry."Additional-Currency Amount" :=
                                  "VAT Base (ACY)" + "Line Discount Amt. (ACY)" + "Inv. Discount Amt. (ACY)";
                                AddCurrGLEntryVATAmt := "Amount Including VAT (ACY)" - "VAT Base (ACY)";
                            END ELSE BEGIN
                                IF "Source Currency Code" = AddCurrencyCode THEN
                                    AddCurrGLEntryVATAmt := "Source Curr. VAT Amount"
                                ELSE
                                    AddCurrGLEntryVATAmt := CalcLCYToAddCurr("VAT Amount (LCY)");
                            END;
                        END;
                END;
                IF ("Account Type" = "Account Type"::"G/L Account") AND
                   ("Account No." IN [VATPostingSetup."Sales VAT Account",
                                      VATPostingSetup."Purchase VAT Account"])
                THEN
                    "BAS Adjustment" := FALSE;

                UseVendExchRate := "VAT Base (ACY)" <> 0;
            END;

        GLEntry."Additional-Currency Amount" :=
          GLCalcAddCurrency(GLEntry.Amount, GLEntry."Additional-Currency Amount", GLEntry."Additional-Currency Amount", TRUE, GenJnlLine, UseVendExchRate);
    end;

    local procedure CalcLCYToAddCurr(AmountLCY: Decimal): Decimal
    begin
        IF AddCurrencyCode = '' THEN
            EXIT;

        EXIT(ExchangeAmtLCYToFCY2(AmountLCY));
    end;

    local procedure InsertSummarizedVAT(GenJnlLine: Record "Gen. Journal Line")


    begin
        exit;//VAH temp
        IF TempGLEntryVAT.FINDSET THEN BEGIN
            REPEAT
                GenJnlPostLine.InsertGLEntry(GenJnlLine, TempGLEntryVAT, TRUE);
            UNTIL TempGLEntryVAT.NEXT = 0;
            TempGLEntryVAT.DELETEALL;
            //InsertedTempGLEntryVAT := 0; //VAH check
        END;
        //NextConnectionNo := NextConnectionNo + 1; //VAH check
    end;

    local procedure GLCalcAddCurrency(Amount: Decimal; AddCurrAmount: Decimal; OldAddCurrAmount: Decimal; UseAddCurrAmount: Boolean; GenJnlLine: Record "Gen. Journal Line"; var UseVendExchRateCheck: Boolean): Decimal
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        IF (AddCurrencyCode <> '') AND
           (GenJnlLine."Additional-Currency Posting" = GenJnlLine."Additional-Currency Posting"::None)
        THEN BEGIN
            IF (GenJnlLine."Source Currency Code" = AddCurrencyCode) AND UseAddCurrAmount THEN
                EXIT(AddCurrAmount);

            PurchSetup.GET;
            IF PurchSetup."Enable Vendor GST Amount (ACY)" AND UseVendExchRateCheck THEN
                EXIT(AddCurrAmount);

            EXIT(ExchangeAmtLCYToFCY2(Amount));
        END;
        //UseVendExchRate := FALSE; //VAH check
        EXIT(OldAddCurrAmount);
    end;

    local procedure ExchangeAmtLCYToFCY2(Amount: Decimal): Decimal
    begin
        IF UseCurrFactorOnly THEN
            EXIT(
              ROUND(
                CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(Amount, CurrencyFactor),
                AddCurrency."Amount Rounding Precision"));
        EXIT(
          ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              CurrencyDate, AddCurrencyCode, Amount, CurrencyFactor),
            AddCurrency."Amount Rounding Precision"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnVendUnrealizedVATOnBeforePostUnrealVATEntry', '', false, false)]
    local procedure OnVendUnrealizedVATOnBeforePostUnrealVATEntry(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLine: Record "Gen. Journal Line"; var VATEntry2: Record "VAT Entry"; var VATAmount: Decimal; var VATBase: Decimal; var VATAmountAddCurr: Decimal; var VATBaseAddCurr: Decimal; var GLEntryNo: Integer; VATPart: Decimal);
    var
        NewVATPercentage: Decimal;
        NewBase: Decimal;
        NewAmount: Decimal;
        NewVATAmount: Decimal;
        NewAmountIncVAT: Decimal;
        OldBase: Decimal;
        VATProdPostingGrp: Record "VAT Product Posting Group";
        AverageVATSetup: Record "Average VAT Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        GLEntry: Record "G/L Entry";
        PurchVATUnrealAccount: Code[20];
        GLSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        GLEntryLastEntry: Record "G/L Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        TotRemAmt: Decimal;
        TotAmtToApply: Decimal;
        AppliedPercent: Decimal;
    begin

        GLSetup.get;
        PurchSetup.Get();//VAH

        //TSA001
        IF GLSetup."Enable VAT Average" THEN BEGIN
            CLEAR(NewVATPercentage);
            CLEAR(NewBase);
            CLEAR(NewAmount);
            CLEAR(NewVATAmount);
            CLEAR(NewAmountIncVAT);
            CLEAR(OldBase);
            IF NOT VATProdPostingGrp.GET(VATEntry2."VAT Prod. Posting Group") THEN
                VATProdPostingGrp.INIT;
            IF NOT VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group") THEN
                VATPostingSetup.INIT;
            PurchVATUnrealAccount := VATPostingSetup."Purch. VAT Unreal. Account";//VAH                
            IF VATProdPostingGrp."Average VAT" THEN BEGIN
                AverageVATSetup.RESET;
                AverageVATSetup.SETFILTER("From Date", '<=%1', GenJnlLine."Posting Date");
                AverageVATSetup.SETFILTER("To Date", '>=%1', GenJnlLine."Posting Date");
                IF AverageVATSetup.FIND('+') THEN BEGIN
                    AverageVATSetup.TESTFIELD(AverageVATSetup."VAT Claim %");
                    IF AverageVATSetup."VAT Claim %" <> VATEntry2."VAT Claim Percentage" THEN BEGIN

                        /* OldBase := (VATAmount + VATBase -
                           VATEntry2."VAT Difference" * VATPart) * 100 / (100 + VATPostingSetup."VAT %");
                         NewAmountIncVAT := (VATAmount + VATBase);
                         NewVATAmount := ROUND((NewAmountIncVAT - OldBase) * AverageVATSetup."VAT Claim %" / 100);
                         IF (NewVATAmount - VATAmount) <> 0 THEN BEGIN*/
                        //>>VAH
                        //    OldBase := (VATEntry2."Unrealized Amount" + VATEntry2."Unrealized Base" -
                        //VATEntry2."VAT Difference" * VATPart) * 100 / (100 + VATPostingSetup."VAT %");
                        //NewAmountIncVAT := (VATAmount + VATBase);
                        //NewVATAmount := ROUND((NewAmountIncVAT - OldBase) * AverageVATSetup."VAT Claim %" / 100);


                        if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) and
                        (GenJnlLine."Applies-to Doc. No." <> '') and (GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice) then begin
                            VendLedgerEntry.Reset;
                            VendLedgerEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                            if GenJnlLine."Account Type" = GenJnlLine."account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", GenJnlLine."Account No.");
                            if GenJnlLine."Bal. Account Type" = GenJnlLine."bal. account type"::Vendor then VendLedgerEntry.SetRange("Vendor No.", GenJnlLine."Bal. Account No.");
                            VendLedgerEntry.SetRange("Document Type", GenJnlLine."Applies-to Doc. Type");
                            VendLedgerEntry.SetRange("Document No.", GenJnlLine."Applies-to Doc. No.");
                            if VendLedgerEntry.Find('-') then begin
                                repeat
                                    VendLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                                    TotRemAmt += (abs(VendLedgerEntry."Remaining Amt. (LCY)"));
                                //TotAmtToApply += VendLedgerEntry."Amount to Apply";
                                until VendLedgerEntry.Next = 0;
                                if TotRemAmt <> 0 then
                                    AppliedPercent := (GenJnlLine.Amount / TotRemAmt) * 100;
                            end;
                            if AppliedPercent <> 0 then
                                NewVATAmount := (VATEntry2."Unrealized Amount" * AppliedPercent) / 100
                            else
                                NewVATAmount := VATEntry2."Unrealized Amount";
                            IF (NewVATAmount - VATAmount) <> 0 THEN BEGIN
                                //<<VAH
                                PurchSetup.TESTFIELD("Average VAT Varience Account");

                                //GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry, PurchSetup."Average VAT Varience Account", -(NewVATAmount - VATAmount), 0, FALSE, TRUE);
                                Sender.IncrNextEntryNo();
                                Sender.IncrNextEntryNo();
                                GLEntryNo += 1;
                                Sender.InitGLEntry(GenJnlLine, GLEntry, PurchSetup."Average VAT Varience Account", (NewVATAmount - VATAmount), 0, FALSE, TRUE);

                                // if GLEntryLastEntry.FindLast() then
                                //   GLEntry."Entry No." := GLEntryLastEntry."Entry No." + 1;
                                //GLEntryNo += 5;
                                //GLEntry."Entry No." := GLEntryNo;
                                GLEntry."Bal. Account No." := PurchVATUnrealAccount;
                                //TempGLEntryVAT.Init();
                                //TempGLEntryVAT.TransferFields(GLEntry);
                                //TempGLEntryVAT.Insert();
                                SummarizeVATFromInitGLEntryVAT(GLEntry, (NewVATAmount - VATAmount));
                                //SummarizeVAT(GLSetup."Summarize G/L Entries", GLEntry);
                                //InitGLEntryVAT(GenJnlLine, PurchVATUnrealAccount, PurchSetup."Average VAT Varience Account", -(NewVATAmount - VATAmount), -VATAmountAddCurr, false);
                                GLEntryNo += 1;
                                Sender.InitGLEntry(GenJnlLine, GLEntry, PurchVATUnrealAccount, -(NewVATAmount - VATAmount), 0, FALSE, TRUE);
                                Sender.IncrNextEntryNo();
                                //GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry, PurchVATUnrealAccount, (NewVATAmount - VATAmount), 0, FALSE, TRUE);
                                //if GLEntryLastEntry.FindLast() then
                                //  GLEntry."Entry No." := GLEntryLastEntry."Entry No." + 2;
                                //GLEntryNo += 1;
                                //GLEntry."Entry No." := GLEntryNo;
                                GLEntry."Bal. Account No." := PurchSetup."Average VAT Varience Account";
                                //TempGLEntryVAT.Init();
                                //TempGLEntryVAT.TransferFields(GLEntry);
                                //TempGLEntryVAT.Insert();
                                //SummarizeVAT(GLSetup."Summarize G/L Entries", GLEntry);
                                SummarizeVATFromInitGLEntryVAT(GLEntry, -(NewVATAmount - VATAmount));

                                //VATBase := (VATAmount + VATBase) - NewVATAmount;
                                //VATAmount := NewVATAmount;
                                InsertSummarizedVAT(GenJnlLine);//VAH check
                                IF TempGLEntryVAT.FINDSET THEN BEGIN
                                    REPEAT
                                        sender.InsertGLEntry(GenJnlLine, TempGLEntryVAT, TRUE);
                                    UNTIL TempGLEntryVAT.NEXT = 0;
                                    TempGLEntryVAT.DELETEALL;
                                end;
                                GLEntryNo += 1;

                            END;
                        END;
                    END;
                END;
            END;
            //TSA001
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnVendUnrealizedVATOnBeforeInitGLEntryVAT', '', false, false)]
    local procedure OnVendUnrealizedVATOnBeforeInitGLEntryVAT(var GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; var VATAmount: Decimal; var VATBase: Decimal; var VATAmountAddCurr: Decimal; var VATBaseAddCurr: Decimal);

    var
        NewVATAmount: Decimal;
        NewAmountIncVAT: Decimal;
        OldBase: Decimal;
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        AverageVATSetup: Record "Average VAT Setup";
        GLSetup: Record "General Ledger Setup";
    begin
        //exit;
        GLSetup.get();
        IF not GLSetup."Enable VAT Average" THEN
            exit;
        // CLEAR(NewVATPercentage);
        // CLEAR(NewBase);
        // CLEAR(NewAmount);
        CLEAR(NewVATAmount);
        CLEAR(NewAmountIncVAT);
        CLEAR(OldBase);
        IF NOT VATProdPostingGrp.GET(VATEntry."VAT Prod. Posting Group") THEN
            VATProdPostingGrp.INIT;
        IF NOT VATPostingSetup.GET(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group") THEN
            VATPostingSetup.INIT;
        IF VATProdPostingGrp."Average VAT" THEN BEGIN
            AverageVATSetup.RESET;
            AverageVATSetup.SETFILTER("From Date", '<=%1', GenJournalLine."Posting Date");
            AverageVATSetup.SETFILTER("To Date", '>=%1', GenJournalLine."Posting Date");
            IF AverageVATSetup.FIND('+') THEN BEGIN
                AverageVATSetup.TESTFIELD(AverageVATSetup."VAT Claim %");
                IF AverageVATSetup."VAT Claim %" <> VATEntry."VAT Claim Percentage" THEN BEGIN

                    OldBase := (VATAmount + VATBase -
                      VATEntry."VAT Difference") * 100 / (100 + VATPostingSetup."VAT %");
                    NewAmountIncVAT := (VATAmount + VATBase);
                    NewVATAmount := ROUND((NewAmountIncVAT - OldBase) * AverageVATSetup."VAT Claim %" / 100);

                    //OldBase := (VATEntry."Unrealized Amount" + VATEntry.Base -
                    //VATEntry."VAT Difference") * 100 / (100 + VATPostingSetup."VAT %");

                    NewAmountIncVAT := (VATAmount + VATBase);
                    NewVATAmount := ROUND((NewAmountIncVAT - OldBase) * AverageVATSetup."VAT Claim %" / 100);

                    VATBase := (VATAmount + VATBase) - NewVATAmount;
                    VATAmount := NewVATAmount;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertPostUnrealVATEntry', '', false, false)]
    local procedure OnBeforeInsertPostUnrealVATEntry(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line"; var VATEntry2: Record "VAT Entry");
    var
        NewVATAmount: Decimal;
        NewAmountIncVAT: Decimal;
        OldBase: Decimal;
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        AverageVATSetup: Record "Average VAT Setup";
        GLSetup: Record "General Ledger Setup";
    begin
        exit;
        GLSetup.get();
        IF not GLSetup."Enable VAT Average" THEN
            exit;
        // CLEAR(NewVATPercentage);
        // CLEAR(NewBase);
        // CLEAR(NewAmount);
        CLEAR(NewVATAmount);
        CLEAR(NewAmountIncVAT);
        CLEAR(OldBase);
        IF NOT VATProdPostingGrp.GET(VATEntry."VAT Prod. Posting Group") THEN
            VATProdPostingGrp.INIT;
        IF NOT VATPostingSetup.GET(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group") THEN
            VATPostingSetup.INIT;
        IF VATProdPostingGrp."Average VAT" THEN BEGIN
            AverageVATSetup.RESET;
            AverageVATSetup.SETFILTER("From Date", '<=%1', GenJournalLine."Posting Date");
            AverageVATSetup.SETFILTER("To Date", '>=%1', GenJournalLine."Posting Date");
            IF AverageVATSetup.FIND('+') THEN BEGIN
                AverageVATSetup.TESTFIELD(AverageVATSetup."VAT Claim %");
                //IF AverageVATSetup."VAT Claim %" <> VATEntry."VAT Claim Percentage" THEN BEGIN
                /*
                                    OldBase := (VATAmount + VATBase -
                                      VATEntry."VAT Difference") * 100 / (100 + VATPostingSetup."VAT %");
                                    NewAmountIncVAT := (VATAmount + VATBase);
                                    NewVATAmount := ROUND((NewAmountIncVAT - OldBase) * AverageVATSetup."VAT Claim %" / 100);
                                    VATBase := (VATAmount + VATBase) - NewVATAmount;
                                    VATAmount := NewVATAmount;
                                    */
                VATEntry.Amount := VATEntry2.Amount - VATEntry.Amount;
                //end;
            end;
        end;
    end;


    local procedure GetCurrencyExchRate(GenJnlLine: Record "Gen. Journal Line")
    var
        NewCurrencyDate: Date;
        IsHandled: Boolean;
    begin
        if IsHandled then
            exit;

        if AddCurrencyCode = '' then
            exit;

        AddCurrency.Get(AddCurrencyCode);
        AddCurrency.TestField("Amount Rounding Precision");
        AddCurrency.TestField("Residual Gains Account");
        AddCurrency.TestField("Residual Losses Account");

        NewCurrencyDate := GenJnlLine."Posting Date";
        if GenJnlLine."Reversing Entry" then
            NewCurrencyDate := NewCurrencyDate - 1;
        if (NewCurrencyDate <> CurrencyDate) or
           UseCurrFactorOnly
        then begin
            UseCurrFactorOnly := false;
            CurrencyDate := NewCurrencyDate;
            CurrencyFactor :=
              CurrExchRate.ExchangeRate(CurrencyDate, AddCurrencyCode);
        end;
        if (GenJnlLine."FA Add.-Currency Factor" <> 0) and
           (GenJnlLine."FA Add.-Currency Factor" <> CurrencyFactor)
        then begin
            UseCurrFactorOnly := true;
            CurrencyDate := 0D;
            CurrencyFactor := GenJnlLine."FA Add.-Currency Factor";
        end;
    end;

    local procedure InitGLEntryVAT(GenJnlLine: Record "Gen. Journal Line"; AccNo: Code[20]; BalAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmtAddCurr: Boolean)
    var
        GLEntry: Record "G/L Entry";

    begin
        //OnBeforeInitGLEntryVAT(GenJnlLine, GLEntry);
        if UseAmtAddCurr then
            GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, AmountAddCurr, true, true)
        else begin
            GenJnlPostLine.InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, false, true);
            GLEntry."Additional-Currency Amount" := AmountAddCurr;
            GLEntry."Bal. Account No." := BalAccNo;
        end;
        SummarizeVATFromInitGLEntryVAT(GLEntry, Amount);
        //OnAfterInitGLEntryVAT(GenJnlLine, GLEntry);
    end;

    local procedure SummarizeVATFromInitGLEntryVAT(var GLEntry: Record "G/L Entry"; Amount: Decimal)
    var
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.get();
        IsHandled := false;
        //OnBeforeSummarizeVATFromInitGLEntryVAT(GLEntry, Amount, IsHandled);
        if IsHandled then
            exit;

        SummarizeVAT(GLSetup."Summarize G/L Entries", GLEntry);
    end;

    var
        TempGLEntryVAT: Record "G/L Entry" temporary;
        AddCurrencyCode: Code[10];
        AddCurrency: Record Currency;
        CurrencyDate: Date;
        UseCurrFactorOnly: Boolean;
        CurrencyFactor: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        InsertedTempGLEntryVAT: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
}

