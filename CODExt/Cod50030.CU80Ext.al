codeunit 50030 CU80Ext
{
    Permissions = tabledata 113 = rimd, tabledata 115 = rimd;

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterCheckMandatoryFields', '', false, false)]
    local procedure OnAfterCheckMandatoryFields_Subscriber(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        SalesHeader.TESTFIELD(Status, SalesHeader.Status::Released);  //TSA005
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesCrMemoHeaderInsert', '', false, false)]
    local procedure OnAfterSalesCrMemoHeaderInsert_Subscriber(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
        xSalesInvLine: Record "Sales Invoice Line";
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        //KKE : #009 +
        IF SalesCrMemoHeader."Applied-to Tax Invoice" <> '' THEN BEGIN
            xSalesInvLine.RESET;
            xSalesInvLine.SETRANGE("Document No.", SalesCrMemoHeader."Applied-to Tax Invoice");
            xSalesInvLine.SETFILTER("Ads. Booking No.", '<>%1', '');
            IF xSalesInvLine.FIND('-') THEN
                REPEAT
                    if AdsBookingLine.GET(xSalesInvLine."Ads. Booking No.", xSalesInvLine."Ads. Booking Line No.") then begin
                        AdsBookingLine."Line Status" := AdsBookingLine."Line Status"::Cancelled;
                        AdsBookingLine."Last Status Date" := CURRENTDATETIME;  //22.10.2010
                        AdsBookingLine."Cancelled Date" := CURRENTDATETIME;  //22.10.2010
                        AdsBookingLine.MODIFY;
                    end;
                UNTIL xSalesInvLine.NEXT = 0;
        end;
        //KKE : #009 -
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesShptLineInsert', '', false, false)]
    local procedure OnAfterSalesShptLineInsert_Subscriber(var SalesShipmentLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line"; ItemShptLedEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        SubscriberContract: Record "Subscriber Contract";
        SubscriberContractLE: Record "Subscriber Contract L/E";
    begin
        //KKE : #003 +
        if SubscriberContract.GET(SalesLine."Subscriber Contract No.") then begin
            SubscriberContractLE.SETPERMISSIONFILTER;
            SubscriberContractLE.RESET;
            SubscriberContractLE.SETRANGE("Magazine Code", SubscriberContract."Magazine Code");
            SubscriberContractLE.SETCURRENTKEY("Sales Order No.");
            SubscriberContractLE.SETRANGE("Sales Order No.", SalesLine."Document No.");
            SubscriberContractLE.SETRANGE("Sales Order Line No.", SalesLine."Line No.");
            if SubscriberContractLE.FIND('-') then begin
                SubscriberContractLE."Delivered Flag" := TRUE;
                SubscriberContractLE."Delivered Date" := SalesShipmentLine."Posting Date"; //<< SalesShptHeader."Posting Date"
                SubscriberContractLE."Delivered Document No." := SalesShipmentLine."Document No."; //<< SalesShptHeader."No.";
                SubscriberContractLE.MODIFY;
                SubscriberContract."Last Shipment Magazine Item No" := SubscriberContractLE."Magazine Item No.";
                SubscriberContract."Last Shipment Date" := SalesShipmentLine."Posting Date"; //<< SalesShptHeader."Posting Date"
                SubscriberContract."Last Shipment Doc. No." := SalesShipmentLine."Document No."; //<< SalesShptHeader."No.";
                SubscriberContract.MODIFY;
            end;
        end;
        //KKE : #003 -
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostInvPostBuffer', '', false, false)]
    local procedure OnBeforePostInvPostBuffer_Subscriber(var GenJnlLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean)
    begin
        GenJnlLine.VATLineNo := InvoicePostBuffer."Line No.";  //TSA002
        //KKE : #002 +
        GenJnlLine."Real Customer/Vendor Name" := SalesHeader."Bill-to Name (Thai)"; //<< "Bill-to Name (Thai)";
        //KKE : #001 +
        GenJnlLine."Tax Invoice No." := GenJnlLine."Document No."; //<< GenJnlLineDocNo
        GenJnlLine."Tax Invoice Date" := SalesHeader."Posting Date"; //<< "Posting Date"
        //KKE : #001 -
        //GenJnlLine.MODIFY; //<< Added Code RJ1.00
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterInvoicePostingBufferSetAmounts', '', false, false)]
    local procedure OnAfterInvoicePostingBufferSetAmounts_Subscriber(var InvoicePostBuffer: Record "Invoice Post. Buffer"; SalesLine: Record "Sales Line")
    var
        VATPostingSetup: Record "VAT Posting Setup";
        ItemVATAnnPrice: Record "Item VAT Announce Price";
        Text50000: Label 'Announce price for item no. %1 line no. %2 has not been set.';
    begin
        //KKE : #001 +
        IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
            VATPostingSetup.GET(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group");
            IF VATPostingSetup."Use Announce Price for O/P VAT" THEN BEGIN
                ItemVATAnnPrice.RESET;
                ItemVATAnnPrice.SETRANGE("Item No.", SalesLine."No.");
                ItemVATAnnPrice.SETRANGE("VAT Type", ItemVATAnnPrice."VAT Type"::"Output VAT");
                ItemVATAnnPrice.SETFILTER("Starting Date", '<=%1', SalesLine."Posting Date"); //<< SalesHeader."Posting Date");
                IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                    IF SalesLine.Amount < 0 THEN
                        InvoicePostBuffer."VAT Base Amount" := -ItemVATAnnPrice."Announce Price"
                    ELSE
                        InvoicePostBuffer."VAT Base Amount" := ItemVATAnnPrice."Announce Price"
                END ELSE
                    ERROR(Text50000, SalesLine."No.", SalesLine."Line No.");
            end;
        end;
        //KKE : #001 -
    end;

    procedure UpdateSalesInvLineCirReceipt(DocNo: Code[20]; LineNo: Integer; CirReceiptNo: Code[20])
    var
        _SalesInvLine: Record "Sales Invoice Line";
    begin
        //KKE : #004 +
        _SalesInvLine.GET(DocNo, LineNo);
        _SalesInvLine."Circulation Receipt No." := CirReceiptNo;
        _SalesInvLine.MODIFY;
        //KKE : #004 -
    end;

    procedure UpdateSalesCrMemoCirReceipt(DocNo: Code[20]; LineNo: Integer; CirReceiptNo: Code[20])
    var
        _SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        //KKE : #004 +
        _SalesCrMemoLine.GET(DocNo, LineNo);
        _SalesCrMemoLine."Circulation Receipt No." := CirReceiptNo;
        _SalesCrMemoLine.MODIFY;
        //KKE : #004 -
    end;

    procedure UpdateBilltoOnSalesInvHdr(xSalesInvHdr: Record "Sales Invoice Header")
    var
        _SalesInvHdr: Record "Sales Invoice Header";
    begin
        //KKE : #006 +
        _SalesInvHdr.GET(xSalesInvHdr."No.");
        _SalesInvHdr."Bill-to Name (Thai)" := xSalesInvHdr."Bill-to Name (Thai)";
        _SalesInvHdr."Bill-to Address (Thai)" := xSalesInvHdr."Bill-to Address (Thai)";
        _SalesInvHdr.MODIFY;
        //KKE : #006 -
    end;

    procedure UpdateSalesTaxInvoice(SalesTaxInvLine: Record "Sales Tax Invoice/Rec. Line")
    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        //KKE : #007 +
        with SalesTaxInvLine do begin
            SalesInvLine.SETCURRENTKEY("Sales Tax Invoice/Receipt No.", "Sales Tax Invoice/Receipt Line");
            SalesInvLine.SETRANGE("Sales Tax Invoice/Receipt No.", "Document No.");
            SalesInvLine.SETRANGE("Sales Tax Invoice/Receipt Line", "Line No.");
            IF SalesInvLine.FIND('-') THEN
                REPEAT
                    SalesInvLine."Sales Tax Invoice/Receipt No." := '';
                    SalesInvLine."Sales Tax Invoice/Receipt Line" := 0;
                    SalesInvLine.MODIFY;
                UNTIL SalesInvLine.NEXT = 0;

            SalesCrMemoLine.SETCURRENTKEY("Sales Tax Invoice/Receipt No.", "Sales Tax Invoice/Receipt Line");
            SalesCrMemoLine.SETRANGE("Sales Tax Invoice/Receipt No.", "Document No.");
            SalesCrMemoLine.SETRANGE("Sales Tax Invoice/Receipt Line", "Line No.");
            IF SalesCrMemoLine.FIND('-') THEN
                REPEAT
                    SalesCrMemoLine."Sales Tax Invoice/Receipt No." := '';
                    SalesCrMemoLine."Sales Tax Invoice/Receipt Line" := 0;
                    SalesCrMemoLine.MODIFY;
                UNTIL SalesCrMemoLine.NEXT = 0;
        end;
        //KKE : #007 -
    end;


    procedure SalesInvHdrEdit(xSalesInvHdr: Record "Sales Invoice Header")
    var
        _SalesInvHdr: Record "Sales Invoice Header";
    begin
        //KKE : #008 +
        _SalesInvHdr.GET(xSalesInvHdr."No.");
        _SalesInvHdr."PO No." := xSalesInvHdr."PO No.";
        _SalesInvHdr."Remark 1" := xSalesInvHdr."Remark 1";
        _SalesInvHdr."Remark 2" := xSalesInvHdr."Remark 2";
        //_SalesInvHdr."Product (Ads. Invoice)" := xSalesInvHdr."Product (Ads. Invoice)";
        _SalesInvHdr.MODIFY;
        //KKE : #008 -
    end;


    procedure SalesInvLineEdit(xSalesInvLine: Record "Sales Invoice Line")
    var
        _SalesInvLine: Record "Sales Invoice Line";
    begin
        //KKE : #008 +
        _SalesInvLine.GET(xSalesInvLine."Document No.", xSalesInvLine."Line No.");
        _SalesInvLine.Description := xSalesInvLine.Description;
        _SalesInvLine."Description 2" := xSalesInvLine."Description 2";
        _SalesInvLine."Report Issuedate" := xSalesInvLine."Report Issuedate";
        _SalesInvLine.MODIFY;
        //KKE : #008 -
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean);
    var

        AdsBookingLine: Record "Ads. Booking Line";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        AdsBookingHeder: Record "Ads. Booking Header";
    begin
        SalesInvLine.reset;
        if SalesInvHdrNo <> '' then
            SalesInvLine.SetRange("Document No.", SalesInvHdrNo);
        if SalesCrMemoHdrNo <> '' then
            SalesInvLine.SetRange("Document No.", SalesCrMemoHdrNo);
        if SalesInvLine.FindSet() then
            repeat
                AdsBookingLine.Reset();
                AdsBookingLine.SetRange("Deal No.", SalesInvLine."Deal No.");
                AdsBookingLine.SetRange("Subdeal No.", SalesInvLine."Sub Deal No.");
                if AdsBookingLine.FindFirst() then begin
                    AdsBookingLine."Posting Status" := AdsBookingLine."Posting Status"::"Inv.+Rev. Posted";
                    AdsBookingLine."Line Status" := AdsBookingLine."Line Status"::Invoiced;
                    AdsBookingLine."Booking Status" := AdsBookingLine."Booking Status"::"Deal Completed";
                    AdsBookingLine.Modify();
                    /*
                    if SalesInvHeader.get(SalesInvLine."Document No.") then begin
                        if SalesInvHeader."Invoice Type" = SalesInvHeader."Invoice Type"::Deferred then
                            if AdsBookingHeder.Get(SalesInvLine."Deal No.") then begin
                                AdsBookingHeder."Manual Invoice Status" := AdsBookingHeder."Manual Invoice Status"::"Manual Inv. Posted";
                                AdsBookingHeder.Modify();
                            end;
                    end;
                    */
                end;
                if SalesInvHeader.get(SalesInvLine."Document No.") then begin
                    if SalesInvHeader."Invoice Type" = SalesInvHeader."Invoice Type"::Deferred then
                        if AdsBookingHeder.Get(SalesInvLine."Deal No.") then begin
                            AdsBookingHeder."Manual Invoice Status" := AdsBookingHeder."Manual Invoice Status"::"Manual Inv. Posted";
                            AdsBookingHeder.Modify();
                        end;
                end;
            until SalesInvLine.Next() = 0;

    end;
}
