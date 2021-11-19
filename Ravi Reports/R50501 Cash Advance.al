report 50501 "Cash Advance Report"
{
    // 
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   16.03.2007   KKE   New report for Cash Advance
    // 002   18.12.2007   KKE   Correct report to show remaining amount incase filter data by Date.
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CashAdvanceReport.rdl';
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.")
                          WHERE("Cash Advance" = filter(true));
            column(Vendor_No; Vendor."No.")
            {
            }
            column(Vendor_NameThai; VendorName)
            {
            }
            column(Today_Date; TODAY)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                RequestFilterFields = "Vendor No.", "Posting Date";
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code")
                                    WHERE("Remaining Amount" = FILTER(<> 0));
                column(PostingDate; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(DebitAmount; DebitAmount)
                {
                }
                column(CreditAmount; CreditAmount)
                {
                }
                column(Des; "Vendor Ledger Entry".Description)
                {
                }
                column(DocNo; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Amount; "Vendor Ledger Entry".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //KKE : #002 +
                    IF VendLedgEntry.GET("Entry No.") THEN
                        VendLedgEntry.CALCFIELDS("Remaining Amount");
                    IF VendLedgEntry."Remaining Amount" = 0 THEN
                        CurrReport.SKIP;
                    //KKE : #002 -
                    TotalDebitAmount += "Debit Amount";
                    TotalCreditAmount += "Credit Amount";
                    TotalDebitAmount2 += "Debit Amount";
                    TotalCreditAmount2 += "Credit Amount";

                    CLEAR(CreditAmount);
                    "Vendor Ledger Entry".CALCFIELDS(Amount);
                    // IF "Vendor Ledger Entry".Amount <> 0 THEN  BEGIN
                    IF "Vendor Ledger Entry".Amount > 0 THEN
                        CreditAmount := "Vendor Ledger Entry".Amount;
                    CLEAR(DebitAmount);
                    IF "Vendor Ledger Entry".Amount < 0 THEN
                        DebitAmount := "Vendor Ledger Entry".Amount
                    // END;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(VendorName);
                if Vendor."Name (Thai)" <> '' then
                    VendorName := Vendor."Name (Thai)"
                else
                    VendorName := Vendor.Name;
                TotalDebitAmount := 0;
                TotalCreditAmount := 0;
                /*
                IF "Balance (LCY)" = 0 THEN
                  CurrReport.SKIP;
                */  //KKE : #002
            end;
        }

    }
    requestpage
    {

        layout
        {
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
        VendorFilter: Text[250];
        TotalDebitAmount: Decimal;
        TotalCreditAmount: Decimal;
        TotalDebitAmount2: Decimal;
        TotalCreditAmount2: Decimal;
        CreditAmount: Decimal;
        DebitAmount: Decimal;
        VendorName: Text[100];
}

