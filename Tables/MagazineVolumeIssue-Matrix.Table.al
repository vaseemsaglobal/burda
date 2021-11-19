Table 50012 "Magazine/Volume/Issue - Matrix"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New table for Magazine/Volume/Issue Matrix - Magazine Sales Module
    // 002   27.08.2007   KKE   Add function to change Issue Date.
    // 003   20.05.2008   KKE   Add function remove ads. item, incase they make a wrong ads. no. series.


    fields
    {
        field(1; "Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";

            trigger OnValidate()
            begin
                if Magazine.Get("Magazine Code") then begin
                    "Unit Price" := Magazine."Unit Price";
                    Validate("Magazine Item Nos.", Magazine."Magazine Item Nos.");
                    "Ads. Item Nos." := Magazine."Ads. Item Nos.";
                end;
            end;
        }
        field(2; "Volume No."; Code[20])
        {
            TableRelation = Volume;
        }
        field(3; "Issue No."; Code[20])
        {
            TableRelation = "Issue No.";
        }
        field(4; "Issue Date"; Date)
        {

            trigger OnValidate()
            begin
                if ("Issue Date" <> xRec."Issue Date") and (xRec."Issue Date" <> 0D) then
                    if Rec.ChangeIssueDate = false then
                        "Issue Date" := xRec."Issue Date";

                Magazine.Get("Magazine Code");
                if Magazine."Ads. Closing Interval" <> XD then
                    "Ads. Closing Date" := CalcDate(StrSubstNo('CD - %1', Magazine."Ads. Closing Interval"), "Issue Date")
                else
                    "Ads. Closing Date" := "Issue Date";
            end;
        }
        field(5; "Magazine Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item where("Item Type" = const(Magazine));
        }
        field(6; "Cover Description"; Text[50])
        {
        }
        field(7; "Unit Price"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(8; "Magazine Item Nos."; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if "Magazine Item Nos." = '' then
                    TestField("Magazine Item No.", '');
            end;
        }
        field(9; "Create as Item"; Boolean)
        {
            Editable = false;
        }
        field(10; "Ads. Item No."; Code[20])
        {
            Editable = false;
            TableRelation = "Ads. Item";
        }
        field(11; "Ads. Closing Date"; Date)
        {
        }
        field(12; "Ads. Item Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; "Create as Ads. Item"; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Magazine Code", "Volume No.", "Issue No.")
        {
            Clustered = true;
        }
        key(Key2; "Create as Item", "Magazine Item No.")
        {
        }
        key(Key3; "Create as Ads. Item", "Ads. Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Create as Item", false);
    end;

    trigger OnModify()
    begin
        if "Issue Date" = xRec."Issue Date" then
            TestField("Create as Item", false);
        TestField("Issue Date");
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Magazine: Record "Sub Product";
        XD: DateFormula;
        Text000: label 'You cannot rename a %1.';
        Text001: label 'Do you want to chagne issue date for magazine %1 volume %2 issue %3 ?';
        Text002: label 'You do not have permission to change issue date.';
        Text003: label 'System will remove ads item %1. Are you sure?';
        Text004: label 'You do not have permission to remove ads item.';


    procedure GetMagazineItemNo(MagazineCode: Code[20]; Volume: Code[20]; IssueNo: Code[20]): Code[20]
    var
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
    begin
        if MagazineVolumeIssue.Get(MagazineCode, Volume, IssueNo) then
            exit(MagazineVolumeIssue."Magazine Item No.");
        exit('');
    end;


    procedure ChangeIssueDate(): Boolean
    var
        UserSetup: Record "User Setup";
        Item: Record Item;
        AdsItem: Record "Ads. Item";
        SSContract: Record "Subscriber Contract";
        SSContractLE: Record "Subscriber Contract L/E";
    begin
        //KKE : #002
        if not Confirm(StrSubstNo(Text001, "Magazine Code", "Volume No.", "Issue No."), false) then
            exit(false);

        UserSetup.Get(UserId);
        if not UserSetup."Allow Change Issue Date" then
            Error(Text002);

        if Item.Get("Magazine Item No.") then begin
            Magazine.Get("Magazine Code");
            Item."Issue Date" := "Issue Date";
            Item."Last Pick-up Date" := CalcDate(Magazine."Pick-up Interval", "Issue Date");
            Item.Modify;
        end;

        if AdsItem.Get("Ads. Item No.") then begin
            AdsItem."Issue Date" := "Issue Date";
            AdsItem.Modify;
        end;

        SSContract.SetRange("Starting Magazine Item No.", "Magazine Item No.");
        if SSContract.Find('-') then
            SSContract.ModifyAll("Starting Issue Date", "Issue Date");

        SSContractLE.SetRange("Magazine Item No.", "Magazine Item No.");
        if SSContractLE.Find('-') then
            SSContractLE.ModifyAll("Issue Date", "Issue Date");

        exit(true);
    end;


    procedure RemoveAdsItem()
    var
        AdsItem: Record "Ads. Item";
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
    begin
        //KKE : #003
        if "Ads. Item No." = '' then
            exit;
        if not Confirm(StrSubstNo(Text003, "Ads. Item No."), false) then
            exit;

        if UpperCase(UserId) <> 'SA' then
            Error(Text004);

        AdsItem.Get("Ads. Item No.");
        AdsItem.Delete(true);

        MagazineVolumeIssue.Get("Magazine Code", "Volume No.", "Issue No.");
        MagazineVolumeIssue."Ads. Item No." := '';
        MagazineVolumeIssue."Create as Ads. Item" := false;
        MagazineVolumeIssue.Modify;
    end;
}

