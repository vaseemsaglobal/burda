Page 50110 "Get Ads. Booking"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   17.05.2007   KKE   New form for "Get Ads. Booking" - Editorial Module

    PageType = Card;
    SourceTable = "Ads. Booking Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field(AdsItemNo; "Ads. Item No.")
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
                field(BookingRevenueCode; "Ads. Type code (Revenue type Code)")
                {
                    ApplicationArea = Basic;
                }
                field(AdsType; "Ads. Type")
                {
                    ApplicationArea = Basic;
                }
                field(AdsSubType; "Ads. Sub-Type")
                {
                    ApplicationArea = Basic;
                }
                field(AdsSize; "Ads. Size Code")
                {
                    ApplicationArea = Basic;
                }
                field(AdsPosition; "Ads. Position Code")
                {
                    ApplicationArea = Basic;
                }
                field(AdsProduct; "Brand Code")
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory; "Industry Category Code")
                {
                    ApplicationArea = Basic;
                }
                field(BookingDate; "Booking Date")
                {
                    ApplicationArea = Basic;
                }
                field(CountingUnit; "Counting Unit")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        if CloseAction = Action::LookupOK then
            LookupOKOnPush;
    end;

    var
        DummyPlanNo: Code[20];
        MagazineItemNo: Code[20];
        RevisionNo: Integer;


    procedure InitRequest(_DummyPlanNo: Code[20]; _MagazineItemNo: Code[20]; _RevisionNo: Integer)
    begin
        DummyPlanNo := _DummyPlanNo;
        MagazineItemNo := _MagazineItemNo;
        RevisionNo := _RevisionNo;
    end;


    procedure InsertBookingList(var AdsBookingLine: Record "Ads. Booking Line")
    var
        AdsBookingLine2: Record "Ads. Booking Line";
        BookingList: Record "Booking List";
        BookingRevType: Record "Booking Revenue Type";
        AdsProduct: Record Brand;
    begin
        if AdsBookingLine.Find('-') then
            repeat
                if not BookingList.Get(DummyPlanNo, RevisionNo, BookingList."from type"::Ads,
                   AdsBookingLine."Deal No.", AdsBookingLine."Line No.")
                then begin
                    if not BookingRevType.Get(AdsBookingLine."Ads. Type code (Revenue type Code)") then
                        Clear(BookingRevType);
                    if not AdsProduct.Get(AdsBookingLine."Brand Code") then
                        Clear(AdsProduct);
                    BookingList.Init;
                    BookingList."Dummy Plan No." := DummyPlanNo;
                    BookingList."Revision No." := RevisionNo;
                    BookingList."From Type" := BookingList."from type"::Ads;
                    BookingList."Booking No." := AdsBookingLine."Deal No.";
                    BookingList."Booking Line No." := AdsBookingLine."Line No.";
                    BookingList."Magazine Item No." := MagazineItemNo;
                    if AdsProduct.Description = '' then
                        BookingList."Column Name" := AdsBookingLine."Brand Code"
                    else
                        BookingList."Column Name" := AdsProduct.Description;
                    BookingList."Content Code" := AdsBookingLine."Brand Code";
                    BookingList."Content Type" := AdsBookingLine."Ads. Type code (Revenue type Code)";
                    //BookingList."Counting Unit" := AdsBookingLine."Counting Unit";
                    BookingList."Counting Unit" := ROUND(AdsBookingLine."Total Counting Unit", 0.01);
                    BookingList."Blackground Color" := BookingRevType."Blackground Color";
                    BookingList."Foreground Color" := BookingRevType."Foreground Color";
                    BookingList."Magazine Code" := AdsBookingLine."Sub Product Code";
                    BookingList."Ads. Position" := AdsBookingLine."Ads. Position Code";
                    BookingList."Ads. Product" := AdsBookingLine."Brand Code";
                    BookingList."Ads. Size" := AdsBookingLine."Ads. Size Code";
                    BookingList."Ads. Type" := AdsBookingLine."Ads. Type";
                    BookingList."Ads. Sub-Type" := AdsBookingLine."Ads. Sub-Type";
                    BookingList."Owner Customer" := AdsBookingLine."Owner Customer";
                    BookingList."Salesperson Code" := AdsBookingLine."Salesperson Code";
                    BookingList.Remark := AdsBookingLine.Remark;
                    BookingList.Insert;
                end;
                AdsBookingLine2.Get(AdsBookingLine."Deal No.", AdsBookingLine."Line No.");
                AdsBookingLine2."Planning Status" := AdsBookingLine2."planning status"::Picked;
                AdsBookingLine2.Modify;
            until AdsBookingLine.Next = 0;
    end;

    local procedure LookupOKOnPush()
    begin
        CurrPage.SetSelectionFilter(Rec);
        InsertBookingList(Rec);
        CurrPage.Close;
    end;
}

