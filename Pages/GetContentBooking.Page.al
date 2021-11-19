Page 50111 "Get Content Booking"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   18.05.2007   KKE   New form for "Get Content Booking" - Editorial Module

    PageType = Card;
    SourceTable = "Content Index Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field(ContentListNo;"Content List No.")
                {
                    ApplicationArea = Basic;
                }
                field(ContentCode;"Content Code")
                {
                    ApplicationArea = Basic;
                }
                field(ColumnName;"Column Name")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(NoofPage;"No. of Page")
                {
                    ApplicationArea = Basic;
                }
                field(ContentType;"Content Type")
                {
                    ApplicationArea = Basic;
                }
                field(ContentSubType;"Content Sub Type")
                {
                    ApplicationArea = Basic;
                }
                field(AuthorName;"Author Name")
                {
                    ApplicationArea = Basic;
                }
                field(SourceofInformation;"Source of Information")
                {
                    ApplicationArea = Basic;
                }
                field(CostLCY;"Cost (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(ContentReceiptDate;"Content Receipt Date")
                {
                    ApplicationArea = Basic;
                }
                field(OwnCustomer;"Own Customer")
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


    procedure InitRequest(_DummyPlanNo: Code[20];_MagazineItemNo: Code[20];_RevisionNo: Integer)
    begin
        DummyPlanNo := _DummyPlanNo;
        MagazineItemNo := _MagazineItemNo;
        RevisionNo := _RevisionNo;
    end;


    procedure InsertBookingList(var ContentIndexLine: Record "Content Index Line")
    var
        ContentIndexLine2: Record "Content Index Line";
        BookingList: Record "Booking List";
        ContentType: Record "Content Group Setup";
    begin
        if ContentIndexLine.Find('-') then
        repeat
          if not BookingList.Get(DummyPlanNo,RevisionNo,BookingList."from type"::Content,
             ContentIndexLine."Content List No.",ContentIndexLine."Content List Line No.")
          then begin
            ContentType.Get(ContentIndexLine."Content Type");
            BookingList.Init;
            BookingList."Dummy Plan No." := DummyPlanNo;
            BookingList."Revision No." := RevisionNo;
            BookingList."From Type" := BookingList."from type"::Content;
            BookingList."Booking No." := ContentIndexLine."Content List No.";
            BookingList."Booking Line No." := ContentIndexLine."Content List Line No.";
            BookingList."Magazine Item No." := MagazineItemNo;
            BookingList."Column Name" := ContentIndexLine."Column Name";
            BookingList."Content Code" := ContentIndexLine."Content Code";
            BookingList."Content Type" := ContentIndexLine."Content Type";
            BookingList."Counting Unit" := ContentIndexLine."No. of Page";
            BookingList."Blackground Color" := ContentType."Blackground Color";
            BookingList."Foreground Color" := ContentType."Foreground Color";
            BookingList."Ads. Size" := ContentIndexLine.Size;
            BookingList."Owner Customer" := ContentIndexLine."Own Customer";
            BookingList.Description := ContentIndexLine.Description;
            BookingList."Author Name" := ContentIndexLine."Author Name";
            BookingList."Source of Information" := ContentIndexLine."Source of Information";
            BookingList."Content Receipt Date" := ContentIndexLine."Content Receipt Date";
            BookingList.Insert;
            ContentIndexLine2.Get(ContentIndexLine."Content List No.",ContentIndexLine."Content List Line No.");
            ContentIndexLine2.Status := ContentIndexLine2.Status::Picked;
            ContentIndexLine2.Modify;
          end;
        until ContentIndexLine.Next=0;
    end;

    local procedure LookupOKOnPush()
    begin
        CurrPage.SetSelectionFilter(Rec);
        InsertBookingList(Rec);
        CurrPage.Close;
    end;
}

