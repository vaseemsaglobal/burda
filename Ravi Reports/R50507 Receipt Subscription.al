report 50507 "Receipt Subsription"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ReceiptSubscriptions.rdl';

    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.05.2007   KKE   New report for "Receipt - Subscription" - Ads. Sales Module
    // 002   05.10.2007   KKE   Total 2 Invoice incase split sales invoice from credit charge fee.
    // 003   07.01.2008   KKE   Incase 2 invoice is not the same customer.
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            CalcFields = "Amount Including VAT";

            column(Amount; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(Description; CommentText)
            {
            }
            column(Address; BillToAddress)
            {
            }
            column(CustName; BillToName)
            {
            }
            column(DocumentNo; "Sales Invoice Header"."No.")
            {
            }
            column(SubscriberNo; SubContNo)
            {
            }
            column(PostingDate; FORMAT("Posting Date", 0, 4))
            {
            }
            column(CaptionTaxID; CaptionTaxID)
            {
            }
            column(CompanyInfo_CompanyNameThai; CompanyInfo."Company Name (Thai)")
            {
            }
            column(CompanyInfo_CompanyAddressThai; CompanyInfo."Company Address (Thai)")
            {
            }
            column(CompanyInfo_CompanyAddress2Thai_PostCode; CompanyInfo."Company Address 2 (Thai)")
            {
            }
            column(CompanyInfo_AddressCompanyInfo_Address2; CompanyInfo.Address + CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_Address3CompanyInfo_PostCode; CompanyInfo."Address 3" + ' ' + CompanyInfo."Post Code")
            {
            }
            column(TelCompanyInfo_PhoneNoFaxVATRegCompanyInfo_FaxNo; 'Tel: ' + CompanyInfo."Phone No." + ' Fax: ' + CompanyInfo."Fax No." + ' Tax ID: ' + CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_VATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CaptionToday; Format(Today, 0, 4))
            {
            }
            column(CompAddr1; CompanyAddr[1] + ' ' + CompanyInfo.Branch)
            {
            }
            column(CompAddr2; CompanyAddr[2])
            {
            }
            column(CompAddr3; CompanyAddr[3])
            {
            }
            column(CompAddr4; CompanyAddr[4])
            {
            }
            column(CompAddr5; CompanyAddr[5])
            {
            }
            column(CompAddr6; CompanyAddr[6])
            {
            }
            column(CompAddr7; CompanyAddr[7])
            {
            }
            column(CompAddr8; CompanyAddr[8])
            {
            }
            column(TextAmount1; TextAmount[1])
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                column(SubscriberNoText; SubscriberNoText)
                {
                }
                column(ChequeNo; ChequeNo)
                {
                }
                column(PostalOrderNo; PostalOrderNo)
                {
                }
                column(CreditCardNo; CreditCardNo)
                {
                }
                column(Cheque; Cheque)
                {
                }
                column(PostalOrder; PostalOrder)
                {
                }
                column(Payment1; Payment[1])
                {
                }
                column(Payment2; Payment[2])
                {
                }
                column(Payment3; Payment[3])
                {
                }
                column(Payment4; Payment[4])
                {
                }
                column(Payment5; Payment[5])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SalesInvLine.RESET;
                    SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                    SalesInvLine.SETFILTER("Subscriber Contract No.", '<>%1', '');
                    IF SalesInvLine.FIND('-') THEN SubContNo := SalesInvLine."Subscriber Contract No.";
                    IF NOT SubscriberCont.GET(SubContNo) THEN SubscriberCont.INIT;
                    SubscriberNoText := '';
                    IF SubscriberCont."Subscriber No." <> '' THEN SubscriberNoText := STRSUBSTNO(Text001, SubscriberCont."Subscriber No.");
                    SubscriberNoText := SubscriberCont."Subscriber No.";
                    CommentText := '';
                    IF Promotion.GET(SubscriberCont."Promotion Code") THEN CommentText := Promotion.Description;
                    CommentText += ' ' + STRSUBSTNO(Text002, SubscriberCont."Contract Quantity", SubscriberCont."Starting Magazine Item No.", SubscriberCont."Ending Magazine Item No.");
                    CASE SubscriberCont."Payment Option" OF
                        SubscriberCont."Payment Option"::Cash:
                            Payment[1] := TRUE;
                        SubscriberCont."Payment Option"::"Postal Order":
                            begin
                                Payment[2] := TRUE;
                                PostalOrderNo := SubscriberCont."Receipt No.";
                            end;
                        SubscriberCont."Payment Option"::Transfer:
                            BEGIN
                                Payment[5] := TRUE;
                            END;
                    END;
                    IF SubscriberCont."Credit Card Amount" <> 0 THEN BEGIN
                        Payment[3] := TRUE;
                        IF GenMasterSetup.GET(GenMasterSetup.Type::"Payment Status", SubscriberCont."Credit Card Bank") THEN CreditCard := GenMasterSetup.Description;
                        IF CreditCard = '' THEN CreditCard := SubscriberCont."Credit Card Bank";
                        CreditCardNo := SubscriberCont."Credit Card No.";
                    END;
                    IF SubscriberCont."Check Amount" <> 0 THEN BEGIN
                        Payment[4] := TRUE;
                        Cheque := SubscriberCont."Bank Code";
                        ChequeNo := SubscriberCont."Check No.";
                    END;
                    IF Payment[1] THEN P[1] := 'P';
                    IF Payment[2] THEN P[2] := 'P';
                    IF Payment[3] THEN P[3] := 'P';
                    IF Payment[4] THEN P[4] := 'P';
                    IF Payment[5] THEN P[5] := 'P';
                end;
            }
            trigger OnAfterGetRecord()
            var
                CustomerRec: Record Customer;
            begin
                i := 0;
                CLEAR(P);
                CLEAR(Payment);
                CLEAR(CreditCard);
                CLEAR(CreditCardNo);
                CLEAR(SubContNo);
                CLEAR(PostalOrderNo);
                CLEAR(Cheque);
                CLEAR(ChequeNo);
                Clear(TtoalCurrCode);
                Clear(TotalAmount);
                if CustomerRec.get("Bill-to Customer No.") then;
                // BillToName := "Bill-to Name (Thai)";
                IF "Bill-to Name (Thai)" <> '' THEN
                    BillToName := "Bill-to Name (Thai)"
                else
                    BillToName := "Bill-to Name";



                if "Bill-to Address (Thai)" <> '' then
                    BillToAddress := "Bill-to Address (Thai)"
                else
                    BillToAddress := "Bill-to Address" + ' ' + "Bill-to Address 2" + ' ' + "Bill-to Address 3";

                LanguageCaption.Reset();
                LanguageCaption.SetRange("Report ID", 50507);
                LanguageCaption.SetRange("Caption Code", 'TaxID');
                if LanguageCaption.FindFirst() then CaptionTaxID := LanguageCaption."Caption in Thai";
                //VR
                CompanyAddr[1] := CompanyInfo.Name;
                CompanyAddr[2] := CompanyInfo."Company Name (Thai)";
                CompanyAddr[3] := CompanyInfo.Address + CompanyInfo."Address 2";
                CompanyAddr[4] := CompanyInfo."Address 3";
                CompanyAddr[5] := CompanyInfo."Company Address (Thai)";
                CompanyAddr[6] := CompanyInfo."Company Address 2 (Thai)";
                IF CompanyInfo."Phone No." <> '' then CompanyAddr[7] := 'Tel: ' + CompanyInfo."Phone No." + '  ';
                IF CompanyInfo."Fax No." <> '' Then CompanyAddr[7] += 'Fax: ' + CompanyInfo."Fax No." + '  ';
                if CompanyInfo."VAT Registration No." <> '' then begin
                    CompanyAddr[7] += 'Tax ID: ' + CompanyInfo."VAT Registration No.";
                    if CaptionTaxID <> '' then CompanyAddr[8] := CaptionTaxID + ' ' + CompanyInfo."VAT Registration No.";
                end;
                CompressArray(CompanyAddr);
                //VR
                if "Sales Invoice Header"."Currency Code" <> '' then begin
                    if Currency.get("Sales Invoice Header"."Currency Code") then
                        TtoalCurrCode := Currency.Description
                    else
                        TtoalCurrCode := "Sales Invoice Header"."Currency Code";
                end
                else begin
                    GeneralLedgerSetup.Get;
                    TtoalCurrCode := GeneralLedgerSetup."Local Currency Description";
                end;
                Clear(TextAmount);
                TotalAmount := "Sales Invoice Header"."Amount Including VAT" + SalesInvHdr."Amount Including VAT";
                IF TotalAmount <> 0 THEN begin
                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(TextAmount, Abs(TotalAmount), "Sales Invoice Header"."Currency Code");
                    if TextAmount[1] <> '' then TextAmount[1] := TextAmount[1] + ' ' + TtoalCurrCode;
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);
            end;
        }
    }
    var
        CompanyInfo: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        CompanyAddr: array[100] of Text[100];
        BillToName: Text[500];
        BillToAddress: Text[500];
        CommentText: Text[250];
        i: Integer;
        Payment: array[5] of Boolean;
        P: array[5] of Text[1];
        Cheque: Text[30];
        ChequeNo: Text[30];
        PostalOrder: Text[30];
        PostalOrderNo: Text[30];
        CreditCard: Text[30];
        CreditCardNo: Text[30];
        SalesInvHdr: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        SubContNo: Code[20];
        TotalAmount: Decimal;
        SubscriberCont: Record "Subscriber Contract";
        GenMasterSetup: Record "General Master Setup";
        Promotion: Record Promotion;
        SubscriberNoText: Text[50];
        Text001: Label 'Member No. %1';
        Text002: Label 'No. of %1, starting from issue %2 to issue %3';
        CaptionTaxID: Text;
        LanguageCaption: Record "Language Caption";
        CheckReport: Report Check;
        TextAmount: array[2] of Text[250];
        TtoalCurrCode: Code[50];
        GeneralLedgerSetup: Record "General Ledger Setup";
        Currency: Record Currency;
}
