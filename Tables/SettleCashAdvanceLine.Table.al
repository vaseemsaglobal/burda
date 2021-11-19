Table 55057 "Settle Cash Advance Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.

    Caption = 'Settle Cash Advance Line';

    fields
    {
        field(1; "Settle Cash Advance No."; Code[20])
        {
            Caption = 'Settle Cash Advance No.';
            TableRelation = "Settle Cash Advance Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Cash Advance Vendor No."; Code[20])
        {
            Caption = 'Cash Advance Vendor No.';
            TableRelation = Vendor where("Cash Advance" = const(true));
        }
        field(4; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            TableRelation = "Vendor Ledger Entry" where("Vendor No." = field("Cash Advance Vendor No."),
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
        key(Key1; "Settle Cash Advance No.", "Line No.")
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
        SettleCashAdvHdr."No." := '';

        TestField("Entry No.");
    end;

    trigger OnModify()
    begin
        TestStatusOpen;
    end;

    var
        SettleCashAdvHdr: Record "Settle Cash Advance Header";
        Text000: label 'The vendor ledger entry no. %1 has already used by another document.';
        Text001: label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.';


    procedure GetSettleCashAdvHdr()
    begin
        TestField("Settle Cash Advance No.");
        if "Settle Cash Advance No." <> SettleCashAdvHdr."No." then begin
            SettleCashAdvHdr.Get("Settle Cash Advance No.");
        end;
    end;

    local procedure TestStatusOpen()
    begin
        GetSettleCashAdvHdr;
        SettleCashAdvHdr.TestField(Status, SettleCashAdvHdr.Status::Open);
    end;


    procedure UpdateSettleLine()
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        GetSettleCashAdvHdr;
        VendLedgEntry.Get("Entry No.");
        if VendLedgEntry."Posting Date" > SettleCashAdvHdr."Posting Date" then
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
        SettleCashAdvLine: Record "Settle Cash Advance Line";
    begin
        SettleCashAdvLine.Reset;
        SettleCashAdvLine.SetCurrentkey("Entry No.");
        SettleCashAdvLine.SetRange("Entry No.", EntryNo);
        if SettleCashAdvLine.FindFirst then
            Error(StrSubstNo(Text000, EntryNo));
    end;
}

