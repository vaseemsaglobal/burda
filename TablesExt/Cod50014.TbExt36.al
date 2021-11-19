codeunit 50014 TbExt36
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure Tb36_Delete(RunTrigger: Boolean; var Rec: Record "Sales Header")
    var
        SubscriberContractLE: Record "Subscriber Contract L/E";
        SubscriberContract: Record "Subscriber Contract";
        AdsBookingLine: Record "Ads. Booking Line";
        AdsBookingHeader: record "Ads. Booking Header";
        SalesLine: Record "Sales Line";
    begin
        if not RunTrigger then
            exit;
        //>>VAH
        if rec."Document Type" = rec."Document Type"::Invoice then begin
            rec.TestField("Remark from Accountant");
            AdsBookingLine.Reset();
            AdsBookingLine.SetRange("Cash Invoice No.", rec."No.");
            if AdsBookingLine.FindSet() then
                repeat
                    AdsBookingLine.validate("Cash Invoice No.", '');
                    AdsBookingLine.validate("Line Status", AdsBookingLine."Line Status"::Approved);
                    AdsBookingLine.validate("Remark from Accountant", rec."Remark from Accountant");
                    AdsBookingLine.validate("Posting Status", AdsBookingLine."Posting Status"::Rejected);
                    AdsBookingLine.Modify();
                until AdsBookingLine.next = 0;
            if rec."Invoice Type" = rec."Invoice Type"::Deferred then begin
                SalesLine.reset;
                SalesLine.SetRange("Document No.", rec."No.");
                SalesLine.SetFilter("Deal No.", '<>%1', '');
                if SalesLine.FindFirst() then begin
                    if AdsBookingHeader.get(SalesLine."Deal No.") then begin
                        AdsBookingHeader."Manual Invoice Status" := AdsBookingHeader."Manual Invoice Status"::Rejected;
                        AdsBookingHeader."Accountant Remark For Manual Inv. " := rec."Remark from Accountant";
                        AdsBookingHeader.Modify();
                    end;
                end;
            end;
        end;

        //<<VAH
        //KKE : #002 + 
        SubscriberContractLE.RESET;
        SubscriberContractLE.SETCURRENTKEY("Paid Sales Order No.");
        SubscriberContractLE.SETRANGE("Paid Sales Order No.", rec."No.");
        IF SubscriberContractLE.FIND('-') THEN BEGIN
            SubscriberContract.GET(SubscriberContractLE."Subscriber Contract No.");
            SubscriberContract."Payment Status" := SubscriberContract."Payment Status"::Open;
            SubscriberContract.MODIFY;
            SubscriberContractLE.MODIFYALL("Paid Flag", FALSE);
            SubscriberContractLE.MODIFYALL("Paid Sales Order No.", '');
        END;
        SubscriberContractLE.RESET;
        SubscriberContractLE.SETCURRENTKEY("Sales Order No.");
        SubscriberContractLE.SETRANGE("Sales Order No.", rec."No.");
        IF SubscriberContractLE.FIND('-') THEN
            REPEAT
                SubscriberContractLE."Sales Order Flag" := FALSE;
                SubscriberContractLE."Sales Order Date" := 0D;
                SubscriberContractLE."Sales Order Line No." := 0;
                SubscriberContractLE."Sales Order No." := '';
                SubscriberContractLE.MODIFY;
            UNTIL SubscriberContractLE.NEXT = 0;
        //KKE : #002 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure OnAfterCopySellToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer; var SkipBillToContact: Boolean);
    begin
        // KKE : #001 +
        SalesHeader."Sell-to Address (Thai)" := COPYSTR(SellToCustomer."Address (Thai)", 1, 50);
        SalesHeader."Sell-to Address 3" := SellToCustomer."Address 3";
        SalesHeader."Sell-to Name (Thai)" := COPYSTR(SellToCustomer."Name (Thai)", 1, 50);
        // KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterSetFieldsBilltoCustomer', '', false, false)]
    local procedure OnAfterSetFieldsBilltoCustomer(var SalesHeader: Record "Sales Header"; Customer: Record Customer);
    var
        Subscriber: Record Subscriber;
    begin
        // KKE : #001 +
        SalesHeader."Bill-to Address (Thai)" := Customer."Address (Thai)";
        SalesHeader."Bill-to Address 3" := Customer."Address 3";
        SalesHeader."Bill-to Name (Thai)" := Customer."Name (Thai)";
        // KKE : #001 -

        // KKE : #002 +
        Subscriber.SETCURRENTKEY("Customer No.");
        Subscriber.SETRANGE("Customer No.", Customer."No.");
        IF NOT Subscriber.FIND('-') THEN
            CLEAR(Subscriber);
        IF Subscriber."Bill-to Name" <> '' THEN BEGIN
            SalesHeader."Bill-to Name" := Subscriber."Bill-to Name";
            SalesHeader."Bill-to Name 2" := Subscriber."Bill-to Name 2";
            SalesHeader."Bill-to Address" := Subscriber."Bill-to Address 1";
            SalesHeader."Bill-to Address 2" := Subscriber."Bill-to Address 2";
            SalesHeader."Bill-to Address 3" := Subscriber."Bill-to Address 3";
        END;
        IF Subscriber."Name (Thai)" <> '' THEN BEGIN
            SalesHeader."Bill-to Name (Thai)" := Subscriber."Name (Thai)";
            SalesHeader."Bill-to Address (Thai)" := Subscriber."Address (Thai)";
        END;
        // KKE : #002 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr', '', false, false)]
    local procedure OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr(var SalesHeader: Record "Sales Header"; ShipToAddress: Record "Ship-to Address");
    begin
        // KKE : #001 +
        SalesHeader."Ship-to Address (Thai)" := ShipToAddress."Address (Thai)";
        SalesHeader."Ship-to Address 3" := ShipToAddress."Address 3";
        SalesHeader."Ship-to Name (Thai)" := ShipToAddress."Name (Thai)";
        // KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopyShipToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure OnAfterCopyShipToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer);
    begin
        // KKE : #001 +
        SalesHeader."Ship-to Address (Thai)" := SellToCustomer."Address (Thai)";
        SalesHeader."Ship-to Address 3" := SellToCustomer."Address 3";
        SalesHeader."Ship-to Name (Thai)" := SellToCustomer."Name (Thai)";
        // KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnUpdateSellToCustOnAfterSetFromSearchContact', '', false, false)]
    local procedure OnUpdateSellToCustOnAfterSetFromSearchContact(var SalesHeader: Record "Sales Header"; var SearchContact: Record Contact);
    begin

        // KKE : #001 +
        SalesHeader."Ship-to Address (Thai)" := SearchContact."Address (Thai)";
        SalesHeader."Ship-to Address 3" := SearchContact."Address 3";
        SalesHeader."Ship-to Name (Thai)" := SearchContact."Name (Thai)";
        // KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterUpdateSellToCust', '', false, false)]
    local procedure OnAfterUpdateSellToCust(var SalesHeader: Record "Sales Header"; Contact: Record Contact);
    begin
        // KKE : #001 +
        SalesHeader."Sell-to Address (Thai)" := COPYSTR(Contact."Address (Thai)", 1, 50);
        SalesHeader."Sell-to Address 3" := Contact."Address 3";
        SalesHeader."Sell-to Name (Thai)" := COPYSTR(Contact."Name (Thai)", 1, 50);
        // KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnUpdateBillToCustOnAfterSalesQuote', '', false, false)]
    local procedure OnUpdateBillToCustOnAfterSalesQuote(var SalesHeader: Record "Sales Header"; Contact: Record Contact);
    begin
        // KKE : #001 +
        SalesHeader."Bill-to Address (Thai)" := Contact."Address (Thai)";
        SalesHeader."Bill-to Address 3" := Contact."Address 3";
        SalesHeader."Bill-to Name (Thai)" := Contact."Name (Thai)";
        // KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterUpdateShipToAddress', '', false, false)]
    local procedure OnAfterUpdateShipToAddress(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; CurrentFieldNo: Integer);
    var
        Location: record Location;
        CompanyInfo: Record "Company Information";
    begin
        if SalesHeader."Location Code" <> '' then begin
            Location.Get(SalesHeader."Location Code");
            // KKE : #001 +
            SalesHeader."Ship-to Name (Thai)" := Location."Name (Thai)";
            SalesHeader."Ship-to Address (Thai)" := Location."Address (Thai)";
            SalesHeader."Ship-to Address 3" := Location."Address 3";
            // KKE : #001 -
        end else begin
            // KKE : #001 +
            SalesHeader."Ship-to Name (Thai)" := CompanyInfo."Company Name (Thai)";
            SalesHeader."Ship-to Address (Thai)" := CompanyInfo."Company Address (Thai)";
            SalesHeader."Ship-to Address 3" := CompanyInfo."Ship-to Address 3";
            // KKE : #001 -
        end;
    end;




}
