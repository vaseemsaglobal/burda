Codeunit 55052 "Cash Adv. - Get Vend. Ledge"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   -Cash Advance

    TableNo = "Settle Cash Advance Header";

    trigger OnRun()
    begin
        SettleCashAdvHdr.Get("No.");
        SettleCashAdvHdr.TestField(Status,SettleCashAdvHdr.Status::Open);

        VendLedgEntry.SetCurrentkey("Vendor No.","Posting Date","Currency Code");
        VendLedgEntry.SetRange("Vendor No.","Cash Advance Vendor No.");
        VendLedgEntry.SetFilter("Posting Date",'..%1',"Posting Date");
        VendLedgEntry.SetRange(Open,true);

        GetVendLedgEntry.SetTableview(VendLedgEntry);
        GetVendLedgEntry.SetSettleCashAdvHeader(SettleCashAdvHdr);
        GetVendLedgEntry.RunModal;
    end;

    var
        SettleCashAdvHdr: Record "Settle Cash Advance Header";
        Text001: label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
        Text002: label 'Creating Settle Cash Advance Lines\';
        Text003: label 'Inserted lines             #1######';
        VendLedgEntry: Record "Vendor Ledger Entry";
        GetVendLedgEntry: Page "Get Vendor Ledger Entries";


    procedure CreateSettleLines(var VendLedgEntry2: Record "Vendor Ledger Entry")
    var
        SettleCashAdvLine: Record "Settle Cash Advance Line";
        SettleCashAdvLine2: Record "Settle Cash Advance Line";
        Window: Dialog;
        LineCount: Integer;
        LineNo: Integer;
    begin
        with VendLedgEntry2 do begin
          SetRange(Open,true);
          if Find('-') then begin
            SettleCashAdvLine.LockTable;
            SettleCashAdvLine.SetRange("Settle Cash Advance No.",SettleCashAdvHdr."No.");
            SettleCashAdvLine."Settle Cash Advance No." := SettleCashAdvHdr."No.";
            if SettleCashAdvLine.FindFirst then
              LineNo := SettleCashAdvLine."Line No.";
            Window.Open(Text002 + Text003);

            repeat
              SettleCashAdvLine.Reset;
              SettleCashAdvLine.SetCurrentkey("Entry No.");
              SettleCashAdvLine.SetRange("Entry No.","Entry No.");  //KKE : 10.07.2007
              if not SettleCashAdvLine.FindFirst then begin
                CalcFields("Remaining Amt. (LCY)");
                if "Remaining Amt. (LCY)" <> 0 then begin
                  LineCount := LineCount + 1;
                  Window.Update(1,LineCount);
                  LineNo += 10000;
                  SettleCashAdvLine2.Init;
                  SettleCashAdvLine2."Settle Cash Advance No." := SettleCashAdvHdr."No.";
                  SettleCashAdvLine2."Line No." := LineNo;
                  SettleCashAdvLine2."Cash Advance Vendor No." := "Vendor No.";
                  SettleCashAdvLine2.Validate("Entry No.","Entry No.");
                  SettleCashAdvLine2.Insert;
                end;
              end;
            until Next = 0;
          end;
        end;
    end;


    procedure SetSettleHeader(var SettleCashAdvHeader2: Record "Settle Cash Advance Header")
    begin
        SettleCashAdvHdr.Get(SettleCashAdvHeader2."No.");
    end;
}

