report 50058 "Ads. Billing Note"
{

    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.05.2007   KKE   New report for "Ads. Billing Note" - Ads. Sales Module

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AdsBillingNote.rdl';
    Caption = 'Ads. Billing Note';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = ALL;

    dataset
    {
        dataitem("Ads. Billing Header"; "Ads. Billing Header")
        {
            RequestFilterFields = "No.";
            column(CustomerNameCaption; CaptionCustomerName)
            {

            }
            column(CustomerNameThaiCaption; CaptionThaiCustomerName)
            {

            }
            column(AmountCaption; CaptionAmount)
            {

            }
            column(BILLINGNOTECaption; CaptionBILLINGNOTE)
            {

            }
            column(PAYMENTTERMSCaption; CaptionPAYMENTTERMS)
            {

            }
            column(RECEIVETERMSCaption; CaptionRECEIVETERMS)
            {

            }
            column(RECEIVERCaption; CaptionRECEIVER)
            {

            }
            column(NoCaption; CaptionNo)
            {

            }
            column(InvoiceNoCaption; CaptionInvoiceNo)
            {

            }
            column(DateCaption; CaptionDate)
            {

            }
            column(AmountThaiCaption; CaptionThaiAmount)
            {

            }
            column(BILLINGNOTEThaiCaption; CaptionThaiBILLINGNOTE)
            {

            }
            column(PAYMENTTERMSThaiCaption; CaptionThaiPAYMENTTERMS)
            {

            }
            column(RECEIVETERMSThaiCaption; CaptionThaiRECEIVETERMS)
            {

            }
            column(RECEIVERThaiCaption; CaptionThaiRECEIVER)
            {

            }
            column(NoThaiCaption; CaptionThaiNo)
            {

            }
            column(InvoiceNoThaiCaption; CaptionThaiInvoiceNo)
            {

            }
            column(DateThaiCaption; CaptionThaiDate)
            {

            }
            column(CompanyName_CompanyInfo; CompanyInfo.Name)
            {

            }
            column(CompanyNameThai_CompanyInfo; CompanyInfo."Company Name (Thai)")
            {

            }
            column(AddressThai_CompanyInfo; tmpCompanyAddrTH[1] + ' ' + tmpCompanyAddrTH[2])
            {

            }
            column(Address_CompanyInfo; tmpCompanyAddr[1] + ' ' + tmpCompanyAddr[2])
            {

            }
            column(TelFax_CompanyInfo; 'Tel: ' + CompanyInfo."Phone No." + '    Fax: ' + CompanyInfo."Fax No.")
            {

            }
            column(No_AdsBillingHeader; "No.")
            {

            }
            column(BilltoCustomerNo_AdsBillingHeader; "Ads. Billing Header"."Bill-to Customer No." + ' ' + "Ads. Billing Header"."Bill-to Name" + "Ads. Billing Header"."Bill-to Name 2")
            {

            }
            column(BilltoCustomerName_AdsBillingHeader; BilltoCustomerName)
            {

            }
            column(BillingDate_AdsBillingHeader; "Ads. Billing Header"."Billing Date")
            {

            }

            dataitem(CopyLoop; "Integer")
            {
                DataItemLinkReference = "Ads. Billing Header";
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                dataitem("Ads. Billing Line"; "Ads. Billing Line")
                {
                    DataItemLinkReference = "Ads. Billing Header";
                    DataItemLink = "Billing No." = FIELD("No.");
                    DataItemTableView = SORTING("Billing No.", "Line No.") WHERE("Billing Amount" = FILTER(<> 0));
                    column(RowNo_I; i)
                    {

                    }
                    column(LineNo_AdsBillingLine; "Line No.")
                    {

                    }
                    column(DocumentNo_AdsBillingLine; "Document No.")
                    {

                    }
                    column(DueDate_AdsBillingLine; "Due Date")
                    {

                    }
                    column(BillingAmout_AdsBillingLine; "Billing Amount")
                    {

                    }
                    column(CurrencyCodeVal; CurrencyCodeVal)
                    {

                    }
                    column(CurrencyCodeDesVal; CurrencyCodeDesVAl)
                    {

                    }
                    trigger OnPreDataItem()
                    var
                    begin

                        if "Ads. Billing Line".FindFirst() then
                            if not CurrReport.PREVIEW then begin
                                "Ads. Billing Header".Status := "Ads. Billing Header".Status::Release;
                                "Ads. Billing Header".Modify();
                            end;
                    end;

                    trigger OnAfterGetRecord()
                    var
                    begin
                        i += 1;
                        CntLine += 1;
                        TotalAmount += "Ads. Billing Line"."Billing Amount";
                        TotalAmountThaiText := FormatNoThaiText(TotalAmount);
                        IF TotalAmountThaiText <> '' THEN
                            TotalAmountThaiText := '(' + TotalAmountThaiText + ')';
                        SalesLine.InitTextVariable();
                        SalesLine.FormatNoText(AmtNoText, TotalAmount, "Ads. Billing Line"."Currency Code");
                    end;
                }
                dataitem(LineSpace; "Integer")
                {
                    DataItemLinkReference = "Ads. Billing Header";
                    DataItemTableView = sorting(Number);
                    column(TotalAmountThaiText; TotalAmountThaiText)
                    {

                    }
                    column(TotalAmountText; AmtNoText[1] + ' ' + AmtNoText[2])
                    {

                    }
                    column(TotalAmount; TotalAmount)
                    {

                    }
                    trigger OnPreDataItem()
                    var

                    begin
                        LineSpace.SetRange(Number, 1, 8 - CntLine);
                    end;
                }
                // dataitem(Total; "Integer")
                // {
                //     DataItemLinkReference = "Ads. Billing Header";
                //     DataItemTableView = sorting(Number) where(Number = const(1));
                // trigger OnAfterGetRecord()
                // var

                // begin
                //     TotalAmount += "Ads. Billing Line"."Billing Amount";
                //     TotalAmountThaiText := FormatNoThaiText(TotalAmount);
                //     IF TotalAmountThaiText <> '' THEN
                //         TotalAmountThaiText := '(' + TotalAmountThaiText + ')';
                //     SalesLine.FormatNoText(AmtNoText, TotalAmount, "Ads. Billing Line"."Currency Code");
                // end;
                // }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin

                    CompanyInfo.GET;
                    CompanyInfo.CALCFIELDS(Picture);
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    IF CompanyInfo."Company Name (Thai)" = '' THEN
                        CompanyInfo."Company Name (Thai)" := CompanyInfo.Name + CompanyInfo."Name 2";
                    tmpCompanyAddrTH[1] := CompanyInfo."Company Address (Thai)";
                    tmpCompanyAddrTH[2] := CompanyInfo."Company Address 2 (Thai)";
                    tmpCompanyAddr[1] := CompanyAddr[2] + ' ' + CompanyAddr[3] + ' ' + CompanyAddr[4];
                    tmpCompanyAddr[2] := CompanyInfo."Address 3";

                    SetLanguageCaption();
                end;

                trigger OnAfterGetRecord()
                var
                    GLSetupRec: Record "General Ledger Setup";
                    CurrencyRec: Record Currency;
                begin
                    i := 0;
                    CntLine := 0;
                    TotalAmount := 0;
                    TotalAmountThaiText := '';
                    CurrencyCodeVal := "Ads. Billing Line"."Currency Code";
                    if CurrencyCodeVal = '' then begin
                        GLSetupRec.Get();
                        CurrencyCodeVal := GLSetupRec."LCY Code";
                        CurrencyCodeDesVal := GLSetupRec."Local Currency Description"
                    end else begin
                        CurrencyRec.Get(CurrencyCodeVal);
                        CurrencyCodeDesVal := CurrencyRec.Description;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
            begin
                CustomerRec.Get("Ads. Billing Header"."Bill-to Customer No.");
                if CustomerRec."Name (Thai)" = '' then
                    BilltoCustomerName := CustomerRec.Name
                else
                    BilltoCustomerName := CustomerRec.Name;
            end;

            trigger OnPostDataItem()
            var

            begin
                //Message('%1', TotalAmount);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        CustomerRec: Record Customer;
        CompanyAddr: array[8] of Text[50];
        tmpCompanyAddr: array[2] of Text[250];
        tmpCompanyAddrTH: array[2] of Text[250];
        AmtNoText: array[2] of Text[80];
        SalesLine: Record "Sales Line";
        i: Integer;
        CntLine: Integer;
        TotalAmount: Decimal;
        BilltoCustomerName: Text;
        TotalAmountThaiText: Text[250];
        Form50BIS: Report "Form 50 BIS -Cash Advance";
        CaptionAmount: Text;
        CaptionBILLINGNOTE: Text;
        CaptionPAYMENTTERMS: Text;
        CaptionRECEIVETERMS: Text;
        CaptionRECEIVER: Text;
        CaptionNo: Text;
        CaptionInvoiceNo: Text;
        CaptionDate: Text;
        CaptionThaiAmount: Text;
        CaptionThaiBILLINGNOTE: Text;
        CaptionThaiPAYMENTTERMS: Text;
        CaptionThaiRECEIVETERMS: Text;
        CaptionThaiRECEIVER: Text;
        CaptionThaiNo: Text;
        CaptionThaiInvoiceNo: Text;
        CaptionThaiDate: Text;
        RepCheck: Report Check;
        CaptionCustomerName: Text;
        CaptionThaiCustomerName: Text;
        CurrencyCodeVal: Code[20];
        CurrencyCodeDesVal: Text;

    local procedure FormatNoThaiText(Amount: Decimal) WHTAmtThaiText: Text[200];
    var
        AmountText: Text[30];
        x: Integer;
        l: Integer;
        p: Integer;
        adigit: Text[1];
        dflag: Boolean;
    begin

        Amount := ROUND(Amount);
        AmountText := FORMAT(Amount, 0);
        x := STRPOS(AmountText, '.');
        CASE TRUE OF
            x = 0:
                AmountText := AmountText + '.00';
            x = STRLEN(AmountText) - 1:
                AmountText := AmountText + '0';
            x > STRLEN(AmountText) - 2:
                AmountText := COPYSTR(AmountText, 1, x + 2);
        end;
        l := STRLEN(AmountText);
        REPEAT
            dflag := FALSE;
            p := STRLEN(AmountText) - l + 1;
            adigit := COPYSTR(AmountText, p, 1);
            IF (l IN [4, 12, 20]) AND (l < STRLEN(AmountText)) AND (adigit = '1') THEN
                dflag := TRUE;
            WHTAmtThaiText := WHTAmtThaiText + FormatDigitThai(adigit, l - 3, dflag);
            l := l - 1;
        UNTIL l = 3;

        IF COPYSTR(AmountText, STRLEN(AmountText) - 2, 3) = '.00' THEN
            WHTAmtThaiText := WHTAmtThaiText + 'บาทถ้วน'
        ELSE begin
            IF WHTAmtThaiText <> '' THEN
                WHTAmtThaiText := WHTAmtThaiText + 'บาท';
            l := 2;
            REPEAT
                dflag := FALSE;
                p := STRLEN(AmountText) - l + 1;
                adigit := COPYSTR(AmountText, p, 1);
                IF (l = 1) AND (adigit = '1') AND (COPYSTR(AmountText, p - 1, 1) <> '0') THEN
                    dflag := TRUE;
                WHTAmtThaiText := WHTAmtThaiText + FormatDigitThai(adigit, l, dflag);
                l := l - 1;
            UNTIL l = 0;
            WHTAmtThaiText := WHTAmtThaiText + 'สตางค์';
        end;

        EXIT(WHTAmtThaiText);
    end;

    local procedure FormatDigitThai(adigit: Text[1]; pos: Integer; dflag: Boolean) fdigitCount: text[100]
    var
        fdigit: Text[30];
        fcount: Text[30];
    begin
        CASE adigit OF
            '1':
                begin
                    IF (pos IN [1, 9, 17]) AND dflag THEN
                        fdigit := 'เอ็ด'
                    ELSE
                        IF pos IN [2, 10, 18] THEN
                            fdigit := ''
                        ELSE
                            fdigit := 'หนึ่ง';
                end;
            '2':
                begin
                    IF pos IN [2, 10, 18] THEN
                        fdigit := 'ยี่'
                    ELSE
                        fdigit := 'สอง';
                end;
            '3':
                fdigit := 'สาม';
            '4':
                fdigit := 'สี่';
            '5':
                fdigit := 'ห้า';
            '6':
                fdigit := 'หก';
            '7':
                fdigit := 'เจ็ด';
            '8':
                fdigit := 'แปด';
            '9':
                fdigit := 'เก้า';
            '0':
                begin
                    IF pos IN [9, 17, 25] THEN
                        fdigit := 'ล้าน';
                end;
            '-':
                fdigit := 'ลบ';
        end;
        IF (adigit <> '0') AND (adigit <> '-') THEN begin
            CASE pos OF
                2, 10, 18:
                    fcount := 'สิบ';
                3, 11, 19:
                    fcount := 'ร้อย';
                5, 13, 21:
                    fcount := 'พัน';
                6, 14, 22:
                    fcount := 'หมื่น';
                7, 15, 23:
                    fcount := 'แสน';
                9, 17, 25:
                    fcount := 'ล้าน';
            end;
        end;
        fdigitCount := fdigit + fcount;
        EXIT(fdigitCount);
    end;

    local procedure SetLanguageCaption()
    var
        LanguageCaption: Record "Language Caption";
    begin
        LanguageCaption.Reset();
        LanguageCaption.SetRange("Report ID", 50058);
        if LanguageCaption.FindSet() then begin
            repeat
                case LanguageCaption."Caption Code" of
                    'NO':
                        begin
                            CaptionNo := LanguageCaption."Caption in English";
                            CaptionThaiNo := LanguageCaption."Caption in Thai";
                        end;

                    'AMOUNT':
                        begin
                            CaptionAmount := LanguageCaption."Caption in English";
                            CaptionThaiAmount := LanguageCaption."Caption in Thai";
                        end;
                    'BILLINGNOTE':
                        begin
                            CaptionBILLINGNOTE := LanguageCaption."Caption in English";
                            CaptionThaiBILLINGNOTE := LanguageCaption."Caption in Thai";
                        end;
                    'DATE':
                        begin
                            CaptionDate := LanguageCaption."Caption in English";
                            CaptionThaiDate := LanguageCaption."Caption in Thai";
                        end;

                    'INVOICENO':
                        begin
                            CaptionInvoiceNo := LanguageCaption."Caption in English";
                            CaptionThaiInvoiceNo := LanguageCaption."Caption in Thai";
                        end;
                    'PAYMENTTERMS':
                        begin
                            CaptionPAYMENTTERMS := LanguageCaption."Caption in English";
                            CaptionThaiPAYMENTTERMS := LanguageCaption."Caption in Thai";
                        end;
                    'RECEIVER':
                        begin
                            CaptionRECEIVER := LanguageCaption."Caption in English";
                            CaptionThaiRECEIVER := LanguageCaption."Caption in Thai";
                        end;
                    'RECEIVETERMS':
                        begin
                            CaptionRECEIVETERMS := LanguageCaption."Caption in English";
                            CaptionThaiRECEIVETERMS := LanguageCaption."Caption in Thai";
                        end;
                    'CUSTOMERNAME':
                        begin
                            CaptionCustomerName := LanguageCaption."Caption in English";
                            CaptionThaiCustomerName := LanguageCaption."Caption in Thai";
                        end;
                    else
                end;
            until LanguageCaption.Next() = 0;
        end;
    end;
}
