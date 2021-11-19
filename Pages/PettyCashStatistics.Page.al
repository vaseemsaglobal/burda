Page 50078 "Petty Cash Statistics"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.
    // Burda
    // 002   14.08.2007   KKE   Average VAT.

    Caption = 'Petty Cash Invoice Statistics';
    Editable = false;
    PageType = Card;
    SourceTable = "Petty Cash Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Amount;VendAmount + InvDiscAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Amount';
                }
                field(VATAmount;VATAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT (VATAmountText);
                    Caption = 'VAT Amount';
                }
                field(AmountInclVAT;AmountInclVAT)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Total Incl. VAT';
                }
                field(AmountLCY;AmountLCY)
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Amount (LCY)';
                }
                field(WHTAmount;WHTAmount)
                {
                    ApplicationArea = Basic;
                    Caption = 'WHT Amount (LCY)';
                }
                field(AvgVATAmount;AvgVATAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT ('Avg. VAT Amount');
                    Caption = 'VAT Amount';
                }
            }
            group(Vendor)
            {
                Caption = 'Vendor';
                field(BalanceLCY;Vend."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Balance (LCY)';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ClearAll;

        if "Currency Code" = '' then
          Currency.InitRoundingPrecision
        else
          Currency.Get("Currency Code");

        PettyCashLine.SetRange("Document No.","No.");

        if PettyCashLine.Find('-') then
          repeat
            VendAmount := VendAmount + PettyCashLine."VAT Base Amount";
            AmountInclVAT := AmountInclVAT + PettyCashLine."Amount Incl. VAT";
            AvgVATAmount := AvgVATAmount + PettyCashLine."Avg. VAT Amount";  //KKE : #002
            if not PettyCashLine."Skip WHT" then
              if WHTPostingSetup.Get(PettyCashLine."WHT Business Posting Group",PettyCashLine."WHT Product Posting Group") then
                if WHTPostingSetup."WHT %" <> 0 then
                  WHTAmount := WHTAmount + PettyCashLine."VAT Base Amount (LCY)" * WHTPostingSetup."WHT %" / 100;
          until PettyCashLine.Next = 0;
        VATAmount := AmountInclVAT - VendAmount;
        InvDiscAmount := ROUND(InvDiscAmount,Currency."Amount Rounding Precision");
        WHTAmount := ROUND(WHTAmount,Currency."Amount Rounding Precision");

        if VATPercentage <= 0 then
          VATAmountText := Text000
        else
          VATAmountText := StrSubstNo(Text001,VATPercentage);

        if "Currency Code" = '' then
          AmountLCY := VendAmount
        else
          AmountLCY :=
            CurrExchRate.ExchangeAmtFCYToLCY(
              WorkDate,"Currency Code",VendAmount,"Currency Factor");

        if not Vend.Get("Petty Cash Vendor No.") then
          Clear(Vend);
        Vend.CalcFields("Balance (LCY)");

        //PurchInvLine.CalcVATAmountLines(Rec,TempVATAmountLine);
        //CurrForm.SubForm.FORM.SetTempVATAmountLine(TempVATAmountLine);
        //CurrForm.SubForm.FORM.InitGlobals("Currency Code",FALSE,FALSE,FALSE,FALSE,0,0);
    end;

    var
        Text000: label 'VAT Amount';
        Text001: label '%1% VAT';
        CurrExchRate: Record "Currency Exchange Rate";
        PettyCashLine: Record "Petty Cash Line";
        Vend: Record Vendor;
        WHTPostingSetup: Record "WHT Posting Setup";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        Currency: Record Currency;
        VendAmount: Decimal;
        AmountInclVAT: Decimal;
        InvDiscAmount: Decimal;
        AmountLCY: Decimal;
        LineQty: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;
        TotalParcels: Decimal;
        VATAmount: Decimal;
        VATPercentage: Decimal;
        VATAmountText: Text[30];
        WHTAmount: Decimal;
        AvgVATAmount: Decimal;
}

