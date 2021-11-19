Table 50023 "Dummy Plan"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Dummy Plan" - Editorial Module

    LookupPageID = "Dummy Plan List";

    fields
    {
        field(1; "Dummy Plan No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "Dummy Plan No." <> xRec."Dummy Plan No." then begin
                    EditorialSetup.Get;
                    NoSeriesMgt.TestManual(EditorialSetup."Dummy Plan Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine));

            trigger OnValidate()
            begin
                TestField("Planning Status", "planning status"::Open);
                if ("Magazine Item No." <> xRec."Magazine Item No.") or ("Magazine Item No." = '') then begin
                    DummyPlanLine.Reset;
                    DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
                    DummyPlanLine.SetRange("Revision No.", "Revision No.");
                    DummyPlanLine.SetFilter("Line No.", '<>%1', 0);
                    if DummyPlanLine.Find('-') then
                        Error(Text005);
                    BookingList.Reset;
                    BookingList.SetRange("Dummy Plan No.", "Dummy Plan No.");
                    BookingList.SetRange("Revision No.", "Revision No.");
                    if BookingList.Find('-') then
                        Error(Text011, FieldCaption("Magazine Item No."));

                    //One Magazine Item per one Dummy Plan
                    if "Magazine Item No." <> '' then begin
                        DummyPlan.Reset;
                        DummyPlan.SetFilter("Dummy Plan No.", '<>%1', "Dummy Plan No.");
                        DummyPlan.SetRange("Magazine Item No.", "Magazine Item No.");
                        DummyPlan.SetRange("Magazine Code");
                        DummyPlan.SETPERMISSIONFILTER;
                        if DummyPlan.Find('-') then
                            Error(Text008, DummyPlan."Dummy Plan No.")
                        else begin
                            ArchivedDummyPlan.Reset;
                            ArchivedDummyPlan.SetFilter("Dummy Plan No.", '<>%1', "Dummy Plan No.");
                            ArchivedDummyPlan.SetRange("Magazine Item No.", "Magazine Item No.");
                            ArchivedDummyPlan.SetRange("Magazine Code");
                            ArchivedDummyPlan.SETPERMISSIONFILTER;
                            if ArchivedDummyPlan.Find('-') then
                                Error(Text008, ArchivedDummyPlan."Dummy Plan No.");
                        end;
                    end;

                    "No. of Page" := 0;
                    DummyPlanLine.Reset;
                    DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
                    DummyPlanLine.SetRange("Revision No.", "Revision No.");
                    if DummyPlanLine.Find('-') then
                        DummyPlanLine.DeleteAll;

                    Item.Get("Magazine Item No.");
                    "Magazine Code" := Item."Magazine Code";
                    if Magazine.Get(Item."Magazine Code") then begin
                        "No. of Page" := Magazine."Minimum No. of Page";

                        DummyPlanLine.Reset;
                        DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
                        DummyPlanLine.SetRange("Revision No.", "Revision No.");
                        if not DummyPlanLine.Find('-') then
                            for x := 1 to "No. of Page" do begin
                                DummyPlanLine.Init;
                                DummyPlanLine."Dummy Plan No." := "Dummy Plan No.";
                                DummyPlanLine."Revision No." := "Revision No.";
                                DummyPlanLine."Magazine Item No." := "Magazine Item No.";
                                DummyPlanLine."Page No." := x;
                                DummyPlanLine."Sub Page No." := 0;
                                DummyPlanLine."Line No." := 0;
                                DummyPlanLine."Box No." := x;
                                DummyPlanLine.Insert;
                            end;
                    end;
                end;
            end;
        }
        field(3; "Planning Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,"Final Approve";
        }
        field(4; "Document Date"; Date)
        {
        }
        field(5; "No. of Page"; Integer)
        {
            Description = '0-289 Page';
            MaxValue = 289;
            MinValue = 0;

            trigger OnValidate()
            var
                BoxNo: Integer;
            begin
                TestField("Planning Status", "planning status"::Open);
                if not Confirm(Text001, false) then begin
                    "No. of Page" := xRec."No. of Page";
                    exit;
                end;

                if "No. of Page" < xRec."No. of Page" then begin
                    DummyPlanLine.Reset;
                    DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
                    DummyPlanLine.SetRange("Revision No.", "Revision No.");
                    DummyPlanLine.SetFilter("Page No.", '>%1', "No. of Page");
                    DummyPlanLine.SetFilter("Planning Status", '<>%1', DummyPlanLine."planning status"::" ");
                    if DummyPlanLine.Find('-') then
                        DummyPlanLine.TestField("Planning Status", DummyPlanLine."planning status"::" ")
                    else begin
                        DummyPlanLine.SetRange("Planning Status");
                        DummyPlanLine.DeleteAll;
                    end;
                end else begin
                    BoxNo := 0;
                    DummyPlanLine.Reset;
                    DummyPlanLine.SetCurrentkey("Dummy Plan No.", "Revision No.", "Box No.");
                    DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
                    DummyPlanLine.SetRange("Revision No.", "Revision No.");
                    DummyPlanLine.SetFilter("Page No.", '<>%1', 1);
                    if DummyPlanLine.Find('+') then
                        BoxNo := DummyPlanLine."Box No.";
                    if BoxNo + "No. of Page" - xRec."No. of Page" > 289 then
                        Error(Text007, 289);
                    for x := 1 to "No. of Page" - xRec."No. of Page" do begin
                        DummyPlanLine.Init;
                        DummyPlanLine."Dummy Plan No." := "Dummy Plan No.";
                        DummyPlanLine."Revision No." := "Revision No.";
                        DummyPlanLine."Magazine Item No." := "Magazine Item No.";
                        DummyPlanLine."Page No." := xRec."No. of Page" + x;
                        DummyPlanLine."Sub Page No." := 0;
                        DummyPlanLine."Line No." := 0;
                        DummyPlanLine."Box No." := BoxNo + x;
                        DummyPlanLine.Insert;
                    end;
                end;
            end;
        }
        field(6; "Magazine Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Sub Product";
        }
        field(10; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(11; "Revision No."; Integer)
        {
            Editable = false;
        }
        field(12; "Revision Date/Time"; DateTime)
        {
            Editable = false;
        }
        field(13; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Dummy Plan No.", "Revision No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Planning Status", "planning status"::Open);

        DummyPlanLine.Reset;
        DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
        DummyPlanLine.SetRange("Revision No.", "Revision No.");
        if DummyPlanLine.Find('-') then
            DummyPlanLine.DeleteAll;

        BookingList.Reset;
        BookingList.SetRange("Dummy Plan No.", "Dummy Plan No.");
        BookingList.SetRange("Revision No.", "Revision No.");
        if BookingList.Find('-') then
            BookingList.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "Dummy Plan No." = '' then begin
            EditorialSetup.Get;
            EditorialSetup.TestField("Dummy Plan Nos.");
            NoSeriesMgt.InitSeries(EditorialSetup."Dummy Plan Nos.", xRec."No. Series", 0D, "Dummy Plan No.", "No. Series");
        end;

        "Document Date" := WorkDate;
        "User ID" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("Planning Status", "planning status"::Open);
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        EditorialSetup: Record "Editorial Setup";
        Item: Record Item;
        Magazine: Record "Sub Product";
        DummyPlan: Record "Dummy Plan";
        DummyPlanLine: Record "Dummy Plan Line";
        ArchivedDummyPlan: Record "Archived Dummy Plan";
        BookingList: Record "Booking List";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: label 'You cannot rename a %1.';
        Text001: label 'Do you want to change no. of page?';
        x: Integer;
        Text002: label 'Do you want to %1 dummy plan %2?';
        Text003: label 'Dummy plan %1 is still opening by revision no. %2.';
        Text004: label 'Dummy plan %1 has been approved by revision no. %2.';
        Text005: label 'You cannot change Magazine Item No.';
        Text006: label 'Dummy Plan %1 has been archived.';
        Text007: label 'Dummy Plan has maximum no. of box is %1.';
        Text008: label 'Magazine Item No. has been used by dummy plan %1.';
        Text009: label 'Dummy Plan %1 cannot final approve because one or more booking list still opening.';
        Text010: label 'Please assign value on page %1%2.';
        Text011: label 'You cannot reset %1 because the booking list still has one or more lines.';


    procedure AssistEdit(OldDummyPlan: Record "Dummy Plan"): Boolean
    var
        DummyPlan: Record "Dummy Plan";
    begin
        with DummyPlan do begin
            DummyPlan := Rec;
            EditorialSetup.Get;
            EditorialSetup.TestField("Dummy Plan Nos.");
            if NoSeriesMgt.SelectSeries(EditorialSetup."Dummy Plan Nos.", OldDummyPlan."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Dummy Plan No.");
                Rec := DummyPlan;
                exit(true);
            end;
        end;
    end;


    procedure Release()
    begin
        if not Confirm(StrSubstNo(Text002, 'release', "Dummy Plan No."), false) then
            exit;

        TestField("Planning Status", "planning status"::Open);

        "Planning Status" := "planning status"::Released;
        "Revision Date/Time" := CurrentDatetime;
        Modify;
    end;


    procedure Reopen(var NewDummyPlan: Record "Dummy Plan")
    var
        NewDummyPlanLine: Record "Dummy Plan Line";
        NewBookingList: Record "Booking List";
        AdsBookingLine: Record "Ads. Booking Line";
        ContentIndexLine: Record "Content Index Line";
        LastRevisionNo: Integer;
    begin
        if not Confirm(StrSubstNo(Text002, 'reopen', "Dummy Plan No."), false) then
            exit;

        TestField("Planning Status", "planning status"::Released);

        //check other revision for this dummy plan is still opening.
        DummyPlan.Reset;
        DummyPlan.SetRange("Dummy Plan No.", "Dummy Plan No.");
        DummyPlan.SetRange("Magazine Code", "Magazine Code");
        DummyPlan.SetRange("Planning Status", DummyPlan."planning status"::Open);
        DummyPlan.SETPERMISSIONFILTER;
        if DummyPlan.Find('-') then
            Error(Text003, "Dummy Plan No.", DummyPlan."Revision No.");

        //check final approve
        DummyPlan.Reset;
        DummyPlan.SetRange("Dummy Plan No.", "Dummy Plan No.");
        DummyPlan.SetRange("Magazine Code", "Magazine Code");
        DummyPlan.SetRange("Planning Status", DummyPlan."planning status"::"Final Approve");
        DummyPlan.SETPERMISSIONFILTER;
        if DummyPlan.Find('-') then
            Error(Text004, "Dummy Plan No.", DummyPlan."Revision No.");

        //find last revision no.
        DummyPlan.Reset;
        DummyPlan.SetRange("Dummy Plan No.", "Dummy Plan No.");
        DummyPlan.SetRange("Magazine Code", "Magazine Code");
        DummyPlan.SETPERMISSIONFILTER;
        if DummyPlan.Find('+') then
            LastRevisionNo := DummyPlan."Revision No.";

        NewDummyPlan.Init;
        NewDummyPlan."Dummy Plan No." := "Dummy Plan No.";
        NewDummyPlan."Revision No." := LastRevisionNo + 1;
        NewDummyPlan."Magazine Item No." := "Magazine Item No.";
        NewDummyPlan."Magazine Code" := "Magazine Code";
        NewDummyPlan."Document Date" := "Document Date";
        NewDummyPlan."No. of Page" := "No. of Page";
        NewDummyPlan."No. Series" := "No. Series";
        NewDummyPlan."User ID" := UserId;
        NewDummyPlan.Insert;

        DummyPlanLine.Reset;
        DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
        DummyPlanLine.SetRange("Revision No.", "Revision No.");
        if DummyPlanLine.Find('-') then
            repeat
                NewDummyPlanLine := DummyPlanLine;
                NewDummyPlanLine."Revision No." := LastRevisionNo + 1;
                NewDummyPlanLine.Insert;
            until DummyPlanLine.Next = 0;

        BookingList.Reset;
        BookingList.SetRange("Dummy Plan No.", "Dummy Plan No.");
        BookingList.SetRange("Revision No.", "Revision No.");
        if BookingList.Find('-') then
            repeat
                NewBookingList := BookingList;
                NewBookingList."Revision No." := LastRevisionNo + 1;
                NewBookingList.Insert;

                //Update "Planning Status" on "Ads. Booking Line" and "Content Index Line"
                case NewBookingList."From Type" of
                    NewBookingList."from type"::Ads:
                        begin
                            if AdsBookingLine.Get(NewBookingList."Booking No.", NewBookingList."Booking Line No.") then begin
                                case NewBookingList."Planning Status" of
                                    NewBookingList."planning status"::" ":
                                        begin
                                            AdsBookingLine."Planning Status" := AdsBookingLine."planning status"::Picked;
                                            AdsBookingLine.Modify;
                                        end;
                                    NewBookingList."planning status"::Occupied:
                                        begin
                                            AdsBookingLine."Planning Status" := AdsBookingLine."planning status"::Occupied;
                                            AdsBookingLine.Modify;
                                        end;
                                end;
                            end else begin
                                if NewBookingList."Planning Status" <> NewBookingList."planning status"::" " then begin
                                    NewDummyPlanLine.Reset;
                                    NewDummyPlanLine.SetRange("Dummy Plan No.", NewBookingList."Dummy Plan No.");
                                    NewDummyPlanLine.SetRange("Revision No.", NewBookingList."Revision No.");
                                    NewDummyPlanLine.SetRange("From Type", NewBookingList."From Type");
                                    NewDummyPlanLine.SetRange("Booking No.", NewBookingList."Booking No.");
                                    NewDummyPlanLine.SetRange("Booking Line No.", NewBookingList."Booking Line No.");
                                    if NewDummyPlanLine.Find('-') then
                                        NewDummyPlanLine.DeleteAll;
                                end;
                                NewBookingList.Delete;
                            end;
                        end;
                    NewBookingList."from type"::Content:
                        begin
                            if ContentIndexLine.Get(NewBookingList."Booking No.", NewBookingList."Booking Line No.") then begin
                                case NewBookingList."Planning Status" of
                                    NewBookingList."planning status"::" ":
                                        begin
                                            ContentIndexLine.Status := ContentIndexLine.Status::Picked;
                                            ContentIndexLine.Modify;
                                        end;
                                    NewBookingList."planning status"::Occupied:
                                        begin
                                            ContentIndexLine.Status := ContentIndexLine.Status::Occupied;
                                            ContentIndexLine.Modify;
                                        end;
                                end;
                            end else begin
                                if NewBookingList."Planning Status" <> NewBookingList."planning status"::" " then begin
                                    NewDummyPlanLine.Reset;
                                    NewDummyPlanLine.SetRange("Dummy Plan No.", NewBookingList."Dummy Plan No.");
                                    NewDummyPlanLine.SetRange("Revision No.", NewBookingList."Revision No.");
                                    NewDummyPlanLine.SetRange("From Type", NewBookingList."From Type");
                                    NewDummyPlanLine.SetRange("Booking No.", NewBookingList."Booking No.");
                                    NewDummyPlanLine.SetRange("Booking Line No.", NewBookingList."Booking Line No.");
                                    if NewDummyPlanLine.Find('-') then
                                        NewDummyPlanLine.DeleteAll;
                                end;
                                NewBookingList.Delete;
                            end;
                        end;
                end;
            until BookingList.Next = 0;

        Commit;
    end;


    procedure FinalApprove()
    var
        AdsBookingLine: Record "Ads. Booking Line";
        ContentIndexHdr: Record "Content Index Header";
        ContentIndexLine: Record "Content Index Line";
        BookingList2: Record "Booking List";
    begin
        if not Confirm(StrSubstNo(Text002, 'final approve', "Dummy Plan No."), false) then
            exit;

        TestField("Planning Status", "planning status"::Released);

        //check page must not be empty.
        DummyPlanLine.Reset;
        DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
        DummyPlanLine.SetRange("Revision No.", "Revision No.");
        DummyPlanLine.SetRange("Line No.", 0);
        if DummyPlanLine.Find('-') then
            repeat
                DummyPlanLine.CalcFields("Has Detail");
                if not DummyPlanLine."Has Detail" then
                    Error(Text010, "Dummy Plan No.");
            until DummyPlanLine.Next = 0;

        //check booking list is still opening.
        BookingList.Reset;
        BookingList.SetRange("Dummy Plan No.", "Dummy Plan No.");
        BookingList.SetRange("Revision No.", "Revision No.");
        BookingList.SetRange("Planning Status", BookingList."planning status"::" ");
        if BookingList.Find('-') then
            repeat
                //ERROR(Text009,"Dummy Plan No.");
                BookingList.UpdateAdsBookingContentIndex;
                BookingList.Delete;
            until BookingList.Next = 0;

        "User ID" := UserId;
        "Planning Status" := "planning status"::"Final Approve";
        Modify;

        DummyPlanLine.Reset;
        DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
        DummyPlanLine.SetRange("Revision No.", "Revision No.");
        DummyPlanLine.SetFilter("Line No.", '<>%1', 0);
        if DummyPlanLine.Find('-') then
            repeat
                Item.Get("Magazine Item No.");
                BookingList2.Get(
                  DummyPlanLine."Dummy Plan No.",
                  DummyPlanLine."Revision No.",
                  DummyPlanLine."From Type",
                  DummyPlanLine."Booking No.",
                  DummyPlanLine."Booking Line No.");
                BookingList2."Planning Status" := BookingList2."planning status"::Confirmed;
                BookingList2.Modify;

                case BookingList2."From Type" of
                    BookingList2."from type"::Ads:
                        begin
                            /*
                            AdsBookingLine.SETRANGE("Booking No.",BookingList2."Booking No.");
                            AdsBookingLine.SETRANGE("Line No.",BookingList2."Booking Line No.");
                            AdsBookingLine.MODIFYALL("Planning Status",AdsBookingLine."Planning Status"::Approved);
                            AdsBookingLine.MODIFYALL("Actual Volume No.",Item."Volume No.");
                            AdsBookingLine.MODIFYALL("Actual Issue No.",Item."Issue No.");
                            AdsBookingLine.MODIFYALL("Actual Page No.",DummyPlanLine."Page No.");
                            AdsBookingLine.MODIFYALL("Actual Sub Page No.",DummyPlanLine."Sub Page No.");
                            */
                            AdsBookingLine.Get(BookingList2."Booking No.", BookingList2."Booking Line No.");
                            if (AdsBookingLine."Actual Page No." = 0) and
                               (AdsBookingLine."Planning Status" = AdsBookingLine."planning status"::Occupied)
                            then begin
                                AdsBookingLine."Planning Status" := AdsBookingLine."planning status"::Approved;
                                AdsBookingLine."Actual Volume No." := Item."Volume No.";
                                AdsBookingLine."Actual Issue No." := Item."Issue No.";
                                AdsBookingLine."Actual Page No." := DummyPlanLine."Page No.";
                                AdsBookingLine."Actual Sub Page No." := DummyPlanLine."Sub Page No.";
                                AdsBookingLine.Modify;
                            end;
                        end;
                    BookingList."from type"::Content:
                        begin
                            ContentIndexHdr.Get(BookingList2."Booking No.");
                            ContentIndexHdr.Close := true;
                            ContentIndexHdr.Modify;
                            /*
                            ContentIndexLine.SETRANGE("Content List No.",BookingList2."Booking No.");
                            ContentIndexLine.SETRANGE("Content List Line No.",BookingList2."Booking Line No.");
                            ContentIndexLine.MODIFYALL(Status,ContentIndexLine.Status::Occupied);
                            ContentIndexLine.MODIFYALL("Actual Volume No.",Item."Volume No.");
                            ContentIndexLine.MODIFYALL("Actual Volume No.",Item."Issue No.");
                            ContentIndexLine.MODIFYALL("Actual Page No.",DummyPlanLine."Page No.");
                            ContentIndexLine.MODIFYALL("Actual Sub Page No.",DummyPlanLine."Sub Page No.");
                            */
                            ContentIndexLine.Get(BookingList2."Booking No.", BookingList2."Booking Line No.");
                            if (ContentIndexLine."Actual Page No." = 0) and (ContentIndexLine.Status = ContentIndexLine.Status::Occupied) then begin
                                ContentIndexLine.Status := ContentIndexLine.Status::Approved;
                                ContentIndexLine."Actual Volume No." := Item."Volume No.";
                                ContentIndexLine."Actual Issue No." := Item."Issue No.";
                                ContentIndexLine."Actual Page No." := DummyPlanLine."Page No.";
                                ContentIndexLine."Actual Sub Page No." := DummyPlanLine."Sub Page No.";
                                ContentIndexLine.Modify;
                            end;
                        end;
                end;

            until DummyPlanLine.Next = 0;

    end;


    procedure Archive()
    var
        ArchivedDummyPlan: Record "Archived Dummy Plan";
        ArchivedDummyPlanLine: Record "Archived Dummy Plan Line";
    begin
        if not Confirm(StrSubstNo(Text002, 'archive', "Dummy Plan No."), false) then
            exit;

        TestField("Planning Status", "planning status"::"Final Approve");

        //archived only one record which it final approve.
        ArchivedDummyPlan.TransferFields(Rec);
        ArchivedDummyPlan.Insert;

        DummyPlanLine.Reset;
        DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
        DummyPlanLine.SetRange("Revision No.", "Revision No.");
        if DummyPlanLine.Find('-') then
            repeat
                ArchivedDummyPlanLine.TransferFields(DummyPlanLine);
                ArchivedDummyPlanLine.Insert;
            until DummyPlanLine.Next = 0;

        BookingList.Reset;
        BookingList.SetRange("Dummy Plan No.", "Dummy Plan No.");
        BookingList.SetRange("Revision No.", "Revision No.");
        BookingList.ModifyAll(Archived, true);

        //delete record
        DummyPlanLine.Reset;
        DummyPlanLine.SetRange("Dummy Plan No.", "Dummy Plan No.");
        if DummyPlanLine.Find('-') then
            DummyPlanLine.DeleteAll;

        DummyPlan.Reset;
        DummyPlan.SetRange("Dummy Plan No.", "Dummy Plan No.");
        DummyPlan.SetRange("Magazine Code", "Magazine Code");
        if DummyPlan.Find('-') then
            DummyPlan.DeleteAll;

        BookingList.Reset;
        BookingList.SetRange("Dummy Plan No.", "Dummy Plan No.");
        BookingList.SetFilter("Revision No.", '<>%1', "Revision No.");
        if BookingList.Find('-') then
            BookingList.DeleteAll;

        Message(Text006, "Dummy Plan No.");
    end;
}

