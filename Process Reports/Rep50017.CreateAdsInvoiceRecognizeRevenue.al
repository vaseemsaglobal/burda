report 50017 "Create Ads Invoice Recog Rev"
{
    ProcessingOnly = true;
    dataset
    {
        dataitem("Ads. Booking Line"; "Ads. Booking Line")
        {
            DataItemTableView = sorting("Deal No.", "Line No.");
            trigger OnAftergetrecord()
            var
                myInt: Integer;
            begin
                CalcFields("Sell-to Customer No.", "Bill-to Customer No.");
                AdsBookingHeader.get("Deal No.");
                InsertSalesHeader("Ads. Booking Line");
                InsertSalesLine("Ads. Booking Line");
                "Cash Invoice No." := SalesHeader."No.";
                "Line Status" := "Line Status"::"Invoice Generated";
                "Posting Status" := "Posting Status"::"Inv.+Rev. Pending";
                "Remark from Accountant" := '';
                "Request Date & Time" := CurrentDateTime;
                "Created By" := UserId;
                Modify();
                //Message(Format("Line No.") + "Deal No.");
            end;

            trigger OnPostDataItem()
            begin
                Message('Ads. sales invoice %1 is ready for review & posting', SalesHeader."No.");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
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
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
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

    local procedure InsertSalesHeader(AdsBookingLine: Record "Ads. Booking Line")
    var
        BrandRec: Record Brand;

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
            Validate("Sell-to Customer No.", AdsBookingLine."Sell-to Customer No.");
            Validate("Bill-to Customer No.", AdsBookingLine."Bill-to Customer No.");
            Validate("Posting Date", PostingDate);
            Validate("Document Date", DocumentDate);
            //Magazine.Get(AdsBookingLine."Sub Product Code");
            Validate("Shortcut Dimension 1 Code", AdsBookingLine."Sub Product Code");
            Validate("Zone Area", AdsBookingHeader."Zone Area");
            Validate("Salesperson Code", AdsBookingHeader."Salesperson Code");
            Validate("Ads. Sales Type", AdsBookingHeader."Client Type");
            Validate("Posting No. Series", AdsItemSetup."Posted Invoice Nos.");
            Validate("Invoice Type", "Invoice Type"::Revenue);
            validate("Currency Code", AdsBookingLine."Currency Code");
            validate("External Document No.", AdsBookingHeader."Contract No.");
            if BrandRec.Get(AdsBookingLine."Brand Code") then
                Validate(Brand, BrandRec.Description);
            Modify(true);
            HeaderCreated := true;
            //COMMIT;
            // NoOfSalesInv := NoOfSalesInv + 1;
        end;
    end;

    procedure InsertSalesLine(AdsBookingLine: Record "Ads. Booking Line")
    var
        Magazine: Record "Sub Product";
        Volume: Record Volume;
        IssueNo: Record "Issue No.";
        AdsPosition: Record "Ads. Position";
        AdsType: Record "Ads. Type";
        textDesc: Text[250];
        SubProduct: Record "Sub Product";
        BookingRevenueType: Record "Booking Revenue Type";
    begin
        with SalesLine do begin
            SetRange("Document Type", SalesHeader."Document Type");
            SetRange("Document No.", SalesHeader."No.");
            Init;
            "Document Type" := SalesHeader."Document Type";
            "Document No." := SalesHeader."No.";
            NextLineNo += 10000;
            "Line No." := NextLineNo;
            AdsType.Get(AdsBookingLine."Ads. Type");
            //AdsType.TestField("Gen. Bus. Posting Group");
            Magazine.Get(AdsBookingLine."Sub Product Code");
            Magazine.TestField("Default Gen. Prod. Posting");
            Validate(Type, SalesLine.Type::"G/L Account");
            Validate("No.", AdsBookingLine."Bill Revenue G/L Account");
            clear(SubProduct);
            SubProduct.Get(AdsBookingLine."Sub Product Code");
            textDesc := SubProduct.Description + '-' + AdsBookingLine."Publication Month";
            Description := CopyStr(textDesc, 1, 50);
            "Description 2" := CopyStr(textDesc, 51, 50);
            Validate("Gen. Bus. Posting Group", AdsType."Gen. Bus. Posting Group");
            Validate("Gen. Prod. Posting Group", Magazine."Default Gen. Prod. Posting");
            Validate("VAT Prod. Posting Group", AdsBookingLine."VAT Prod. Posting Group");
            Validate("Currency Code", AdsBookingLine."Currency Code");

            Validate(Quantity, 1);
            Validate("Unit Price", AdsBookingLine."Cash Invoice Amount");
            validate("Deal No.", AdsBookingLine."Deal No.");
            Validate("Sub Deal No.", AdsBookingLine."Subdeal No.");
            Validate("Publication Month", AdsBookingLine."Publication month");
            Validate(Brand, AdsBookingLine."Product Code");
            Validate("Invoice Type", "Invoice Type"::Revenue);
            Validate("Salesperson Code", AdsBookingLine."Salesperson Code");
            Insert(true);
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            if Volume.Get(AdsBookingLine."Volume No.") then; //VAH

            "Ads. Sales Type" := AdsBookingHeader."Client Type";
            "Zone Area" := AdsBookingHeader."Zone Area";
            "Ads. Booking No." := AdsBookingLine."Deal No.";
            "Ads. Booking Line No." := AdsBookingLine."Line No.";
            //InsertDim('PRODUCT', AdsBookingLine."Product Code");//VAH
            if BookingRevenueType.get(AdsBookingLine."Ads. Type Code (Revenue Type Code)", AdsBookingLine."Shortcut Dimension 7 Code") and (BookingRevenueType."Shortcut Dimension 1 Code" <> '') then
                InsertDim('SUB-PRODUCT', BookingRevenueType."Shortcut Dimension 1 Code")//VAH 
            else
                if SubProduct.Get(AdsBookingLine."Sub Product Code") then
                    InsertDim('SUB-PRODUCT', SubProduct."Dimension 1 Code");//VAH

            InsertDim('SEGMENT', AdsBookingLine."Shortcut Dimension 7 Code");
            //InsertDim('ADS.POSITION', AdsBookingLine."Ads. Position Code");//VAH
            if AdsPosition.Get(AdsBookingLine."Ads. Position Code") then
                InsertDim('ADS.POSITION', AdsPosition."Shortcut Dimension 5 Code"); //VAH
            InsertDim('REVENUE-TYPE', AdsBookingLine."Ads. Type code (Revenue type Code)");
            "Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntry);
            Modify;

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

    var

        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NextLineNo: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PostingDate: Date;
        DocumentDate: date;
        AdsBookingHeader: Record "Ads. Booking Header";
        AdsItemSetup: Record "Ads. Item Setup";
        HeaderCreated: Boolean;
        DimSetEntry: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        DealNo: Code[20];
        ClientName: Text;
}
