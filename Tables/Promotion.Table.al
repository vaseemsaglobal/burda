Table 50004 Promotion
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New table for Promotion - Subscription Module

    LookupPageID = "Subscriber Promotion List";

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MagazineAdsSetup.Get;
                    NoSeriesMgt.TestManual(MagazineAdsSetup."Promotion Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Promotion Date"; Date)
        {
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; "End Date"; Date)
        {
        }
        field(6; "Limitation Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(7; "Magazine Item Code"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine));

            trigger OnValidate()
            begin
                if Item.Get("Magazine Item Code") then begin
                    "Magazine Code" := Item."Magazine Code";
                    "Volume No." := Item."Volume No.";
                    "Issue No." := Item."Issue No.";
                    "Issue Date" := Item."Issue Date";
                end else begin
                    "Magazine Code" := '';
                    "Volume No." := '';
                    "Issue No." := '';
                    "Issue Date" := 0D;
                end;
            end;
        }
        field(8; "Magazine Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Sub Product";
        }
        field(9; "Volume No."; Code[20])
        {
            Editable = false;
            TableRelation = Volume;
        }
        field(10; "Issue No."; Code[20])
        {
            Editable = false;
            TableRelation = "Issue No.";
        }
        field(11; "Issue Date"; Date)
        {
            Editable = false;
        }
        field(12; "Promotion Type"; Option)
        {
            Caption = 'Promotion Type';
            OptionMembers = " ",Discount,Premium,Both;

            trigger OnValidate()
            begin
                case "Promotion Type" of
                    "promotion type"::" ":
                        begin
                            TestField("Discount Value", 0);
                            TestField("Premium Flag", false);
                            TestField("Free Magazine Flag", false);
                        end;
                    "promotion type"::Discount:
                        begin
                            TestField("Premium Flag", false);
                            TestField("Free Magazine Flag", false);
                        end;
                    "promotion type"::Premium:
                        begin
                            TestField("Discount Value", 0);
                        end;
                end;
            end;
        }
        field(13; "Discount Type"; Option)
        {
            Caption = 'Discount Type';
            OptionMembers = " ",Amount,Percentage;

            trigger OnValidate()
            begin
                Validate("Discount Value");
                Validate("Promotion Price");
            end;
        }
        field(14; "Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            MinValue = 0;

            trigger OnValidate()
            begin
                if (("Discount Value" > 100) or ("Discount Value" < 0)) and ("Discount Type" = "discount type"::Percentage) then
                    Error(Text002);
                Validate("Promotion Price");
            end;
        }
        field(15; "Credit Card Bank"; Text[30])
        {
        }
        field(16; "Promotion Duration"; Option)
        {
            Caption = 'Promotion Duration';
            OptionMembers = " ","2 Months","3 Months","6 Months","1 Year","2 Years","18 Months","3 Years";
        }
        field(17; "Promotion Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Promotion Price';

            trigger OnValidate()
            begin
                if "Discount Type" = "discount type"::Percentage then
                    "Promotion Net Price" := "Promotion Price" - ROUND("Promotion Price" * "Discount Value" / 100)
                else
                    "Promotion Net Price" := "Promotion Price" - "Discount Value";
            end;
        }
        field(18; "Promotion Quantity"; Decimal)
        {
            Caption = 'Promotion Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(19; "Promotion Net Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Promotion Net Price';
            Editable = false;
        }
        field(20; "Premium Flag"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Premium Flag" = false then begin
                    TestField("Premium Item 1", '');
                    TestField("Premium Quantity 1", 0);
                    TestField("Premium Item 2", '');
                    TestField("Premium Quantity 2", 0);
                    TestField("Premium Item 3", '');
                    TestField("Premium Quantity 3", 0);
                    TestField("Premium Item 4", '');
                    TestField("Premium Quantity 4", 0);
                    TestField("Premium Item 5", '');
                    TestField("Premium Quantity 5", 0);
                end;
            end;
        }
        field(21; "Premium Item 1"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 1" = '' then
                    "Premium Quantity 1" := 0
                else
                    "Premium Quantity 1" := 1;
            end;
        }
        field(22; "Premium Quantity 1"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Premium Quantity 1" <> 0 then
                    TestField("Premium Item 1");
            end;
        }
        field(23; "Premium Item 2"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 2" = '' then
                    "Premium Quantity 2" := 0
                else
                    "Premium Quantity 2" := 1;
            end;
        }
        field(24; "Premium Quantity 2"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Premium Quantity 2" <> 0 then
                    TestField("Premium Item 2");
            end;
        }
        field(25; "Premium Item 3"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 3" = '' then
                    "Premium Quantity 3" := 0
                else
                    "Premium Quantity 3" := 1;
            end;
        }
        field(26; "Premium Quantity 3"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Premium Quantity 3" <> 0 then
                    TestField("Premium Item 3");
            end;
        }
        field(27; "Premium Item 4"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 4" = '' then
                    "Premium Quantity 4" := 0
                else
                    "Premium Quantity 4" := 1;
            end;
        }
        field(28; "Premium Quantity 4"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Premium Quantity 4" <> 0 then
                    TestField("Premium Item 4");
            end;
        }
        field(29; "Premium Item 5"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 5" = '' then
                    "Premium Quantity 5" := 0
                else
                    "Premium Quantity 5" := 1;
            end;
        }
        field(30; "Premium Quantity 5"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Premium Quantity 5" <> 0 then
                    TestField("Premium Item 5");
            end;
        }
        field(31; "Free Magazine Flag"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Free Magazine Flag" = false then begin
                    TestField("Free Magazine Code", '');
                    TestField("Free Magazine Quantity", 0);
                end;
            end;
        }
        field(32; "Free Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";

            trigger OnValidate()
            begin
                if "Free Magazine Code" <> '' then begin
                    TestField("Free Magazine Flag", true);
                    TestField("Free Magazine Code", "Magazine Code");
                end else
                    Validate("Free Magazine Quantity", 0);
            end;
        }
        field(33; "Free Magazine Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Free Magazine Quantity" <> 0 then
                    TestField("Free Magazine Code");
            end;
        }
        field(34; "Free Other Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";

            trigger OnValidate()
            begin
                if "Free Other Magazine Code" <> '' then begin
                    if "Free Other Magazine Code" = "Magazine Code" then
                        Error(Text003, FieldCaption("Free Other Magazine Code"), FieldCaption("Magazine Code"));
                end else
                    Validate("Free Other Magazine Quantity", 0);
            end;
        }
        field(35; "Free Other Magazine Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Free Other Magazine Quantity" <> 0 then
                    TestField("Free Other Magazine Code");
            end;
        }
        field(49; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Promotion),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(51; "Comment Text"; Text[30])
        {
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
    var
        SubscriberContract: Record "Subscriber Contract";
    begin
        SubscriberContract.SetRange("Promotion Code", "No.");
        if SubscriberContract.Find('-') then
            Error(Text001, "No.", SubscriberContract."No.");
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MagazineAdsSetup.Get;
            MagazineAdsSetup.TestField("Promotion Nos.");
            NoSeriesMgt.InitSeries(MagazineAdsSetup."Promotion Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Promotion Date" := WorkDate;
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        MagazineAdsSetup: Record "Subscription Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: label 'You cannot rename a %1.';
        Text001: label 'You cannot delete promotion %1 because it has been used by subscriber contract %2.';
        Text002: label 'Invalid Discount Value.';
        Item: Record Item;
        Text003: label '%1 and %2 must be different.';


    procedure AssistEdit(OldPromotion: Record Promotion): Boolean
    var
        Promotion: Record Promotion;
    begin
        with Promotion do begin
            Promotion := Rec;
            MagazineAdsSetup.Get;
            MagazineAdsSetup.TestField("Promotion Nos.");
            if NoSeriesMgt.SelectSeries(MagazineAdsSetup."Promotion Nos.", OldPromotion."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Promotion;
                exit(true);
            end;
        end;
    end;
}

