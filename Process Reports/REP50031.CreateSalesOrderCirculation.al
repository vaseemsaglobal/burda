Report 50031 "Create Sales Order Circulation"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   23.04.2007   KKE   New batchjob to create sales order circulation - Circulation Module
    //                          Separate "Sales Order" by "Sell-to Cust No." and "Bill-to Cust No.".
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Agent Customer Header"; "Agent Customer Header")
        {
            DataItemTableView = sorting("No.");
            column(ReportForNavId_1; 1)
            {
            }
            dataitem("Agent Customer Line"; "Agent Customer Line")
            {
                DataItemLink = "Agent Customer No." = field("No.");
                DataItemTableView = sorting("Sell-to Customer No.", "Bill-to Customer No.") where("Delivered Flag" = const(false));

                trigger OnPreDataItem()
                begin
                    if CustNo <> '' then
                        SetRange("Sell-to Customer No.", CustNo);
                    clear(SellToCust);
                end;

                trigger OnAfterGetRecord()

                begin
                    if SellToCust <> "Agent Customer Line"."Sell-to Customer No." then begin
                        SellToCust := "Agent Customer Line"."Sell-to Customer No.";

                        IF "Sell-to Customer No." <> Cust."No." THEN
                            Cust.GET("Sell-to Customer No.");
                        IF NOT (Cust.Blocked IN [Cust.Blocked::All, Cust.Blocked::Invoice]) THEN BEGIN
                            TESTFIELD("Sell-to Customer No.");
                            IF "Sell-to Customer No." <> SalesHeader."Sell-to Customer No." THEN BEGIN
                                IF SalesHeader."No." <> '' THEN
                                    FinalizeSalesHeader;
                                InsertSalesHeader("Agent Customer Header", "Agent Customer Line");
                                InsertSalesLine("Agent Customer Header", "Agent Customer Line");
                            END ELSE
                                InsertSalesLine("Agent Customer Header", "Agent Customer Line");
                        END ELSE
                            NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin
                if DocNo <> '' then
                    SetRange("No.", DocNo);
                if SalespersonCode <> '' then
                    SetRange("Salesperson Code", SalespersonCode);
                SetRange("Magazine Code", Item."Magazine Code");
                SetRange("Volume No.", Item."Volume No.");
                SetRange("Issue No.", Item."Issue No.");
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
                    field(DocNo; DocNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Document No.';
                        TableRelation = "Agent Customer Header";
                    }
                    field(CustNo; CustNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Customer No.';
                        TableRelation = Customer;

                        trigger OnValidate()
                        begin
                            if not Cust.Get(CustNo) then
                                Clear(Cust);
                            CustPostingGroup := Cust."Customer Posting Group";
                        end;
                    }
                    field(CustPostingGroup; CustPostingGroup)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Customer Posting Group';
                        Editable = false;
                        TableRelation = "Customer Posting Group";
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
                            if not Item.Get(MagazineItemNo) then begin
                                Clear(Item);
                                exit;
                            end;
                            Magazine.Get(Item."Magazine Code");
                            Magazine.TestField("Circulation S/O Nos.");
                            SalesOrderNos := Magazine."Circulation S/O Nos.";
                        end;
                    }
                    field(MagazineCode; Item."Magazine Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Magazine Code';
                        Editable = false;
                    }
                    field(VolumeNo; Item."Volume No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Volume No.';
                        Editable = false;
                    }
                    field(IssueNo; Item."Issue No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Issue No.';
                        Editable = false;
                    }
                    field(IssueDate; Item."Issue Date")
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
                    field(SalespersonCode; SalespersonCode)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Salesperson Code';
                        TableRelation = "Salesperson/Purchaser";
                    }
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Posting Date';
                    }
                    field(DocumentDate; DocumentDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Document Date';
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
            Error(Text000, 'Magazine Item No.');
        if PostingDate = 0D then
            Error(Text000, 'Posting Date');
        if DocumentDate = 0D then
            Error(Text000, 'document Date');
        MagazineSalesSetup.Get;
        MagazineSalesSetup.TestField("Posted Invoice Nos.");
    end;

    var
        MagazineSalesSetup: Record "Magazine Sales Setup";
        Cust: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Item: Record Item;
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
        Text003: label 'The sales order for agent customer are now completed, and the number of order(s) created is %1.';
        DocNo: Code[20];
        CustNo: Code[20];
        CustPostingGroup: Code[10];
        MagazineItemNo: Code[20];
        SalespersonCode: Code[20];
        SalesOrderNos: Code[10];
        PostingDate: Date;
        DocumentDate: Date;
        SellToCust: Code[20];

    local procedure FinalizeSalesHeader()
    begin
        with SalesHeader do begin
            SalesHeader.Find;
            //DimMgt.TransferTempToDimToDocDim(TempToLineDim); //VAH
            //  COMMIT;
        end;
    end;

    local procedure InsertSalesHeader(xAgentCustHeader: Record "Agent Customer Header"; xAgentCustLine: Record "Agent Customer Line")
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
            Validate("Sell-to Customer No.", xAgentCustLine."Sell-to Customer No.");
            if (xAgentCustLine."Bill-to Customer No." <> xAgentCustLine."Sell-to Customer No.") and
               (xAgentCustLine."Bill-to Customer No." <> '')
            then
                Validate("Bill-to Customer No.", "Agent Customer Line"."Bill-to Customer No.");
            Validate("Posting Date", PostingDate);
            Validate("Order Date", PostingDate);
            Validate("Document Date", DocumentDate);
            Validate("Location Code", xAgentCustHeader."Location Code");
            Magazine.Get(xAgentCustHeader."Magazine Code");
            //  Magazine.TESTFIELD("Payment Method for Delivery");
            //  VALIDATE("Payment Method Code",Magazine."Payment Method for Delivery");
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            Validate("Posting No. Series", MagazineSalesSetup."Posted Invoice Nos.");
            Modify;
            //  COMMIT;
            NoOfSalesInv := NoOfSalesInv + 1;
        end;
    end;


    procedure InsertSalesLine(xAgentCustHeader: Record "Agent Customer Header"; xAgentCustLine: Record "Agent Customer Line")
    var
        AgentCustLine: Record "Agent Customer Line";
        Magazine: Record "Sub Product";
        Volume: Record Volume;
        IssueNo: Record "Issue No.";
    begin
        if xAgentCustLine."Line Amount" = 0 then
            exit;
        AgentCustLine.Reset;
        AgentCustLine.SetRange("Agent Customer No.", xAgentCustLine."Agent Customer No.");
        AgentCustLine.SetRange("Sell-to Customer No.", xAgentCustLine."Sell-to Customer No.");
        AgentCustLine.SetRange("Bill-to Customer No.", xAgentCustLine."Bill-to Customer No.");
        if AgentCustLine.Find('-') then
            repeat
                with SalesLine do begin
                    Init;
                    "Document Type" := SalesHeader."Document Type";
                    "Document No." := SalesHeader."No.";
                    NextLineNo += 10000;
                    "Line No." := NextLineNo;
                    Validate(Type, SalesLine.Type::Item);
                    Validate("No.", xAgentCustHeader."Magazine Item No.");
                    Validate(Quantity, AgentCustLine.Quantity);
                    Validate("Unit Price", AgentCustLine."Unit Price");
                    Validate("Line Discount %", AgentCustLine."Discount %");
                    Validate(SalesLine."Agent Customer No.", AgentCustLine."Agent Customer No.");
                    Insert(true);
                    Magazine.Get(xAgentCustHeader."Magazine Code");
                    Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
                    Volume.Get(xAgentCustHeader."Volume No.");
                    IssueNo.Get(xAgentCustHeader."Issue No.");
                    /*DimMgt.SaveDocDim(
                      Database::"Sales Line",
                      "document type"::Order,
                      "Document No.","Line No.",
                      3,Volume."Dimension 3 Code");
                    DimMgt.SaveDocDim(
                      Database::"Sales Line",
                      "document type"::Order,
                      "Document No.","Line No.",
                      4,IssueNo."Dimension 4 Code");*/
                    Modify;
                    AgentCustLine."Delivered Flag" := true;
                    AgentCustLine."Delivered Date" := Today;
                    AgentCustLine."Delivered Document No." := "Document No.";
                    AgentCustLine."Delivered Document Line No." := "Line No.";
                    AgentCustLine.Modify;
                end;
            until AgentCustLine.Next = 0;
    end;


}

