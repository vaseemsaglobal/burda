codeunit 50017 TbExt37
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeModifyEvent', '', true, true)]
    local procedure Tb37_Modify(RunTrigger: Boolean; var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        Text50001: Label 'You cannot change the order line because it is associated with ads. booking %1 line %2.';
    begin
        if not RunTrigger then
            exit;
        //KKE : #004 +
        //IF (rec."Ads. Booking No." <> '') AND (rec.Description = xRec.Description) THEN
        //  ERROR(Text50001, rec."Ads. Booking No.", rec."Ads. Booking Line No.");
        //KKE : #004 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', true, true)]
    local procedure Tb37_OnDelete(RunTrigger: Boolean; var Rec: Record "Sales Line")
    var
        SubscriberContractLE: Record "Subscriber Contract L/E";
        SubscriberContract: record "Subscriber Contract";
        AgentCustLine: Record "Agent Customer Line";
        AdsBookingLine: record "Ads. Booking Line";
    begin
        if not RunTrigger then
            exit;
        //KKE : #002 +
        /*
        SubscriberContractLE.RESET;
        SubscriberContractLE.SETCURRENTKEY("Paid Sales Order No.");
        SubscriberContractLE.SETRANGE("Paid Sales Order No.","No.");
        IF SubscriberContractLE.FIND('-') THEN BEGIN
          SubscriberContract.GET(SubscriberContractLE."Subscriber Contract No.");
          SubscriberContract."Payment Status" := SubscriberContract."Payment Status"::Open;
          SubscriberContract.MODIFY;
          SubscriberContractLE.MODIFYALL("Paid Flag",FALSE);
          SubscriberContractLE.MODIFYALL("Paid Sales Order No.",'');
        END;
        */
        SubscriberContractLE.RESET;
        SubscriberContractLE.SETCURRENTKEY("Sales Order No.");
        SubscriberContractLE.SETRANGE("Sales Order No.", Rec."No.");
        SubscriberContractLE.SETRANGE("Sales Order Line No.", Rec."Line No.");
        IF SubscriberContractLE.FIND('-') THEN BEGIN
            SubscriberContract.GET(SubscriberContractLE."Subscriber Contract No.");
            SubscriberContract."Payment Status" := SubscriberContract."Payment Status"::Open;
            SubscriberContract.MODIFY;
            REPEAT
                SubscriberContractLE."Sales Order Flag" := FALSE;
                SubscriberContractLE."Sales Order Date" := 0D;
                SubscriberContractLE."Sales Order Line No." := 0;
                SubscriberContractLE."Sales Order No." := '';
                SubscriberContractLE.MODIFY;
            UNTIL SubscriberContractLE.NEXT = 0;
        END;
        //KKE : #002 -

        //KKE : #003 +
        AgentCustLine.RESET;
        AgentCustLine.SETRANGE("Agent Customer No.", Rec."Agent Customer No.");
        AgentCustLine.SETRANGE("Delivered Document No.", Rec."Document No.");
        AgentCustLine.SETRANGE("Delivered Document Line No.", Rec."Line No.");
        IF AgentCustLine.FIND('-') THEN
            REPEAT
                AgentCustLine."Delivered Flag" := FALSE;
                AgentCustLine."Delivered Date" := 0D;
                AgentCustLine."Delivered Document Line No." := 0;
                AgentCustLine."Delivered Document No." := '';
                AgentCustLine.MODIFY;
            UNTIL AgentCustLine.NEXT = 0;
        //KKE : #003 -

        //KKE : #004 +
        IF AdsBookingLine.GET(Rec."Ads. Booking No.", Rec."Ads. Booking Line No.") THEN BEGIN
            IF AdsBookingLine."Line Status" = AdsBookingLine."Line Status"::Invoiced THEN BEGIN
                AdsBookingLine."Line Status" := AdsBookingLine."Line Status"::Approved;
                AdsBookingLine."Cash Invoice No." := '';
                AdsBookingLine."Barter Invoice No." := '';
                AdsBookingLine.Closed := FALSE;
                AdsBookingLine.MODIFY;
            END;
        END;
        //KKE : #004 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Type', true, true)]
    local procedure Tb37_Type_OnValidate(var Rec: Record "Sales Line")
    var
        Text50001: Label 'You cannot change the order line because it is associated with ads. booking %1 line %2.';
    begin
        //KKE : #004 +
        IF Rec."Ads. Booking No." <> '' THEN
            ERROR(Text50001, Rec."Ads. Booking No.", Rec."Ads. Booking Line No.");
        //KKE : #004 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'No.', true, true)]
    local procedure Tb37_No_OnValidate(var Rec: Record "Sales Line")
    var
        Text50001: Label 'You cannot change the order line because it is associated with ads. booking %1 line %2.';
    begin
        //KKE : #004 +
        IF Rec."Ads. Booking No." <> '' THEN
            ERROR(Text50001, rec."Ads. Booking No.", Rec."Ads. Booking Line No.");
        //KKE : #004 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeInitOutstandingAmount', '', false, false)]
    local procedure OnBeforeInitOutstandingAmount(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean);
    var
        SalesHeader: Record "Sales Header";
        VATPostingSetup: Record "VAT Posting Setup";
        ItemVATAnnPrice: Record "Item VAT Announce Price";
        Text50000: Label 'Announce price for item no. %1 line no. %2 has not been set.';
        Currency: Record Currency;
    begin
        if SalesHeader.get(salesline."Document Type", SalesLine."Document No.") then;
        CASE SalesLine."VAT Calculation Type" OF
            SalesLine."VAT Calculation Type"::"Normal VAT",
            SalesLine."VAT Calculation Type"::"Reverse Charge VAT":
                BEGIN
                    //SalesLine."VAT Base Amount" :=
                    //ROUND(SalesLine.Amount * (1 - SalesHeader."VAT Base Discount %" / 100), Currency."Amount Rounding Precision");
                    //KKE : #001 +
                    IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                        VATPostingSetup.GET(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group");
                        IF VATPostingSetup."Use Announce Price for O/P VAT" THEN BEGIN
                            ItemVATAnnPrice.RESET;
                            ItemVATAnnPrice.SETRANGE("Item No.", SalesLine."No.");
                            ItemVATAnnPrice.SETRANGE("VAT Type", ItemVATAnnPrice."VAT Type"::"Output VAT");
                            ItemVATAnnPrice.SETFILTER("Starting Date", '<=%1', SalesHeader."Posting Date");
                            IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                                SalesLine."Use VAT Announce Price" := TRUE;
                                SalesLine."Org. VAT Base Amount" := SalesLine."VAT Base Amount";
                                SalesLine."VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                            END ELSE
                                ERROR(Text50000, SalesLine."No.", SalesLine."Line No.");
                        END;
                    END;
                    //KKE : #001 -
                    Currency.Initialize(SalesHeader."Currency Code");//SAG
                    SalesLine."Amount Including VAT" :=
                      ROUND(SalesLine.Amount + SalesLine."VAT Base Amount" * SalesLine."VAT %" / 100, Currency."Amount Rounding Precision");

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateAmountIncludingVATOnAfterAssignAmounts', '', false, false)]
    local procedure OnValidateAmountIncludingVATOnAfterAssignAmounts(var SalesLine: Record "Sales Line"; Currency: Record Currency);
    var
        SalesHeader: Record "Sales Header";
        VATPostingSetup: Record "VAT Posting Setup";
        ItemVATAnnPrice: Record "Item VAT Announce Price";
        Text50000: Label 'Announce price for item no. %1 line no. %2 has not been set.';

    begin
        if SalesHeader.get(salesline."Document Type", SalesLine."Document No.") then;
        CASE SalesLine."VAT Calculation Type" OF
            SalesLine."VAT Calculation Type"::"Normal VAT",
            SalesLine."VAT Calculation Type"::"Reverse Charge VAT":
                BEGIN
                    //SalesLine."VAT Base Amount" :=
                    //ROUND(SalesLine.Amount * (1 - SalesHeader."VAT Base Discount %" / 100), Currency."Amount Rounding Precision");
                    //KKE : #001 +
                    IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                        VATPostingSetup.GET(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group");
                        IF VATPostingSetup."Use Announce Price for O/P VAT" THEN BEGIN
                            ItemVATAnnPrice.RESET;
                            ItemVATAnnPrice.SETRANGE("Item No.", SalesLine."No.");
                            ItemVATAnnPrice.SETRANGE("VAT Type", ItemVATAnnPrice."VAT Type"::"Output VAT");
                            ItemVATAnnPrice.SETFILTER("Starting Date", '<=%1', SalesHeader."Posting Date");
                            IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                                SalesLine."Use VAT Announce Price" := TRUE;
                                SalesLine."Org. VAT Base Amount" := SalesLine."VAT Base Amount";
                                SalesLine."VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                            END ELSE
                                ERROR(Text50000, SalesLine."No.", SalesLine."Line No.");
                        END;
                    END;
                    //KKE : #001 -
                    SalesLine."Amount Including VAT" :=
                      ROUND(SalesLine.Amount + SalesLine."VAT Base Amount" * SalesLine."VAT %" / 100, Currency."Amount Rounding Precision");

                end;
        end;
    end;

}
