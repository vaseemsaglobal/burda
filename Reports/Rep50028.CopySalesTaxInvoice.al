Report 50028 "Copy Sales Tax Invoice"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   15.05.2007   KKE   Customized report to copy document for "Sales Tax Invoice/Receipt" - Ads. Sales Module

    Caption = 'Copy Sales Document';
    Permissions = TableData "Sales Invoice Line" = rm, TableData "Sales Cr.Memo Line" = rm;
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DocType; DocType)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Document Type';
                        OptionCaption = 'Posted Invoice,Posted Credit Memo';

                        trigger OnValidate()
                        begin
                            DocNo := '';
                            ValidateDocNo;
                        end;
                    }
                    field(DocNo; DocNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Document No.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            LookupDocNo;
                        end;

                        trigger OnValidate()
                        begin
                            ValidateDocNo;
                        end;
                    }
                    field(SelltoCustomerNo; FromSalesHeader."Sell-to Customer No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Sell-to Customer No.';
                        Editable = false;
                    }
                    field(SelltoCustomerName; FromSalesHeader."Sell-to Customer Name")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Sell-to Customer Name';
                        Editable = false;
                    }
                    field(IncludeHeader; IncludeHeader)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Header';

                        trigger OnValidate()
                        begin
                            ValidateIncludeHeader;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if DocNo <> '' then begin
                case DocType of
                    Doctype::"Posted Invoice":
                        if FromSalesInvHeader.Get(DocNo) then
                            FromSalesHeader.TransferFields(FromSalesInvHeader);
                    Doctype::"Posted Credit Memo":
                        if FromSalesCrMemoHeader.Get(DocNo) then
                            FromSalesHeader.TransferFields(FromSalesCrMemoHeader);
                end;
                if FromSalesHeader."No." = '' then
                    DocNo := '';
            end;
            ValidateDocNo;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        SalesSetup.Get;
        if SalesTaxInvHeader."No." <> '' then begin
            CopySalesTaxInvoice(SalesTaxInvHeader."No.");
        end else begin
            CopyDocMgt.SetProperties(
              IncludeHeader, RecalculateLines, false, false, false, SalesSetup."Exact Cost Reversing Mandatory", false);
            CopyDocMgt.CopySalesDoc(DocType, DocNo, SalesHeader);
            with SalesHeader do begin
                if ReplacePostDate or ReplaceDocDate then begin
                    if ReplacePostDate then
                        Validate("Posting Date", PostingDate);
                    if ReplaceDocDate then
                        Validate("Document Date", PostingDate);
                    Modify;
                end;
                GLSetup.Get;
                if ("Document Type" in ["document type"::"Credit Memo", "document type"::"Return Order"]) and
                   GLSetup.GSTEnabled(FromSalesHeader."Document Date")
                then begin
                    case DocType of
                        Doctype::"Posted Invoice":
                            begin
                                "Adjustment Applies-to" := FromSalesInvHeader."No.";
                                "BAS Adjustment" := BASManagementExt.CheckBASPeriod("Document Date", FromSalesInvHeader."Document Date");
                            end;
                        Doctype::"Posted Credit Memo":
                            begin
                                "Adjustment Applies-to" := FromSalesCrMemoHeader."No.";
                                "BAS Adjustment" := BASManagementExt.CheckBASPeriod("Document Date", FromSalesCrMemoHeader."Document Date");
                            end;
                    end;
                    Modify;
                end;
            end;
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        FromSalesHeader: Record "Sales Header";
        FromSalesShptHeader: Record "Sales Shipment Header";
        FromSalesInvHeader: Record "Sales Invoice Header";
        FromReturnRcptHeader: Record "Return Receipt Header";
        FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        GLSetup: Record "General Ledger Setup";
        PostCodeCheck: Codeunit "Post Code Check";
        PostCodeCheckExt: Codeunit "Cod50041.CU28000Ext";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        BASManagement: Codeunit "BAS Management";
        BASManagementExt: Codeunit "Cod50040.CU11601Ext";
        DocType: Option "Posted Invoice","Posted Credit Memo";
        DocNo: Code[20];
        IncludeHeader: Boolean;
        RecalculateLines: Boolean;
        ReplacePostDate: Boolean;
        ReplaceDocDate: Boolean;
        PostingDate: Date;
        SalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header";
        AdsSalesSetup: Record "Ads. Item Setup";


    procedure SetSalesTaxInvHeader(var NewSalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header")
    begin
        SalesTaxInvHeader := NewSalesTaxInvHeader;
        SalesTaxInvHeader.TestField("Issued Tax Invoice/Receipt", false);
        SalesTaxInvHeader.TestField("Cancel Tax Invoice", false);
    end;

    local procedure ValidateDocNo()
    begin
        if DocNo = '' then
            FromSalesHeader.Init
        else
            if FromSalesHeader."No." = '' then begin
                FromSalesHeader.Init;
                case DocType of
                    Doctype::"Posted Invoice":
                        begin
                            FromSalesInvHeader.Get(DocNo);
                            FromSalesHeader.TransferFields(FromSalesInvHeader);
                            PostCodeCheckExt.CopyAllAddressID(
                              Database::"Sales Invoice Header", FromSalesInvHeader.GetPosition,
                              Database::"Sales Header", FromSalesHeader.GetPosition);
                        end;
                    Doctype::"Posted Credit Memo":
                        begin
                            FromSalesCrMemoHeader.Get(DocNo);
                            FromSalesHeader.TransferFields(FromSalesCrMemoHeader);
                            PostCodeCheckExt.CopyAllAddressID(
                              Database::"Sales Cr.Memo Header", FromSalesCrMemoHeader.GetPosition,
                              Database::"Sales Header", FromSalesHeader.GetPosition);
                        end;
                end;
            end;
        FromSalesHeader."No." := '';
        IncludeHeader :=
          (DocType = Doctype::"Posted Invoice") and (SalesTaxInvHeader."Sell-to Customer No." = '');
        ValidateIncludeHeader;
    end;

    local procedure LookupDocNo()
    begin
        AdsSalesSetup.Get;
        case DocType of
            Doctype::"Posted Invoice":
                begin
                    FromSalesInvHeader."No." := DocNo;
                    if SalesTaxInvHeader."Sell-to Customer No." <> '' then
                        if FromSalesInvHeader.SetCurrentkey("Sell-to Customer No.") then begin
                            FromSalesInvHeader.SetRange("Sell-to Customer No.", SalesTaxInvHeader."Sell-to Customer No.");
                            if FromSalesInvHeader.Find('=><') then;
                        end;
                    //IF AdsSalesSetup."Posted Invoice Nos." <> '' THEN
                    //  FromSalesInvHeader.SETRANGE("No. Series",AdsSalesSetup."Posted Invoice Nos.");
                    if Page.RunModal(0, FromSalesInvHeader) = Action::LookupOK then
                        DocNo := FromSalesInvHeader."No.";
                end;
            Doctype::"Posted Credit Memo":
                begin
                    FromSalesCrMemoHeader."No." := DocNo;
                    if SalesTaxInvHeader."Sell-to Customer No." <> '' then
                        if FromSalesCrMemoHeader.SetCurrentkey("Sell-to Customer No.") then begin
                            FromSalesCrMemoHeader.SetRange("Sell-to Customer No.", SalesTaxInvHeader."Sell-to Customer No.");
                            if FromSalesCrMemoHeader.Find('=><') then;
                        end;
                    //IF AdsSalesSetup."Posted Invoice Nos." <> '' THEN
                    //  FromSalesInvHeader.SETRANGE("No. Series",AdsSalesSetup."Posted Invoice Nos.");
                    if Page.RunModal(0, FromSalesCrMemoHeader) = Action::LookupOK then
                        DocNo := FromSalesCrMemoHeader."No.";
                end;
        end;
        ValidateDocNo;
    end;

    local procedure ValidateIncludeHeader()
    begin
        RecalculateLines := not IncludeHeader;
    end;


    procedure CopySalesTaxInvoice(SalesTaxInvNo: Code[20])
    var
        SalesTaxInvLine: Record "Sales Tax Invoice/Rec. Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShipHeader: Record "Sales Shipment Header";
        SalesShipLine: Record "Sales Shipment Line";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        FromPostedDocDim: Record "Dimension Set Entry";
        ToPostedDocDim: Record "Dimension Set Entry";
        DimMgt: Codeunit DimensionManagement;
        LineNo: Integer;
        SalesInvLine2: Record "Sales Invoice Line";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
    begin
        LineNo := 0;
        SalesTaxInvLine.LockTable;
        SalesTaxInvLine.Reset;
        SalesTaxInvLine.SetRange("Document No.", SalesTaxInvNo);
        if SalesTaxInvLine.Find('+') then
            LineNo := SalesTaxInvLine."Line No.";
        case DocType of
            Doctype::"Posted Invoice":
                begin
                    if SalesInvHeader.Get(DocNo) then begin
                        if IncludeHeader then begin
                            SalesTaxInvHeader.TransferFields(SalesInvHeader);
                            SalesTaxInvHeader."No." := SalesTaxInvNo;
                            SalesTaxInvHeader."Dimension Set ID" := SalesInvHeader."Dimension Set ID";//VAH
                            SalesTaxInvHeader.Modify;
                            /*CopyPostedDocDimToPostedDocDim(
                              Database::"Sales Invoice Header", DocNo, 0,
                              Database::"Sales Tax Invoice/Rec. Header", SalesTaxInvNo, 0);*/
                        end;
                        SalesInvLine.Reset;
                        SalesInvLine.SetRange("Document No.", DocNo);
                        SalesInvLine.SetRange("Sales Tax Invoice/Receipt No.", '');
                        if SalesInvLine.Find('-') then begin
                            repeat
                                SalesTaxInvLine.TransferFields(SalesInvLine);
                                SalesTaxInvLine."Document No." := SalesTaxInvNo;
                                LineNo += 10000;
                                SalesTaxInvLine."Line No." := LineNo;
                                SalesTaxInvLine."Sell-to Customer No." := SalesInvHeader."Sell-to Customer No.";
                                SalesTaxInvLine."Posted Document Type" := SalesTaxInvLine."posted document type"::Invoice;
                                SalesTaxInvLine."Posted Document No." := SalesInvHeader."No.";
                                SalesTaxInvLine."Posted Document Line No." := SalesInvLine."Line No.";
                                SalesTaxInvLine."Dimension Set ID" := SalesInvLine."Dimension Set ID";//VAH
                                SalesTaxInvLine.Insert;
                                /*CopyPostedDocDimToPostedDocDim(
                                  Database::"Sales Invoice Line", DocNo, SalesInvLine."Line No.",
                                  Database::"Sales Tax Invoice/Rec. Line", SalesTaxInvNo, LineNo);*/
                                SalesInvLine2.Get(SalesInvLine."Document No.", SalesInvLine."Line No.");
                                SalesInvLine2."Sales Tax Invoice/Receipt No." := SalesTaxInvLine."Document No.";
                                SalesInvLine2."Sales Tax Invoice/Receipt Line" := SalesTaxInvLine."Line No.";
                                SalesInvLine2.Modify;
                            until SalesInvLine.Next = 0;
                        end;
                    end;
                end;
            Doctype::"Posted Credit Memo":
                begin
                    if SalesCrMemoHeader.Get(DocNo) then begin
                        if IncludeHeader then begin
                            SalesTaxInvHeader.TransferFields(SalesCrMemoHeader);
                            SalesTaxInvHeader."No." := SalesTaxInvNo;
                            SalesTaxInvHeader."Dimension Set ID" := SalesCrMemoHeader."Dimension Set ID";//VAH
                            SalesTaxInvHeader.Modify;
                            /*CopyPostedDocDimToPostedDocDim(
                              Database::"Sales Cr.Memo Header", DocNo, 0,
                              Database::"Sales Tax Invoice/Rec. Header", SalesTaxInvNo, 0);*/
                        end;
                        SalesCrMemoLine.Reset;
                        SalesCrMemoLine.SetRange("Document No.", DocNo);
                        SalesCrMemoLine.SetRange("Sales Tax Invoice/Receipt No.", '');
                        if SalesCrMemoLine.Find('-') then begin
                            repeat
                                SalesTaxInvLine.TransferFields(SalesCrMemoLine);
                                SalesTaxInvLine."Document No." := SalesTaxInvNo;
                                if LineNo <> 0 then begin
                                    LineNo += 10000;
                                    SalesTaxInvLine."Line No." := LineNo;
                                end;
                                SalesTaxInvLine."Sell-to Customer No." := SalesCrMemoHeader."Sell-to Customer No.";
                                SalesTaxInvLine."Posted Document Type" := SalesTaxInvLine."posted document type"::"Credit Memo";
                                SalesTaxInvLine."Posted Document No." := SalesCrMemoHeader."No.";
                                SalesTaxInvLine."Posted Document Line No." := SalesCrMemoLine."Line No.";
                                SalesTaxInvLine.Quantity := -SalesTaxInvLine.Quantity;
                                SalesTaxInvLine."Line Amount" := -SalesTaxInvLine."Line Amount";
                                SalesTaxInvLine.Amount := -SalesTaxInvLine.Amount;
                                SalesTaxInvLine."Amount Including VAT" := -SalesTaxInvLine."Amount Including VAT";
                                SalesTaxInvLine."Dimension Set ID" := SalesCrMemoLine."Dimension Set ID";//VAH
                                SalesTaxInvLine.Insert;
                                /*CopyPostedDocDimToPostedDocDim(
                                  Database::"Sales Cr.Memo Line", DocNo, SalesCrMemoLine."Line No.",
                                  Database::"Sales Tax Invoice/Rec. Line", SalesTaxInvNo, LineNo);*/
                                SalesCrMemoLine2.Get(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.");
                                SalesCrMemoLine2."Sales Tax Invoice/Receipt No." := SalesTaxInvLine."Document No.";
                                SalesCrMemoLine2."Sales Tax Invoice/Receipt Line" := SalesTaxInvLine."Line No.";
                                SalesCrMemoLine2.Modify;
                            until SalesCrMemoLine.Next = 0;
                        end;
                    end;
                end;
        end;
    end;


    /*  procedure CopyDocDimToPostedDocDim(FromTableNo: Integer; FromDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; FromDocNo: Code[20]; FromLineNo: Integer; ToTableNo: Integer; ToDocNo: Code[20]; ToLineNo: Integer)
      var
          FromDocDim: Record "Dimension Set Entry";
          ToPostedDocDim: Record "Dimension Set Entry";
      begin
          FromDocDim.Reset;
          FromDocDim.SetRange("Table ID", FromTableNo);
          FromDocDim.SetRange("Document Type", FromDocType);
          FromDocDim.SetRange("Document No.", FromDocNo);
          FromDocDim.SetRange("Line No.", FromLineNo);
          if FromDocDim.Find('-') then
              repeat
                  ToPostedDocDim.TransferFields(FromDocDim);
                  ToPostedDocDim."Table ID" := ToTableNo;
                  ToPostedDocDim."Document No." := ToDocNo;
                  ToPostedDocDim."Line No." := ToLineNo;
                  ToPostedDocDim.Insert;
              until FromDocDim.Next = 0;
      end;


      procedure CopyPostedDocDimToPostedDocDim(FromTableNo: Integer; FromDocNo: Code[20]; FromLineNo: Integer; ToTableNo: Integer; ToDocNo: Code[20]; ToLineNo: Integer)
      var
          FromPostedDocDim: Record "Dimension Set Entry";
          ToPostedDocDim: Record "Dimension Set Entry";
      begin
          FromPostedDocDim.Reset;
          FromPostedDocDim.SetRange("Table ID", FromTableNo);
          FromPostedDocDim.SetRange("Document No.", FromDocNo);
          FromPostedDocDim.SetRange("Line No.", FromLineNo);
          if FromPostedDocDim.Find('-') then
              repeat
                  ToPostedDocDim := FromPostedDocDim;
                  ToPostedDocDim."Table ID" := ToTableNo;
                  ToPostedDocDim."Document No." := ToDocNo;
                  ToPostedDocDim."Line No." := ToLineNo;
                  ToPostedDocDim.Insert;
              until FromPostedDocDim.Next = 0;
      end;
      */
}

