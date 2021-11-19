Page 50109 "Sales Tax Invoice Statistics"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   15.05.2007   KKE   -Sales Tax Invoice/Receipt.

    Caption = 'Sales Tax Invoice Statistics';
    PageType = Card;
    SourceTable = "Sales Tax Invoice/Rec. Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Amount; CustAmount + InvDiscAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Amount';
                    Editable = false;
                }
                field(InvDiscAmount; InvDiscAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Inv. Discount Amount';
                    Editable = false;
                }
                field(CustAmount; CustAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Total';
                    Editable = false;
                }
                field(VATAmount; VATAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT(VATAmountText);
                    Caption = 'VAT Amount';
                    Editable = false;
                }
                field(AmountInclVAT; AmountInclVAT)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Total Incl. VAT';
                    Editable = false;
                }
                field(AmountLCY; AmountLCY)
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Sales (LCY)';
                    Editable = false;
                }
                field(CostLCY; CostLCY)
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Cost (LCY)';
                    Editable = false;
                }
                field(ProfitLCY; ProfitLCY)
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Profit (LCY)';
                    Editable = false;
                }
                field(ProfitPct; ProfitPct)
                {
                    ApplicationArea = Basic;
                    Caption = 'Profit %';
                    DecimalPlaces = 1 : 1;
                    Editable = false;
                }
                field(LineQty; LineQty)
                {
                    ApplicationArea = Basic;
                    Caption = 'Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(TotalParcels; TotalParcels)
                {
                    ApplicationArea = Basic;
                    Caption = 'Parcels';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(TotalNetWeight; TotalNetWeight)
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(TotalGrossWeight; TotalGrossWeight)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gross Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(TotalVolume; TotalVolume)
                {
                    ApplicationArea = Basic;
                    Caption = 'Volume';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
            }
            part(Subform; "VAT Specification Subform")
            {
                ApplicationArea = basic;
            }
            group(Customer)
            {
                Caption = 'Customer';
                field(BalanceLCY; Cust."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Balance (LCY)';
                    Editable = false;
                }
                field(CreditLimitLCY; Cust."Credit Limit (LCY)")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Credit Limit (LCY)';
                    Editable = false;
                }
                field(CreditLimitLCYExpendedPct; CreditLimitLCYExpendedPct)
                {
                    ApplicationArea = Basic;
                    Caption = 'Expended % of Credit Limit (LCY)';
                    ExtendedDatatype = Ratio;
                    ToolTip = 'Expended % of Credit Limit (LCY)';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.Caption(Text002);
        if PrevNo = "No." then
            exit;
        PrevNo := "No.";
        FilterGroup(2);
        SetRange("No.", PrevNo);
        FilterGroup(0);
        Clear(SalesTaxInvLine);

        if "Currency Code" = '' then
            currency.InitRoundingPrecision
        else
            currency.Get("Currency Code");

        SalesTaxInvLine.SetRange("Document No.", "No.");
        if SalesTaxInvLine.Find('-') then
            repeat
                CustAmount := CustAmount + SalesTaxInvLine.Amount;
                AmountInclVAT := AmountInclVAT + SalesTaxInvLine."Amount Including VAT" + SalesTaxInvLine."VAT Difference";
                if "Prices Including VAT" then
                    InvDiscAmount := InvDiscAmount + SalesTaxInvLine."Inv. Discount Amount" / (1 + SalesTaxInvLine."VAT %" / 100)
                else
                    InvDiscAmount := InvDiscAmount + SalesTaxInvLine."Inv. Discount Amount";
                CostLCY := CostLCY + (SalesTaxInvLine.Quantity * SalesTaxInvLine."Unit Cost (LCY)");
                LineQty := LineQty + SalesTaxInvLine.Quantity;
                TotalNetWeight := TotalNetWeight + (SalesTaxInvLine.Quantity * SalesTaxInvLine."Net Weight");
                TotalGrossWeight := TotalGrossWeight + (SalesTaxInvLine.Quantity * SalesTaxInvLine."Gross Weight");
                TotalVolume := TotalVolume + (SalesTaxInvLine.Quantity * SalesTaxInvLine."Unit Volume");
                if SalesTaxInvLine."Units per Parcel" > 0 then
                    TotalParcels := TotalParcels + ROUND(SalesTaxInvLine.Quantity / SalesTaxInvLine."Units per Parcel", 1, '>');
                if SalesTaxInvLine."VAT %" <> VATPercentage then
                    if VATPercentage = 0 then
                        VATPercentage := SalesTaxInvLine."VAT %"
                    else
                        VATPercentage := -1;
            until SalesTaxInvLine.Next = 0;
        VATAmount := AmountInclVAT - CustAmount;
        InvDiscAmount := ROUND(InvDiscAmount, currency."Amount Rounding Precision");

        if VATPercentage <= 0 then
            VATAmountText := Text000
        else
            VATAmountText := StrSubstNo(Text001, VATPercentage);

        if "Currency Code" = '' then
            AmountLCY := CustAmount
        else
            AmountLCY :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                WorkDate, "Currency Code", CustAmount, "Currency Factor");
        ProfitLCY := AmountLCY - CostLCY;
        if AmountLCY <> 0 then
            ProfitPct := ROUND(100 * ProfitLCY / AmountLCY, 0.1);

        if Cust.Get("Bill-to Customer No.") then
            Cust.CalcFields("Balance (LCY)")
        else
            Clear(Cust);
        if Cust."Credit Limit (LCY)" = 0 then
            CreditLimitLCYExpendedPct := 0
        else
            if Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0 then
                CreditLimitLCYExpendedPct := 0
            else
                if Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1 then
                    CreditLimitLCYExpendedPct := 10000
                else
                    CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);
        SalesTaxInvLine.CalcVATAmountLines(Rec, TempVATAmountLine);
        CurrPage.Subform.Page.SetTempVATAmountLine(TempVATAmountLine);
        //CurrForm.Subform.FORM.InitGlobals("Currency Code",FALSE,FALSE,FALSE,FALSE,"VAT Base Discount %",1);
        SetVATSpecification;
    end;

    trigger OnOpenPage()
    begin
        SalesSetup.Get;
        AllowInvDisc :=
          not (SalesSetup."Calc. Inv. Discount" and CustInvDiscRecExists("Invoice Disc. Code"));
        AllowVATDifference :=
          SalesSetup."Allow VAT Difference";
        CurrPage.Editable :=
          AllowVATDifference or AllowInvDisc;
        SetVATSpecification;
    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        GetVATSpecification;
        if TempVATAmountLine.GetAnyLineModified then
            UpdateVATOnSalesTaxInvLines;
        exit(true);
    end;

    var
        Text000: label 'VAT Amount';
        Text001: label '%1% VAT';
        SalesSetup: Record "Sales & Receivables Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        SalesTaxInvLine: Record "Sales Tax Invoice/Rec. Line";
        Cust: Record Customer;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        currency: Record Currency;
        PrevNo: Code[20];
        CustAmount: Decimal;
        AmountInclVAT: Decimal;
        InvDiscAmount: Decimal;
        VATAmount: Decimal;
        CostLCY: Decimal;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        LineQty: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;
        TotalParcels: Decimal;
        AmountLCY: Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        VATPercentage: Decimal;
        VATAmountText: Text[30];
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        Text002: label 'Sales Tax Invoice Statistics';

    local procedure UpdateHeaderInfo()
    var
        CurrExchRate: Record "Currency Exchange Rate";
        UseDate: Date;
    begin
        /*
        VATAmount := TempVATAmountLine."VAT Amount";
        AmountInclVAT := TempVATAmountLine."Amount Including VAT";
        
        TotalSalesLine."Inv. Discount Amount" := TempVATAmountLine.GetTotalInvDiscAmount;
        TotalAmount1 :=
          TotalSalesLine."Line Amount" - TotalSalesLine."Inv. Discount Amount";
        VATAmount := TempVATAmountLine.GetTotalVATAmount;
        IF "Prices Including VAT" THEN BEGIN
          TotalAmount1 := TempVATAmountLine.GetTotalAmountInclVAT;
          TotalAmount2 := TotalAmount1 - VATAmount;
          TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE
          TotalAmount2 := TotalAmount1 + VATAmount;
        
        IF "Prices Including VAT" THEN
          TotalSalesLineLCY.Amount := TotalAmount2
        ELSE
          TotalSalesLineLCY.Amount := TotalAmount1;
        IF "Currency Code" <> '' THEN BEGIN
          IF ("Document Type" IN ["Document Type"::"Blanket Order","Document Type"::Quote]) AND
             ("Posting Date" = 0D)
          THEN
            UseDate := WORKDATE
          ELSE
            UseDate := "Posting Date";
        
          TotalSalesLineLCY.Amount :=
            CurrExchRate.ExchangeAmtFCYToLCY(
              UseDate,"Currency Code",TotalSalesLineLCY.Amount,"Currency Factor");
        END;
        ProfitLCY := TotalSalesLineLCY.Amount - TotalSalesLineLCY."Unit Cost (LCY)";
        IF TotalSalesLineLCY.Amount = 0 THEN
          ProfitPct := 0
        ELSE
          ProfitPct := ROUND(100 * ProfitLCY / TotalSalesLineLCY.Amount,0.01);
        */

    end;

    local procedure CustInvDiscRecExists(InvDiscCode: Code[20]): Boolean
    var
        CustInvDisc: Record "Cust. Invoice Disc.";
    begin
        CustInvDisc.SetRange(Code, InvDiscCode);
        exit(CustInvDisc.Find('-'));
    end;

    local procedure GetVATSpecification()
    begin
        CurrPage.Subform.Page.GetTempVATAmountLine(TempVATAmountLine);
        UpdateHeaderInfo;
    end;

    local procedure SetVATSpecification()
    begin
        CurrPage.Subform.Page.SetTempVATAmountLine(TempVATAmountLine);
        CurrPage.Subform.Page.InitGlobals(
          "Currency Code", AllowVATDifference, AllowVATDifference,
          "Prices Including VAT", AllowInvDisc, "VAT Base Discount %", 1);
    end;

    local procedure UpdateVATOnSalesTaxInvLines()
    var
        SalesTaxInvLine: Record "Sales Tax Invoice/Rec. Line";
    begin
        GetVATSpecification;
        if TempVATAmountLine.GetAnyLineModified then begin
            SalesTaxInvLine.UpdateVATOnLines(0, Rec, SalesTaxInvLine, TempVATAmountLine);
            SalesTaxInvLine.UpdateVATOnLines(1, Rec, SalesTaxInvLine, TempVATAmountLine);
        end;
        PrevNo := '';
    end;
}

