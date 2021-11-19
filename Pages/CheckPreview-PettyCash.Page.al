Page 50083 "Check Preview - Petty Cash"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   23.08.2006   KKE   Check Preview - Petty Cash.
    // 002   24.01.2007   KKE   Display 'Paid to Vendor Name'

    Caption = 'Check Preview';
    DataCaptionExpression = "No." + ' ' + CheckToAddr[1];
    Editable = false;
    PageType = Card;
    SourceTable = "Settle Petty Cash Header";

    layout
    {
        area(content)
        {
            group(Control11)
            {
                field(CompanyAddr1; CompanyAddr[1])
                {
                    ApplicationArea = Basic;
                }
                field(CompanyAddr2; CompanyAddr[2])
                {
                    ApplicationArea = Basic;
                }
                field(CompanyAddr3; CompanyAddr[3])
                {
                    ApplicationArea = Basic;
                }
                field(CompanyAddr4; CompanyAddr[4])
                {
                    ApplicationArea = Basic;
                }
                label(Control13)
                {
                    ApplicationArea = Basic;
                    CaptionClass = FORMAT(NumberText[1]);
                }
                label(Control14)
                {
                    ApplicationArea = Basic;
                    CaptionClass = FORMAT(NumberText[2]);
                }
                label(Control1)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19036990;
                    MultiLine = true;
                }
                field(CheckToAddr1; CheckToAddr[1])
                {
                    ApplicationArea = Basic;
                }
                field(CheckToAddr2; CheckToAddr[2])
                {
                    ApplicationArea = Basic;
                }
                field(CheckToAddr3; CheckToAddr[3])
                {
                    ApplicationArea = Basic;
                }
                field(CheckToAddr4; CheckToAddr[4])
                {
                    ApplicationArea = Basic;
                }
                field(Date; "Cheque Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                }
                field(CheckAmount; CheckAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Amount';
                }
                field("0"; 0)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'WHT';
                }
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(CheckStatusText; CheckStatusText)
                {
                    ApplicationArea = Basic;
                }
                field(Control1500002; CheckAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT('Total ' + "Currency Code");
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CalcCheck;
    end;

    trigger OnOpenPage()
    begin
        CompanyInfo.Get;
        FormatAddr.Company(CompanyAddr, CompanyInfo);
    end;

    var
        Text000: label 'Printed Check';
        Text001: label 'Not Printed Check';
        GenJnlLine: Record "Gen. Journal Line";
        Cust: Record Customer;
        Vend: Record Vendor;
        BankAcc: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        FormatAddr: Codeunit "Format Address";
        CheckToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        NumberText: array[2] of Text[80];
        CheckStatusText: Text[30];
        CheckAmount: Decimal;
        Text19036990: label 'Pay to the order of';

    local procedure CalcCheck()
    var
        GenJnlLine1: Record "Gen. Journal Line";
    begin
        if "Cheque Printed" then
            CheckStatusText := Text000
        else
            CheckStatusText := Text001;

        CalcFields("Balance Settle");
        CheckAmount := -"Balance Settle";

        if CheckAmount < 0 then
            CheckAmount := 0;

        CheckReport.InitTextVariable;
        CheckReport.FormatNoText(NumberText, CheckAmount, "Currency Code");

        Vend.Get("Petty Cash Vendor No.");
        Vend.Contact := '';
        //FormatAddr.Vendor(CheckToAddr,Vend);
        //KKE : #002 +
        if "Paid to Vendor Name" <> '' then
            CheckToAddr[1] := "Paid to Vendor Name"
        else
            if Vend."Name (Thai)" <> '' then
                CheckToAddr[1] := Vend."Name (Thai)"
            else
                CheckToAddr[1] := Vend.Name + Vend."Name 2";
        //KKE : #002 -
    end;
}

