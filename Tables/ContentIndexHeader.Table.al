Table 50019 "Content Index Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New table for "Content Index Header" - Editorial Module

    LookupPageID = "Content Index List";

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    EditorialSetup.Get;
                    NoSeriesMgt.TestManual(EditorialSetup."Content Index Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Creation Date"; Date)
        {
        }
        field(3; "Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine));

            trigger OnValidate()
            begin
                if ("Magazine Item No." <> xRec."Magazine Item No.") or ("Magazine Item No." = '') then begin
                    ContentIndexLine.SetRange("Content List No.", "No.");
                    if ContentIndexLine.Find('-') then
                        Error(Text002, FieldCaption("Magazine Item No."));
                end;

                if Item.Get("Magazine Item No.") then
                    "Magazine Code" := Item."Magazine Code"
                else
                    "Magazine Code" := '';
            end;
        }
        field(5; "Magazine Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Sub Product";
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(20; Close; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ContentIndexLine.SetRange("Content List No.", "No.");
        if ContentIndexLine.Find('-') then
            Error(Text001, "No.");

        ContentIndexLine.Reset;
        ContentIndexLine.SetRange("Content List No.", "No.");
        ContentIndexLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            EditorialSetup.Get;
            EditorialSetup.TestField("Content Index Nos.");
            NoSeriesMgt.InitSeries(EditorialSetup."Content Index Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Creation Date" := Today;
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        EditorialSetup: Record "Editorial Setup";
        Item: Record Item;
        ContentIndexLine: Record "Content Index Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: label 'You cannot rename a %1.';
        Text001: label 'You cannot delete %1 because the document still has one or more lines.';
        Text002: label 'You cannot reset %1 because the document still has one or more lines.';


    procedure AssistEdit(OldContentListHdr: Record "Content Index Header"): Boolean
    var
        ContentListHdr: Record "Content Index Header";
    begin
        with ContentListHdr do begin
            ContentListHdr := Rec;
            EditorialSetup.Get;
            EditorialSetup.TestField("Content Index Nos.");
            if NoSeriesMgt.SelectSeries(EditorialSetup."Content Index Nos.", OldContentListHdr."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := ContentListHdr;
                exit(true);
            end;
        end;
    end;
}

