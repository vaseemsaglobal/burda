Report 50023 "Create Subscriber Delivery"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   16.03.2007   KKE   New batchjob to create subscriber delivery - Subscription Module

    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("Subscriber Contract L/E"; "Subscriber Contract L/E")
        {
            DataItemTableView = sorting("Shipping Agent Code", "Delivered Flag") where("Paid Flag" = const(true), "Sales Order Flag" = const(false), "Delivered Flag" = const(false), "Reversed Flag" = const(false));

            dataitem("Subscriber Contract L/E2"; "Subscriber Contract L/E")
            {
                DataItemLink = "Subscriber Contract No." = field("Subscriber Contract No."), "Subscriber No." = field("Subscriber No."), "Magazine Code" = field("Magazine Code"), "Volume No." = field("Volume No.");
                DataItemTableView = sorting("Subscriber Contract No.", "Subscriber No.", "Magazine Code", "Volume No.", "Issue No.") where("Paid Flag" = const(true), "Delivered Flag" = const(false), "Sales Order Flag" = const(false), "Reversed Flag" = const(false));


                trigger OnAfterGetRecord()
                begin
                    InsertSalesLine("Subscriber Contract L/E2",
                      MagazineVolumeIssue.GetMagazineItemNo("Magazine Code", "Volume No.", "Issue No."),
                      true);
                end;

                trigger OnPreDataItem()
                begin
                    if not IncludeOlderthanMagazine then
                        CurrReport.Break;
                    SetFilter("Issue Date", '<%1', "Subscriber Contract L/E"."Issue Date");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SubscriberContract.Get("Subscriber Contract No.");
                if (SubscriberContract."Contract Status" <> SubscriberContract."contract status"::Released) or
                   (SubscriberContract."Payment Status" <> SubscriberContract."payment status"::Paid)
                then
                    CurrReport.Skip;
                if "Shipping Agent Code" <> Cust."No." then
                    Cust.Get("Shipping Agent Code");
                if not (Cust.Blocked in [Cust.Blocked::All, Cust.Blocked::Invoice]) then begin
                    TestField("Shipping Agent Code");
                    if ("Shipping Agent Code" <> SalesHeader."Sell-to Customer No.") or
                       ("Magazine Code" <> SubscriberContractLE."Magazine Code")
                    then begin
                        if SalesHeader."No." <> '' then
                            FinalizeSalesHeader;
                        InsertSalesHeader("Subscriber Contract L/E");
                        InsertSalesLine("Subscriber Contract L/E", MagazineItemNo, false);
                    end else
                        InsertSalesLine("Subscriber Contract L/E", MagazineItemNo, false);
                end else
                    NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
                if ("Magazine Code" <> SubscriberContractLE."Magazine Code") then
                    SubscriberContractLE := "Subscriber Contract L/E";
            end;

            trigger OnPreDataItem()
            begin
                if SubscriberNo <> '' then
                    SetRange("Subscriber No.", SubscriberNo);
                if ShippingAgentCode <> '' then
                    SetRange("Shipping Agent Code", ShippingAgentCode);
                SetRange("Magazine Code", MagazineVolumeIssue."Magazine Code");
                SetRange("Volume No.", MagazineVolumeIssue."Volume No.");
                SetRange("Issue No.", MagazineVolumeIssue."Issue No.");
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
                    field(SubscriberNo; SubscriberNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Subscriber No.';
                        TableRelation = Subscriber;
                    }
                    field(MagazineItemNo; MagazineItemNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Magazine Item No.';
                        TableRelation = Item where("Item Type" = const(Magazine));

                        trigger OnValidate()
                        var
                            Magazine: Record "Sub Product";
                        begin
                            SalesOrderNos := '';
                            Clear(MagazineVolumeIssue);
                            if MagazineItemNo = '' then
                                exit;
                            MagazineVolumeIssue.SETPERMISSIONFILTER;
                            MagazineVolumeIssue.SetRange("Magazine Item No.", MagazineItemNo);
                            MagazineVolumeIssue.Find('-');
                            Magazine.Get(MagazineVolumeIssue."Magazine Code");
                            Magazine.TestField("Subscriber S/O Nos.");
                            SalesOrderNos := Magazine."Subscriber S/O Nos.";
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
                    field(SalesOrderNos; SalesOrderNos)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Sales Order Nos.';
                        Editable = false;
                    }
                    field(IncludeOlderthanMagazine; IncludeOlderthanMagazine)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Older than Magazine';
                    }
                    field(ShippingAgentCode; ShippingAgentCode)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Shipping Agent Code';
                        TableRelation = Customer where("Shipping Agent" = const(true));
                    }
                }
            }
        }

        actions
        {
        }
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
        if MagazineItemNo = '' then
            Error(Text000);
        SubscriptionSetup.Get;
        SubscriptionSetup.TestField("Posted Invoice Nos.");
        SubscriptionSetup.TestField("Delivery Location Code");
    end;

    var
        SubscriptionSetup: Record "Subscription Setup";
        Cust: Record Customer;
        Subscriber: Record Subscriber;
        SubscriberContract: Record "Subscriber Contract";
        SubscriberContractLE: Record "Subscriber Contract L/E";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Item: Record Item;
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        TempToLineDim: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextLineNo: Integer;
        NoOfSalesInv: Integer;
        NoOfSalesInvErrors: Integer;
        HideDialog: Boolean;
        Text000: label 'Magazine Item No. must be specify.';
        Text001: label 'There is nothing to create.';
        Text002: label 'Not all the invoices were posted. A total of %1 invoices were not posted.';
        Text003: label 'The sales order for subscriber are now completed, and the number of order(s) created is %1.';
        SubscriberNo: Code[20];
        MagazineItemNo: Code[20];
        ShippingAgentCode: Code[20];
        IncludeOlderthanMagazine: Boolean;
        SalesOrderNos: Code[10];

    local procedure FinalizeSalesHeader()
    begin
        with SalesHeader do begin
            SalesHeader.Find;
            //DimMgt.TransferTempToDimToDocDim(TempToLineDim);//VAH
            //  COMMIT;
        end;
    end;

    local procedure InsertSalesHeader(xSubscriberContractLE: Record "Subscriber Contract L/E")
    var
        Magazine: Record "Sub Product";
        Volume: Record Volume;
        IssueNo: Record "Issue No.";
    begin
        with SalesHeader do begin
            Init;
            "Document Type" := "document type"::Order;
            "No." := NoSeriesMgt.GetNextNo(SalesOrderNos, WorkDate, true);
            Insert(true);
            Validate("Sell-to Customer No.", xSubscriberContractLE."Shipping Agent Code");
            Validate("Order Date", xSubscriberContractLE."Issue Date");
            Validate("Posting Date", xSubscriberContractLE."Issue Date");
            Magazine.Get(xSubscriberContractLE."Magazine Code");
            Magazine.TestField("Payment Method for Delivery");
            Validate("Payment Method Code", Magazine."Payment Method for Delivery");
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            Validate("Posting No. Series", SubscriptionSetup."Posted Invoice Nos.");
            if SubscriptionSetup."Delivery Location Code" <> '' then
                Validate("Location Code", SubscriptionSetup."Delivery Location Code");
            Modify;
            //  COMMIT;
            NoOfSalesInv := NoOfSalesInv + 1;
        end;
    end;


    procedure InsertSalesLine(xSubscriberContractLE: Record "Subscriber Contract L/E"; xMagazineItemNo: Code[20]; OldMagazine: Boolean)
    var
        Magazine: Record "Sub Product";
        Volume: Record Volume;
        IssueNo: Record "Issue No.";
        SubscriberContract: Record "Subscriber Contract";
    begin
        if xMagazineItemNo = '' then
            exit;
        with SalesLine do begin
            SetRange("Document Type", SalesHeader."Document Type");
            SetRange("Document No.", SalesHeader."No.");
            "Document Type" := SalesHeader."Document Type";
            "Document No." := SalesHeader."No.";
            NextLineNo += 10000;
            "Line No." := NextLineNo;
            Validate(Type, SalesLine.Type::Item);
            Validate("No.", xMagazineItemNo);
            Validate(Quantity, 1);
            Validate("Unit Price", xSubscriberContractLE."Unit Price");
            Validate("Subscriber Contract No.", xSubscriberContractLE."Subscriber Contract No.");
            Insert(true);
            Magazine.Get(xSubscriberContractLE."Magazine Code");
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            Volume.Get(xSubscriberContractLE."Volume No.");
            IssueNo.Get(xSubscriberContractLE."Issue No.");
            /*DimMgt.SaveDocDim(
              Database::"Sales Line",
              "document type"::Order,
              "Document No.", "Line No.",
              3, Volume."Dimension 3 Code");
            DimMgt.SaveDocDim(
              Database::"Sales Line",
              "document type"::Order,
              "Document No.", "Line No.",
              4, IssueNo."Dimension 4 Code");*///VAH
            Modify;
            xSubscriberContractLE."Sales Order Flag" := true;
            xSubscriberContractLE."Sales Order Date" := SalesHeader."Posting Date";  //issue date
            xSubscriberContractLE."Sales Order No." := "Document No.";
            xSubscriberContractLE."Sales Order Line No." := "Line No.";
            xSubscriberContractLE.Modify;
            if (not OldMagazine) and
               SubscriberContract.Get(xSubscriberContractLE."Subscriber Contract No.")
            then begin
                SubscriberContract."Last SO Doc. No." := "Document No.";
                SubscriberContract."Last SO Date" := SalesHeader."Posting Date";
                SubscriberContract."Last SO Magazine Item No." := MagazineItemNo;
                SubscriberContract.Modify;
            end;
        end;
    end;
}

