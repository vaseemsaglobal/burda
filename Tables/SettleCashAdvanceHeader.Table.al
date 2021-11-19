Table 55056 "Settle Cash Advance Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.
    // 002   22.01.2007   KKE   Add new field "Cheque Date" - Show on Print Cheque,Cheque ledger entries

    Caption = 'Settle Cash Advance Header';
    DrillDownPageID = "Settle Cash Advance List";
    LookupPageID = "Settle Cash Advance List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Cash Advance Vendor No."; Code[20])
        {
            Caption = 'Cash Advance Vendor No.';
            TableRelation = Vendor where("Cash Advance" = const(true));

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if ("Cash Advance Vendor No." <> xRec."Cash Advance Vendor No.") and
                   (xRec."Cash Advance Vendor No." <> '')
                then begin
                    if HideValidationDialog then
                        Confirmed := true
                    else
                        Confirmed := Confirm(Text001, false, FieldCaption("Cash Advance Vendor No."));
                    if Confirmed then begin
                        SettleCashAdvLine.SetRange("Settle Cash Advance No.", "No.");
                        if "Cash Advance Vendor No." = '' then begin
                            if SettleCashAdvLine.Find('-') then
                                Error(
                                  Text004,
                                  FieldCaption("Cash Advance Vendor No."));
                            Init;
                            "No. Series" := xRec."No. Series";
                            InitRecord;
                            exit;
                        end;
                        SettleCashAdvLine.Reset;
                    end else begin
                        Rec := xRec;
                        exit;
                    end;
                end;

                GetVend("Cash Advance Vendor No.");
                "Cash Advance Name" := Vend.Name;
                Validate("Location Code", Vend."Location Code");
                Validate("Currency Code", Vend."Currency Code");
                //"Cash Advance Amount" := Vend."Cash Advance Amount";
            end;
        }
        field(3; "Cash Advance Name"; Text[50])
        {
            Caption = 'Cash Advance Name';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; "Cash Advance Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cash Advance Amount';
            Editable = false;
        }
        field(7; "Balance Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Cash Advance Vendor No."),
                                                                           "Posting Date" = field("Date Filter")));
            Caption = 'Balance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Balance Settle"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Settle Cash Advance Line"."Amount (LCY) Incl. VAT" where("Settle Cash Advance No." = field("No.")));
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
            CalcFormula = sum("Settle Cash Advance Line"."WHT Amount (LCY)" where("Settle Cash Advance No." = field("No.")));
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
            CalcFormula = exist("Cash Advance Comment Line" where("Document Type" = const(Settle),
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
                        RecreateSettleCashAdvLines(FieldCaption("Currency Code"));
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
                    UpdateSettleCashAdvLines(FieldCaption("Currency Factor"));
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
        SettleCashAdvLine.LockTable;
        SettleCashAdvLine.SetRange("Settle Cash Advance No.", "No.");
        SettleCashAdvLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        CashAdvSetup.Get;

        if "No." = '' then begin
            CashAdvSetup.TestField("Settle Cash Advance Nos.");
            NoSeriesMgt.InitSeries(CashAdvSetup."Settle Cash Advance Nos.", xRec."No. Series", "Posting Date", "No.", "No. Series");
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
        SettleCashAdvHdr: Record "Settle Cash Advance Header";
        SettleCashAdvLine: Record "Settle Cash Advance Line";
        CashAdvSetup: Record "Cash Advance Setup";
        CashAdvCmtLine: Record "Cash Advance Comment Line";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        Vend: Record Vendor;
        SourceCodeSetup: Record "Source Code Setup";
        //DocDim: Record "Document Dimension";
        GLSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: label 'Do you want to change %1?';
        Text002: label 'If you change %1, the existing cash advance invoice lines will be deleted and new cash advance invoice lines based on the new information in the header will be created.\\';
        DimMgt: Codeunit DimensionManagement;
        PostCodeCheck: Codeunit "Post Code Check";
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Text003: label 'You must delete the existing cash advance invoice lines before you can change %1.';
        Text004: label 'You cannot reset %1 because the document still has one or more lines.';
        CurrencyDate: Date;
        Text005: label 'Do you want to update the exchange rate?';
        Text006: label 'Vendor ledger entries no. %1 has already applied by another docuement.';
        Text007: label '%1 must be a Bank Account.';
        Text025: label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        SkipPayToContact: Boolean;
        Text028: label 'There is nothing to release for %1.';
        Text030: label 'Actual Vendor No. on Cash Advance Line must not be difference.';


    procedure InitRecord()
    begin
        if ("Posting Date" = 0D)
        then
            "Posting Date" := WorkDate;
        "Document Date" := WorkDate;

        SourceCodeSetup.Get;
        SourceCodeSetup.TestField("Cash Advance");
        "Source Code" := SourceCodeSetup."Cash Advance";
    end;


    procedure AssistEdit(OldSettleCashAdvHdr: Record "Settle Cash Advance Header"): Boolean
    begin
        CashAdvSetup.Get;
        CashAdvSetup.TestField("Settle Cash Advance Nos.");
        if NoSeriesMgt.SelectSeries(CashAdvSetup."Settle Cash Advance Nos.", OldSettleCashAdvHdr."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;


    procedure RecreateSettleCashAdvLines(ChangedFieldName: Text[100])
    var
        SettleCashAdvLineTmp: Record "Settle Cash Advance Line" temporary;
    begin
        if SettleCashAdvLinesExist then begin
            if HideValidationDialog then
                Confirmed := true
            else
                Confirmed :=
                  Confirm(
                    Text002 +
                     Text001, false, ChangedFieldName);
            if Confirmed then begin
                SettleCashAdvLine.LockTable;
                Modify;

                SettleCashAdvLine.Reset;
                SettleCashAdvLine.SetRange("Settle Cash Advance No.", "No.");
                if SettleCashAdvLine.Find('-') then begin
                    repeat
                        SettleCashAdvLineTmp := SettleCashAdvLine;
                        SettleCashAdvLine.Modify;
                        SettleCashAdvLineTmp.Insert;
                    until SettleCashAdvLine.Next = 0;

                    SettleCashAdvLine.DeleteAll(true);

                    SettleCashAdvLine.Init;
                    SettleCashAdvLine."Line No." := 0;
                    SettleCashAdvLineTmp.Find('-');
                    repeat
                        SettleCashAdvLine.Init;
                        SettleCashAdvLine."Line No." := SettleCashAdvLine."Line No." + 10000;
                        SettleCashAdvLine.Validate("Entry No.", SettleCashAdvLineTmp."Entry No.");
                        SettleCashAdvLine.Insert;
                    until SettleCashAdvLineTmp.Next = 0;

                    SettleCashAdvLineTmp.Reset;
                    SettleCashAdvLineTmp.DeleteAll;
                end;
            end else
                Error(
                  Text003, ChangedFieldName);
        end;
    end;


    procedure SettleCashAdvLinesExist(): Boolean
    begin
        SettleCashAdvLine.Reset;
        SettleCashAdvLine.SetRange("Settle Cash Advance No.", "No.");
        exit(SettleCashAdvLine.Find('-'));
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


    procedure UpdateSettleCashAdvLines(ChangedFieldName: Text[100])
    var
        _SettleCashAdvLine: Record "Settle Cash Advance Line";
        UpdateConfirmed: Boolean;
    begin
        if SettleCashAdvLinesExist then begin

            if not GuiAllowed then
                UpdateConfirmed := true;

            SettleCashAdvLine.LockTable;
            Modify;

            repeat
                _SettleCashAdvLine := SettleCashAdvLine;
                case ChangedFieldName of
                    FieldCaption("Currency Factor"):
                        if SettleCashAdvLine."Entry No." <> 0 then
                            SettleCashAdvLine.Validate("Entry No.");
                end;
                SettleCashAdvLine.Modify(true);
            until SettleCashAdvLine.Next = 0;
        end;
    end;


    procedure Release()
    var
        SettleCashAdvLine2: Record "Settle Cash Advance Line";
    begin
        if Status = Status::Released then
            exit;

        TestField("Cash Advance Vendor No.");
        TestField("Posting Date");
        TestField("Settle Account No.");
        TestField("Cheque Printed", false);

        SettleCashAdvLine2.SetRange("Settle Cash Advance No.", "No.");
        if not SettleCashAdvLine2.Find('-') then
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
        SettleCashAdvLine2: Record "Settle Cash Advance Line";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        SettleCashAdvLine2.SetRange("Settle Cash Advance No.", "No.");
        if SettleCashAdvLine2.Find('-') then
            repeat
                VendLedgEntry.Get(SettleCashAdvLine2."Entry No.");
                if VendLedgEntry."Applies-to ID" <> '' then
                    Error(StrSubstNo(Text006, SettleCashAdvLine2."Entry No."));
                GenJnlLine.SetRange("Applies-to Doc. Type", SettleCashAdvLine2."Document Type");
                GenJnlLine.SetRange("Applies-to Doc. No.", SettleCashAdvLine2."Document No.");
                if GenJnlLine.Find('-') then
                    Error(StrSubstNo(Text006, SettleCashAdvLine2."Entry No."));
            until SettleCashAdvLine2.Next = 0;
    end;


    procedure CheckUnappliedVendLedgEntry(): Boolean
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        SettleCashAdvLine2: Record "Settle Cash Advance Line";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        SettleCashAdvLine2.SetRange("Settle Cash Advance No.", "No.");
        if SettleCashAdvLine2.Find('-') then
            repeat
                VendLedgEntry.Get(SettleCashAdvLine2."Entry No.");
                if VendLedgEntry."Applies-to ID" <> '' then
                    exit(true);
            until SettleCashAdvLine2.Next = 0;
        exit(false);
    end;


    procedure SetVendApplId(ResetAppliedID: Boolean)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry2: Record "Vendor Ledger Entry";
        SettleCashAdvLine2: Record "Settle Cash Advance Line";
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
            /*
            VendLedgEntry2.RESET;
            VendLedgEntry2.SETRANGE("Vendor No.","Cash Advance Vendor No.");
            VendLedgEntry2.SETRANGE("Document Type",VendLedgEntry2."Document Type"::Payment);
            VendLedgEntry2.SETRANGE(Open,TRUE);
            VendLedgEntry2.SETFILTER("Posting Date",'..%1',"Posting Date");
            VendLedgEntry2.SETCURRENTKEY("Vendor No.","Posting Date");
            IF VendLedgEntry2.FIND('-') THEN
              REPEAT
                VendLedgEntry2.CALCFIELDS("Remaining Amt. (LCY)");
                IF VendLedgEntry2."Remaining Amt. (LCY)" + RemBalanceSettle > 0 THEN
                  RemBalanceSettle := 0
                ELSE
                  RemBalanceSettle := VendLedgEntry2."Remaining Amt. (LCY)" + RemBalanceSettle;
                VendLedgEntry := VendLedgEntry2;
                VendLedgEntry.MARK(TRUE);
              UNTIL (VendLedgEntry2.NEXT=0) OR (RemBalanceSettle=0);
            */
            SettleCashAdvLine2.SetRange("Settle Cash Advance No.", "No.");
            if SettleCashAdvLine2.Find('-') then
                repeat
                    VendLedgEntry.Get(SettleCashAdvLine2."Entry No.");
                    if VendLedgEntry.Open then
                        VendLedgEntry.Mark(true);
                until SettleCashAdvLine2.Next = 0;
        end;

        VendLedgEntry.MarkedOnly(true);
        if VendLedgEntry.Count = 0 then
            exit;
        //VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, AppliedAmount, PmtDiscAmount, "No.");//SAG
        VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, "No.");

    end;
}

