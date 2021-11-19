report 50018 "Create Manual Invoice"
{
    ProcessingOnly = true;
    dataset
    {
        dataitem("Ads. Booking Header"; "Ads. Booking Header")
        {
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter("No.", DealNo);
            end;
            //DataItemTableView = sorting("No.");
            trigger OnAftergetrecord()
            var
                myInt: Integer;
            begin
                IsManualInvoicePresent;
                InsertSalesHeader("Ads. Booking Header");
                InsertSalesLine("Ads. Booking Header");
                //"Cash Invoice No." := SalesHeader."No.";
                //"Line Status" := "Line Status"::"Invoice Generated";
                //"Posting Status" := "Posting Status"::Pending;
                "Manual Invoice Status" := "Manual Invoice Status"::"Manual Inv. Pending";
                "Accountant Remark For Manual Inv. " := '';
                "Request Date & Time" := CurrentDateTime;
                "Created By" := UserId;
                Modify();
                //Message(Format("Line No.") + "Deal No.");
                //CurrReport.Break();
            end;

            trigger OnPostDataItem()
            begin
                Message('Manual invoice %1 is ready for review & posting', SalesHeader."No.");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field("Deal No."; DealNo)
                    {
                        Editable = false;
                        ApplicationArea = All;

                    }
                    field(ClientName; ClientName)
                    {
                        Caption = 'Client Name';
                        Editable = false;
                        ApplicationArea = All;

                    }
                    field("Posting Date"; postingdate)
                    {
                        ApplicationArea = All;

                    }
                    field("Document Date"; DocumentDate)
                    {
                        ApplicationArea = All;

                    }
                    field("G/L Account No."; accno)
                    {
                        Caption = 'G/L Account No.';
                        TableRelation = "G/L Account" where("For Manual Invoice" = const(true));
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            GLAccount: Record "G/L Account";
                        begin
                            GLAccount.Get(Accno);
                            ManualDesc := GLAccount.Name;
                        end;

                    }
                    field(Description; ManualDesc)
                    {
                        Caption = 'Description';
                        ApplicationArea = All;

                    }
                    field(Amount; Amt)
                    {
                        Caption = 'Amount';
                        ApplicationArea = All;

                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
        trigger Onopenpage()
        var
            AdsSaleSetup: Record "Ads. Item Setup";
            GLAccount: Record "G/L Account";
        begin
            AdsSaleSetup.Get();
            Accno := AdsSaleSetup."Deffered A/c No.";
            GLAccount.Get(Accno);
            ManualDesc := GLAccount.Name;
        end;
    }
    procedure InitRequest(var AdsBookingNo: Code[20])
    var
        AdsBookingHeader: Record "Ads. Booking Header";
        Cust: Record Customer;
    begin
        DealNo := AdsBookingNo;
        AdsBookingHeader.Get(DealNo);
        if Cust.get(AdsBookingHeader."Bill-to Customer No.") then
            ClientName := cust.Name;
    end;

    local procedure InsertSalesHeader(AdsBookingHdr: Record "Ads. Booking Header")


    begin
        if HeaderCreated then
            exit;
        AdsItemSetup.Get();
        with SalesHeader do begin
            Init;
            "Document Type" := "document type"::Invoice;
            "No." := NoSeriesMgt.GetNextNo(AdsItemSetup."Ads. Sales Invoice Nos.", WorkDate, true);
            Insert(true);
            SetHideValidationDialog(true); //do not warning message.
            Validate("Sell-to Customer No.", AdsBookingHdr."Final Customer No.");
            Validate("Bill-to Customer No.", AdsBookingHdr."Bill-to Customer No.");
            if PostingDate <> 0D then
                Validate("Posting Date", PostingDate);
            if DocumentDate <> 0D then
                Validate("Document Date", DocumentDate);
            //Magazine.Get(AdsBookingLine."Sub Product Code");
            Validate("Currency Code", AdsBookingHdr."Currency Code");
            Validate("Zone Area", AdsBookingHdr."Zone Area");
            Validate("Salesperson Code", AdsBookingHdr."Salesperson Code");
            Validate("Ads. Sales Type", AdsBookingHdr."Client Type");
            Validate("Posting No. Series", AdsItemSetup."Posted Invoice Nos.");
            Validate("Invoice Type", "Invoice Type"::Deferred);
            validate("External Document No.", AdsBookingHdr."Contract No.");
            Modify(true);
            HeaderCreated := true;
            //COMMIT;
            // NoOfSalesInv := NoOfSalesInv + 1;
        end;
    end;

    procedure InsertSalesLine(AdsBookingHdr: Record "Ads. Booking Header")
    var
        Magazine: Record "Sub Product";
        Volume: Record Volume;
        IssueNo: Record "Issue No.";
        AdsPosition: Record "Ads. Position";
        AdsType: Record "Ads. Type";
        textDesc: Text[250];
        SubProduct: Record "Sub Product";
    begin
        with SalesLine do begin
            SetRange("Document Type", SalesHeader."Document Type");
            SetRange("Document No.", SalesHeader."No.");
            Init;
            "Document Type" := SalesHeader."Document Type";
            "Document No." := SalesHeader."No.";
            NextLineNo += 10000;
            "Line No." := NextLineNo;
            //Magazine.TestField("Default Gen. Prod. Posting");
            Validate(Type, SalesLine.Type::"G/L Account");
            Validate("No.", Accno);
            Validate(Description, ManualDesc);
            Validate(Quantity, 1);
            Validate("Unit Price", Amt);
            validate("Deal No.", AdsBookingHdr."No.");
            Validate("Invoice Type", "Invoice Type"::Deferred);
            Validate("Salesperson Code", AdsBookingHdr."Salesperson Code");
            Insert(true);
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            "Ads. Sales Type" := AdsBookingHdr."Client Type";
            "Zone Area" := AdsBookingHdr."Zone Area";
            "Ads. Booking No." := AdsBookingHdr."No.";
            validate("VAT Prod. Posting Group", AdsItemSetup."VAT Prod. Posting Group");
            Validate("Gen. Prod. Posting Group", AdsItemSetup."Gen. Prod. Posting Group");
            Modify(true);

        end;
    end;

    local procedure InsertDim(DimCode: Code[20]; DimValue: Code[20])

    begin
        DimSetEntry.Init();
        DimSetEntry.validate("Dimension Code", dimCode);
        DimSetEntry.Validate("Dimension Value Code", DimValue);
        DimSetEntry."Dimension Set ID" := -1;
        if not DimSetEntry.Insert() then DimSetEntry.Modify();
    end;

    local procedure IsManualInvoicePresent()
    var
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
    begin
        SalesLine.reset;
        SalesLine.SetRange("Deal No.", "Ads. Booking Header"."No.");
        if SalesLine.FindSet() then
            repeat
                if SalesHeader.get(SalesHeader."Document Type"::Invoice, SalesLine."Document No.") then
                    if SalesHeader."Invoice Type" = SalesHeader."Invoice Type"::Deferred then
                        Error('Manual invoice %1 already created for deal %2', SalesHeader."No.", "Ads. Booking Header"."No.");
            until SalesLine.Next() = 0;
    end;

    var

        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NextLineNo: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PostingDate: Date;
        DocumentDate: date;

        AdsItemSetup: Record "Ads. Item Setup";
        HeaderCreated: Boolean;
        DimSetEntry: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        Amt: Decimal;
        Accno: code[20];
        ManualDesc: Text[100];
        DealNo: Code[20];
        ClientName: Text;

}
