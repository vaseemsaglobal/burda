Page 50060 "Ads. Booking Overview"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Ads. Booking Overview" - Ads. Sales Module
    // 002   24.01.2008   KKE   Allow Salesperson to view all record.
    UsageCategory = Documents;
    ApplicationArea = all;
    Caption = 'Ads Booking Overview';
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Ads. Booking Overview Buffer";

    layout
    {
    }

    actions
    {
    }

    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
        TeamSales: Record "Team Salesperson";
        MagazineFilter: Code[250];
        VolumeFilter: Code[20];
        IssueNoFilter: Code[20];
        RevenueTypeFilter: Code[20];
        AdsSizeFilter: Code[20];
        AdsTypeFilter: Code[20];
        AdsPositionFilter: Code[20];
        TeamSalesFilter: Text[500];
        SalespersonFilter: Text[500];
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
        HideDetails: Boolean;
        MatrixHeader: Text[50];
        MatrixAmount: Decimal;
        Text001: label 'You do not have permision to see Ads. Booking Overview.';

    local procedure FindRec(InsertLine: Boolean; var AdsBuf: Record "Ads. Booking Overview Buffer"; Which: Text[250]): Boolean
    var
        Found: Boolean;
        IssueNo: Record "Issue No.";
        AdsPosition: Record "Ads. Position";
        AdsSize: Record "Ads. Size";
        RevenueType: Record "Booking Revenue Type";
        AdsType: Record "Ads. Type";
    begin
    end;

    local procedure NextRec(InsertLine: Boolean; var AdsBuf: Record "Ads. Booking Overview Buffer"; Steps: Integer): Integer
    var
        ResultSteps: Integer;
        IssueNo: Record "Issue No.";
        AdsPosition: Record "Ads. Position";
        AdsSize: Record "Ads. Size";
        RevenueType: Record "Booking Revenue Type";
        AdsType: Record "Ads. Type";
    begin
    end;


    procedure CheckLineStatus(): Text[150]
    var
        V1Linestatus: Text[150];
    begin
    end;

    local procedure CopyIssueToBuf(var TheIssueNo: Record "Issue No."; var TheAdsBuffer: Record "Ads. Booking Overview Buffer")
    var
        i: Integer;
        LineStatusFilter: Text[150];
    begin
    end;

    local procedure CopyAdsPosToBuf(var TheAdsPosition: Record "Ads. Position"; var TheAdsBuffer: Record "Ads. Booking Overview Buffer")
    begin
    end;

    local procedure CopyAdsSizeToBuf(var TheAdsSize: Record "Ads. Size"; var TheAdsBuffer: Record "Ads. Booking Overview Buffer")
    begin
    end;

    local procedure CopyRevTypeToBuf(var TheRevType: Record "Booking Revenue Type"; var TheAdsBuffer: Record "Ads. Booking Overview Buffer")
    begin
    end;

    local procedure CopyAdsTypeToBuf(var TheAdsType: Record "Ads. Type"; var TheAdsBuffer: Record "Ads. Booking Overview Buffer")
    begin
    end;

    local procedure GetData(SetColFilter: Boolean): Text[250]
    var
        Amount: Decimal;
        ColumnCode: Code[20];
        AdsBookingLine: Record "Ads. Booking Line";
    begin
    end;

    local procedure DrillDown(SetColFilter: Boolean)
    var
        AdsBookingLines: Page "Ads. Booking Lines";
        AdsBookingLine: Record "Ads. Booking Line";
        ColumnCode: Code[20];
    begin
    end;
}

