Table 55001 "Petty Cash Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.

    Caption = 'Petty Cash Header';
    DrillDownPageID = "Petty Cash Invoices";
    LookupPageID = "Petty Cash Invoices";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Petty Cash Vendor No."; Code[20])
        {
            Caption = 'Petty Cash Vendor No.';
            TableRelation = Vendor where("Petty Cash" = const(true));

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if ("Petty Cash Vendor No." <> xRec."Petty Cash Vendor No.") and
                   (xRec."Petty Cash Vendor No." <> '')
                then begin
                    if HideValidationDialog then
                        Confirmed := true
                    else
                        Confirmed := Confirm(Text001, false, FieldCaption("Petty Cash Vendor No."));
                    if Confirmed then begin
                        PettyCashLine.SetRange("Document No.", "No.");
                        if "Petty Cash Vendor No." = '' then begin
                            if PettyCashLine.Find('-') then
                                Error(
                                  Text004,
                                  FieldCaption("Petty Cash Vendor No."));
                            Init;
                            "No. Series" := xRec."No. Series";
                            InitRecord;
                            exit;
                        end;
                        PettyCashLine.Reset;
                    end else begin
                        Rec := xRec;
                        exit;
                    end;
                end;

                GetVend("Petty Cash Vendor No.");
                Vend.CheckBlockedVendOnDocs(Vend, false);
                Vend.CheckVendorPettyCash;
                Vend.TestField("Gen. Bus. Posting Group");
                Name := Vend.Name;
                "Name 2" := Vend."Name 2";
                Address := Vend.Address;
                "Address 2" := Vend."Address 2";
                "Address 3" := Vend."Address 3";
                "Name (Thai)" := Vend."Name (Thai)";
                "Address (Thai)" := Vend."Address (Thai)";
                City := Vend.City;
                "Post Code" := Vend."Post Code";
                County := Vend.County;
                "Country Code" := Vend."Country/Region Code";
                if not SkipPayToContact then
                    Contact := Vend.Contact;

                Validate("Location Code", Vend."Location Code");
                Validate("Currency Code", Vend."Currency Code");
                "Petty Cash Amount" := Vend."Petty Cash Amount";
                Validate("Gen. Bus. Posting Group", Vend."Gen. Bus. Posting Group");
                Validate("VAT Bus. Posting Group", Vend."VAT Bus. Posting Group");
                Validate("WHT Business Posting Group", Vend."WHT Business Posting Group");
            end;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(7; "Petty Cash Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Petty Cash Amount';
            Editable = false;
        }
        field(8; "Balance Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Petty Cash Vendor No."),
                                                                          "Posting Date" = field("Date Filter")));
            Caption = 'Balance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Invoice Description"; Text[50])
        {
            Caption = 'Invoice Description';
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(11; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
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
                TestField(Status, Status::Open);
                if (xRec."Petty Cash Vendor No." = "Petty Cash Vendor No.") and
                   (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group")
                then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then begin
                        "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
                        RecreatePettyCashLines(FieldCaption("Gen. Bus. Posting Group"));
                    end;
            end;
        }
        field(21; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if (xRec."Petty Cash Vendor No." = "Petty Cash Vendor No.") and
                   (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
                then
                    RecreatePettyCashLines(FieldCaption("VAT Bus. Posting Group"));
            end;
        }
        field(22; "WHT Business Posting Group"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            TableRelation = "WHT Business Posting Group";
        }
        field(25; "Printing WHT Slip (Doc:WHT)"; Option)
        {
            Caption = 'Printing WHT Slip (Doc:WHT)';
            OptionMembers = "1:1","1:N";
        }
        field(30; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(31; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(32; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(33; "Address 3"; Text[30])
        {
            Caption = 'Address 3';
        }
        field(34; "Name (Thai)"; Text[120])
        {
            Caption = 'Name (Thai)';
        }
        field(35; "Address (Thai)"; Text[200])
        {
            Caption = 'Address (Thai)';
        }
        field(36; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                PostCodeCheck.LookUpCity(
                  CurrFieldNo, Database::"Petty Cash Header", Rec.GetPosition, 4,
                  Name, "Name 2", Contact, Address, "Address 2",
                  City, "Post Code", County, "Country Code", true);
            end;

            trigger OnValidate()
            begin
                PostCodeCheck.ValidateCity(
                  CurrFieldNo, Database::"Petty Cash Header", Rec.GetPosition, 4,
                  Name, "Name 2", Contact, Address, "Address 2",
                  City, "Post Code", County, "Country Code");
            end;
        }
        field(37; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(38; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCodeCheck.LookUpPostCode(
                  CurrFieldNo, Database::"Petty Cash Header", Rec.GetPosition, 4,
                  Name, "Name 2", Contact, Address, "Address 2",
                  City, "Post Code", County, "Country Code", true);
            end;

            trigger OnValidate()
            begin
                PostCodeCheck.ValidatePostCode(
                  CurrFieldNo, Database::"Petty Cash Header", Rec.GetPosition, 4,
                  Name, "Name 2", Contact, Address, "Address 2",
                  City, "Post Code", County, "Country Code");
            end;
        }
        field(39; County; Text[30])
        {
            Caption = 'County';
        }
        field(40; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = exist("Petty Cash Comment Line" where("Document Type" = const(Invoice),
                                                                 "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
            //LoginMgt: Codeunit "Login Management";
            begin
                //LoginMgt.LookupUserID("User ID");
            end;
        }
        field(48; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(50; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if not (CurrFieldNo in [0, FieldNo("Posting Date")]) then
                    TestField(Status, Status::Open);
                if CurrFieldNo <> FieldNo("Currency Code") then
                    UpdateCurrencyFactor
                else begin
                    if "Currency Code" <> xRec."Currency Code" then begin
                        UpdateCurrencyFactor;
                        RecreatePettyCashLines(FieldCaption("Currency Code"));
                    end else
                        if "Currency Code" <> '' then begin
                            UpdateCurrencyFactor;
                            if "Currency Factor" <> xRec."Currency Factor" then
                                ConfirmUpdateCurrencyFactor;
                        end;
                end;
            end;
        }
        field(51; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Currency Factor" <> xRec."Currency Factor" then
                    UpdatePettyCashLines(FieldCaption("Currency Factor"));
            end;
        }
        field(52; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //DimMgt.DeleteDocDim(Database::"Petty Cash Header",DocDim."document type"::Invoice,"No.",0);

        PettyCashLine.LockTable;
        PettyCashLine.SetRange("Document No.", "No.");
        PettyCashLine.DeleteAll;

        PettyCashCmtLine.SetRange("Document Type", PettyCashCmtLine."document type"::Invoice);
        PettyCashCmtLine.SetRange("No.", "No.");
        PettyCashCmtLine.DeleteAll;

        //PostCodeCheck.DeleteAllAddressID(Database::"Petty Cash Header", Rec.GetPosition); //SAG
        DeleteAllAddressID(Database::"Petty Cash Header", Rec.GetPosition);//SAG
    end;

    trigger OnInsert()
    begin
        PettyCashSetup.Get;

        if "No." = '' then begin
            PettyCashSetup.TestField("Petty Cash Nos.");
            NoSeriesMgt.InitSeries(PettyCashSetup."Petty Cash Nos.", xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;

        InitRecord;

        "Posting Date" := WorkDate;
        "Document Date" := WorkDate;
    end;

    trigger OnModify()
    begin
        TestField(Status, Status::Open);
    end;

    var
        PettyCashHeader: Record "Petty Cash Header";
        PettyCashLine: Record "Petty Cash Line";
        PettyCashSetup: Record "Petty Cash Setup";
        PettyCashCmtLine: Record "Petty Cash Comment Line";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        Vend: Record Vendor;
        SourceCodeSetup: Record "Source Code Setup";
        //DocDim: Record "Document Dimension";
        GLSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: label 'Do you want to change %1?';
        Text002: label 'If you change %1, the existing petty cash invoice lines will be deleted and new petty cash invoice lines based on the new information in the header will be created.\\';
        DimMgt: Codeunit DimensionManagement;
        PostCodeCheck: Codeunit "Post Code Check";
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Text003: label 'You must delete the existing petty cash invoice lines before you can change %1.';
        Text004: label 'You cannot reset %1 because the document still has one or more lines.';
        CurrencyDate: Date;
        Text005: label 'Do you want to update the exchange rate?';
        Text025: label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        SkipPayToContact: Boolean;
        Text028: label 'There is nothing to release for %1.';
        Text029: label 'The WHT Absorb Base must be positive.';
        Text030: label 'Actual Vendor No. on Petty Cash Line must be the same.';


    procedure InitRecord()
    begin
        if ("Posting Date" = 0D)
        then
            "Posting Date" := WorkDate;
        "Document Date" := WorkDate;

        SourceCodeSetup.Get;
        SourceCodeSetup.TestField("Petty Cash");
        "Source Code" := SourceCodeSetup."Petty Cash";
    end;


    procedure AssistEdit(OldPettyCashHeader: Record "Petty Cash Header"): Boolean
    begin
        PettyCashSetup.Get;
        PettyCashSetup.TestField("Petty Cash Nos.");
        if NoSeriesMgt.SelectSeries(PettyCashSetup."Petty Cash Nos.", OldPettyCashHeader."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;


    procedure RecreatePettyCashLines(ChangedFieldName: Text[100])
    var
        PettyCashLineTmp: Record "Petty Cash Line" temporary;
    begin
        if PettyCashLinesExist then begin
            if HideValidationDialog then
                Confirmed := true
            else
                Confirmed :=
                  Confirm(
                    Text002 +
                     Text001, false, ChangedFieldName);
            if Confirmed then begin
                //DocDim.LockTable;
                PettyCashLine.LockTable;
                Modify;

                PettyCashLine.Reset;
                PettyCashLine.SetRange("Document No.", "No.");
                if PettyCashLine.Find('-') then begin
                    repeat
                        PettyCashLineTmp := PettyCashLine;
                        PettyCashLine.Modify;
                        PettyCashLineTmp.Insert;
                    until PettyCashLine.Next = 0;

                    PettyCashLine.DeleteAll(true);

                    PettyCashLine.Init;
                    PettyCashLine."Line No." := 0;
                    PettyCashLineTmp.Find('-');
                    repeat
                        PettyCashLine.Init;
                        PettyCashLine."Line No." := PettyCashLine."Line No." + 10000;
                        PettyCashLine.Validate(Type, PettyCashLineTmp.Type);
                        if PettyCashLineTmp."No." = '' then begin
                            PettyCashLine.Validate(Description, PettyCashLineTmp.Description);
                            PettyCashLine.Validate("Description 2", PettyCashLineTmp."Description 2");
                        end else begin
                            PettyCashLine.Validate("No.", PettyCashLineTmp."No.");
                            if PettyCashLine.Type <> PettyCashLine.Type::" " then begin
                                PettyCashLine.Validate("Amount Incl. VAT", PettyCashLineTmp."Amount Incl. VAT");
                            end;
                        end;
                        PettyCashLine.Insert;
                    until PettyCashLineTmp.Next = 0;

                    PettyCashLineTmp.Reset;
                    PettyCashLineTmp.DeleteAll;
                end;
            end else
                Error(
                  Text003, ChangedFieldName);
        end;
    end;


    procedure PettyCashLinesExist(): Boolean
    begin
        PettyCashLine.Reset;
        PettyCashLine.SetRange("Document No.", "No.");
        exit(PettyCashLine.Find('-'));
    end;

    local procedure GetVend(VendNo: Code[20])
    begin
        if VendNo <> Vend."No." then
            Vend.Get(VendNo);
    end;

    local procedure UpdateCurrencyFactor()
    begin
        if "Currency Code" <> '' then begin
            GLSetup.Get;
            CurrencyDate := "Posting Date";

            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;

    local procedure ConfirmUpdateCurrencyFactor()
    begin
        if HideValidationDialog then
            Confirmed := true
        else
            Confirmed := Confirm(Text005, false);
        if Confirmed then
            Validate("Currency Factor")
        else
            "Currency Factor" := xRec."Currency Factor";
    end;


    procedure UpdatePettyCashLines(ChangedFieldName: Text[100])
    var
        xPettyCashLine: Record "Petty Cash Line";
        UpdateConfirmed: Boolean;
    begin
        if PettyCashLinesExist then begin

            if not GuiAllowed then
                UpdateConfirmed := true;

            //DocDim.LockTable;
            PettyCashLine.LockTable;
            Modify;

            repeat
                xPettyCashLine := PettyCashLine;
                case ChangedFieldName of
                    FieldCaption("Currency Factor"):
                        if PettyCashLine.Type <> PettyCashLine.Type::" " then
                            PettyCashLine.Validate("Amount Incl. VAT");
                end;
                PettyCashLine.Modify(true);
            until PettyCashLine.Next = 0;
        end;
    end;


    /*procedure ShowDocDim()
    var
        DocDim: Record "Document Dimension";
        DocDims: Page UnknownPage546;
    begin
        DocDim.SetRange("Table ID", Database::"Petty Cash Header");
        DocDim.SetRange("Document Type", DocDim."document type"::Invoice);
        DocDim.SetRange("Document No.", "No.");
        DocDim.SetRange("Line No.", 0);
        DocDims.SetTableview(DocDim);
        DocDims.RunModal;
        Get("No.");
    end;*/
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeShowDocDim(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //OnShowDocDimOnBeforeUpdateSalesLines(Rec, xRec);
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            //if SalesLinesExist then
            //UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;


    /*procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        if "No." <> '' then begin
            DimMgt.SaveDocDim(
              Database::"Petty Cash Header", DocDim."document type"::Invoice, "No.", 0, FieldNumber, ShortcutDimCode);
            Modify;
        end else
            DimMgt.SaveTempDim(FieldNumber, ShortcutDimCode);
    end;*/
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        //OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            Modify;

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            //if SalesLinesExist then
            //UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;

        //OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;


    procedure Release()
    var
        xPettyCashLine: Record "Petty Cash Line";
    begin
        if Status = Status::Released then
            exit;

        TestField("Petty Cash Vendor No.");
        TestField("Posting Date");

        GetVend("Petty Cash Vendor No.");
        Vend.CheckVendorPettyCash;

        CheckPettyCashLine;

        xPettyCashLine.Reset;
        xPettyCashLine.SetRange("Document No.", "No.");
        xPettyCashLine.SetFilter(Type, '>0');
        xPettyCashLine.SetFilter("Amount Incl. VAT", '<>0');
        if not xPettyCashLine.Find('-') then
            Error(Text028, "No.");

        xPettyCashLine.SetFilter("WHT Absorb Base", '<%1', 0);
        if xPettyCashLine.Find('-') then
            Error(Text029);

        Status := Status::Released;
        Modify;
    end;


    procedure Reopen()
    begin
        if Status = Status::Open then
            exit;

        Status := Status::Open;
        Modify;
    end;


    procedure CheckPettyCashLine()
    var
        PettyCashLine2: Record "Petty Cash Line";
        WHTPostingSetup: Record "WHT Posting Setup";
        ActualVendNo: Code[20];
    begin
        ActualVendNo := '';
        PettyCashLine2.Reset;
        PettyCashLine2.SetRange("Document No.", "No.");
        PettyCashLine2.SetFilter("Amount (LCY) Incl. VAT", '<>0');
        if PettyCashLine2.Find('-') then
            repeat
                PettyCashLine2.TestField(Type, PettyCashLine2.Type::"G/L Account");

                if PettyCashLine2."VAT %" <> 0 then
                    PettyCashLine2.TestField("Actual Vendor No.");
                if not PettyCashLine2."Skip WHT" then begin
                    WHTPostingSetup.Get(PettyCashLine2."WHT Business Posting Group", PettyCashLine2."WHT Product Posting Group");
                    if WHTPostingSetup."WHT %" <> 0 then begin
                        PettyCashLine2.TestField("Actual Vendor No.");
                        if "Printing WHT Slip (Doc:WHT)" = "printing wht slip (doc:wht)"::"1:1" then begin
                            if ActualVendNo = '' then
                                ActualVendNo := PettyCashLine2."Actual Vendor No."
                            else
                                if ActualVendNo <> PettyCashLine2."Actual Vendor No." then
                                    Error(Text030);
                        end;
                    end;
                end;
            until PettyCashLine2.Next = 0;
    end;
    //>>SAG
    procedure DeleteAllAddressID(TableNo: Integer; TableKey: Text[1024])
    var
        AddressID: Record "Address ID";
    begin
        AddressID.SetRange("Table No.", TableNo);
        AddressID.SetRange("Table Key", TableKey);
        AddressID.DeleteAll();
    end;
    //<<SAG
}

