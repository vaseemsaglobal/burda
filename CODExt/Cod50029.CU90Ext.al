codeunit 50029 CU90Ext
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   16.12.2004   KKE   -Correct and update WHT.
    //       19.04.2007   KKE   -Cal. WHT for any Inv. Amount
    // 002   16.12.2004   KKE   -Modify program to get value from "Pay-to Name (Thai)" field on purchase header into
    //                           "Real Customer/Vendor Name" field in VAT Entry table on posting.
    // 003   12.03.2005   KKE   -Loc-VAT-001.
    // 004   05.04.2005   TSA   -localization VAT Undue (Apply Cr. Memo ).
    // 005   10.10.2005   KKE   -Modify program to correct record line no. on VATEntry table.
    //                           "Line No." should be equal "Applies-to Line No." on Credit Memo Line. table.
    // 006   11.08.2006   KKE   -incase invoice with Payment Method is CASH, system must print WHT Slip and generate WHT Certificate No.
    // Burda
    // 007   10.07.2007   TSA   -Average VAT
    // 008   29.08.2007   TSA   -Allow posting only Status = Released

    trigger OnRun()
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        GLReg: Record "G/L Register";
        WHTManagement: Codeunit "WHTManagement";
        VATProdPostingGrp: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterCheckMandatoryFields', '', false, false)]
    local procedure OnAfterCheckMandatoryFields_Subscriber(var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        //PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Released);  //TSA008
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnReleasePurchDocumentOnBeforeSetStatus', '', false, false)]
    local procedure OnReleasePurchDocumentOnBeforeSetStatus_Subscriber(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PostWHT: Boolean;
    begin
        //KKE : #001 +
        PurchaseHeader.CALCFIELDS(Amount);
        IF PurchaseHeader."Cal. WHT for any Inv. Amount" THEN
            PostWHT := TRUE
        ELSE BEGIN
            IF ABS(PurchaseHeader.Amount) >= GLSetup."WHT Minimum Invoice Amount" THEN
                PostWHT := TRUE
            ELSE
                PostWHT := FALSE;
        END;
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostInvPostBuffer', '', false, false)]
    local procedure OnBeforePostInvPostBuffer_Subscriber(var GenJnlLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; var PurchHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    begin
        GenJnlLine.VATLineNo := InvoicePostBuffer."Line No.";  //TSA004
        //TSA007
        GenJnlLine."Use Average VAT" := InvoicePostBuffer."Use Average VAT";
        GenJnlLine."Average VAT Year" := InvoicePostBuffer."Average VAT Year";
        GenJnlLine."VAT Claim %" := InvoicePostBuffer."VAT Claim Percentage";
        //TSA007
        //KKE : #002 +
        GenJnlLine."Real Customer/Vendor Name" := PurchHeader."Pay-to Name (Thai)";
        IF PurchHeader."Invoice Description" <> '' THEN
            GenJnlLine.Description := COPYSTR(PurchHeader."Invoice Description", 1, 50);
        //KKE : #002 -
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostVendorEntry', '', false, false)]
    local procedure OnBeforePostVendorEntry_Subscriber(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    begin
        //KKE : #002 +
        GenJnlLine."Real Customer/Vendor Name" := PurchHeader."Pay-to Name (Thai)";
        IF PurchHeader."Invoice Description" <> '' THEN
            GenJnlLine.Description := COPYSTR(PurchHeader."Invoice Description", 1, 50);
        //KKE : #002 -        
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostBalancingEntry', '', false, false)]
    local procedure OnBeforePostBalancingEntry_Subscriber(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    begin
        //KKE : #002 +
        GenJnlLine."Real Customer/Vendor Name" := PurchHeader."Pay-to Name (Thai)";
        IF PurchHeader."Invoice Description" <> '' THEN
            GenJnlLine.Description := COPYSTR(PurchHeader."Invoice Description", 1, 50);
        //KKE : #002 -
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPostBalancingEntry', '', false, false)]
    local procedure OnAfterPostBalancingEntry_Subscriber(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        xGenJnlLine: Record "Gen. Journal Line";
        PostWHT: Boolean;
        WHTManagementExt: Codeunit Cu28040Ext;
    begin
        //KKE : #006 +
        xGenJnlLine.RESET;
        xGenJnlLine.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
        xGenJnlLine.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
        xGenJnlLine.SETRANGE("Is WHT", TRUE);
        IF xGenJnlLine.FIND('-') THEN BEGIN
            REPEAT
                GenJnlPostLine.RunWithoutCheck(xGenJnlLine);
            UNTIL xGenJnlLine.NEXT = 0;
            xGenJnlLine.DELETEALL;

            PurchSetup.GET;
            //KKE : #001 +
            PurchHeader.CALCFIELDS(Amount);
            IF PurchHeader."Cal. WHT for any Inv. Amount" THEN
                PostWHT := TRUE
            ELSE BEGIN
                IF ABS(PurchHeader.Amount) >= GLSetup."WHT Minimum Invoice Amount" THEN
                    PostWHT := TRUE
                ELSE
                    PostWHT := FALSE;
            END;
            //KKE : #001 -
            //IF (NOT "Skip WHT") AND (PurchSetup."Print WHT Docs. on Pay. Post") AND (NOT PrintWHT) THEN
            IF GLReg.FINDLAST AND PostWHT THEN BEGIN
                GLReg.SETRECFILTER;
                //WHTManagement.PrintWHTSlips(GLReg);//VAH
                WHTManagementExt.PrintWHTSlips(GLReg, false);
            END;
        END;
        //KKE : #006 -
    end;
    //>>VAH
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line");
    begin
        ItemJnlLine."Unit Cost" := 0;  //TSA001
        ItemJnlLine."Unit Cost (ACY)" := 0;  //TSA001
    end;

    //<<VAH
    [EventSubscriber(ObjectType::Codeunit, 90, 'OnPostItemJnlLineOnAfterPrepareItemJnlLine', '', false, false)]
    local procedure OnPostItemJnlLineOnAfterPrepareItemJnlLine_Subscriber(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header")
    begin
        //TSA001
        GLSetup.get();//VAH
        IF GLSetup."Enable VAT Average" THEN BEGIN
            IF NOT VATProdPostingGrp.GET(PurchaseLine."VAT Prod. Posting Group") THEN
                VATProdPostingGrp.INIT;
            IF NOT VATPostingSetup.GET(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group") THEN
                VATPostingSetup.INIT;
            IF VATProdPostingGrp."Average VAT" THEN BEGIN
                //KKE : #007 +
                IF PurchaseLine."Avg. VAT Amount" <> 0 THEN BEGIN
                    PurchaseLine.Amount :=
                      PurchaseLine."Amount Including VAT" - PurchaseLine."Avg. VAT Amount";
                    IF PurchaseLine.Quantity <> 0 THEN
                        PurchaseLine."Unit Cost (LCY)" := PurchaseLine.Amount / PurchaseLine.Quantity;
                END;
                //KKE : #007 -
            END;
        END;
        ItemJournalLine."Unit Cost" := PurchaseLine."Unit Cost (LCY)";
        ItemJournalLine."Unit Cost (ACY)" := PurchaseLine."Unit Cost";
        //TSA001
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterFillInvoicePostBuffer', '', false, false)]
    local procedure OnAfterFillInvoicePostBuffer_Subscriber(var InvoicePostBuffer: Record "Invoice Post. Buffer"; PurchLine: Record "Purchase Line"; var TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; CommitIsSupressed: Boolean)
    var
        ItemVATAnnPrice: Record "Item VAT Announce Price";
        PurchHeader: Record "Purchase Header";
        Text50000: Label 'Announce price for item no. %1 line no. %2 has not been set.';
    begin
        //>>VAH
        GLSetup.get;
        if PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Reverse Charge VAT" then begin
            /* if PurchLine."Deferral Code" <> '' then
                 InvoicePostBuffer.SetAmounts(
                     TotalVAT, TotalVATACY, TotalAmount, TotalAmountACY, PurchLine."VAT Difference", TotalVATBase, TotalVATBaseACY)
             else
                 InvoicePostBuffer.SetAmountsNoVAT(TotalAmount, TotalAmountACY, PurchLine."VAT Difference")*/
        end else//<<VAH
            IF (NOT PurchLine."Use Tax") OR (PurchLine."VAT Calculation Type" <> PurchLine."VAT Calculation Type"::"Sales Tax") THEN BEGIN
                //KKE : #003 +
                IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
                    VATPostingSetup.GET(PurchLine."VAT Bus. Posting Group", PurchLine."VAT Prod. Posting Group");
                    IF VATPostingSetup."Use Announce Price for I/P VAT" THEN BEGIN
                        PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No."); //<<RJ1.00
                        ItemVATAnnPrice.RESET;
                        ItemVATAnnPrice.SETRANGE("Item No.", PurchLine."No.");
                        ItemVATAnnPrice.SETRANGE("VAT Type", ItemVATAnnPrice."VAT Type"::"Input VAT");
                        ItemVATAnnPrice.SETFILTER("Starting Date", '<=%1', PurchHeader."Posting Date");
                        IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                            IF PurchLine.Amount < 0 THEN
                                InvoicePostBuffer."VAT Base Amount" := -ItemVATAnnPrice."Announce Price"
                            ELSE
                                InvoicePostBuffer."VAT Base Amount" := ItemVATAnnPrice."Announce Price"
                        END ELSE
                            ERROR(Text50000, PurchLine."No.", PurchLine."Line No.");
                    END;
                END;
                //KKE : #003 -

                //TSA001
                IF GLSetup."Enable VAT Average" THEN BEGIN
                    IF NOT VATProdPostingGrp.GET(PurchLine."VAT Prod. Posting Group") THEN
                        VATProdPostingGrp.INIT;
                    IF NOT VATPostingSetup.GET(PurchLine."VAT Bus. Posting Group", PurchLine."VAT Prod. Posting Group") THEN
                        VATPostingSetup.INIT;
                    IF VATProdPostingGrp."Average VAT" THEN BEGIN
                        //KKE : #007 +
                        IF PurchLine."Avg. VAT Amount" <> 0 THEN BEGIN
                            InvoicePostBuffer."VAT %" := PurchLine."VAT %";
                            InvoicePostBuffer."Use Average VAT" := VATProdPostingGrp."Average VAT";
                            InvoicePostBuffer."Average VAT Year" := PurchLine."Average VAT Year";
                            InvoicePostBuffer."VAT Claim Percentage" := PurchLine."VAT Claim %";
                            InvoicePostBuffer.Amount := PurchLine."Amount Including VAT" - PurchLine."Avg. VAT Amount";
                            InvoicePostBuffer."VAT Base Amount" := PurchLine."Amount Including VAT" - PurchLine."Avg. VAT Amount";
                            InvoicePostBuffer."VAT Amount" := PurchLine."Avg. VAT Amount";
                            //>> VAH
                            //<< VAH
                        END;
                        //KKE : #007 -
                    END;
                END;
                //TSA001
            END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterReverseAmount', '', false, false)]
    local procedure OnAfterReverseAmount_Subcriber(var PurchLine: Record "Purchase Line")
    begin
        PurchLine."Avg. VAT Amount" := -PurchLine."Avg. VAT Amount";  //KKE : #007
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnDivideAmountOnBeforeTempVATAmountLineRemainderModify', '', false, false)]
    local procedure OnDivideAmountOnBeforeTempVATAmountLineRemainderModify_Subscriber(PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line"; var TempVATAmountLineRemainder: Record "VAT Amount Line"; Currency: Record Currency)
    var
        ItemVATAnnPrice: Record "Item VAT Announce Price";
        Text50000: Label 'Announce price for item no. %1 line no. %2 has not been set.';
    begin

        IF NOT PurchHeader."Prices Including VAT" THEN BEGIN
            if NOT (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT") then begin
                IF NOT (GLSetup."Full GST on Prepayment") THEN
                    //KKE : #003 +
                    IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
                        VATPostingSetup.GET(PurchLine."VAT Bus. Posting Group", PurchLine."VAT Prod. Posting Group");
                        IF VATPostingSetup."Use Announce Price for I/P VAT" THEN BEGIN
                            ItemVATAnnPrice.RESET;
                            ItemVATAnnPrice.SETRANGE("Item No.", PurchLine."No.");
                            ItemVATAnnPrice.SETRANGE("VAT Type", ItemVATAnnPrice."VAT Type"::"Input VAT");
                            ItemVATAnnPrice.SETFILTER("Starting Date", '<=%1', PurchHeader."Posting Date");
                            IF ItemVATAnnPrice.findlast THEN BEGIN
                                PurchLine."Use VAT Announce Price" := TRUE;
                                PurchLine."Org. VAT Base Amount" := PurchLine."VAT Base Amount";
                                IF PurchLine.Amount < 0 THEN
                                    PurchLine."VAT Base Amount" := -ItemVATAnnPrice."Announce Price"
                                ELSE
                                    PurchLine."VAT Base Amount" := ItemVATAnnPrice."Announce Price"
                            END ELSE
                                ERROR(Text50000, PurchLine."No.", PurchLine."Line No.");
                        END;
                    END;
                //KKE : #003 -
            end;
        end;
    end;
}


