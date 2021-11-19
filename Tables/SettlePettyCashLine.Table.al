Table 55007 "Settle Petty Cash Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.

    Caption = 'Settle Petty Cash Line';

    fields
    {
        field(1; "Settle Petty Cash No."; Code[20])
        {
            Caption = 'Settle Petty Cash No.';
            TableRelation = "Settle Petty Cash Header";
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
        field(4; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            TableRelation = "Vendor Ledger Entry" where("Vendor No." = field("Petty Cash Vendor No."),
                                                         "Document Type" = const(Invoice),
                                                         Open = const(true));

            trigger OnValidate()
            begin
                CheckExistVendLedgEntry("Entry No.");
                UpdateSettleLine;
            end;
        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(8; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(11; "Amount Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Incl. VAT';
            Editable = false;
        }
        field(12; "Amount (LCY) Incl. VAT"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY) Incl. VAT';
            Editable = false;
        }
        field(13; "WHT Amount (LCY)"; Decimal)
        {
            Caption = 'WHT Amount (LCY)';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Settle Petty Cash No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Amount Incl. VAT", "Amount (LCY) Incl. VAT", "WHT Amount (LCY)";
        }
        key(Key2; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestStatusOpen;
    end;

    trigger OnInsert()
    var
    //DocDim: Record "Document Dimension";
    begin
        TestStatusOpen;

        LockTable;
        SettlePettyCashHdr."No." := '';
        TestField("Entry No.");
    end;

    trigger OnModify()
    begin
        TestStatusOpen;
    end;

    var
        SettlePettyCashHdr: Record "Settle Petty Cash Header";
        Text000: label 'The vendor ledger entry no. %1 has already used by another document.';
        Text001: label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.';


    procedure GetSettlePettyCashHdr()
    begin
        TestField("Settle Petty Cash No.");
        if "Settle Petty Cash No." <> SettlePettyCashHdr."No." then begin
            SettlePettyCashHdr.Get("Settle Petty Cash No.");
        end;
    end;

    local procedure TestStatusOpen()
    begin
        GetSettlePettyCashHdr;
        SettlePettyCashHdr.TestField(Status, SettlePettyCashHdr.Status::Open);
    end;


    procedure UpdateSettleLine()
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        GetSettlePettyCashHdr;
        VendLedgEntry.Get("Entry No.");
        if VendLedgEntry."Posting Date" > SettlePettyCashHdr."Posting Date" then
            Error(Text001);
        "Posting Date" := VendLedgEntry."Posting Date";
        "Document Type" := VendLedgEntry."Document Type";
        "Document No." := VendLedgEntry."Document No.";
        Description := VendLedgEntry.Description;
        "Currency Code" := VendLedgEntry."Currency Code";
        VendLedgEntry.CalcFields("Remaining Amount", "Remaining Amt. (LCY)", "WHT Amount (LCY)");
        "Amount Incl. VAT" := VendLedgEntry."Remaining Amount";
        "Amount (LCY) Incl. VAT" := VendLedgEntry."Remaining Amt. (LCY)";
        "WHT Amount (LCY)" := VendLedgEntry."WHT Amount (LCY)";
    end;


    procedure CheckExistVendLedgEntry(EntryNo: Integer)
    var
        SettlePettyCashLine: Record "Settle Petty Cash Line";
    begin
        SettlePettyCashLine.Reset;
        SettlePettyCashLine.SetCurrentkey("Entry No.");
        SettlePettyCashLine.SetRange("Entry No.", EntryNo);
        if SettlePettyCashLine.FindFirst then
            Error(StrSubstNo(Text000, EntryNo));
    end;
}

