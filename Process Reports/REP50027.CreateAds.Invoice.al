Report 50027 "Create Ads. Invoice"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   14.05.2007   KKE   -New batchjob to create ads invoice - Ads. Sales Module
    //                          -Billing Note need to separate invoice if user not tick mark on "Combine invoice" by
    //                           "Bill-to Customer No.","Salesperson","Ads. Sales Type","Zone Area"
    //                          -"Scheduled Invoice Date" use for filter data only.
    // 002   19.10.2010   GKU   -Add "Status Date"

    ProcessingOnly = true;

    dataset
    {
        dataitem("Ads. Booking Header"; "Ads. Booking Header")
        {
            DataItemTableView = sorting("Bill-to Customer No.", "Final Customer No.");

            dataitem("Ads. Booking Line"; "Ads. Booking Line")
            {
                CalcFields = "Sell-to Customer No.", "Bill-to Customer No.";
                DataItemLink = "Deal No." = field("No.");
                DataItemTableView = sorting("Ads. Item No.", "Line Status") where("Line Status" = const(Approved));


                trigger OnAfterGetRecord()
                begin
                    if "Bill-to Customer No." <> Cust."No." then
                        Cust.Get("Bill-to Customer No.");
                    if not (Cust.Blocked in [Cust.Blocked::All, Cust.Blocked::Invoice]) then begin
                        TestField("Bill-to Customer No.");
                        if CombineInvDoc then begin
                            if ("Bill-to Customer No." <> SalesHeader."Bill-to Customer No.") or
                               ("Ads. Booking Header"."Salesperson Code" <> SalesHeader."Salesperson Code") or
                               ("Ads. Booking Header"."Client Type" <> SalesHeader."Ads. Sales Type") or
                               ("Ads. Booking Header"."Zone Area" <> SalesHeader."Zone Area")
                            then begin
                                if SalesHeader."No." <> '' then
                                    FinalizeSalesHeader;
                                InsertSalesHeader("Ads. Booking Line");
                            end;
                            if "Create Sales Invoice" then begin
                                TestField("Bill Revenue G/L Account");
                                InsertSalesLine(
                                  "Ads. Booking Line",
                                  "Bill Revenue G/L Account",
                                  "Cash Invoice Amount");
                                AdsBookingLine.Get("Deal No.", "Line No.");
                                AdsBookingLine."Line Status" := AdsBookingLine."line status"::Invoiced;
                                AdsBookingLine."Last Status Date" := CurrentDatetime;//GKU:002
                                AdsBookingLine."Last Date Modified" := CurrentDatetime;  //18.06.2012
                                AdsBookingLine."Cash Invoice No." := SalesHeader."No.";
                                AdsBookingLine.Closed := true;
                                //AdsBookingLine."Scheduled Invoice Date" := ScheduleInvDate;
                                AdsBookingLine.Modify;
                            end;
                            if "Barter Required Document" then begin
                                TestField("Barter G/L Account");
                                InsertSalesLine(
                                  "Ads. Booking Line",
                                  "Barter G/L Account",
                                  "Barter Amount");
                                AdsBookingLine.Get("Deal No.", "Line No.");
                                AdsBookingLine."Line Status" := AdsBookingLine."line status"::Invoiced;
                                AdsBookingLine."Last Status Date" := CurrentDatetime;//GKU:002
                                AdsBookingLine."Last Date Modified" := CurrentDatetime;  //18.06.2012
                                AdsBookingLine."Barter Invoice No." := SalesHeader."No.";
                                AdsBookingLine.Closed := true;
                                //AdsBookingLine."Scheduled Invoice Date" := ScheduleInvDate;
                                AdsBookingLine.Modify;
                            end;
                        end else begin
                            if "Create Sales Invoice" then begin
                                if SalesHeader."No." <> '' then
                                    FinalizeSalesHeader;
                                InsertSalesHeader("Ads. Booking Line");
                                TestField("Bill Revenue G/L Account");
                                InsertSalesLine(
                                  "Ads. Booking Line",
                                  "Bill Revenue G/L Account",
                                  "Cash Invoice Amount");
                                AdsBookingLine.Get("Deal No.", "Line No.");
                                AdsBookingLine."Line Status" := AdsBookingLine."line status"::Invoiced;
                                AdsBookingLine."Last Status Date" := CurrentDatetime;//GKU:002
                                AdsBookingLine."Last Date Modified" := CurrentDatetime;  //18.06.2012
                                AdsBookingLine."Cash Invoice No." := SalesHeader."No.";
                                AdsBookingLine.Closed := true;
                                //AdsBookingLine."Scheduled Invoice Date" := ScheduleInvDate;
                                AdsBookingLine.Modify;
                            end;
                            if "Barter Required Document" then begin
                                if SalesHeader."No." <> '' then
                                    FinalizeSalesHeader;
                                InsertSalesHeader("Ads. Booking Line");
                                TestField("Barter G/L Account");
                                InsertSalesLine(
                                  "Ads. Booking Line",
                                  "Barter G/L Account",
                                  "Barter Amount");
                                AdsBookingLine.Get("Deal No.", "Line No.");
                                AdsBookingLine."Line Status" := AdsBookingLine."line status"::Invoiced;
                                AdsBookingLine."Last Status Date" := CurrentDatetime;//GKU:002
                                AdsBookingLine."Last Date Modified" := CurrentDatetime;  //18.06.2012
                                AdsBookingLine."Barter Invoice No." := SalesHeader."No.";
                                AdsBookingLine.Closed := true;
                                //AdsBookingLine."Scheduled Invoice Date" := ScheduleInvDate;
                                AdsBookingLine.Modify;
                            end;
                        end;
                    end else
                        NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
                end;

                trigger OnPreDataItem()
                begin
                    if AdsBookingNo <> '' then
                        SetFilter("Deal No.", AdsBookingNo);
                    if AdsProduct <> '' then
                        SetFilter("Brand Code", AdsProduct);
                    if AdsItemNo <> '' then
                        SetFilter("Ads. Item No.", AdsItemNo);
                    /*
                    IF ScheduleInvDate <> 0D THEN
                      SETRANGE("Scheduled Invoice Date",ScheduleInvDate);
                    */
                    SetRange("Sub Product Code");
                    SETPERMISSIONFILTER;

                end;
            }

            trigger OnPreDataItem()
            begin
                if SelltoCust <> '' then
                    SetFilter("Final Customer No.", SelltoCust);
                if BilltoCust <> '' then
                    SetFilter("Bill-to Customer No.", BilltoCust);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AdsBookingNo; AdsBookingNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ads. Booking No.';
                        TableRelation = "Ads. Booking Header";
                    }
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Posting Date';
                    }
                    field(SelltoCust; SelltoCust)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Sell-to Customer No.';
                        TableRelation = Customer;
                    }
                    field(DocumentDate; DocumentDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Document Date';
                    }
                    field(BilltoCust; BilltoCust)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bill-to Customer No.';
                        TableRelation = Customer;
                    }
                    field(AdsItemNo; AdsItemNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ads. Item No.';
                        TableRelation = "Ads. Item";

                        trigger OnValidate()
                        var
                            Magazine: Record "Sub Product";
                        begin
                            SalesInvNos := '';
                            Clear(MagazineVolumeIssue);
                            if AdsItemNo = '' then
                                exit;
                            MagazineVolumeIssue.SETPERMISSIONFILTER;
                            MagazineVolumeIssue.SetRange("Magazine Code");
                            MagazineVolumeIssue.SetRange("Ads. Item No.", AdsItemNo);
                            MagazineVolumeIssue.Find('-');
                        end;
                    }
                    field(MagazineCode; MagazineVolumeIssue."Magazine Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Magazine Code';
                        Editable = false;
                    }
                    field(VolumeNo; MagazineVolumeIssue."Volume No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Volume No.';
                        Editable = false;
                    }
                    field(IssueNo; MagazineVolumeIssue."Issue No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Issue No.';
                        Editable = false;
                    }
                    field(IssueDate; MagazineVolumeIssue."Issue Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Issue Date';
                        Editable = false;
                    }
                    field(SalesInvNos; SalesInvNos)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Sales Invoice Nos.';
                        Editable = false;
                    }
                    field(tbxAdsProduct; AdsProduct)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ads. Product';
                        TableRelation = Brand;
                    }
                    field(tbxCombineInvDoc; CombineInvDoc)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Combine Invoice';
                        Editable = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        var
            Magazine: Record "Sub Product";
        begin
        end;

        trigger OnOpenPage()
        begin
            SalesInvNos := '';
            Clear(MagazineVolumeIssue);
            if AdsItemNo = '' then
                exit;
            MagazineVolumeIssue.SETPERMISSIONFILTER;
            MagazineVolumeIssue.SetRange("Magazine Code");
            MagazineVolumeIssue.SetRange("Ads. Item No.", AdsItemNo);
            MagazineVolumeIssue.Find('-');
            PostingDate := WorkDate;
            DocumentDate := WorkDate;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if SalesHeader."No." <> '' then begin // Not the first time
            FinalizeSalesHeader;
            if (NoOfSalesInvErrors = 0) and not HideDialog then begin
                Message(
                  Text003,
                  NoOfSalesInv);
            end else
                if not HideDialog then
                    Message(
                      Text002,
                      NoOfSalesInvErrors)
        end else
            if not HideDialog then
                Message(Text001);
    end;

    trigger OnPreReport()
    begin
        if not UserSetup.Get(UserId) then
            Clear(UserSetup);
        if not UserSetup."Allow Create Ads. Invoice" then
            Error(Text004);
        if BilltoCust = '' then
            Error(Text000, 'Bill-to Customer No.');
        /*
        IF AdsItemNo = '' THEN
          ERROR(Text000,'Ads. Item No.');
        IF ScheduleInvDate = 0D THEN
          ERROR(Text000,'Schedule Invoice Date');
        */
        if PostingDate = 0D then
            Error(Text000, 'Posting Date');
        if DocumentDate = 0D then
            Error(Text000, 'Document Date');
        AdsItemSetup.Get;
        AdsItemSetup.TestField("Ads. Sales Invoice Nos.");
        SalesInvNos := AdsItemSetup."Ads. Sales Invoice Nos.";
        AdsItemSetup.TestField("Posted Invoice Nos.");

    end;

    var
        AdsItemSetup: Record "Ads. Item Setup";
        UserSetup: Record "User Setup";
        Cust: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        AdsBookingLine: Record "Ads. Booking Line";
        Magazine: Record "Sub Product";
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        TempToLineDim: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextLineNo: Integer;
        NoOfSalesInv: Integer;
        NoOfSalesInvErrors: Integer;
        HideDialog: Boolean;
        Text000: label '%1 must be specify.';
        Text001: label 'There is nothing to create.';
        Text002: label 'Not all the invoices were posted. A total of %1 invoices were not posted.';
        AdsBookingNo: Code[20];
        AdsItemNo: Code[20];
        SelltoCust: Code[20];
        BilltoCust: Code[20];
        SalesInvNos: Code[10];
        AdsProduct: Code[20];
        CombineInvDoc: Boolean;
        Text003: label 'The sales invoice for ads. booking are now completed, and the number of invoice(s) created is %1.';
        Text004: label 'You do not have permission to create ads. sales invoice.';
        ScheduleInvDate: Date;
        PostingDate: Date;
        DocumentDate: Date;


    procedure InitRequest(_AdsBookingNo: Code[20]; _AdsItemNo: Code[20]; _SelltoCust: Code[20]; _BilltoCust: Code[20]; _AdsProd: Code[20]; CombineInv: Boolean)
    begin
        AdsBookingNo := _AdsBookingNo;
        AdsItemNo := _AdsItemNo;
        SelltoCust := _SelltoCust;
        BilltoCust := _BilltoCust;
        AdsProduct := _AdsProd;
        CombineInvDoc := CombineInv;
        ; // TODO Request//RequestOptionsPage.tbxAdsProduct.EDITABLE := FALSE;
        ; // TODO Request//RequestOptionsPage.tbxCombineInvDoc.EDITABLE := TRUE;
    end;

    local procedure FinalizeSalesHeader()
    begin
        with SalesHeader do begin
            SalesHeader.Find;
            //DimMgt.TransferTempToDimToDocDim(TempToLineDim);//VAH
            //COMMIT;
        end;
    end;

    local procedure InsertSalesHeader(xAdsBookingLine: Record "Ads. Booking Line")
    var
        Magazine: Record "Sub Product";
        Volume: Record Volume;
        IssueNo: Record "Issue No.";
    begin
        with SalesHeader do begin
            Init;
            "Document Type" := "document type"::Invoice;
            "No." := NoSeriesMgt.GetNextNo(SalesInvNos, WorkDate, true);
            Insert(true);
            SetHideValidationDialog(true); //do not warning message.
            Validate("Sell-to Customer No.", xAdsBookingLine."Sell-to Customer No.");
            Validate("Bill-to Customer No.", xAdsBookingLine."Bill-to Customer No.");
            Validate("Posting Date", PostingDate);
            Validate("Document Date", DocumentDate);
            Magazine.Get(xAdsBookingLine."Sub Product Code");
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            Validate("Zone Area", "Ads. Booking Header"."Zone Area");
            Validate("Salesperson Code", "Ads. Booking Header"."Salesperson Code");
            Validate("Ads. Sales Type", "Ads. Booking Header"."Client Type");
            Validate("Posting No. Series", AdsItemSetup."Posted Invoice Nos.");
            Modify;
            //COMMIT;
            NoOfSalesInv := NoOfSalesInv + 1;
        end;
    end;


    procedure InsertSalesLine(xAdsBookingLine: Record "Ads. Booking Line"; GLAcc: Code[20]; UnitPrice: Decimal)
    var
        Magazine: Record "Sub Product";
        Volume: Record Volume;
        IssueNo: Record "Issue No.";
        AdsPosition: Record "Ads. Position";
        AdsType: Record "Ads. Type";
        textDesc: Text[250];
    begin
        with SalesLine do begin
            SetRange("Document Type", SalesHeader."Document Type");
            SetRange("Document No.", SalesHeader."No.");
            Init;
            "Document Type" := SalesHeader."Document Type";
            "Document No." := SalesHeader."No.";
            NextLineNo += 10000;
            "Line No." := NextLineNo;
            AdsType.Get(xAdsBookingLine."Ads. Type");
            AdsType.TestField("Gen. Bus. Posting Group");
            Magazine.Get(xAdsBookingLine."Sub Product Code");
            Magazine.TestField("Default Gen. Prod. Posting");
            Validate(Type, SalesLine.Type::"G/L Account");
            Validate("No.", GLAcc);
            textDesc :=
              Description + '(' +
              xAdsBookingLine."Sub Product Code" + '-' +
              xAdsBookingLine."Volume No." + '-' +
              xAdsBookingLine."Issue No." + ')';
            Description := CopyStr(textDesc, 1, 50);
            "Description 2" := CopyStr(textDesc, 51, 50);
            Validate("Gen. Bus. Posting Group", AdsType."Gen. Bus. Posting Group");
            Validate("Gen. Prod. Posting Group", Magazine."Default Gen. Prod. Posting");
            Validate("VAT Prod. Posting Group", xAdsBookingLine."VAT Prod. Posting Group");
            Validate(Quantity, 1);
            Validate("Unit Price", UnitPrice);
            Insert(true);
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            Volume.Get(xAdsBookingLine."Volume No.");
            /*DimMgt.SaveDocDim(
              Database::"Sales Line",
              "document type"::Invoice,
              "Document No.","Line No.",
              3,Volume."Dimension 3 Code");
            IssueNo.Get(xAdsBookingLine."Issue No.");
            DimMgt.SaveDocDim(
              Database::"Sales Line",
              "document type"::Invoice,
              "Document No.","Line No.",
              4,IssueNo."Dimension 4 Code");*/
            AdsPosition.Get(xAdsBookingLine."Ads. Position Code");
            /*DimMgt.SaveDocDim(
              Database::"Sales Line",
              "document type"::Invoice,
              "Document No.","Line No.",
              5,AdsPosition."Shortcut Dimension 5 Code");*/
            "Ads. Sales Type" := "Ads. Booking Header"."Client Type";
            "Zone Area" := "Ads. Booking Header"."Zone Area";
            "Ads. Booking No." := xAdsBookingLine."Deal No.";
            "Ads. Booking Line No." := xAdsBookingLine."Line No.";
            Modify;
        end;
    end;
}

