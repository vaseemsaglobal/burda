Table 55002 "Petty Cash Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.
    // Burda
    // 002   14.08.2007   KKE   Average VAT.

    Caption = 'Petty Cash Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Petty Cash Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Petty Cash Vendor No."; Code[20])
        {
            Caption = 'Petty Cash Vendor No.';
            TableRelation = Vendor where("Petty Cash" = const(true));
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            InitValue = "G/L Account";
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item
            else
            if (Type = const(" ")) Resource
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge";

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Cross Reference";
            begin
                TestStatusOpen;
                TempPettyCashLine := Rec;
                Init;
                Type := TempPettyCashLine.Type;
                "No." := TempPettyCashLine."No.";
                if "No." = '' then
                    exit;
                GetPettyCashHdr;
                PettyCashHdr.TestField("Petty Cash Vendor No.");

                "Petty Cash Vendor No." := PettyCashHdr."Petty Cash Vendor No.";
                "Currency Code" := PettyCashHdr."Currency Code";
                "Shortcut Dimension 1 Code" := PettyCashHdr."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code" := PettyCashHdr."Shortcut Dimension 2 Code";
                Vendor.Get("Petty Cash Vendor No.");
                if Vendor."Name (Thai)" <> '' then
                    "Real Customer/Vendor Name" := Vendor."Name (Thai)"
                else
                    "Real Customer/Vendor Name" := Vendor.Name + ' ' + Vendor."Name 2";
                "Gen. Bus. Posting Group" := PettyCashHdr."Gen. Bus. Posting Group";
                "VAT Bus. Posting Group" := PettyCashHdr."VAT Bus. Posting Group";
                "WHT Business Posting Group" := PettyCashHdr."WHT Business Posting Group";

                TestField(Type, Type::"G/L Account");
                GLAcc.Get("No.");
                GLAcc.CheckGLAcc;
                GLAcc.TestField("Direct Posting", true);
                Description := GLAcc.Name;
                "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
                "WHT Product Posting Group" := GLAcc."WHT Product Posting Group";
                Validate("VAT Prod. Posting Group");

                CreateDim(
                  DimMgt.TypeToTableID3(Type), "No.",
                  0, '',
                  0, '');
            end;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(10; "Amount Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Incl. VAT';

            trigger OnValidate()
            begin
                GetPettyCashHdr;
                /*
                GLSetup.GET;
                Amount := ROUND(Amount,Currency."Amount Rounding Precision");
                CASE "VAT Calculation Type" OF
                  "VAT Calculation Type"::"Normal VAT",
                  "VAT Calculation Type"::"Reverse Charge VAT":
                    BEGIN
                      "VAT Base Amount" :=
                         ROUND(Amount,Currency."Amount Rounding Precision");
                      {
                      "VAT Base Amount (LCY)" :=
                         ROUND(
                           CurrExchRate.ExchangeAmtLCYToFCY(
                             PettyCashHdr."Posting Date",GLSetup."Additional Reporting Currency",
                           ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                             PettyCashHdr."Posting Date","Currency Code","VAT Base Amount",
                             PettyCashHdr."Currency Factor"),Currency."Amount Rounding Precision"),CurrencyFactor),
                             AddCurrency."Amount Rounding Precision");
                      }
                    END;
                  "VAT Calculation Type"::"Full VAT":
                    IF Amount <> 0 THEN
                      FIELDERROR(Amount,
                        STRSUBSTNO(
                          Text001,FIELDCAPTION("VAT Calculation Type"),
                          "VAT Calculation Type"));
                  "VAT Calculation Type"::"Sales Tax":
                    BEGIN
                      "VAT Base Amount" := Amount;
                    END;
                END;
                
                */
                GetCurrency;
                if "Currency Code" = '' then
                    "Amount (LCY) Incl. VAT" := "Amount Incl. VAT"
                else
                    "Amount (LCY) Incl. VAT" := ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        PettyCashHdr."Posting Date", "Currency Code",
                        "Amount Incl. VAT", PettyCashHdr."Currency Factor"));

                "Amount Incl. VAT" := ROUND("Amount Incl. VAT", Currency."Amount Rounding Precision");

                Validate("VAT %");

            end;
        }
        field(11; "Amount (LCY) Incl. VAT"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY) Incl. VAT';

            trigger OnValidate()
            begin
                if "Currency Code" = '' then begin
                    "Amount Incl. VAT" := "Amount (LCY) Incl. VAT";
                    Validate("Amount Incl. VAT");
                end else begin
                    if CheckFixedCurrency then begin
                        GetCurrency;
                        "Amount Incl. VAT" := ROUND(
                          CurrExchRate.ExchangeAmtLCYToFCY(
                            PettyCashHdr."Posting Date", "Currency Code",
                            "Amount (LCY) Incl. VAT", PettyCashHdr."Currency Factor"),
                            Currency."Amount Rounding Precision")
                    end else begin
                        TestField("Amount (LCY) Incl. VAT");
                        TestField("Amount Incl. VAT");
                        PettyCashHdr."Currency Factor" := "Amount Incl. VAT" / "Amount (LCY) Incl. VAT";
                    end;

                    Validate("VAT %");
                end;
            end;
        }
        field(12; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                GetPettyCashHdr;
                GetCurrency;
                case "VAT Calculation Type" of
                    "vat calculation type"::"Normal VAT",
                    "vat calculation type"::"Reverse Charge VAT":
                        begin
                            "VAT Base Amount" :=
                              ROUND("Amount Incl. VAT" / (1 + "VAT %" / 100), Currency."Amount Rounding Precision");
                            "VAT Amount" :=
                              ROUND("Amount Incl. VAT" - "VAT Base Amount", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                        end;
                    "vat calculation type"::"Full VAT":
                        "VAT Amount" := "Amount Incl. VAT";
                    "vat calculation type"::"Sales Tax":
                        /*
                        IF ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) AND
                        THEN BEGIN
                          "VAT Amount" := 0;
                          "VAT %" := 0;
                        END ELSE BEGIN
                          "VAT Amount" :=
                            Amount -
                            SalesTaxCalculate.ReverseCalculateTax(
                              "Tax Area Code","Tax Group Code","Tax Liable",
                              "Posting Date",Amount,Quantity,"Currency Factor");
                          IF Amount - "VAT Amount" <> 0 THEN
                            "VAT %" := ROUND(100 * "VAT Amount" / (Amount - "VAT Amount"),0.00001)
                          ELSE
                            "VAT %" := 0;
                          "VAT Amount" :=
                            ROUND("VAT Amount",Currency."Amount Rounding Precision");
                        END;
                        */
                        ;
                end;
                "VAT Base Amount" := "Amount Incl. VAT" - "VAT Amount";
                "VAT Difference" := 0;

                if "Currency Code" = '' then
                    "VAT Amount (LCY)" := "VAT Amount"
                else
                    "VAT Amount (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          PettyCashHdr."Posting Date", "Currency Code",
                          "VAT Amount", PettyCashHdr."Currency Factor"));
                "VAT Base Amount (LCY)" := "Amount (LCY) Incl. VAT" - "VAT Amount (LCY)";

                //KKE : #002 +
                "VAT Claim %" := 0;
                "VAT Unclaim %" := 0;
                "Avg. VAT Amount" := 0;
                "Average VAT Year" := 0;
                GetGLSetup;
                if GLSetup."Enable VAT Average" then begin
                    if not VATProdPostingGrp.Get("VAT Prod. Posting Group") then
                        VATProdPostingGrp.Init;
                    if VATProdPostingGrp."Average VAT" then begin
                        AverageVATSetup.Reset;
                        AverageVATSetup.SetFilter("From Date", '<=%1', PettyCashHdr."Posting Date");
                        AverageVATSetup.SetFilter("To Date", '>=%1', PettyCashHdr."Posting Date");
                        if AverageVATSetup.Find('+') then begin
                            AverageVATSetup.TestField("VAT Claim %");
                            "VAT Claim %" := AverageVATSetup."VAT Claim %";
                            "VAT Unclaim %" := AverageVATSetup."VAT Unclaim %";
                            "Avg. VAT Amount" :=
                              ROUND(("Amount Incl. VAT" - "VAT Base Amount") * "VAT Claim %" / 100,
                              Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                            "Average VAT Year" := AverageVATSetup.Year;
                        end;
                    end;
                end;
                //KKE : #002 -

            end;
        }
        field(13; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
        }
        field(14; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';

            trigger OnValidate()
            begin
                PettyCashSetup.Get;
                PettyCashSetup.TestField("Allow VAT Difference", true);
                if not ("VAT Calculation Type" in
                  ["vat calculation type"::"Normal VAT", "vat calculation type"::"Reverse Charge VAT"])
                then
                    Error(
                      Text010, FieldCaption("VAT Calculation Type"),
                      "vat calculation type"::"Normal VAT", "vat calculation type"::"Reverse Charge VAT");
                if "VAT Amount" <> 0 then begin
                    TestField("VAT %");
                    TestField("Amount Incl. VAT");
                end;

                GetCurrency;
                "VAT Amount" := ROUND("VAT Amount", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);

                if "VAT Amount" * "Amount Incl. VAT" < 0 then
                    if "VAT Amount" > 0 then
                        Error(Text011, FieldCaption("VAT Amount"))
                    else
                        Error(Text012, FieldCaption("VAT Amount"));

                "VAT Base Amount" := "Amount Incl. VAT" - "VAT Amount";

                "VAT Difference" :=
                  "VAT Amount" -
                  ROUND(
                    "Amount Incl. VAT" * "VAT %" / (100 + "VAT %"),
                    Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                if Abs("VAT Difference") > Currency."Max. VAT Difference Allowed" then
                    Error(Text013, FieldCaption("VAT Difference"), Currency."Max. VAT Difference Allowed");

                if "Currency Code" = '' then
                    "VAT Amount (LCY)" := "VAT Amount"
                else
                    "VAT Amount (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          PettyCashHdr."Posting Date", "Currency Code",
                          "VAT Amount", PettyCashHdr."Currency Factor"));
                "VAT Base Amount (LCY)" := "Amount (LCY) Incl. VAT" - "VAT Amount (LCY)";
            end;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(20; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(21; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                TestStatusOpen;
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(22; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                Validate("VAT Prod. Posting Group");
            end;
        }
        field(23; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                TestStatusOpen;
                VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                "VAT Difference" := 0;
                "VAT %" := VATPostingSetup."VAT %";
                "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                case "VAT Calculation Type" of
                    "vat calculation type"::"Reverse Charge VAT",
                  "vat calculation type"::"Sales Tax":
                        "VAT %" := 0;
                    "vat calculation type"::"Full VAT":
                        begin
                            TestField(Type, Type::"G/L Account");
                            VATPostingSetup.TestField("Purchase VAT Account");
                            TestField("No.", VATPostingSetup."Purchase VAT Account");
                        end;
                end;
                Validate("VAT %");
                //UpdateAmounts;
            end;
        }
        field(24; "WHT Business Posting Group"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            TableRelation = "WHT Business Posting Group";
        }
        field(25; "WHT Product Posting Group"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            TableRelation = "WHT Product Posting Group";
        }
        field(26; "WHT Absorb Base"; Decimal)
        {
            Caption = 'WHT Absorb Base';
        }
        field(30; "Real Customer/Vendor Name"; Text[120])
        {
            Caption = 'Real Customer/Vendor Name';
        }
        field(31; "Actual Vendor No."; Code[20])
        {
            Caption = 'Actual Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Actual Vendor No.") then
                    if Vendor."Name (Thai)" <> '' then
                        "Real Customer/Vendor Name" := Vendor."Name (Thai)"
                    else
                        "Real Customer/Vendor Name" := Vendor.Name + ' ' + Vendor."Name 2";
            end;
        }
        field(32; "Skip WHT"; Boolean)
        {
            Caption = 'Skip WHT';

            trigger OnValidate()
            begin
                if "Skip WHT" then
                    TestField("Certificate Printed", false);
            end;
        }
        field(33; "WHT Certificate No."; Code[20])
        {
            Caption = 'WHT Certificate No.';
        }
        field(34; "Certificate Printed"; Boolean)
        {
            Caption = 'Certificate Printed';
            Editable = false;
        }
        field(35; "WHT Entry No."; Integer)
        {
            Caption = 'WHT Entry No.';
        }
        field(40; "Tax Invoice No."; Code[20])
        {
            Caption = 'Tax Invoice No.';
        }
        field(41; "Tax Invoice Date"; Date)
        {
            Caption = 'Tax Invoice Date';
        }
        field(42; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(50; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Amount (LCY)';
            Editable = false;
        }
        field(79; "VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Base Amount (LCY)';
            Editable = false;
        }
        field(85; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';

            trigger OnValidate()
            begin
                Validate("VAT %");
            end;
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(50020; "VAT Claim %"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50021; "VAT Unclaim %"; Decimal)
        {
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50022; "Avg. VAT Amount"; Decimal)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50024; "Average VAT Year"; Integer)
        {
            Description = 'Burda1.00';
            TableRelation = "Average VAT Setup";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Amount Incl. VAT", "Amount (LCY) Incl. VAT";
        }
        key(Key2; "Actual Vendor No.", "WHT Business Posting Group", "WHT Product Posting Group")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestStatusOpen;
        TestField("Certificate Printed", false);
    end;

    trigger OnInsert()
    var
    //DocDim: Record "Document Dimension";
    begin
        TestStatusOpen;

        // DocDim.LockTable;
        LockTable;
        PettyCashHdr."No." := '';

        //DimMgt.InsertDocDim(
        //Database::"Petty Cash Line", DocDim."document type"::Invoice, "Document No.", "Line No.",
        //"Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        TestStatusOpen;
    end;

    var
        PettyCashSetup: Record "Petty Cash Setup";
        PettyCashHdr: Record "Petty Cash Header";
        TempPettyCashLine: Record "Petty Cash Line";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        Vendor: Record Vendor;
        GLAcc: Record "G/L Account";
        GLSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        VATProdPostingGrp: Record "VAT Product Posting Group";
        AverageVATSetup: Record "Average VAT Setup";
        Currency: Record Currency;
        AddCurrency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Text000: label 'cannot be specified without %1';
        DimMgt: Codeunit DimensionManagement;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        CurrencyCode: Code[10];
        CurrencyFactor: Decimal;
        Text001: label ' must be 0 when %1 is %2.';
        Text010: label '%1 must be %2 or %3.';
        Text011: label '%1 must be negative.';
        Text012: label '%1 must be positive.';
        Text013: label 'The %1 must not be more than %2.';


    procedure GetPettyCashHdr()
    begin
        TestField("Document No.");
        if "Document No." <> PettyCashHdr."No." then begin
            PettyCashHdr.Get("Document No.");
            if PettyCashHdr."Currency Code" = '' then
                Currency.InitRoundingPrecision
            else begin
                PettyCashHdr.TestField("Currency Factor");
                Currency.Get(PettyCashHdr."Currency Code");
                Currency.TestField("Amount Rounding Precision");
            end;
            GetGLSetup;
            Clear(CurrencyFactor);
            if GLSetup."Additional Reporting Currency" <> '' then begin
                AddCurrency.Get(GLSetup."Additional Reporting Currency");
                CurrencyFactor :=
                  CurrExchRate.ExchangeRate(
                    PettyCashHdr."Posting Date", GLSetup."Additional Reporting Currency");
            end;
        end;
    end;

    local procedure TestStatusOpen()
    begin
        GetPettyCashHdr;
        PettyCashHdr.TestField(Status, PettyCashHdr.Status::Open);
    end;

    local procedure GetCurrency()
    begin
        CurrencyCode := "Currency Code";

        if CurrencyCode = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision
        end else
            if CurrencyCode <> Currency.Code then begin
                Currency.Get(CurrencyCode);
                Currency.TestField("Amount Rounding Precision");
            end;
    end;


    procedure CheckFixedCurrency(): Boolean
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        CurrExchRate.SetRange("Currency Code", "Currency Code");
        CurrExchRate.SetRange("Starting Date", 0D, PettyCashHdr."Posting Date");

        if not CurrExchRate.Find('+') then
            exit(false);

        if CurrExchRate."Relational Currency Code" = '' then
            exit(
              CurrExchRate."Fix Exchange Rate Amount" =
              CurrExchRate."fix exchange rate amount"::Both);

        if CurrExchRate."Fix Exchange Rate Amount" <>
          CurrExchRate."fix exchange rate amount"::Both
        then
            exit(false);

        CurrExchRate.SetRange("Currency Code", CurrExchRate."Relational Currency Code");
        if CurrExchRate.Find('+') then
            exit(
              CurrExchRate."Fix Exchange Rate Amount" =
              CurrExchRate."fix exchange rate amount"::Both);

        exit(false);
    end;


    /*procedure ShowDimensions()
    var
        DocDim: Record "Document Dimension";
        DocDimensions: Page UnknownPage546;
    begin
        TestField("Document No.");
        TestField("Line No.");
        DocDim.SetRange("Table ID", Database::"Petty Cash Line");
        DocDim.SetRange("Document Type", DocDim."document type"::Invoice);
        DocDim.SetRange("Document No.", "Document No.");
        DocDim.SetRange("Line No.", "Line No.");
        DocDimensions.SetTableview(DocDim);
        DocDimensions.RunModal;
    end;*/
    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin


        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 ', "Document No.", "Line No."));
        //VerifyItemLineDim();
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //ATOLink.UpdateAsmDimFromSalesLine(Rec);
        IsChanged := OldDimSetID <> "Dimension Set ID";


    end;



    local procedure GetGLSetup()
    begin
        GLSetup.Get;
    end;


    procedure SetPettyCashHeader(NewPettyCashHeader: Record "Petty Cash Header")
    begin
        PettyCashHdr := NewPettyCashHeader;

        if PettyCashHdr."Currency Code" = '' then
            Currency.InitRoundingPrecision
        else begin
            PettyCashHdr.TestField("Currency Factor");
            Currency.Get(PettyCashHdr."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
    end;


    /*procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        DocDim: Record "Document Dimension";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        DimMgt.GetPreviousDocDefaultDim(
          Database::"Petty Cash Header", DocDim."document type"::Invoice, "Document No.", 0,
          Database::Vendor, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        DimMgt.GetDefaultDim(
          TableID, No, SourceCodeSetup."Petty Cash",
          "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if "Line No." <> 0 then
            DimMgt.UpdateDocDefaultDim(
              Database::"Petty Cash Line", DocDim."document type"::Invoice, "Document No.", "Line No.",
              "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;*/
    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        IsHandled: Boolean;
        PettyCashHeader: record "Petty Cash Header";
    begin


        SourceCodeSetup.Get();
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        //OnAfterCreateDimTableIDs(Rec, CurrFieldNo, TableID, No);

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        //GetSalesHeader();
        PettyCashHeader.Get("Document No.");
        "Dimension Set ID" :=
          DimMgt.GetRecDefaultDimID(
            Rec, CurrFieldNo, TableID, No, SourceCodeSetup.Sales,
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", PettyCashHeader."Dimension Set ID", DATABASE::Customer);
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //ATOLink.UpdateAsmDimFromSalesLine(Rec);

        //OnAfterCreateDim(Rec, CurrFieldNo);
    end;


    /*procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DocDim: Record "Document Dimension";
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        if "Line No." <> 0 then begin
            DimMgt.SaveDocDim(
              Database::"Petty Cash Line", DocDim."document type"::Invoice, "Document No.",
              "Line No.", FieldNumber, ShortcutDimCode);
            Modify;
        end else
            DimMgt.SaveTempDim(FieldNumber, ShortcutDimCode);
    end;*/
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode, IsHandled);
        if IsHandled then
            exit;

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        //VerifyItemLineDim();

        //OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;


    /*procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DocDim: Record "Document Dimension";
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        if "Line No." <> 0 then begin
            DimMgt.SaveDocDim(
              Database::"Petty Cash Line", DocDim."document type"::Invoice, "Document No.",
              "Line No.", FieldNumber, ShortcutDimCode);
            Modify;
        end else
            DimMgt.SaveTempDim(FieldNumber, ShortcutDimCode);
    end;*/
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeLookupShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode, IsHandled);
        if IsHandled then
            exit;

        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;


    /*procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    var
        DocDim: Record "Document Dimension";
    begin
        if "Line No." <> 0 then
            DimMgt.ShowDocDim(
              Database::"Petty Cash Line", DocDim."document type"::Invoice, "Document No.",
              "Line No.", ShortcutDimCode)
        else
            DimMgt.ShowTempDim(ShortcutDimCode);
    end;*/

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

}

