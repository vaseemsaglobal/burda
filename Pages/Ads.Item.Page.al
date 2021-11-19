Page 50045 "Ads. Item"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Ads. Item" - Ads. Sales Module
    // 002   30.08.2007   KKE   Add magazine filter permission.

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "Ads. Item";
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(AdsItemNo; "Ads. Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Product Code"; "Product Code")
                {
                    ApplicationArea = Basic;

                }
                field(MagazineCode; "Sub Product Code")
                {
                    ApplicationArea = Basic;
                }
                field(VolumeNo; "Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueNo; "Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueDate; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field(BaseUnitofMeasure; "Base Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(VATProdPostingGroup; "VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(AdsClosingDate; "Ads. Closing Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Ads. Closing DateEditable";
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                }
            }
            group(Summary)
            {
                Caption = 'Summary';
                field(BookingLine; BookingLine)
                {
                    ApplicationArea = Basic;
                    Caption = 'Booking Line';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        AdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        AdsBookingLine.SetRange("Line Status", AdsBookingLine."line status"::Booking);
                        Page.Run(0, AdsBookingLine);
                    end;
                }
                field(WaitingList; WaitingList)
                {
                    ApplicationArea = Basic;
                    Caption = 'Waiting List Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        AdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        AdsBookingLine.SetRange("Line Status", AdsBookingLine."line status"::"Waiting List");
                        Page.Run(0, AdsBookingLine);
                    end;
                }
                field(ConfirmedBooking; ConfirmedBooking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Confirmed Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        AdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        AdsBookingLine.SetRange("Line Status", AdsBookingLine."line status"::Confirmed);
                        Page.Run(0, AdsBookingLine);
                    end;
                }
                field(CancelledBooking; CancelledBooking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancelled Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        AdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        AdsBookingLine.SetRange("Line Status", AdsBookingLine."line status"::Cancelled);
                        Page.Run(0, AdsBookingLine);
                    end;
                }
                field(ApprovedBooking; ApprovedBooking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        AdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        AdsBookingLine.SetRange("Line Status", AdsBookingLine."line status"::Approved);
                        Page.Run(0, AdsBookingLine);
                    end;
                }
                field(HoldBooking; HoldBooking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hold Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        AdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        AdsBookingLine.SetRange("Line Status", AdsBookingLine."line status"::Hold);
                        Page.Run(0, AdsBookingLine);
                    end;
                }
                field(InvoicedBooking; InvoicedBooking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Invoiced Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        AdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        AdsBookingLine.SetRange("Line Status", AdsBookingLine."line status"::Invoiced);
                        Page.Run(0, AdsBookingLine);
                    end;
                }
                field(ClosedBooking; ClosedBooking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Closed Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        AdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        AdsBookingLine.SetRange("Line Status", AdsBookingLine."line status"::Closed);
                        Page.Run(0, AdsBookingLine);
                    end;
                }
                field(ArchCancelledBooking; ArchCancelledBooking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Archived Cancelled Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        ArchAdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        ArchAdsBookingLine.SetRange("Line Status", ArchAdsBookingLine."line status"::Cancelled);
                        Page.Run(0, ArchAdsBookingLine);
                    end;
                }
                field(ArchInvoicedBooking; ArchInvoicedBooking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Archived Invoiced Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        ArchAdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        ArchAdsBookingLine.SetRange("Line Status", ArchAdsBookingLine."line status"::Invoiced);
                        Page.Run(0, ArchAdsBookingLine);
                    end;
                }
                field(ArchClosedBooking; ArchClosedBooking)
                {
                    ApplicationArea = Basic;
                    Caption = 'Archived Closed Booking';
                    DecimalPlaces = 0 : 5;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        ArchAdsBookingLine.SetRange("Ads. Item No.", "Ads. Item No.");
                        ArchAdsBookingLine.SetRange("Line Status", ArchAdsBookingLine."line status"::Closed);
                        Page.Run(0, ArchAdsBookingLine);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Ads. Closing DateEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        //KKE : #002 +
        UserSetup.Get(UserId);
        FilterGroup(2);
        SetFilter("Sub Product Code", UserSetup."Magazine Filter");
        FilterGroup(0);
    end;

    var
        AdsItemSetup: Record "Ads. Item Setup";
        AdsItem: Record "Ads. Item";
        AdsBookingLine: Record "Ads. Booking Line";
        ArchAdsBookingLine: Record "Archived Ads. Booking Line";
        BookingLine: Decimal;
        ConfirmedBooking: Decimal;
        WaitingList: Decimal;
        ApprovedBooking: Decimal;
        HoldBooking: Decimal;
        CancelledBooking: Decimal;
        InvoicedBooking: Decimal;
        ClosedBooking: Decimal;
        ArchCancelledBooking: Decimal;
        ArchInvoicedBooking: Decimal;
        ArchClosedBooking: Decimal;
        Salesperson: Record "Salesperson/Purchaser";
        UserSetup: Record "User Setup";
        TeamSales: Record "Team Salesperson";
        TeamSalesFilter: Text[500];
        SalespersonFilter: Text[500];
        Text001: label 'You do not have permision to see ads. item.';
        [InDataSet]
        "Ads. Closing DateEditable": Boolean;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        AdsItemSetup.Get;
        "Ads. Closing DateEditable" := not AdsItemSetup."Lock Ads. Closing Date";
        if AdsItem.Get("Ads. Item No.") then
            AdsItem.CalcFields(
              "Booking Line", "Confirmed Booking", "Waiting List Booking",
              "Approved Booking", "Hold Booking", "Cancelled Booking",
              "Invoiced Booking", "Closed Booking",
              "Archived Cancelled Booking", "Archived Closed Booking", "Archived Invoiced Booking");
        BookingLine := AdsItem."Booking Line";
        ConfirmedBooking := AdsItem."Confirmed Booking";
        WaitingList := AdsItem."Waiting List Booking";
        ApprovedBooking := AdsItem."Approved Booking";
        HoldBooking := AdsItem."Hold Booking";
        CancelledBooking := AdsItem."Cancelled Booking";
        InvoicedBooking := AdsItem."Invoiced Booking";
        ClosedBooking := AdsItem."Closed Booking";
        ArchCancelledBooking := AdsItem."Archived Cancelled Booking";
        ArchClosedBooking := AdsItem."Archived Closed Booking";
        ArchInvoicedBooking := AdsItem."Archived Invoiced Booking";
    end;
}

