codeunit 50012 TbExt38
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure Tb38_Delete(RunTrigger: Boolean; var Rec: Record "Purchase Header")
    begin
        if not RunTrigger then
            exit;
        //KKE : #002 +
        Rec.TESTFIELD(Status, Rec.Status::Open);
        //KKE : #002 -

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorFieldsFromVendor', '', false, false)]
    local procedure OnAfterCopyBuyFromVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header");
    begin

        //KKE : #001 +
        PurchaseHeader."Buy-from Address (Thai)" := Vendor."Address (Thai)";
        PurchaseHeader."Buy-from Address 3" := Vendor."Address 3";
        PurchaseHeader."Buy-from Name (Thai)" := Vendor."Name (Thai)";
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePurchaseHeaderPayToVendorNo', '', false, false)]
    local procedure OnValidatePurchaseHeaderPayToVendorNo(var Sender: Record "Purchase Header"; Vendor: Record Vendor; var PurchaseHeader: Record "Purchase Header");
    begin
        //KKE : #001 +
        PurchaseHeader."Pay-to Address (Thai)" := Vendor."Address (Thai)";
        PurchaseHeader."Pay-to Address 3" := Vendor."Address 3";
        PurchaseHeader."Pay-to Name (Thai)" := Vendor."Name (Thai)";
        PurchaseHeader."Dummy Vendor" := Vendor."Dummy Vendor";
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Ship-to Code', true, true)]
    local procedure Tb38_ShipToCode_OnValidate(var Rec: Record "Purchase Header")
    var
        ShipToAddr: Record "Ship-to Address";
        Cust: Record customer;
    begin
        if rec."Ship-to Code" <> '' then begin
            ShipToAddr.Get(rec."Sell-to Customer No.", rec."Ship-to Code");

            //KKE : #001 +
            rec."Ship-to Address (Thai)" := ShipToAddr."Address (Thai)";
            rec."Ship-to Address 3" := ShipToAddr."Address 3";
            rec."Ship-to Name (Thai)" := ShipToAddr."Name (Thai)";
            //KKE : #001 -
        end else begin
            Cust.Get(rec."Sell-to Customer No.");

            //KKE : #001 +
            rec."Ship-to Address (Thai)" := Cust."Address (Thai)";
            rec."Ship-to Address 3" := Cust."Address 3";
            rec."Ship-to Name (Thai)" := Cust."Name (Thai)";
            //KKE : #001 -
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Order Address Code', true, true)]
    local procedure MyProcedure(var Rec: Record "Purchase Header")
    var
        OrderAddr: Record "Order Address";
        Vend: Record Vendor;
    begin
        if rec."Order Address Code" <> '' then begin
            OrderAddr.GET(rec."Buy-from Vendor No.", rec."Order Address Code");
            //KKE : #001 +
            rec."Buy-from Address (Thai)" := OrderAddr."Address (Thai)";
            rec."Buy-from Address 3" := OrderAddr."Address 3";
            rec."Buy-from Name (Thai)" := OrderAddr."Name (Thai)";
            if rec.IsCreditDocType() then begin
                //KKE : #001 +
                rec."Ship-to Address (Thai)" := OrderAddr."Address (Thai)";
                rec."Ship-to Address 3" := OrderAddr."Address 3";
                rec."Ship-to Name (Thai)" := OrderAddr."Name (Thai)";
                //KKE : #001 -
            end;
            //KKE : #001 -
        end else begin
            Vend.get(rec."Buy-from Vendor No.");
            //KKE : #001 +
            rec."Buy-from Address (Thai)" := Vend."Address (Thai)";
            rec."Buy-from Address 3" := Vend."Address 3";
            rec."Buy-from Name (Thai)" := Vend."Name (Thai)";
            if rec.IsCreditDocType() then begin
                //KKE : #001 +
                rec."Ship-to Address (Thai)" := Vend."Address (Thai)";
                rec."Ship-to Address 3" := Vend."Address 3";
                rec."Ship-to Name (Thai)" := Vend."Name (Thai)";
                //KKE : #001 -
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterGetNoSeriesCode', '', false, false)]
    local procedure OnAfterGetNoSeriesCode(var PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup"; var NoSeriesCode: Code[20]);
    var
        POType: Record "PO Type";
    begin

        if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then
       //TSA001
       BEGIN
            IF PAGE.RUNMODAL(PAGE::"PO Type Setup", POType) = ACTION::LookupOK THEN BEGIN
                POType.TESTFIELD("Nos. for PO");
                PurchHeader."PO Type" := POType."PO Type Code";
                PurchHeader."No. Series" := POType."Nos. for PO";
            END;
            PurchHeader.TestNoSeries;
            NoSeriesCode := PurchHeader."No. Series";
            //EXIT("No. Series");
            //EXIT(PurchSetup."Order Nos.");
        END;
        //TSA001
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterUpdateShipToAddress', '', false, false)]
    local procedure OnAfterUpdateShipToAddress(var PurchHeader: Record "Purchase Header");
    var
        location: Record Location;
        CompanyInfo: Record "Company Information";
    begin

        IF (PurchHeader."Location Code" <> '') AND
           Location.GET(PurchHeader."Location Code") AND
           (PurchHeader."Sell-to Customer No." = '')
        THEN BEGIN
            //KKE : #001 +
            PurchHeader."Ship-to Address (Thai)" := Location."Address (Thai)";
            PurchHeader."Ship-to Address 3" := Location."Address 3";
            PurchHeader."Ship-to Name (Thai)" := Location."Name (Thai)";
            //KKE : #001 -
        end;

        IF (PurchHeader."Location Code" = '') AND
           (PurchHeader."Sell-to Customer No." = '')
        THEN BEGIN
            CompanyInfo.GET;
            //KKE : #001 +
            PurchHeader."Ship-to Name (Thai)" := CompanyInfo."Company Name (Thai)";
            PurchHeader."Ship-to Address (Thai)" := CompanyInfo."Company Address (Thai)";
            PurchHeader."Ship-to Address 3" := CompanyInfo."Ship-to Address 3";
            //KKE : #001 -
        end;
    end;
}
