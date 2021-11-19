report 50165 "Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/PurchaseOrder.rdl';
    Caption = 'Purchase Order';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';

            column(DocumentType_PurchHdr; "Document Type")
            {
            }
            column(No_PurchHdr; "No.")
            {
            }
            column(AmtCaption; AmtCaptionLbl)
            {
            }
            column(Desc_PurchLineCaption; DescCaptionLbl)
            {
            }
            column(Quantity_PurchLineCaption; QtyCaptionLbl)
            {
            }
            column(UnitofMeasure_PurchLineCaption; unitpriceCaptionLbl)
            {
            }
            column(DirectUnitCostCaption; unitpriceCaptionLbl)
            {
            }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl)
            {
            }
            column(ORIGINALCaptionLbl; ORIGINALCaptionLbl)
            {
            }
            column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
            {
            }
            column(RemarksCaptionLbl; RemarksCaptionLbl)
            {
            }
            column(DateCaptionLbl; DateCaptionLbl)
            {
            }
            column(RequestedByCaptionLbl; RequestedByCaptionLbl)
            {
            }
            column(RequestedDateCaptionLbl; RequestedDateCaptionLbl)
            {
            }
            column(AuthorizedByCaptionLbl; AuthorizedByCaptionLbl)
            {
            }
            column(AuthorizedSignCaptionLbl; AuthorizedSignCaptionLbl)
            {
            }
            column(SupplierNameCpationLbl; SupplierNameCpationLbl)
            {
            }
            column(ShiptoCaptionLbl; ShiptoCaptionLbl)
            {
            }
            column(TermofDeliveryCaptionLbl; TermofDeliveryCaptionLbl)
            {
            }
            column(NettotalCaptionLbl; NettotalCaptionLbl)
            {
            }
            column(TaxIDThai; TaxIDCaptionLbl)
            {
            }
            column(CaptionPurchaseOrderThai; CaptionPurchaseOrderThai)
            {
            }
            column(PoNoCapThai; PoNoCapThai)
            {
            }
            column(PoDateThaiCap; PoDateThaiCap)
            {
            }
            column(PaymentTermThaiCap; PaymentTermThaiCap)
            {
            }
            column(TermofDelThaiCap; TermofDelThaiCap)
            {
            }
            column(SupplierNameThaiCap; SupplierNameThaiCap)
            {
            }
            column(ShipToThaiCap; ShipToThaiCap)
            {
            }
            column(contactpersonCap; contactpersonCap)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
            {
            }
            column(CompanyAddr7; CompanyAddr[7])
            {
            }
            column(CompanyAddr8; CompanyAddr[8])
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(OrderCopyText; StrSubstNo(Text004, CopyText))
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(Forcaptionlbl; StrSubstNo(ForCaptionLbl, CompanyInfo.Name))
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(SelltoCustNo_PurchHdr; "Purchase Header"."Sell-to Customer No.")
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(ShiptoAddCaption; ShiptoAddCaptionLbl)
                    {
                    }
                    column(SelltoCustNo_PurchHdrCaption; "Purchase Header".FieldCaption("Sell-to Customer No."))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ShowInternalInfo; '')
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(VATBaseDisc_PurchHdr; "Purchase Header"."VAT Base Discount %")
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHdr; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(BuyfromVendorNo_PurchHdr; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(buyfromcontact; "Purchase Header"."Buy-from Contact")
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(RefText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchHdr; "Purchase Header"."Your Reference")
                    {
                    }
                    column(DocDate_PurchHdr; Format("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(PricesIncVAT_PurchHdr; "Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(DimText; '')
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(DocDateCaption; DocDateCaptionLbl)
                    {
                    }
                    column(BuyfromVendorNo_PurchHdrCaption; "Purchase Header".FieldCaption("Buy-from Vendor No."))
                    {
                    }
                    column(PricesIncVAT_PurchHdrCaption; "Purchase Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    column(CurrCode; currencyCode)
                    {
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break;
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(PurchLineLineAmt; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Desc_PurchLine; "Purchase Line".Description)
                        {
                        }
                        column(LineNo_PurchLine; "Purchase Line"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        {
                        }
                        column(Type_PurchLine; Format("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(No_PurchLine; "Purchase Line"."No.")
                        {
                        }
                        column(Quantity_PurchLine; "Purchase Line".Quantity)
                        {
                        }
                        column(UnitofMeasure_PurchLine; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(DirectUnitCost_PurchLine; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchLine; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(LineAmt_PurchLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvoiceDisc_PurchLine; "Purchase Line"."Allow Invoice Disc.")
                        {
                        }
                        column(PurchLineInvDiscAmt; -PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(PurchLineLineAmtInvDiscAmt; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; 'VAT')
                        {
                        }
                        column(VATAmt; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscAmt; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmt; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DiscountPercentCaption; DiscountPercentCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(No_PurchLineCaption; "Purchase Line".FieldCaption("No."))
                        {
                        }
                        column(AllowInvoiceDisc_PurchLineCaption; "Purchase Line".FieldCaption("Allow Invoice Disc."))
                        {
                        }
                        column(AmountLangA1AmountLangA2; AmountLangA[1] + ' ' + AmountLangA[2] + ' ' + currencyDesc)
                        {
                        }
                        column(TotalAmountThaiText; TotalAmountThaiText)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                PurchLine.Find('-')
                            else
                                PurchLine.Next;
                            "Purchase Line" := PurchLine;
                            if not "Purchase Header"."Prices Including VAT" and (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT") then PurchLine."Line Amount" := 0;
                            if (PurchLine.Type = PurchLine.Type::"G/L Account") then "Purchase Line"."No." := '';
                            AllowInvDisctxt := Format("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Disc. Amount to Invoice";
                            TotalAmount += "Purchase Line".Amount;
                            IF CntLine > 25 THEN
                                CntLine := 1
                            ELSE
                                CntLine += 1;
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DeleteAll;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.Find('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and (PurchLine."No." = '') and (PurchLine.Quantity = 0) and (PurchLine.Amount = 0) do MoreLines := PurchLine.Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break;
                            PurchLine.SetRange("Line No.", 0, PurchLine."Line No.");
                            SetRange(Number, 1, PurchLine.Count);
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
                            if CntLine + Line + Number > 9 then CurrReport.Break;
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
                    PrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                begin
                    Clear(PurchLine);
                    Clear(PurchPost);
                    PurchLine.DeleteAll;
                    VATAmountLine.DeleteAll;
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount := VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;
                    if Number > 1 then CopyText := FormatDocument.GetCOPYText;
                    OutputNo := OutputNo + 1;
                    TotalSubTotal := 0;
                    TotalAmount := 0;
                    CntLine := 0;
                    if "Purchase Header"."Currency Code" = '' then begin
                        currencyCode := GLSetup."Local Currency Symbol";
                        currencyDesc := GLSetup."Local Currency Description"
                    end
                    else begin
                        currencyCode := "Purchase Header"."Currency Code";
                        If currency.Get(currencyCode) then currencyDesc := currency.Description;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    if not IsReportInPreviewMode then CODEUNIT.Run(CODEUNIT::"Purch.Header-Printed", "Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                //if "Language Code" <> '' then
                //  CurrReport.Language := Language.GetLanguageID("Language Code");
                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");
                PricesInclVATtxt := Format("Prices Including VAT");
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
                    CompanyAddr[8] := TaxIDThai + ' ' + CompanyInfo."VAT Registration No.";
                end;
                //CompressArray(CompanyAddr);
                //VR
                CalcFields(Amount);
                CalcFields("Amount Including VAT");
                AmountLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", Amount, "Currency Factor"));
                AmountIncLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", "Amount Including VAT", "Currency Factor"));
                PurchaseLine.InitTextVariable;
                PurchaseLine.FormatNoText(AmountLangA, "Amount Including VAT", "Currency Code");
                TotalAmountThaiText := FormatNoThaiText("Amount Including VAT");
                IF TotalAmountThaiText <> '' THEN TotalAmountThaiText := '(' + TotalAmountThaiText + ')';
            end;

            trigger OnPreDataItem()
            begin
                //SetLanguageCaption;
            end;
        }
    }
    requestpage
    {
        //        SaveValues = true;
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        PurchSetup.Get;
    end;

    var
        Text004: Label 'PURCHASE ORDER', Comment = '%1 = Document No.';
        Text005: Label 'Page %1', Comment = '%1 = Page No.';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        PurchLine: Record "Purchase Line" temporary;
        Language: Codeunit Language;
        PurchSetup: Record "Purchases & Payables Setup";
        PurchaseLine: Record "Purchase Line";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        PurchPost: Codeunit "Purch.-Post";
        VendAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[9] of Text[100];
        BuyFromAddr: array[8] of Text[100];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        Continue: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        PageCaptionLbl: Label 'Page';
        OrderNoCaptionLbl: Label 'PO No.:';
        DocDateCaptionLbl: Label 'PO Date:';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost';
        DiscountPercentCaptionLbl: Label 'Discount %';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATPercentCaptionLbl: Label 'VAT %';
        VendNoCaptionLbl: Label 'Vendor No.';
        LineAmtCaptionLbl: Label 'Line Amount';
        InvDiscAmt1CaptionLbl: Label 'Invoice Discount Amount';
        TotalCaptionLbl: Label 'Total Amount';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        ShiptoAddCaptionLbl: Label 'Ship-to Address';
        DescCaptionLbl: Label 'Description';
        QtyCaptionLbl: Label 'Qty';
        ORIGINALCaptionLbl: Label 'ORIGINAL';
        AmtCaptionLbl: Label 'Net Price';
        UnitPriceCaptionLbl: Label 'Unit Price';
        PaymentTermsCaptionLbl: Label 'Payment Terms: ';
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount';
        RemarksCaptionLbl: Label 'Remarks: ';
        AmountLangA: array[2] of Text[80];
        DateCaptionLbl: Label 'Date:';
        RequestedByCaptionLbl: Label 'Requested By: ______________';
        RequestedDateCaptionLbl: Label 'Requested Date: ____________';
        AuthorizedByCaptionLbl: Label 'Authorized By: ____________';
        AuthorizedSignCaptionLbl: Label 'Authorized Signature';
        ForCaptionLbl: Label 'For %1';
        SupplierNameCpationLbl: Label 'Supplier Name and Address:';
        ShiptoCaptionLbl: Label 'Ship-to:';
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        TermofDeliveryCaptionLbl: Label 'Term of Delivery: ';
        NettotalCaptionLbl: Label 'Net Total';
        TaxIDCaptionLbl: Label 'Tax ID:';
        TaxIDThai: Text;
        CaptionPurchaseOrderThai: Text;
        PoNoCapThai: Text;
        PoDateThaiCap: Text;
        PaymentTermThaiCap: Text;
        TermofDelThaiCap: Text;
        SupplierNameThaiCap: Text;
        ShipToThaiCap: Text;
        TotalAmountThaiText: Text;
        contactpersonCap: Label 'Contact Person:';
        CntLine: Integer;
        Line: Integer;
        LineSpace: Integer;
        currencyCode: Code[20];
        currencyDesc: Text;
        currency: Record Currency;
        AmountLCY: Decimal;
        AmountIncLCY: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        VendorRec: Record Vendor;

    procedure InitializeRequest(NewNoOfCopies: Integer;
    NewShowInternalInfo: Boolean;
    NewArchiveDocument: Boolean;
    NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    begin
        //FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center",RespCenter,CompanyInfo,CompanyAddr);
        //FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        //if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        //FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
        VendorRec.Get(PurchaseHeader."Buy-from Vendor No.");
        BuyFromAddr[1] := PurchaseHeader."Buy-from Vendor Name";
        BuyFromAddr[2] := PurchaseHeader."Buy-from Address";
        BuyFromAddr[3] := PurchaseHeader."Buy-from Address 2";
        BuyFromAddr[4] := PurchaseHeader."Buy-from Address 3";
        IF VendorRec.Branch <> '' then BuyFromAddr[4] += ' (' + VendorRec.Branch + ')';
        if VendorRec."Branch No." <> '' then BuyFromAddr[4] += ' ' + VendorRec."Branch No.";
        ShipToAddr[1] := PurchaseHeader."Ship-to Name";
        ShipToAddr[2] := PurchaseHeader."Ship-to Address";
        ShipToAddr[3] := PurchaseHeader."Ship-to Address 2";
        ShipToAddr[4] := PurchaseHeader."Ship-to Address 3";
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatDocument.SetTotalLabels(PurchaseHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchaseHeader."Payment Terms Code", PurchaseHeader."Language Code");
        //FormatDocument.SetPaymentTerms(PrepmtPaymentTerms,"Prepmt. Payment Terms Code","Language Code");
        //  FormatDocument.SetShipmentMethod(ShipmentMethod,"Shipment Method Code","Language Code");
        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader.FieldCaption("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader.FieldCaption("VAT Registration No."));
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
        LanguageCaption.SetRange("Report ID", 50065);
        if LanguageCaption.FindSet() then begin
            repeat
                case LanguageCaption."Caption Code" of
                    'Tax ID':
                        begin
                            //CaptionNo := LanguageCaption."Caption in English";
                            TaxIDThai := LanguageCaption."Caption in Thai";
                        end;
                    'Purchase Order':
                        begin
                            // CaptionAmount := LanguageCaption."Caption in English";
                            CaptionPurchaseOrderThai := LanguageCaption."Caption in Thai";
                        end;
                    'PO No.':
                        begin
                            // CaptionBILLINGNOTE := LanguageCaption."Caption in English";
                            PoNoCapThai := LanguageCaption."Caption in Thai";
                        end;
                    'Po Date':
                        begin
                            //CaptionDate := LanguageCaption."Caption in English";
                            PoDateThaiCap := LanguageCaption."Caption in Thai";
                        end;
                    'Payment Terms':
                        begin
                            //CaptionInvoiceNo := LanguageCaption."Caption in English";
                            PaymentTermThaiCap := LanguageCaption."Caption in Thai";
                        end;
                    'Term of Delivery':
                        begin
                            //CaptionPAYMENTTERMS := LanguageCaption."Caption in English";
                            TermofDelThaiCap := LanguageCaption."Caption in Thai";
                        end;
                    'Supplier Name and address':
                        begin
                            //CaptionRECEIVER := LanguageCaption."Caption in English";
                            SupplierNameThaiCap := LanguageCaption."Caption in Thai";
                        end;
                    'Ship to':
                        begin
                            // CaptionRECEIVETERMS := LanguageCaption."Caption in English";
                            ShipToThaiCap := LanguageCaption."Caption in Thai";
                        end;
                    else
                end;
            until LanguageCaption.Next() = 0;
        end;
    end;
}
