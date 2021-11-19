Table 50041 "Agent Customer Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Agent Customer Header" - Circulation Module

    LookupPageID = "Agent Customer List";

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MagazineSalesSetup.Get;
                    NoSeriesMgt.TestManual(MagazineSalesSetup."Agent Customer Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
        }
        field(3; "Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine));

            trigger OnValidate()
            begin
                if not Item.Get("Magazine Item No.") then
                    Clear(Item);

                "Magazine Code" := Item."Magazine Code";
                "Volume No." := Item."Volume No.";
                "Issue No." := Item."Issue No.";
                "Issue Date" := Item."Issue Date";
                "Unit of Measure Code" := Item."Base Unit of Measure";
            end;
        }
        field(4; "Magazine Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Sub Product";
        }
        field(5; "Volume No."; Code[20])
        {
            Editable = false;
            TableRelation = Volume;
        }
        field(6; "Issue No."; Code[20])
        {
            Editable = false;
            TableRelation = "Issue No.";
        }
        field(7; "Issue Date"; Date)
        {
            Editable = false;
        }
        field(9; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(10; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(11; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Magazine Item No."));

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
                ResUnitofMeasure: Record "Resource Unit of Measure";
            begin
            end;
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(21; "Total Reserved Quantity"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Agent Customer Line".Quantity where("Agent Customer No." = field("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Total Reserved Amount"; Decimal)
        {
            CalcFormula = sum("Agent Customer Line"."Line Amount" where("Agent Customer No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
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
        AgentCustLine.Reset;
        AgentCustLine.SetRange("Agent Customer No.", "No.");
        AgentCustLine.SetRange("Delivered Flag", true);
        if AgentCustLine.Find('-') then
            Error(Text001);

        AgentCustLine.Reset;
        AgentCustLine.SetRange("Agent Customer No.", "No.");
        AgentCustLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MagazineSalesSetup.Get;
            MagazineSalesSetup.TestField("Agent Customer Nos.");
            NoSeriesMgt.InitSeries(MagazineSalesSetup."Agent Customer Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Document Date" := WorkDate;
    end;

    trigger OnModify()
    begin
        AgentCustLine.Reset;
        AgentCustLine.SetRange("Agent Customer No.", "No.");
        AgentCustLine.SetRange("Delivered Flag", true);
        if AgentCustLine.Find('-') then
            Error(Text001);
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        MagazineSalesSetup: Record "Magazine Sales Setup";
        Item: Record Item;
        AgentCustLine: Record "Agent Customer Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: label 'You cannot rename a %1.';
        Text001: label 'There was some agent customer line has been delivered.';


    procedure AssistEdit(OldAgentSalesHdr: Record "Agent Customer Header"): Boolean
    var
        AgentSalesHdr: Record "Agent Customer Header";
    begin
        with AgentSalesHdr do begin
            AgentSalesHdr := Rec;
            MagazineSalesSetup.Get;
            MagazineSalesSetup.TestField("Agent Customer Nos.");
            if NoSeriesMgt.SelectSeries(MagazineSalesSetup."Agent Customer Nos.", OldAgentSalesHdr."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := AgentSalesHdr;
                exit(true);
            end;
        end;
    end;
}

