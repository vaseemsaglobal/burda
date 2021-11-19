Report 50088 "Suggest Petty Cash Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.

    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Settle Petty Cash Header"; "Settle Petty Cash Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LineNo := 0;
                SettlePettyCashLine.Reset;
                SettlePettyCashLine.SetRange("Settle Petty Cash No.", "No.");
                if SettlePettyCashLine.Find('+') then
                    LineNo := SettlePettyCashLine."Line No.";
                VendLedgEntry.Reset;
                VendLedgEntry.SetCurrentkey("Vendor No.", "Posting Date", "Currency Code");
                VendLedgEntry.SetRange("Vendor No.", "Petty Cash Vendor No.");
                VendLedgEntry.SetFilter("Posting Date", '..%1', "Posting Date");
                VendLedgEntry.SetRange("Document Type", VendLedgEntry."document type"::Invoice);
                VendLedgEntry.SetRange(Open, true);
                if VendLedgEntry.Find('-') then
                    repeat
                        VendLedgEntry.CalcFields("Remaining Amt. (LCY)");
                        if VendLedgEntry."Remaining Amt. (LCY)" <> 0 then begin
                            SettlePettyCashLine.Reset;
                            SettlePettyCashLine.SetCurrentkey("Entry No.");
                            SettlePettyCashLine.SetRange("Entry No.", VendLedgEntry."Entry No.");
                            if not SettlePettyCashLine.FindFirst then begin
                                LineNo += 10000;
                                SettlePettyCashLine2.Init;
                                SettlePettyCashLine2."Settle Petty Cash No." := "No.";
                                SettlePettyCashLine2."Line No." := LineNo;
                                SettlePettyCashLine2."Petty Cash Vendor No." := VendLedgEntry."Vendor No.";
                                SettlePettyCashLine2.Validate("Entry No.", VendLedgEntry."Entry No.");
                                SettlePettyCashLine2.Insert;
                            end;
                        end;
                    until VendLedgEntry.Next = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        SettlePettyCashLine: Record "Settle Petty Cash Line";
        SettlePettyCashLine2: Record "Settle Petty Cash Line";
        LineNo: Integer;
}

