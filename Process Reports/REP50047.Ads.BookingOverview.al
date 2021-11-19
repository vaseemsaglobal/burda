Report 50047 "Ads. Booking Overview"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   09.05.2007   KKE   New report for "Ads. Booking Overview" - Ads. Sales Module

    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number);
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then begin
                    AdsBufferTemp.Find('-');
                    ColumnWidth := 8;
                end else begin
                    AdsBufferTemp.Next;
                    ColumnWidth := 0;
                end;
                with AdsBufferTemp do begin
                    if SendToExcel then begin
                        RowNo += 1;
                        RowHeight := 50;
                        EnterCell(RowNo, 1, "Issue No.", false, false, true, true);
                        RowHeight := 0;
                        EnterCell(RowNo, 2, Name, false, false, true, true);
                        i := 2;
                        case ShowAsColumn of
                            Showascolumn::"Ads. Position":
                                begin
                                    if AdsBufferTemp."Magazine Code Filter" <> '' then
                                        AdsPosition.SetFilter("Magazine Code", AdsBufferTemp."Magazine Code Filter");
                                    AdsPosition.Find('-');
                                    repeat
                                        i += 1;
                                        EnterCell(RowNo, i, GetData(AdsBufferTemp, AdsPosition.Code), false, false, true, true);
                                    until AdsPosition.Next = 0;
                                end;
                            Showascolumn::"Ads. Size":
                                begin
                                    AdsSize.Find('-');
                                    repeat
                                        i += 1;
                                        EnterCell(RowNo, i, GetData(AdsBufferTemp, AdsSize.Code), false, false, true, true);
                                    until AdsSize.Next = 0;
                                end;
                            Showascolumn::"Revenue Type":
                                begin
                                    RevenueType.Find('-');
                                    repeat
                                        i += 1;
                                        EnterCell(RowNo, i, GetData(AdsBufferTemp, RevenueType.Code), false, false, true, true);
                                    until RevenueType.Next = 0;
                                end;
                            Showascolumn::"Ads. Type":
                                begin
                                    AdsType.Find('-');
                                    repeat
                                        i += 1;
                                        EnterCell(RowNo, i, GetData(AdsBufferTemp, AdsType.Code), false, false, true, true);
                                    until AdsType.Next = 0;
                                end;
                        end;
                        EnterCell(RowNo, i + 1, '', false, false, false, true);
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, AdsBufferTemp.Count);
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
                    field(MagazineFilter; MagazineFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Magazine Code';
                        Editable = false;
                        TableRelation = "Sub Product";
                    }
                    field(ShowAsColumn; ShowAsColumn)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show as Columns';
                        Editable = false;
                    }
                    field(VolumeFilter; VolumeFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Volume No.';
                        Editable = false;
                        TableRelation = Volume;
                    }
                    field(ShowColumnName; ShowColumnName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Column Name';
                        Editable = false;
                    }
                    field(StBooking; StBooking)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Booking';
                        Editable = false;
                    }
                    field(StWaitingList; StWaitingList)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Waiting List';
                        Editable = false;
                    }
                    field(IssueNoFilter; IssueNoFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Issue No.';
                        Editable = false;
                        TableRelation = "Issue No.";
                    }
                    field(StConfirmed; StConfirmed)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Confirmed';
                        Editable = false;
                    }
                    field(RevenueTypeFilter; RevenueTypeFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Revenue Type';
                        Editable = false;
                        TableRelation = "Booking Revenue Type";
                    }
                    field(StApproved; StApproved)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Approved';
                        Editable = false;
                    }
                    field(AdsSizeFilter; AdsSizeFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ads. Size';
                        Editable = false;
                        TableRelation = "Ads. Size";
                    }
                    field(StHold; StHold)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Hold';
                        Editable = false;
                    }
                    field(StCancelled; StCancelled)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cancelled';
                        Editable = false;
                    }
                    field(Dim2Filter; AdsPositionFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ads. Position';
                        Editable = false;
                        TableRelation = "Ads. Position";
                    }
                    field(StInvoiced; StInvoiced)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Invoiced';
                        Editable = false;
                    }
                    field(AdsTypeFilter; AdsTypeFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ads. Type';
                        Editable = false;
                        TableRelation = "Ads. Type";
                    }
                    field(StClosed; StClosed)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Closed';
                        Editable = false;
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

    trigger OnInitReport()
    begin
        SendToExcel := true;
    end;

    trigger OnPostReport()
    begin
        if SendToExcel then begin
            Window.Close;
            /*
            IF Option = Option::"Update Workbook" THEN BEGIN
              TempExcelBuffer.OpenBook(FileName,SheetName);
              TempExcelBuffer.CreateSheet(SheetName,'',COMPANYNAME,USERID);
            END ELSE BEGIN
            */
            TempExcelBuffer.CreateNewBook('Ads. Booking Overview');
            TempExcelBuffer.writeSheet('Ads. Sales', COMPANYNAME, UserId);
            //END;
            //TempExcelBuffer.GiveUserControl;
        end;

    end;

    trigger OnPreReport()
    begin
        if SendToExcel then begin
            Window.Open(
              Text000 +
              '@1@@@@@@@@@@@@@@@@@@@@@\');
            Window.Update(1, 0);
            TempExcelBuffer.DeleteAll;
            Clear(TempExcelBuffer);
            AdsBufferTemp.Find('-');
            NoOfCol := 0;
            //Header
            EnterCell(1, 2, 'Ads. Booking Overview', true, false, false, false);
            EnterCell(2, 2, 'Magazine Code : ' + MagazineFilter, false, false, false, false);
            EnterCell(3, 2, 'Volume No. : ' + VolumeFilter, false, false, false, false);
            EnterCell(4, 2, 'Issue No. : ' + IssueNoFilter, false, false, false, false);
            EnterCell(5, 2, 'Revenue Type : ' + RevenueTypeFilter, false, false, false, false);
            EnterCell(6, 2, 'Ads. Size : ' + AdsSizeFilter, false, false, false, false);
            EnterCell(7, 2, 'Ads. Position : ' + AdsPositionFilter, false, false, false, false);
            EnterCell(8, 2, 'Include Line Status : ' + AdsBufferTemp.Status, false, false, false, false);
            for i := 1 to 2 do
                EnterCell(9, i, '', false, false, true, false);
            EnterCell(10, 1, 'Issue No.', false, false, true, true);
            EnterCell(10, 2, 'Name', false, false, true, true);
            case ShowAsColumn of
                Showascolumn::"Ads. Position":
                    begin
                        i := 2;
                        if AdsBufferTemp."Magazine Code Filter" <> '' then
                            AdsPosition.SetFilter("Magazine Code", AdsBufferTemp."Magazine Code Filter");
                        NoOfCol := AdsPosition.Count;
                        AdsPosition.Find('-');
                        repeat
                            i += 1;
                            EnterCell(9, i, '', false, false, true, false);
                            if ShowColumnName then
                                EnterCell(10, i, AdsPosition.Description, false, false, true, true)
                            else
                                EnterCell(10, i, AdsPosition.Code, false, false, true, true)
                        until AdsPosition.Next = 0;
                    end;
                Showascolumn::"Ads. Size":
                    begin
                        i := 2;
                        NoOfCol := AdsSize.Count;
                        AdsSize.Find('-');
                        repeat
                            i += 1;
                            EnterCell(9, i, '', false, false, true, false);
                            if ShowColumnName then
                                EnterCell(10, i, AdsSize.Description, false, false, true, true)
                            else
                                EnterCell(10, i, AdsSize.Code, false, false, true, true)
                        until AdsSize.Next = 0;
                    end;
                Showascolumn::"Revenue Type":
                    begin
                        i := 2;
                        NoOfCol := RevenueType.Count;
                        RevenueType.Find('-');
                        repeat
                            i += 1;
                            EnterCell(9, i, '', false, false, true, false);
                            if ShowColumnName then
                                EnterCell(10, i, RevenueType.Description, false, false, true, true)
                            else
                                EnterCell(10, i, RevenueType.Code, false, false, true, true)
                        until RevenueType.Next = 0;
                    end;
                Showascolumn::"Ads. Type":
                    begin
                        i := 2;
                        NoOfCol := AdsType.Count;
                        AdsType.Find('-');
                        repeat
                            i += 1;
                            EnterCell(9, i, '', false, false, true, false);
                            if ShowColumnName then
                                EnterCell(10, i, AdsType.Description, false, false, true, true)
                            else
                                EnterCell(10, i, AdsType.Code, false, false, true, true)
                        until AdsType.Next = 0;
                    end;
            end;
            EnterCell(10, NoOfCol + 3, '', false, false, false, true);
            RowNo := 10;
        end;
        i := 0;
    end;

    var
        AdsBufferTemp: Record "Ads. Booking Overview Buffer" temporary;
        AdsPosition: Record "Ads. Position";
        AdsSize: Record "Ads. Size";
        AdsType: Record "Ads. Type";
        RevenueType: Record "Booking Revenue Type";
        Salesperson: Record "Salesperson/Purchaser";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        MagazineFilter: Code[250];
        VolumeFilter: Code[20];
        IssueNoFilter: Code[20];
        RevenueTypeFilter: Code[20];
        AdsSizeFilter: Code[20];
        AdsTypeFilter: Code[20];
        AdsPositionFilter: Code[20];
        StBooking: Boolean;
        StWaitingList: Boolean;
        StConfirmed: Boolean;
        StApproved: Boolean;
        StHold: Boolean;
        StCancelled: Boolean;
        StInvoiced: Boolean;
        StClosed: Boolean;
        ShowColumnName: Boolean;
        ShowAsColumn: Option "Ads. Position","Ads. Size","Revenue Type","Ads. Type";
        Window: Dialog;
        RowNo: Integer;
        SendToExcel: Boolean;
        Text000: label 'Analyzing Data...\\';
        i: Integer;
        NoOfCol: Integer;
        NewLine: label '';
        ColumnWidth: Decimal;
        RowHeight: Decimal;
        st: label '''';


    procedure InitRequest(var AdsBuffer: Record "Ads. Booking Overview Buffer")
    begin
        AdsBufferTemp.Init;
        AdsBufferTemp := AdsBuffer;
        AdsBufferTemp.Insert;
        AdsBufferTemp.CopyFilters(AdsBuffer);
    end;


    procedure InitRequest2(_MagazineFilter: Code[250]; _VolumeFilter: Code[20]; _IssueNoFilter: Code[20]; _RevenueTypeFilter: Code[20]; _AdsSizeFilter: Code[20]; _AdsTypeFilter: Code[20]; _AdsPositionFilter: Code[20]; _StBooking: Boolean; _StWaitingList: Boolean; _StConfirmed: Boolean; _StApproved: Boolean; _StHold: Boolean; _StCancelled: Boolean; _StInvoiced: Boolean; _StClosed: Boolean; _ShowColumnName: Boolean; _ShowAsColumn: Option "Ads. Position","Ads. Size","Revenue Type")
    begin
        MagazineFilter := _MagazineFilter;
        VolumeFilter := _VolumeFilter;
        IssueNoFilter := _IssueNoFilter;
        RevenueTypeFilter := _RevenueTypeFilter;
        AdsSizeFilter := _AdsSizeFilter;
        AdsTypeFilter := _AdsTypeFilter;
        AdsPositionFilter := _AdsPositionFilter;
        StBooking := _StBooking;
        StWaitingList := _StWaitingList;
        StConfirmed := _StConfirmed;
        StApproved := _StApproved;
        StHold := _StHold;
        StCancelled := _StCancelled;
        StInvoiced := _StInvoiced;
        StClosed := _StClosed;
        ShowColumnName := _ShowColumnName;
        ShowAsColumn := _ShowAsColumn;
    end;

    local procedure GetData(var AdsBuff: Record "Ads. Booking Overview Buffer"; ColumnCode: Code[20]): Text[250]
    var
        AdsBookingLine: Record "Ads. Booking Line";
        AdsProduct: Record Brand;
        Qty: Decimal;
    begin
        Qty := 0;
        with AdsBuff do begin
            AdsBookingLine.Reset;
            AdsBookingLine.SetCurrentkey("Sub Product Code", "Volume No.", "Issue No.", "Line Status",
              "Ads. Type code (Revenue type Code)", "Ads. Size Code", "Ads. Type", "Ads. Position Code", "Salesperson Code");
            if "Magazine Code Filter" <> '' then
                AdsBookingLine.SetRange("Sub Product Code", "Magazine Code Filter");
            if "Volume No. Filter" <> '' then
                AdsBookingLine.SetRange("Volume No.", "Volume No. Filter");
            if "Issue No. Filter" <> '' then
                AdsBookingLine.SetRange("Issue No.", "Issue No. Filter");
            Copyfilter("Line Status Filter", AdsBookingLine."Line Status");
            if (ShowAsColumn = Showascolumn::"Ads. Size") and (ColumnCode <> '') then begin
                if "Ads. Size Filter" <> '' then
                    AdsBookingLine.SetFilter("Ads. Size Code", '%1&%2', ColumnCode, "Ads. Size Filter")
                else
                    AdsBookingLine.SetRange("Ads. Size Code", ColumnCode);
            end else
                if "Ads. Size Filter" <> '' then
                    AdsBookingLine.SetRange("Ads. Size Code", "Ads. Size Filter");
            if (ShowAsColumn = Showascolumn::"Ads. Type") and (ColumnCode <> '') then begin
                if "Ads. Type Filter" <> '' then
                    AdsBookingLine.SetFilter("Ads. Type", '%1&%2', ColumnCode, "Ads. Type Filter")
                else
                    AdsBookingLine.SetRange("Ads. Type", ColumnCode);
            end else
                if "Ads. Type Filter" <> '' then
                    AdsBookingLine.SetRange("Ads. Type", "Ads. Type Filter");
            if (ShowAsColumn = Showascolumn::"Ads. Position") and (ColumnCode <> '') then begin
                if "Ads. Position Filter" <> '' then
                    AdsBookingLine.SetFilter("Ads. Position Code", '%1&%2', ColumnCode, "Ads. Position Filter")
                else
                    AdsBookingLine.SetRange("Ads. Position Code", ColumnCode);
            end else
                if "Ads. Position Filter" <> '' then
                    AdsBookingLine.SetRange("Ads. Position Code", "Ads. Position Filter");
            if (ShowAsColumn = Showascolumn::"Revenue Type") and (ColumnCode <> '') then begin
                if "Booking Revenue Code Filter" <> '' then
                    AdsBookingLine.SetFilter("Ads. Type code (Revenue type Code)", '%1&%2', ColumnCode, "Booking Revenue Code Filter")
                else
                    AdsBookingLine.SetFilter("Ads. Type code (Revenue type Code)", ColumnCode);
            end else
                if "Booking Revenue Code Filter" <> '' then
                    AdsBookingLine.SetRange("Ads. Type code (Revenue type Code)", "Booking Revenue Code Filter");
            /*
            IF (ShowAsColumn = ShowAsColumn::"Ads. Size") AND (ColumnCode <> '') THEN
              AdsBookingLine.SETRANGE("Ads. Size",ColumnCode)
            ELSE
              IF "Ads. Size Filter" <> '' THEN
                AdsBookingLine.SETRANGE("Ads. Size","Ads. Size Filter");
            IF (ShowAsColumn = ShowAsColumn::"Ads. Type") AND (ColumnCode <> '') THEN
              AdsBookingLine.SETRANGE("Ads. Type",ColumnCode)
            ELSE
              IF "Ads. Type Filter" <> '' THEN
                AdsBookingLine.SETRANGE("Ads. Type","Ads. Type Filter");
            IF (ShowAsColumn = ShowAsColumn::"Ads. Position") AND (ColumnCode <> '') THEN
              AdsBookingLine.SETRANGE("Ads. Position",ColumnCode)
            ELSE
              IF "Ads. Position Filter" <> '' THEN
                AdsBookingLine.SETRANGE("Ads. Position","Ads. Position Filter");
            IF (ShowAsColumn = ShowAsColumn::"Revenue Type") AND (ColumnCode <> '') THEN
              AdsBookingLine.SETFILTER("Booking Revenue Code",ColumnCode)
            ELSE
              IF "Booking Revenue Code Filter" <> '' THEN
                AdsBookingLine.SETRANGE("Booking Revenue Code","Booking Revenue Code Filter");
            */
            Copyfilter("Salesperson Filter", AdsBookingLine."Salesperson Code");
            if AdsBookingLine.Find('-') then begin
                //AdsBookingLine.CALCSUMS("Counting Unit");
                //Qty := AdsBookingLine."Counting Unit";
                AdsBookingLine.CalcSums("Total Counting Unit");
                Qty := AdsBookingLine."Total Counting Unit";
                if not AdsProduct.Get(AdsBookingLine."Brand Code") then
                    Clear(AdsProduct);
            end;
        end;
        if Qty <> 0 then
            exit(StrSubstNo('%1 %2 %3',
              Qty,
              NewLine + AdsProduct."Short Description",
              NewLine + Format(AdsBookingLine.Amount, 0, '<Precision,2:3><Standard Format,0>') + ' ' + AdsBookingLine."Ads. Size Code"))
        else
            exit('');

    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; EdgeLeft: Boolean)
    begin
        TempExcelBuffer.Init;
        TempExcelBuffer.Validate("Row No.", RowNo);
        TempExcelBuffer.Validate("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        if UnderLine then
            TempExcelBuffer."Line Style" := 1;
        TempExcelBuffer.EdgeLeft := EdgeLeft;
        TempExcelBuffer.NumberFormat := '@';
        if ColumnNo = 2 then begin
            TempExcelBuffer."AutoFit Column" := true;
        end else begin
            TempExcelBuffer."Column Width" := ColumnWidth;
            TempExcelBuffer."Row Height" := RowHeight;
        end;
        TempExcelBuffer.Insert;
    end;
}

