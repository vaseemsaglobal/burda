report 50175 "Receipt (SGHKMY)"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Receipt (SGHKMY).rdl';
    Caption = 'Receipt (SGHKMY)';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(No_SalesInvHeader; "No.")
            {
            }
            column(LineAmountCaption; LineAmountCaptionLbl)
            {
            }
            column(InvoiceDiscountAmountCaption; InvoiceDiscountAmountCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PrintSummary; PrintSummary)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(Comment; CommentText)
                    {
                    }
                    column(WorkDescription; WorkDescription)
                    {
                    }
                    column(BilltoCaption; BilltoCaption)
                    {
                    }
                    column(PurchaseOrderLbl; PurchaseOrderLbl)
                    {
                    }
                    column(ContractNoLbl; ContractNoLbl)
                    {
                    }
                    column(SalespersonCaption; SalespersonLbl)
                    {
                    }
                    column(SubjectToLbl; SubjectToLbl)
                    {
                    }
                    column(REMARKLbl; REMARKLbl)
                    {
                    }
                    column(ADVERTISERLbl; ADVERTISERLbl)
                    {
                    }
                    column(PRODUCTLbl; PRODUCTLbl)
                    {
                    }
                    column(COMMENTSLbl; COMMENTSLbl)
                    {
                    }
                    column(ChequesLbl; StrSubstNo(ChequesLbl, CompanyInfo.Name))
                    {
                    }
                    column(BranchLbl; BranchLbl)
                    {
                    }
                    column(AddressLbl; AddressLbl)
                    {
                    }
                    column(ComputerGenLbl; ComputerGenLbl)
                    {
                    }
                    column(SwiftcodeLbl; SwiftcodeLbl)
                    {
                    }
                    column(ACNumberLbl; ACNumberLbl)
                    {
                    }
                    column(ACNameLbl; ACNameLbl)
                    {
                    }
                    column(Billtocontact; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(SelltoCustomerName; "Sales Invoice Header"."Sell-to Customer Name")
                    {
                    }
                    column(DocumentCaptionCopyText; DocumentCaption)
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompAddr1; CompanyAddr[1] + ' ' + CompanyInfo.Branch)
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(ShipMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(CompInfoVATRegsNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompInfoGiroNo; CompanyInfo."SWIFT Code")
                    {
                    }
                    column(CompInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankBranh; CompanyInfo."Bank Branch")
                    {
                    }
                    column(CompInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(CompanyinfoBankAddress; CompanyInfo."Bank Address")
                    {
                    }
                    column(CompanyInfoBankACname; CompanyInfo."Bank A/C Name")
                    {
                    }
                    column(BilltoCustNo_SalesInvHeader; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDt_SalesInvHeader; Format("Sales Invoice Header"."Posting Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegsNo_SalesInvHeader; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHeader; Format("Sales Invoice Header"."Due Date", 0, 4))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(SalesInvHeaderNo1; "Sales Invoice Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(SalesInvHeaderYourReference; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_SalesInvHdr; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
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
                    column(DocumentDate04_SalesInvHeader; Format("Sales Invoice Header"."Order Date", 0, 4))
                    {
                    }
                    column(PricesIncludVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo; Format("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(FormatAddrPrintBarCode1; FormatAddr.PrintBarCode(1))
                    {
                    }
                    column(CompInfoABNDivPartNo; CompanyInfo."ABN Division Part No.")
                    {
                    }
                    column(CompInfoABN; CompanyInfo.ABN)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccountNoCaption; BankAccountNoCaptionLbl)
                    {
                    }
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(ABNCaption; ABNCaptionLbl)
                    {
                    }
                    column(DivisionPartNoCaption; DivisionPartNoCaptionLbl)
                    {
                    }
                    column(PaymentTermsDescriptionCaption; PaymentTermsDescriptionCaptionLbl)
                    {
                    }
                    column(ShipmentMethodDescriptionCaption; ShipmentMethodDescriptionCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvHeaderCaption; "Sales Invoice Header".FieldCaption("Bill-to Customer No."))
                    {
                    }
                    column(PricesIncludVAT_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(EmailIdCaption; EmailIdCaptionLbl)
                    {
                    }
                    column(ProductAdsInvoice; "Sales Invoice Header"."Product (Ads. Invoice)")
                    {
                    }
                    column(Reamrk1; "Sales Invoice Header"."Remark 1")
                    {
                    }
                    column(Reamrk2; Remark2)
                    //"Sales Invoice Header"."Remark 2")
                    {
                    }
                    column(Attn; "Sales Invoice Header"."Sell-to Contact")
                    {
                    }
                    column(PoNO; "Sales Invoice Header"."PO No.")
                    {
                    }
                    column(Attncaption; Attncaption)
                    {
                    }
                    column(TaxIDcaption; TaxIDcaption)
                    {
                    }
                    column(SubjectText; SubjectText)
                    {
                    }
                    column(totalLinamount; totalLinamount)
                    {
                    }
                    column(TotalLineDiscountAmountprint; TotalLineDiscountAmountprint)
                    {
                    }
                    column(TotalUnitprice; TotalUnitprice)
                    {
                    }
                    column(PreparedBylbl; PreparedBylbl)
                    {
                    }
                    column(AuthorizedSignatureLbl; AuthorizedSignatureLbl)
                    {
                    }
                    column(ForLbl; StrSubstNo(ForLbl, CompanyInfo.Name))
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");

                        column(LineAmt_SalesInvLine; "Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesInvLine; Description)
                        {
                        }
                        column(No_SalesInvLine; "No.")
                        {
                        }
                        column(No_SalesInvLineCaption; FieldCaption("No."))
                        {
                        }
                        column(Qty_SalesInvLine; Quantity)
                        {
                        }
                        column(UnitMeasure_SalesInvLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Unit Price")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_SalesInvLine; "Line Discount amount")
                        {
                        }
                        column(VATIdentifier_SalesInvLine; "VAT Identifier")
                        {
                        }
                        column(PostedShipDt_SalesInvLine; Format("Shipment Date"))
                        {
                        }
                        column(SalesLineType_SalesInvLine; Format(Type))
                        {
                        }
                        column(InvDiscountAmt_SalesInvLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal_SalesInvLine; TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscountAmt_SalesInvLine; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText_SalesInvLine; TotalText)
                        {
                        }
                        column(Amount__SalesInvLine; Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalAmount__SalesInvLine; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmtIncludVATAmt; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtIncludVAT_SalesInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; StrSubstNo(Text000, TaxType, VATAmountLine."VAT %"))
                        //VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDisOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(SalesInvHeaderCurrFactor; "Sales Invoice Header"."Currency Factor")
                        {
                        }
                        column(TotalExclVATTextLCY; TotalExclVATTextLCY)
                        {
                        }
                        column(TotalInclVATTextLCY; TotalInclVATTextLCY)
                        {
                        }
                        column(AmtIncLCYAmtLCY; AmountIncLCY - AmountLCY)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtIncLCY; AmountIncLCY)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtLCY; AmountLCY)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(CurrLCY; CurrencyLCY)
                        {
                        }
                        column(CurrCode_SalesInvHeader; currencyCode)
                        {
                        }
                        column(AmtLangB1AmtLangB2; AmountLangB[1] + ' ' + AmountLangB[2] + currencyDesc)
                        {
                            AutoFormatType = 1;
                        }
                        column(AmtLangA1AmtLangA2; AmountLangA[1] + ' ' + AmountLangA[2] + currencyDesc)
                        {
                            AutoFormatType = 1;
                        }
                        column(AmtInWords; AmountInWords)
                        {
                        }
                        column(SalesInvLineLineNo; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscountPercentCaption; DiscountPercentCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(PostedShipmentDateCaption; PostedShipmentDateCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; GrandtotalCaptionLbl)
                        {
                        }
                        column(Desc_SalesInvLineCaption; FieldCaption(Description))
                        {
                        }
                        column(Qty_SalesInvLineCaption; QtyCaptionLbl)
                        {
                        }
                        column(UnitMeasure_SalesInvLineCaption; FieldCaption("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesInvLineCaption; FieldCaption("VAT Identifier"))
                        {
                        }
                        column(IsLineWithTotals; LineNoWithTotal = "Line No.")
                        {
                        }
                        column(Qty; Qty)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if (Type = Type::"G/L Account") then "No." := '';
                            VATAmountLine.Init();
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."VAT Amount" := "Amount Including VAT" - Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            if "Allow Invoice Disc." then VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;
                            CalcVATAmountLineLCY("Sales Invoice Header", VATAmountLine, TempVATAmountLineLCY, VATBaseRemainderAfterRoundingLCY, AmtInclVATRemainderAfterRoundingLCY);
                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            Qty := 1;
                            IF CntLine > 25 THEN
                                CntLine := 1
                            ELSE
                                CntLine += 1;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if PrintSummary then CurrReport.Skip();
                            VATAmountLine.DeleteAll();
                            TempVATAmountLineLCY.DeleteAll();
                            VATBaseRemainderAfterRoundingLCY := 0;
                            AmtInclVATRemainderAfterRoundingLCY := 0;
                            FirstValueEntryNo := 0;
                            MoreLines := Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do MoreLines := Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break();
                            LineNoWithTotal := "Line No.";
                            SetRange("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(LineLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                        column(Number_LineLoop; LineLoop.Number)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if CntLine + Line + Number > 10 then CurrReport.Break;
                        end;

                        trigger OnPreDataItem()
                        begin
                            /*GenJnlLine3.COPY("Gen. Journal Line");
                                                    IF GenJnlLine3.NEXT <> 0 THEN
                                                    IF (GenJnlLine3."Document No." = GenJnlLine2."Document No.") THEN
                                                      CurrReport.BREAK;  */
                            if CurrReport.PageNo = 1 then
                                LineSpace := 15
                            else
                                LineSpace := 25;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                var
                    salesinvoiceLine: Record "Sales Invoice Line";
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                    end;
                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscountOnVAT := 0;
                    CntLine := 0;
                    totalLinamount := 0;
                    TotalLineDiscountAmountprint := 0;
                    TotalUnitprice := 0;
                    if PrintSummary then begin
                        Qty := 1;
                        salesinvoiceLine.Reset();
                        salesinvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        IF salesinvoiceLine.FindSet() then
                            repeat
                                TotalLineDiscountAmountprint += salesinvoiceLine."Line Discount Amount";
                                totalLinamount += salesinvoiceLine."Line Amount";
                                TotalUnitprice += salesinvoiceLine."Unit Price" * salesinvoiceLine.Quantity;
                            until salesinvoiceLine.Next() = 0;
                    end;
                    if "Sales Invoice Header"."Currency Code" = '' then begin
                        currencyCode := GLSetup."Local Currency Symbol";
                        currencyDesc := GLSetup."Local Currency Description"
                    end
                    else begin
                        currencyCode := "Sales Invoice Header"."Currency Code";
                        If currency.Get(currencyCode) then currencyDesc := currency.Description;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    if not IsReportInPreviewMode then CODEUNIT.Run(CODEUNIT::"Sales Inv.-Printed", "Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                Handled: Boolean;
            begin
                if "Language Code" <> '' then CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                //VR
                Clear(CompanyAddr);
                TaxType := CompanyInfo."Invoice Caption";
                CompanyAddr[1] := CompanyInfo.Name;
                CompanyAddr[2] := CompanyInfo.Address + CompanyInfo."Address 2";
                CompanyAddr[3] := CompanyInfo."Address 3";
                IF CompanyInfo."Phone No." <> '' then CompanyAddr[4] := 'Tel: ' + CompanyInfo."Phone No." + '  ';
                IF CompanyInfo."Fax No." <> '' Then CompanyAddr[4] += 'Fax: ' + CompanyInfo."Fax No." + '  ';
                if CompanyInfo."Registration No." <> '' then CompanyAddr[5] := 'ROC: ' + CompanyInfo."Registration No.";
                if CompanyInfo."VAT Registration No." <> '' then CompanyAddr[6] := StrSubstNo('%1 Reg. No.: %2', TaxType, CompanyInfo."VAT Registration No.");
                CompressArray(CompanyAddr);
                //VR
                FormatAddressFields("Sales Invoice Header");
                FormatDocumentFields("Sales Invoice Header");
                if not Cust.Get("Bill-to Customer No.") then Clear(Cust);
                CalcFields(Amount);
                CalcFields("Amount Including VAT");
                AmountLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", Amount, "Currency Factor"));
                AmountIncLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", "Amount Including VAT", "Currency Factor"));
                SalesLine.InitTextVariable;
                SalesLine.FormatNoText(AmountLangA, "Amount Including VAT", "Currency Code");
                //if PrintSummary then begin
                //  WorkDescription := GetWorkDescription();
                //end;
                SubjectText := SalesSetup."Subject To";
                if CommentText = '' then
                    Remark2 := "Sales Invoice Header"."Remark 2"
                else
                    Remark2 := CommentText;
            end;

            trigger OnPreDataItem()
            begin
                SetLanguageCaption;
                if PrintSummary then if WorkDescription = '' then Error(Err001);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                        Visible = false;
                    }
                    field(PrintSummary; PrintSummary)
                    {
                        Caption = 'Print Summary';
                        ApplicationArea = Basic, Suite;
                        // Visible = false;
                    }
                    field(Comment; CommentText)
                    {
                        Caption = 'Comment';
                        ApplicationArea = Basic, Suite;
                    }
                    field("Work Description"; WorkDescription)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            PrintSummary := true;
            CommentText := '';
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        GLSetup.Get();
        SalesSetup.Get();
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CompanyInfo.VerifyAndSetPaymentInfo;
    end;

    var
        Text004: Label 'Sales - Invoice %1', Comment = '%1 = Document No.';
        PageCaptionCap: Label 'Page %1 of %2';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        TempVATAmountLineLCY: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        CurrExchRate: Record "Currency Exchange Rate";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[250];
        ShipToAddr: array[8] of Text[250];
        CompanyAddr: array[8] of Text[250];
        OrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        VALExchRate: Text[50];
        Text009: Label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        Text010: Label 'Sales - Prepayment Invoice %1';
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        TotalInclVATTextLCY: Text[50];
        TotalExclVATTextLCY: Text[50];
        AmountLCY: Decimal;
        AmountIncLCY: Decimal;
        CurrencyLCY: Boolean;
        AmountInWords: Boolean;
        AmountLangA: array[2] of Text[80];
        AmountLangB: array[2] of Text[80];
        SalesLine: Record "Sales Line";
        ShowTHFormatting: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        VATPercentCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        InvDiscBaseAmountCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmountCaptionLbl: Label 'Line Amount';
        InvoiceDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
        TotalCaptionLbl: Label 'TOTAL';
        DocumentDateCaptionLbl: Label 'Document Date';
        PhoneNoCaptionLbl: Label 'Phone No.';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank:';
        BankAccountNoCaptionLbl: Label 'Account No.';
        DueDateCaptionLbl: Label 'Due Date:';
        InvoiceNoCaptionLbl: Label 'No.:';
        PostingDateCaptionLbl: Label 'Date:';
        ABNCaptionLbl: Label 'ABN';
        DivisionPartNoCaptionLbl: Label 'Division Part No.';
        PaymentTermsDescriptionCaptionLbl: Label 'Payment Terms:';
        ShipmentMethodDescriptionCaptionLbl: Label 'Shipment Method';
        HomePageCaptionLbl: Label 'Home Page';
        EmailIdCaptionLbl: Label 'E-Mail';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        DiscountPercentCaptionLbl: Label 'Discount%';
        AmountCaptionLbl: Label 'Net Price';
        QtyCaptionLbl: Label 'Qty';
        PostedShipmentDateCaptionLbl: Label 'Posted Shipment Date';
        InvDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        PaymentDiscountonVATCaptionLbl: Label 'Payment Discount on VAT';
        ExchangeRateCaptionLbl: Label 'Exchange Rate';
        ShipmentCaptionLbl: Label 'Shipment';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        DisplayAdditionalFeeNote: Boolean;
        LineNoWithTotal: Integer;
        VATBaseRemainderAfterRoundingLCY: Decimal;
        AmtInclVATRemainderAfterRoundingLCY: Decimal;
        PrintSummary: Boolean;
        CommentText: Text[100];
        Remark2: Text;
        [InDataSet]
        WorkDescription: Text[250];
        Qty: Integer;
        BilltoCaption: Label 'Bill-to:';
        PurchaseOrderLbl: Label 'Purchase Order No.:';
        ContractNoLbl: Label 'Contract No.:';
        SalespersonLbl: Label 'Salesperson:';
        SubjectToLbl: Label 'SUBJECT TO:';
        REMARKLbl: Label 'REMARK: ';
        ADVERTISERLbl: Label 'ADVERTISER:';
        PRODUCTLbl: Label 'BRAND:';
        COMMENTSLbl: Label 'COMMENTS:';
        ChequesLbl: Label 'Cheques should be crossed "A/C PAYEE ONLY" and made payable to %1';
        BranchLbl: Label 'Branch:';
        AddressLbl: Label 'Address:';
        ACNameLbl: Label 'A/C Name:';
        ACNumberLbl: Label 'A/C Number:';
        SwiftcodeLbl: Label 'Swift Code:';
        ComputerGenLbl: Label 'This is a computer generated Invoice, No signature is required.';
        GrandtotalCaptionLbl: Label 'Grand Total';
        TaxIDThai: Text;
        TaxIDcaption: Label 'Tax ID';
        Attncaption: Label 'Attn.:';
        SubjectText: Text;
        CntLine: Integer;
        Line: Integer;
        LineSpace: Integer;
        TotalLineDiscountAmountprint: Decimal;
        TotalUnitprice: Decimal;
        totalLinamount: Decimal;
        currencyCode: Text;
        currencyDesc: Text;
        Currency: Record Currency;
        PreparedBylbl: Label 'Prepared By: _______________';
        AuthorizedSignatureLbl: Label 'Authorized Signature';
        ForLbl: Label 'For %1';
        CustRec: Record Customer;
        Err001: Label 'Work Description must have value.';
        Text000: Label '%1 %2%';
        TaxType: Text;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: Text;
    begin
        exit('RECEIPT');
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer;
    NewShowInternalInfo: Boolean;
    NewLogInteraction: Boolean;
    NewAmountInWords: Boolean;
    NewCurrencyLCY: Boolean;
    NewShowTHFormatting: Boolean;
    NewDisplayAsmInfo: Boolean;
    NewDisplayAdditionalFeeNote: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        AmountInWords := NewAmountInWords;
        CurrencyLCY := NewCurrencyLCY;
        DisplayAdditionalFeeNote := NewDisplayAdditionalFeeNote;
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        FormatDocument.SetTotalLabels(SalesInvoiceHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        //FormatDocument.SetSalesPerson(SalesPurchPerson, SalesInvoiceHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesInvoiceHeader."Payment Terms Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesInvoiceHeader."Shipment Method Code", SalesInvoiceHeader."Language Code");
        OrderNoText := FormatDocument.SetText(SalesInvoiceHeader."Order No." <> '', SalesInvoiceHeader.FieldCaption("Order No."));
        ReferenceText := FormatDocument.SetText(SalesInvoiceHeader."Your Reference" <> '', SalesInvoiceHeader.FieldCaption("Your Reference"));
        VATNoText := FormatDocument.SetText(SalesInvoiceHeader."VAT Registration No." <> '', SalesInvoiceHeader.FieldCaption("VAT Registration No."));
        if SalesPurchPerson.Get(SalesInvoiceHeader."Salesperson Code") then
            SalesPersonText := SalesPurchPerson.Name
        else
            SalesPersonText := '';
    end;

    local procedure FormatAddressFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        //FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        //FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        //ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
        Clear(CustAddr);
        Clear(ShipToAddr);
        CustRec.Get(SalesInvoiceHeader."Bill-to Customer No.");
        if (SalesInvoiceHeader."Bill-to Name (Thai)" = '') then
            CustAddr[1] := SalesInvoiceHeader."Bill-to Name"
        else
            CustAddr[1] := SalesInvoiceHeader."Bill-to Name (Thai)";
        if (SalesInvoiceHeader."Bill-to Address (Thai)" = '') then begin
            CustAddr[2] := SalesInvoiceHeader."Bill-to Address";
            CustAddr[3] := SalesInvoiceHeader."Bill-to Address 2";
            CustAddr[4] := SalesInvoiceHeader."Bill-to Address 3";
            IF CustRec.Branch <> '' then CustAddr[5] := '(' + CustRec.Branch + ')';
            if CustRec."Branch No." <> '' then CustAddr[5] += ' ' + CustRec."Branch No.";
        end
        else begin
            CustAddr[2] := SalesInvoiceHeader."Bill-to Address (Thai)";
            IF CustRec.Branch <> '' then CustAddr[3] := '(' + CustRec.Branch + ')';
            if CustRec."Branch No." <> '' then CustAddr[3] += ' ' + CustRec."Branch No.";
        end;
        ShipToAddr[1] := SalesInvoiceHeader."Ship-to Name";
        ShipToAddr[2] := SalesInvoiceHeader."Ship-to Address";
        ShipToAddr[3] := SalesInvoiceHeader."Ship-to Address 2";
        ShipToAddr[4] := SalesInvoiceHeader."Ship-to Address 3";
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PadStr('', 2, ' '));
    end;

    local procedure CalcVATAmountLineLCY(SalesInvoiceHeader: Record "Sales Invoice Header";
    TempVATAmountLine2: Record "VAT Amount Line" temporary;
    var TempVATAmountLineLCY2: Record "VAT Amount Line" temporary;
    var VATBaseRemainderAfterRoundingLCY2: Decimal;
    var AmtInclVATRemainderAfterRoundingLCY2: Decimal)
    var
        VATBaseLCY: Decimal;
        AmtInclVATLCY: Decimal;
    begin
        if (not GLSetup."Print VAT specification in LCY") or (SalesInvoiceHeader."Currency Code" = '') then exit;
        TempVATAmountLineLCY2.Init();
        TempVATAmountLineLCY2 := TempVATAmountLine2;
        //with SalesInvoiceHeader do begin
        VATBaseLCY := CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", TempVATAmountLine2."VAT Base", SalesInvoiceHeader."Currency Factor") + VATBaseRemainderAfterRoundingLCY2;
        AmtInclVATLCY := CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", TempVATAmountLine2."Amount Including VAT", SalesInvoiceHeader."Currency Factor") + AmtInclVATRemainderAfterRoundingLCY2;
        //end;
        TempVATAmountLineLCY2."VAT Base" := Round(VATBaseLCY);
        TempVATAmountLineLCY2."Amount Including VAT" := Round(AmtInclVATLCY);
        TempVATAmountLineLCY2.InsertLine;
        VATBaseRemainderAfterRoundingLCY2 := VATBaseLCY - TempVATAmountLineLCY2."VAT Base";
        AmtInclVATRemainderAfterRoundingLCY2 := AmtInclVATLCY - TempVATAmountLineLCY2."Amount Including VAT";
    end;

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
            IF (l IN [4, 12, 20]) AND (l < STRLEN(AmountText)) AND (adigit = '1') THEN dflag := TRUE;
            WHTAmtThaiText := WHTAmtThaiText + FormatDigitThai(adigit, l - 3, dflag);
            l := l - 1;
        UNTIL l = 3;
        IF COPYSTR(AmountText, STRLEN(AmountText) - 2, 3) = '.00' THEN
            WHTAmtThaiText := WHTAmtThaiText + 'Š­‡†Ò—‰'
        ELSE begin
            IF WHTAmtThaiText <> '' THEN WHTAmtThaiText := WHTAmtThaiText + 'Š­‡';
            l := 2;
            REPEAT
                dflag := FALSE;
                p := STRLEN(AmountText) - l + 1;
                adigit := COPYSTR(AmountText, p, 1);
                IF (l = 1) AND (adigit = '1') AND (COPYSTR(AmountText, p - 1, 1) <> '0') THEN dflag := TRUE;
                WHTAmtThaiText := WHTAmtThaiText + FormatDigitThai(adigit, l, dflag);
                l := l - 1;
            UNTIL l = 0;
            WHTAmtThaiText := WHTAmtThaiText + 'š…­ºñÕ';
        end;
        EXIT(WHTAmtThaiText);
    end;

    local procedure FormatDigitThai(adigit: Text[1];
    pos: Integer;
    dflag: Boolean) fdigitCount: text[100]
    var
        fdigit: Text[30];
        fcount: Text[30];
    begin
        CASE adigit OF
            '1':
                begin
                    IF (pos IN [1, 9, 17]) AND dflag THEN
                        fdigit := 'ÊÏ„'
                    ELSE
                        IF pos IN [2, 10, 18] THEN
                            fdigit := ''
                        ELSE
                            fdigit := '›‰´Ðº';
                end;
            '2':
                begin
                    IF pos IN [2, 10, 18] THEN
                        fdigit := '’³Ð'
                    ELSE
                        fdigit := 'šº';
                end;
            '3':
                fdigit := 'š­‘';
            '4':
                fdigit := 'š³Ð';
            '5':
                fdigit := '›Ò­';
            '6':
                fdigit := '›í';
            '7':
                fdigit := 'Ê¿Ï„';
            '8':
                fdigit := 'ß‹„';
            '9':
                fdigit := 'ÊíÒ­';
            '0':
                begin
                    IF pos IN [9, 17, 25] THEN fdigit := '•Ò­‰';
                end;
            '-':
                fdigit := '•Š';
        end;
        IF (adigit <> '0') AND (adigit <> '-') THEN begin
            CASE pos OF
                2, 10, 18:
                    fcount := 'š¯Š';
                3, 11, 19:
                    fcount := '“Ò’';
                5, 13, 21:
                    fcount := 'Ž©‰';
                6, 14, 22:
                    fcount := '›‘¸Ð‰';
                7, 15, 23:
                    fcount := 'ßš‰';
                9, 17, 25:
                    fcount := '•Ò­‰';
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
        LanguageCaption.SetRange("Report ID", 50175);
        if LanguageCaption.FindSet() then begin
            repeat
                case LanguageCaption."Caption Code" of
                    'TaxID':
                        begin
                            //CaptionNo := LanguageCaption."Caption in English";
                            TaxIDThai := LanguageCaption."Caption in Thai";
                        end;
                    else
                end;
            until LanguageCaption.Next() = 0;
        end;
    end;

    procedure WorkDescriptionFromDoc(pWorkDescription: Text)
    begin
        WorkDescription := pWorkDescription;
    end;
}
