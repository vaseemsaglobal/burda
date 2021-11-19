codeunit 50044 TbExt39
{
    Permissions = tabledata 291 = rmid;
    /*
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCalcVATAmountLinesOnAfterCalcLineTotals', '', false, false)]
    local procedure OnCalcVATAmountLinesOnAfterCalcLineTotals(var VATAmountLine: Record "VAT Amount Line"; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; Currency: Record Currency; QtyType: Option; var TotalVATAmount: Decimal);
    var
        AvgVATSetup: Record "Average VAT Setup";
        VatProdPostGroup: Record "VAT Product Posting Group";
    begin
        exit;
        if VatProdPostGroup.Get(PurchaseLine."VAT Prod. Posting Group") and VatProdPostGroup."Average VAT" then begin
            AvgVATSetup.Reset();
            AvgVATSetup.SetFilter("From Date", '<=%1', PurchaseHeader."Posting Date");
            AvgVATSetup.SetFilter("To Date", '>=%1', PurchaseHeader."Posting Date");
            if AvgVATSetup.FindFirst() then begin
                if AvgVATSetup."VAT Claim %" <> 0 then begin
                    VATAmountLine."VAT Claim %" := AvgVATSetup."VAT Claim %";
                    VATAmountLine."VAT Unclaim %" := AvgVATSetup."VAT Unclaim %";
                    //VATAmountLine."Avg. VAT Amount" := round(VATAmountLine."VAT Amount" * AvgVATSetup."VAT Claim %" / 100, Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                    VATAmountLine."Avg. VAT Amount" := ROUND((PurchaseLine."Amount Including VAT" - PurchaseLine.Amount) * VATAmountLine."VAT Claim %" / 100,
                    Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                    VATAmountLine.Modify();
                    PurchaseLine."VAT Claim %" := AvgVATSetup."VAT Claim %";
                    PurchaseLine."VAT Unclaim %" := AvgVATSetup."VAT Unclaim %";
                    PurchaseLine."Avg. VAT Amount" := VATAmountLine."Avg. VAT Amount";

                    //PurchaseLine.Modify();
                    //"VAT Difference" +
                    //ROUND((PurchaseLine."Amount Including VAT" - PurchaseLine.Amount) * VATAmountLine."VAT Claim %" / 100,
                    //Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                end;
            end;
        end;
    end;
*/
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterCalcVATAmountLines', '', false, false)]
    local procedure OnAfterCalcVATAmountLines(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line"; QtyType: Option);
    var
        VatProdPostGroup: Record "VAT Product Posting Group";
        AvgVATSetup: Record "Average VAT Setup";
        Currency: Record Currency;
    begin
        /*
        exit;
        if Currency.get(PurchHeader."Currency Code") then;
        if VatProdPostGroup.Get(PurchLine."VAT Prod. Posting Group") then
            if VatProdPostGroup."Average VAT" then begin
                AvgVATSetup.Reset();
                AvgVATSetup.SetFilter("From Date", '<=%1', PurchHeader."Posting Date");
                AvgVATSetup.SetFilter("To Date", '>=%1', PurchHeader."Posting Date");
                if AvgVATSetup.FindFirst() then begin
                    if AvgVATSetup."VAT Claim %" <> 0 then begin
                        VATAmountLine."VAT Claim %" := AvgVATSetup."VAT Claim %";
                        VATAmountLine."VAT Unclaim %" := AvgVATSetup."VAT Unclaim %";
                        //VATAmountLine."Avg. VAT Amount" := round(VATAmountLine."VAT Amount" * AvgVATSetup."VAT Claim %" / 100, Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                        VATAmountLine.Modify();
                        //PurchLine."VAT Claim %" := AvgVATSetup."VAT Claim %";
                        //PurchLine."VAT Unclaim %" := AvgVATSetup."VAT Unclaim %";
                        //PurchLine."Avg. VAT Amount" := VATAmountLine."Avg. VAT Amount";
                        //PurchLine.Modify();
                    end;
                end;
            end;
            */
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCalcVATAmountLinesOnAfterCalcLineTotals', '', false, false)]
    local procedure OnCalcVATAmountLinesOnAfterCalcLineTotals(var VATAmountLine: Record "VAT Amount Line"; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; Currency: Record Currency; QtyType: Option; var TotalVATAmount: Decimal);
    var
        GLSetup: Record "General Ledger Setup";
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        AverageVATSetup: Record "Average VAT Setup";
        TotVatAmt: Decimal;
        PurchaseLine1: Record "Purchase Line";
    begin
        Clear(TotVatAmt);
        PurchaseLine1.Reset();
        PurchaseLine1.SetRange("Document Type", PurchaseLine."Document Type");
        PurchaseLine1.SetRange("Document No.", PurchaseLine."Document No.");
        PurchaseLine1.SetRange("VAT Prod. Posting Group", PurchaseLine."VAT Prod. Posting Group");
        if PurchaseLine1.FindSet() then
            repeat
                TotVatAmt += PurchaseLine1."Amount Including VAT" - PurchaseLine1.Amount;
            until PurchaseLine1.Next() = 0;
        //exit;
        GLSetup.Get();
        //KKE : #003 +
        IF GLSetup."Enable VAT Average" THEN BEGIN
            IF NOT VATProdPostingGrp.GET(PurchaseLine."VAT Prod. Posting Group") THEN
                VATProdPostingGrp.INIT;
            IF VATProdPostingGrp."Average VAT" THEN BEGIN
                VATPostingSetup.GET(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group");
                AverageVATSetup.RESET;
                AverageVATSetup.SETFILTER("From Date", '<=%1', PurchaseHeader."Posting Date");
                AverageVATSetup.SETFILTER("To Date", '>=%1', PurchaseHeader."Posting Date");
                IF AverageVATSetup.FIND('+') THEN BEGIN
                    AverageVATSetup.TESTFIELD("VAT Claim %");
                    VATAmountLine."VAT Claim %" := AverageVATSetup."VAT Claim %";
                    VATAmountLine."VAT Unclaim %" := AverageVATSetup."VAT Unclaim %";
                    VATAmountLine."Average VAT Year" := AverageVATSetup.Year;

                    VATAmountLine."Avg. VAT Amount" :=
                      //"VAT Difference" +
                      ROUND(TotVatAmt * VATAmountLine."VAT Claim %" / 100,
                        //ROUND(TotalVATAmount * VATAmountLine."VAT Claim %" / 100,
                        Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                    VATAmountLine.Modify();
                    //PurchaseLine."Avg. VAT Amount" :=
                    //      ROUND((PurchaseLine."Amount Including VAT" - PurchaseLine.Amount) * VATAmountLine."VAT Claim %" / 100,
                    //    Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                    //PurchaseLine.Modify();
                END;
            END;
        END;
        //KKE : #003 -
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCalcVATAmountLinesOnBeforeVATAmountLineSumLine', '', false, false)]
    local procedure OnCalcVATAmountLinesOnBeforeVATAmountLineSumLine(PurchaseLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line"; QtyType: Option);
    var
        GLSetup: Record "General Ledger Setup";
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        AverageVATSetup: Record "Average VAT Setup";
        PurchaseHeader: Record "Purchase Header";
        Currency: Record Currency;
    begin
        /*
                //KKE : #003 +
                GLSetup.get;
                if PurchaseHeader.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then
                    if PurchaseHeader."Currency Code" <> '' then
                        Currency.get(PurchaseHeader."Currency Code");
                IF GLSetup."Enable VAT Average" THEN BEGIN
                    IF NOT VATProdPostingGrp.GET(PurchaseLine."VAT Prod. Posting Group") THEN
                        VATProdPostingGrp.INIT;
                    IF VATProdPostingGrp."Average VAT" THEN BEGIN
                        VATPostingSetup.GET(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group");
                        AverageVATSetup.RESET;
                        AverageVATSetup.SETFILTER("From Date", '<=%1', PurchaseHeader."Posting Date");
                        AverageVATSetup.SETFILTER("To Date", '>=%1', PurchaseHeader."Posting Date");
                        IF AverageVATSetup.FIND('+') THEN BEGIN
                            AverageVATSetup.TESTFIELD("VAT Claim %");
                            VATAmountLine."VAT Claim %" := AverageVATSetup."VAT Claim %";
                            VATAmountLine."VAT Unclaim %" := AverageVATSetup."VAT Unclaim %";
                            VATAmountLine."Average VAT Year" := AverageVATSetup.Year;
                            //VATAmountLine."Avg. VAT Amount" :=

                            //ROUND((PurchaseLine."Amount Including VAT" - PurchaseLine.Amount) * VATAmountLine."VAT Claim %" / 100,
                            //Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                            VATAmountLine.Modify();
                        END;
                    END;
                END;
                //KKE : #003 -
        */
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnUpdateVATOnLinesOnAfterCalculateAmounts', '', false, false)]
    local procedure OnUpdateVATOnLinesOnAfterCalculateAmounts(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header");
    var
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        AverageVATSetup: Record "Average VAT Setup";
    begin
        //Message('test');
        /*GLSetup.get;
        if PurchaseHeader.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then
            if PurchaseHeader."Currency Code" <> '' then
                Currency.get(PurchaseHeader."Currency Code");
        IF GLSetup."Enable VAT Average" THEN BEGIN
            IF NOT VATProdPostingGrp.GET(PurchaseLine."VAT Prod. Posting Group") THEN
                VATProdPostingGrp.INIT;
            IF VATProdPostingGrp."Average VAT" THEN BEGIN
                VATPostingSetup.GET(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group");
                AverageVATSetup.RESET;
                AverageVATSetup.SETFILTER("From Date", '<=%1', PurchaseHeader."Posting Date");
                AverageVATSetup.SETFILTER("To Date", '>=%1', PurchaseHeader."Posting Date");
                IF AverageVATSetup.FIND('+') THEN BEGIN
                    AverageVATSetup.TESTFIELD("VAT Claim %");
                    PurchaseLine."Avg. VAT Amount" :=
                    ROUND((PurchaseLine."Amount Including VAT" - PurchaseLine.Amount) * AverageVATSetup."VAT Claim %" / 100,
                    Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                    //VATAmountLine.Modify();
                END;
            END;
        END;
        //KKE : #003 -*/
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeInsertEvent', '', true, true)]
    local procedure Tb39_OnInsert(RunTrigger: Boolean; var Rec: Record "Purchase Line")
    var
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        AverageVATSetup: Record "Average VAT Setup";
        PurchaseHeader: Record "Purchase Header";
    begin
        if not RunTrigger then
            exit;
        //exit;
        GLSetup.get;
        if PurchaseHeader.get(Rec."Document Type", Rec."Document No.") then
            if PurchaseHeader."Currency Code" <> '' then
                Currency.get(PurchaseHeader."Currency Code");
        IF GLSetup."Enable VAT Average" THEN BEGIN
            IF NOT VATProdPostingGrp.GET(Rec."VAT Prod. Posting Group") THEN
                VATProdPostingGrp.INIT;
            IF VATProdPostingGrp."Average VAT" THEN BEGIN
                VATPostingSetup.GET(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group");
                AverageVATSetup.RESET;
                AverageVATSetup.SETFILTER("From Date", '<=%1', PurchaseHeader."Posting Date");
                AverageVATSetup.SETFILTER("To Date", '>=%1', PurchaseHeader."Posting Date");
                IF AverageVATSetup.FIND('+') THEN BEGIN
                    AverageVATSetup.TESTFIELD("VAT Claim %");
                    Rec."Avg. VAT Amount" :=
                    ROUND((Rec."Amount Including VAT" - Rec.Amount) * AverageVATSetup."VAT Claim %" / 100,
                    Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                    //VATAmountLine.Modify();
                END;
            END;
        END;
        //KKE : #003 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeModifyEvent', '', true, true)]
    local procedure Tb39_OnModify(RunTrigger: Boolean; var Rec: Record "Purchase Line")
    var
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        AverageVATSetup: Record "Average VAT Setup";
        PurchaseHeader: Record "Purchase Header";
    begin
        if not RunTrigger then
            exit;
        //exit;
        GLSetup.get;
        if PurchaseHeader.get(Rec."Document Type", Rec."Document No.") then
            if PurchaseHeader."Currency Code" <> '' then
                Currency.get(PurchaseHeader."Currency Code");
        IF GLSetup."Enable VAT Average" THEN BEGIN
            IF NOT VATProdPostingGrp.GET(Rec."VAT Prod. Posting Group") THEN
                VATProdPostingGrp.INIT;
            IF VATProdPostingGrp."Average VAT" THEN BEGIN
                VATPostingSetup.GET(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group");
                AverageVATSetup.RESET;
                AverageVATSetup.SETFILTER("From Date", '<=%1', PurchaseHeader."Posting Date");
                AverageVATSetup.SETFILTER("To Date", '>=%1', PurchaseHeader."Posting Date");
                IF AverageVATSetup.FIND('+') THEN BEGIN
                    AverageVATSetup.TESTFIELD("VAT Claim %");
                    Rec."Avg. VAT Amount" :=
                    ROUND((Rec."Amount Including VAT" - Rec.Amount) * AverageVATSetup."VAT Claim %" / 100,
                    Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                    //VATAmountLine.Modify();
                END;
            END;
        END;
        //KKE : #003 -
    end;
}
