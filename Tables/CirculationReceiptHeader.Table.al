Table 50043 "Circulation Receipt Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.04.2007   KKE   New table for "Circulation Receipt Header" - Circulation Module
    // 002   18.09.2007   KKE   Add Calc. Payment

    LookupPageID = "Circulation Receipt List";

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MagazineSalesSetup.Get;
                    NoSeriesMgt.TestManual(MagazineSalesSetup."Circulation Receipt Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
        }
        field(3; "Customer No."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if not Cust.Get("Customer No.") then
                    Clear(Cust);
                Contact := Cust.Contact;
            end;
        }
        field(8; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(21; "No. Printed"; Integer)
        {
            Editable = false;
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
        CirculationRecLine.Reset;
        CirculationRecLine.SetRange("Circulation Receipt No.", "No.");
        if CirculationRecLine.FindSet then
            repeat
                CirculationRecLine.Delete(true);
            until CirculationRecLine.Next = 0;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MagazineSalesSetup.Get;
            MagazineSalesSetup.TestField("Circulation Receipt Nos.");
            NoSeriesMgt.InitSeries(MagazineSalesSetup."Circulation Receipt Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Document Date" := WorkDate;
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        MagazineSalesSetup: Record "Magazine Sales Setup";
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: label 'You cannot rename a %1.';
        CustLedgEntry: Record "Cust. Ledger Entry";
        CreateCustLedgEntry: Record "Cust. Ledger Entry";
        Text001: label 'Do you want to calculate payment amount?';
        Text002: label 'Payment amount is zero.';
        CirculationRecLine: Record "Circulation Receipt Line";


    procedure AssistEdit(OldCirReceiptHdr: Record "Circulation Receipt Header"): Boolean
    var
        CirReceiptHdr: Record "Circulation Receipt Header";
    begin
        with OldCirReceiptHdr do begin
            OldCirReceiptHdr := Rec;
            MagazineSalesSetup.Get;
            MagazineSalesSetup.TestField("Circulation Receipt Nos.");
            if NoSeriesMgt.SelectSeries(MagazineSalesSetup."Circulation Receipt Nos.", OldCirReceiptHdr."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := CirReceiptHdr;
                exit(true);
            end;
        end;
    end;


    procedure CalcPayment()
    var
        CustLedgEntry2: Record "Cust. Ledger Entry";
        CirReceiptLine: Record "Circulation Receipt Line";
        CirReceiptLineTemp: Record "Circulation Receipt Line" temporary;
        AppliedDocNo: Text[500];
        PaymentAmt: Decimal;
        LineNo: Integer;
    begin
        //KKE: #002 +
        if not Confirm(Text001, false) then
            exit;
        LineNo := 0;
        PaymentAmt := 0;
        CirReceiptLineTemp.DeleteAll;
        CirReceiptLine.Reset;
        CirReceiptLine.SetRange("Circulation Receipt No.", "No.");
        if CirReceiptLine.Find('+') then;
        LineNo := CirReceiptLine."Line No.";
        CirReceiptLine.SetRange("Document Type", CirReceiptLine."document type"::Invoice);
        if CirReceiptLine.Find('-') then
            repeat
                CirReceiptLineTemp.Reset;
                CirReceiptLineTemp.SetRange("Document No.", CirReceiptLine."Document No.");
                if not CirReceiptLineTemp.Find('-') then begin
                    CirReceiptLineTemp."Circulation Receipt No." := CirReceiptLine."Circulation Receipt No.";
                    CirReceiptLineTemp."Line No." := CirReceiptLine."Line No.";
                    CirReceiptLineTemp."Document No." := CirReceiptLine."Document No.";
                    CirReceiptLineTemp.Insert;
                end;
            until CirReceiptLine.Next = 0;

        CirReceiptLineTemp.Reset;
        with CirReceiptLineTemp do begin
            if not Find('-') then
                Error(Text002);

            repeat
                CustLedgEntry2.Reset;
                CustLedgEntry2.SetCurrentkey("Document No.", "Document Type", "Customer No.");
                CustLedgEntry2.SetRange("Document Type", CustLedgEntry2."document type"::Invoice);
                CustLedgEntry2.SetRange("Document No.", "Document No.");
                if CustLedgEntry2.Find('-') then begin
                    CustLedgEntry2.CalcFields(Amount, "Remaining Amount");
                    if CustLedgEntry2.Amount <> CustLedgEntry2."Remaining Amount" then begin
                        CreateCustLedgEntry := CustLedgEntry2;
                        FindApplnEntriesDtldtLedgEntry;

                        CustLedgEntry.SetCurrentkey("Entry No.");
                        CustLedgEntry.SetRange("Entry No.");

                        if CreateCustLedgEntry."Closed by Entry No." <> 0 then begin
                            CustLedgEntry."Entry No." := CreateCustLedgEntry."Closed by Entry No.";
                            CustLedgEntry.Mark(true);
                        end;

                        CustLedgEntry.SetCurrentkey("Closed by Entry No.");
                        CustLedgEntry.SetRange("Closed by Entry No.", CreateCustLedgEntry."Entry No.");
                        if CustLedgEntry.Find('-') then
                            repeat
                                CustLedgEntry.Mark(true);
                            until CustLedgEntry.Next = 0;

                        CustLedgEntry.SetCurrentkey("Entry No.");
                        CustLedgEntry.SetRange("Closed by Entry No.");
                    end;
                end;
            until Next = 0;

            CustLedgEntry.MarkedOnly(true);
            //CustLedgEntry.SETRANGE("Document Type",CustLedgEntry."Document Type"::Payment);
            if CustLedgEntry.Find('-') then
                repeat
                    if CustLedgEntry."Document Type" = CustLedgEntry."document type"::Payment then begin
                        CustLedgEntry.CalcFields(Amount);
                        PaymentAmt += CustLedgEntry.Amount;
                    end;
                until CustLedgEntry.Next = 0;
            CustLedgEntry.Reset;
        end;

        if PaymentAmt = 0 then
            Error(Text002);

        CirReceiptLine.Reset;
        CirReceiptLine.SetRange("Circulation Receipt No.", "No.");
        CirReceiptLine.SetRange("Document Type", CirReceiptLine."document type"::Payment);
        if CirReceiptLine.Find('-') then begin
            CirReceiptLine."Line Amount Incl. VAT" := PaymentAmt;
            CirReceiptLine.Modify;
        end else begin
            CirReceiptLine.Init;
            CirReceiptLine."Circulation Receipt No." := "No.";
            CirReceiptLine."Line No." := LineNo + 10000;
            CirReceiptLine."Document Type" := CirReceiptLine."document type"::Payment;
            CirReceiptLine.Description := 'Amount that has been paid';
            CirReceiptLine."Line Amount Incl. VAT" := PaymentAmt;
            CirReceiptLine.Insert;
        end;

        //KKE: #002 -
    end;

    local procedure FindApplnEntriesDtldtLedgEntry()
    var
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
    begin
        //KKE: #002 +
        DtldCustLedgEntry1.SetCurrentkey("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SetRange("Cust. Ledger Entry No.", CreateCustLedgEntry."Entry No.");
        DtldCustLedgEntry1.SetRange(Unapplied, false);
        if DtldCustLedgEntry1.Find('-') then begin
            repeat
                if DtldCustLedgEntry1."Cust. Ledger Entry No." =
                  DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                then begin
                    DtldCustLedgEntry2.Init;
                    DtldCustLedgEntry2.SetCurrentkey("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SetRange(
                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SetRange("Entry Type", DtldCustLedgEntry2."entry type"::Application);
                    DtldCustLedgEntry2.SetRange(Unapplied, false);
                    if DtldCustLedgEntry2.Find('-') then begin
                        repeat
                            if DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                              DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                            then begin
                                CustLedgEntry.SetCurrentkey("Entry No.");
                                CustLedgEntry.SetRange("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                if CustLedgEntry.Find('-') then
                                    CustLedgEntry.Mark(true);
                            end;
                        until DtldCustLedgEntry2.Next = 0;
                    end;
                end else begin
                    CustLedgEntry.SetCurrentkey("Entry No.");
                    CustLedgEntry.SetRange("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    if CustLedgEntry.Find('-') then
                        CustLedgEntry.Mark(true);
                end;
            until DtldCustLedgEntry1.Next = 0;
        end;
        //KKE: #002 -
    end;
}

