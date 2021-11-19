Table 50050 "Ads. Billing Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   25.05.2007   KKE   New table for "Ads. Billing Note Header" - Ads. Sales Module

    LookupPageID = "Ads. Billing List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Billing Date"; Date)
        {
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            var
            //TempDocDim: Record "Document Dimension" temporary;
            begin
                TestField(Status, Status::Open);

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                "Bill-to Name" := Cust.Name;
                "Bill-to Address" := Cust.Address;
                "Bill-to Address 2" := Cust."Address 2";
                "Bill-to Address 3" := Cust."Address 3";
                "Bill-to City" := Cust.City;
                "Bill-to Post Code" := Cust."Post Code";
                "Bill-to County" := Cust.County;
                "Bill-to Country Code" := Cust."Country/Region Code";
                "Bill-to Contact" := Cust.Contact;
            end;
        }
        field(5; "Bill-to Name"; Text[50])
        {
            Caption = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name';
        }
        field(7; "Bill-to Address"; Text[50])
        {
            Caption = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(9; "Bill-to Address 3"; Text[30])
        {
            Caption = 'Bill-to Address 3';
        }
        field(10; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';

            trigger OnLookup()
            begin
                PostCodeCheck.LookUpCity(
                  CurrFieldNo, Database::"Ads. Billing Header", Rec.GetPosition, 1,
                  "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
                  "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country Code", true);
            end;

            trigger OnValidate()
            begin
                PostCodeCheck.ValidateCity(
                  CurrFieldNo, Database::"Ads. Billing Header", Rec.GetPosition, 1,
                  "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
                  "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country Code");
            end;
        }
        field(11; "Bill-to Contact"; Text[50])
        {
            Caption = 'Bill-to Contact';
        }
        field(12; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCodeCheck.LookUpPostCode(
                  CurrFieldNo, Database::"Ads. Billing Header", Rec.GetPosition, 1,
                  "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
                  "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country Code", true);
            end;

            trigger OnValidate()
            begin
                PostCodeCheck.ValidatePostCode(
                  CurrFieldNo, Database::"Ads. Billing Header", Rec.GetPosition, 1,
                  "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
                  "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country Code");
            end;
        }
        field(13; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
        }
        field(14; "Bill-to Country Code"; Code[10])
        {
            Caption = 'Bill-to Country Code';
            TableRelation = "Country/Region";
        }
        field(15; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(16; "Due Date"; Date)
        {
        }
        field(20; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Release;
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; Remark; Text[100])
        {
        }
        field(23; Comment; Boolean)
        {
            CalcFormula = exist("Sales Comment Line" where("Document Type" = const("Ads. Billing"),
                                                            "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
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
        TestField(Status, Status::Open);

        BillingLine.Reset;
        BillingLine.LockTable;

        BillingLine.SetRange("Billing No.", "No.");
        BillingLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        AdsItemSetup.Get;

        if "No." = '' then begin
            AdsItemSetup.TestField("Billing Nos.");
            NoSeriesMgt.InitSeries(AdsItemSetup."Billing Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;

        "Billing Date" := WorkDate;
    end;

    trigger OnModify()
    begin
        TestField(Status, Status::Open);
    end;

    var
        AdsItemSetup: Record "Ads. Item Setup";
        BillingHeader: Record "Ads. Billing Header";
        BillingLine: Record "Ads. Billing Line";
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: label 'The Billing No. %1 already exists.';
        PostCodeCheck: Codeunit "Post Code Check";
        Text002: label 'Do you want to reopen ads. billing %1?';
        Text003: label 'Do you want to archived ads. billing %1?';
        Text004: label 'Ads. Billing %1 has been archived.';


    procedure AssistEdit(OldBillingHeader: Record "Ads. Billing Header"): Boolean
    var
        BillingHeader2: Record "Ads. Billing Header";
    begin
        with BillingHeader do begin
            BillingHeader.Copy(Rec);
            AdsItemSetup.Get;
            AdsItemSetup.TestField("Billing Nos.");
            if NoSeriesMgt.SelectSeries(AdsItemSetup."Billing Nos.", OldBillingHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                if BillingHeader2.Get("No.") then
                    Error(Text001, Lowercase("No."));
                Rec := BillingHeader;
                exit(true);
            end;
        end;
    end;


    procedure SuggestBillingLines(AdsBillingHeader: Record "Ads. Billing Header")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        AdsBillingLine: Record "Ads. Billing Line";
        LineNo: Integer;
        FormGetInvoice: Page "Get Invoice - Ads. Billing";
    begin
        TestField(Status, Status::Open);
        AdsItemSetup.Get;
        AdsBillingLine.Reset;
        AdsBillingLine.SetRange("Billing No.", AdsBillingHeader."No.");
        if AdsBillingLine.FindLast then
            LineNo := AdsBillingLine."Line No.";

        CustLedgEntry.Reset;
        CustLedgEntry.SetCurrentkey("Customer No.", Open, Positive, "Due Date", "Currency Code");
        CustLedgEntry.FilterGroup(2);
        CustLedgEntry.SetRange("Customer No.", AdsBillingHeader."Bill-to Customer No.");
        CustLedgEntry.SetRange(Open, true);
        if AdsBillingHeader."Due Date" <> 0D then
            CustLedgEntry.SetFilter("Due Date", '<=%1', AdsBillingHeader."Due Date");
        CustLedgEntry.FilterGroup(0);
        if CustLedgEntry.Find('-') then begin
            FormGetInvoice.LookupMode := true;
            FormGetInvoice.SetTableview(CustLedgEntry);
            FormGetInvoice.InitRequest(AdsBillingHeader."No.", LineNo);
            FormGetInvoice.RunModal;
            Clear(FormGetInvoice);
        end;
        /*
          REPEAT
            CustLedgEntry.CALCFIELDS("Remaining Amount","Remaining Amt. (LCY)");
            LineNo += 10000;
            AdsBillingLine.INIT;
            AdsBillingLine."Billing No." := AdsBillingHeader."No.";
            AdsBillingLine."Line No." := LineNo ;
            AdsBillingLine."Bill-to Customer No." := CustLedgEntry."Customer No.";
            AdsBillingLine."Cust. Ledger Entry No." := CustLedgEntry."Entry No.";
            IF NOT AdsBillingLine.CheckDupCustEntryNo THEN BEGIN
              AdsBillingLine.VALIDATE("Cust. Ledger Entry No.",CustLedgEntry."Entry No.");
              AdsBillingLine.INSERT;
            END;
          UNTIL CustLedgEntry.NEXT = 0 ;
        */

    end;


    procedure Reopen()
    begin
        if not Confirm(StrSubstNo(Text002, "No."), false) then
            exit;

        Status := Status::Open;
        Modify;
    end;


    procedure ArchivedAdsBilling()
    var
        AdsBillingLine: Record "Ads. Billing Line";
        ArchAdsBillingHdr: Record "Archived Ads. Billing Header";
        ArchAdsBillingLine: Record "Archived Ads. Billing Line";
    begin
        if not Confirm(StrSubstNo(Text003, "No."), false) then
            exit;

        TestField(Status, Status::Release);

        ArchAdsBillingHdr.Init;
        ArchAdsBillingHdr.TransferFields(Rec);
        ArchAdsBillingHdr.Insert;

        AdsBillingLine.Reset;
        AdsBillingLine.SetRange("Billing No.", "No.");
        if AdsBillingLine.Find('-') then
            repeat
                ArchAdsBillingLine.Init;
                ArchAdsBillingLine.TransferFields(AdsBillingLine);
                ArchAdsBillingLine.Insert;
            until AdsBillingLine.Next = 0;

        Delete;
        AdsBillingLine.DeleteAll;

        Message(Text004, "No.");
    end;
}

