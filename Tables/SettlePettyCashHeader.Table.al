Table 55006 "Settle Petty Cash Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.
    // 002   22.01.2007   KKE   Add new field "Cheque Date" - Show on Print Cheque,Cheque ledger entries

    Caption = 'Settle Petty Cash Header';
    DrillDownPageID = "Settle Petty Cash List";
    LookupPageID = "Settle Petty Cash List";

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
                        SettlePettyCashLine.SetRange("Settle Petty Cash No.", "No.");
                        if "Petty Cash Vendor No." = '' then begin
                            if SettlePettyCashLine.Find('-') then
                                Error(
                                  Text004,
                                  FieldCaption("Petty Cash Vendor No."));
                            Init;
                            "No. Series" := xRec."No. Series";
                            InitRecord;
                            exit;
                        end;
                        SettlePettyCashLine.Reset;
                    end else begin
                        Rec := xRec;
                        exit;
                    end;
                end;

                GetVend("Petty Cash Vendor No.");
                "Petty Cash Name" := Vend.Name;
                Validate("Location Code", Vend."Location Code");
                Validate("Currency Code", Vend."Currency Code");
                "Petty Cash Amount" := Vend."Petty Cash Amount";
            end;
        }
        field(3; "Petty Cash Name"; Text[50])
        {
            Caption = 'Petty Cash Name';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; "Petty Cash Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Petty Cash Amount';
            Editable = false;
        }
        field(7; "Balance Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Petty Cash Vendor No."),
                                                                           "Posting Date" = field("Date Filter")));
            Caption = 'Balance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Balance Settle"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Settle Petty Cash Line"."Amount (LCY) Incl. VAT" where("Settle Petty Cash No." = field("No.")));
            Caption = 'Balance Settle';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Payment Invoice Description"; Text[50])
        {
            Caption = 'Payment Invoice Description';
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
        field(12; "Settle Account Type"; Option)
        {
            Caption = 'Settle Account Type';
            InitValue = "Bank Account";
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";

            trigger OnValidate()
            begin
                if "Settle Account Type" <> xRec."Settle Account Type" then
                    "Settle Account No." := '';
            end;
        }
        field(13; "Settle Account No."; Code[20])
        {
            Caption = 'Settle Account No.';
            TableRelation = if ("Settle Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Settle Account Type" = const(Customer)) Customer
            else
            if ("Settle Account Type" = const(Vendor)) Vendor
            else
            if ("Settle Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Settle Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Settle Account Type" = const("IC Partner")) "IC Partner";
        }
        field(21; "Total WHT (LCY)"; Decimal)
        {
            CalcFormula = sum("Settle Petty Cash Line"."WHT Amount (LCY)" where("Settle Petty Cash No." = field("No.")));
            Caption = 'Total WHT (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Bank Payment Type"; Option)
        {
            Caption = 'Bank Payment Type';
            OptionCaption = ' ,Computer Check,Manual Check';
            OptionMembers = " ","Computer Check","Manual Check";

            trigger OnValidate()
            begin
                if ("Bank Payment Type" <> "bank payment type"::" ") and
                   ("Settle Account Type" <> "settle account type"::"Bank Account")
                then
                    Error(
                      Text007,
                      FieldCaption("Settle Account Type"));
                if ("Settle Account Type" = "settle account type"::"Fixed Asset") and
                   ("Bank Payment Type" <> "bank payment type"::" ")
                then
                    FieldError("Settle Account Type");
            end;
        }
        field(31; "Cheque Printed"; Boolean)
        {
            Caption = 'Cheque Printed';
            Editable = false;
        }
        field(32; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            Editable = false;
        }
        field(33; "Paid to Vendor Name"; Text[120])
        {
            Caption = 'Paid to Vendor Name';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = exist("Petty Cash Comment Line" where("Document Type" = const(Settle),
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

            end;
        }
        field(48; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(49; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
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
                        RecreateSettlePettyCashLines(FieldCaption("Currency Code"));
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
                    UpdateSettlePettyCashLines(FieldCaption("Currency Factor"));
            end;
        }
        field(52; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50000; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
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
        SettlePettyCashLine.LockTable;
        SettlePettyCashLine.SetRange("Settle Petty Cash No.", "No.");
        SettlePettyCashLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        PettyCashSetup.Get;

        if "No." = '' then begin
            PettyCashSetup.TestField("Settle Petty Cash Nos.");
            NoSeriesMgt.InitSeries(PettyCashSetup."Settle Petty Cash Nos.", xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;

        InitRecord;

        "Posting Date" := WorkDate;
        "Document Date" := WorkDate;
    end;

    trigger OnModify()
    begin
        TestField(Status, Status::Open);
        TestField("Cheque Printed", false);
    end;

    var
        SettlePettyCashHdr: Record "Settle Petty Cash Header";
        SettlePettyCashLine: Record "Settle Petty Cash Line";
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
        Text006: label 'Vendor ledger entries no. %1 has already applied by another docuement.';
        Text007: label '%1 must be a Bank Account.';
        Text025: label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        SkipPayToContact: Boolean;
        Text028: label 'There is nothing to release for %1.';
        Text030: label 'Actual Vendor No. on Petty Cash Line must not be difference.';


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


    procedure AssistEdit(OldSettlePettyCashHdr: Record "Settle Petty Cash Header"): Boolean
    begin
        PettyCashSetup.Get;
        PettyCashSetup.TestField("Settle Petty Cash Nos.");
        if NoSeriesMgt.SelectSeries(PettyCashSetup."Settle Petty Cash Nos.", OldSettlePettyCashHdr."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;


    procedure RecreateSettlePettyCashLines(ChangedFieldName: Text[100])
    var
        SettlePettyCashLineTmp: Record "Settle Petty Cash Line" temporary;
    begin
        if SettlePettyCashLinesExist then begin
            if HideValidationDialog then
                Confirmed := true
            else
                Confirmed :=
                  Confirm(
                    Text002 +
                     Text001, false, ChangedFieldName);
            if Confirmed then begin
                SettlePettyCashLine.LockTable;
                Modify;

                SettlePettyCashLine.Reset;
                SettlePettyCashLine.SetRange("Settle Petty Cash No.", "No.");
                if SettlePettyCashLine.Find('-') then begin
                    repeat
                        SettlePettyCashLineTmp := SettlePettyCashLine;
                        SettlePettyCashLine.Modify;
                        SettlePettyCashLineTmp.Insert;
                    until SettlePettyCashLine.Next = 0;

                    SettlePettyCashLine.DeleteAll(true);

                    SettlePettyCashLine.Init;
                    SettlePettyCashLine."Line No." := 0;
                    SettlePettyCashLineTmp.Find('-');
                    repeat
                        SettlePettyCashLine.Init;
                        SettlePettyCashLine."Line No." := SettlePettyCashLine."Line No." + 10000;
                        SettlePettyCashLine.Validate("Entry No.", SettlePettyCashLineTmp."Entry No.");
                        SettlePettyCashLine.Insert;
                    until SettlePettyCashLineTmp.Next = 0;

                    SettlePettyCashLineTmp.Reset;
                    SettlePettyCashLineTmp.DeleteAll;
                end;
            end else
                Error(
                  Text003, ChangedFieldName);
        end;
    end;


    procedure SettlePettyCashLinesExist(): Boolean
    begin
        SettlePettyCashLine.Reset;
        SettlePettyCashLine.SetRange("Settle Petty Cash No.", "No.");
        exit(SettlePettyCashLine.Find('-'));
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


    procedure UpdateSettlePettyCashLines(ChangedFieldName: Text[100])
    var
        _SettlePettyCashLine: Record "Settle Petty Cash Line";
        UpdateConfirmed: Boolean;
    begin
        if SettlePettyCashLinesExist then begin

            if not GuiAllowed then
                UpdateConfirmed := true;

            SettlePettyCashLine.LockTable;
            Modify;

            repeat
                _SettlePettyCashLine := SettlePettyCashLine;
                case ChangedFieldName of
                    FieldCaption("Currency Factor"):
                        if SettlePettyCashLine."Entry No." <> 0 then
                            SettlePettyCashLine.Validate("Entry No.");
                end;
                SettlePettyCashLine.Modify(true);
            until SettlePettyCashLine.Next = 0;
        end;
    end;


    procedure Release()
    var
        SettlePettyCashLine2: Record "Settle Petty Cash Line";
    begin
        if Status = Status::Released then
            exit;

        TestField("Petty Cash Vendor No.");
        TestField("Posting Date");
        TestField("Settle Account No.");
        TestField("Cheque Printed", false);

        SettlePettyCashLine2.SetRange("Settle Petty Cash No.", "No.");
        if not SettlePettyCashLine2.Find('-') then
            Error(Text028, "No.");

        CheckAppliedVendLedgEntry;

        SetVendApplId(false);

        Status := Status::Released;
        Modify;
    end;


    procedure Reopen()
    begin
        if Status = Status::Open then
            exit;

        TestField("Cheque Printed", false);
        SetVendApplId(true);

        if CheckUnappliedVendLedgEntry then
            exit;

        Status := Status::Open;
        Modify;
    end;


    procedure CheckAppliedVendLedgEntry()
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        SettlePettyCashLine2: Record "Settle Petty Cash Line";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        SettlePettyCashLine2.SetRange("Settle Petty Cash No.", "No.");
        if SettlePettyCashLine2.Find('-') then
            repeat
                VendLedgEntry.Get(SettlePettyCashLine2."Entry No.");
                if VendLedgEntry."Applies-to ID" <> '' then
                    Error(StrSubstNo(Text006, SettlePettyCashLine2."Entry No."));
                GenJnlLine.SetRange("Applies-to Doc. Type", SettlePettyCashLine2."Document Type");
                GenJnlLine.SetRange("Applies-to Doc. No.", SettlePettyCashLine2."Document No.");
                if GenJnlLine.Find('-') then
                    Error(StrSubstNo(Text006, SettlePettyCashLine2."Entry No."));
            until SettlePettyCashLine2.Next = 0;
    end;


    procedure CheckUnappliedVendLedgEntry(): Boolean
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        SettlePettyCashLine2: Record "Settle Petty Cash Line";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        SettlePettyCashLine2.SetRange("Settle Petty Cash No.", "No.");
        if SettlePettyCashLine2.Find('-') then
            repeat
                VendLedgEntry.Get(SettlePettyCashLine2."Entry No.");
                if VendLedgEntry."Applies-to ID" <> '' then
                    exit(true);
            until SettlePettyCashLine2.Next = 0;
        exit(false);
    end;


    procedure SetVendApplId(ResetAppliedID: Boolean)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry2: Record "Vendor Ledger Entry";
        SettlePettyCashLine2: Record "Settle Petty Cash Line";
        ApplyingVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        AppliedAmount: Decimal;
        PmtDiscAmount: Decimal;
        RemBalanceSettle: Decimal;
    begin
        if ResetAppliedID then begin
            VendLedgEntry.SetRange("Applies-to ID", "No.");
            if VendLedgEntry.Find('-') then
                repeat
                    VendLedgEntry.Mark(true);
                until VendLedgEntry.Next = 0;
        end else begin
            CalcFields("Balance Settle");
            RemBalanceSettle := "Balance Settle";
            VendLedgEntry2.Reset;
            VendLedgEntry2.SetRange("Vendor No.", "Petty Cash Vendor No.");
            VendLedgEntry2.SetRange("Document Type", VendLedgEntry2."document type"::Payment);
            VendLedgEntry2.SetRange(Open, true);
            VendLedgEntry2.SetFilter("Posting Date", '..%1', "Posting Date");
            VendLedgEntry2.SetCurrentkey("Vendor No.", "Posting Date");
            if VendLedgEntry2.Find('-') then
                repeat
                    VendLedgEntry2.CalcFields("Remaining Amt. (LCY)");
                    if VendLedgEntry2."Remaining Amt. (LCY)" + RemBalanceSettle > 0 then
                        RemBalanceSettle := 0
                    else
                        RemBalanceSettle := VendLedgEntry2."Remaining Amt. (LCY)" + RemBalanceSettle;
                    VendLedgEntry := VendLedgEntry2;
                    VendLedgEntry.Mark(true);
                until (VendLedgEntry2.Next = 0) or (RemBalanceSettle = 0);

            SettlePettyCashLine2.SetRange("Settle Petty Cash No.", "No.");
            if SettlePettyCashLine2.Find('-') then
                repeat
                    VendLedgEntry.Get(SettlePettyCashLine2."Entry No.");
                    if VendLedgEntry.Open then
                        VendLedgEntry.Mark(true);
                until SettlePettyCashLine2.Next = 0;
        end;

        VendLedgEntry.MarkedOnly(true);
        if VendLedgEntry.Count = 0 then
            exit;
        //VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, AppliedAmount, PmtDiscAmount, "No.");//SAG
        VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, "No.");//SAG
    end;
}

