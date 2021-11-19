Table 50011 "Sub Product"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New table for Magazine - Magazine Sales Module

    LookupPageID = "Sub Products";

    fields
    {
        field(1; "Sub Product Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Frequency; Code[20])
        {
            TableRelation = Frequency;
        }
        field(4; "Magazine Item Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(5; "Pick-up Interval"; DateFormula)
        {
        }
        field(6; "Unit Price"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(7; "Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(8; "Minimum No. of Page"; Integer)
        {
        }
        field(9; "Payment Method for Delivery"; Code[10])
        {
            TableRelation = "Payment Method";
        }
        field(10; "Ads. Item Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "Ads. Closing Interval"; DateFormula)
        {
        }
        field(12; "Subscriber S/O Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(13; "Defer Revenue SS Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(14; "Default Gen. Prod. Posting"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(15; "Circulation S/O Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(20; "Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Product;
        }
        field(50; "Shortcut Dimension 7 Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), Blocked = const(false));
            CaptionClass = '1,2,7';
        }
        field(60; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(70; "Unit Of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
    }

    keys
    {
        key(Key1; "Sub Product Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CheckFieldMandatory;
    end;

    trigger OnModify()
    begin
        CheckFieldMandatory;
    end;


    procedure CheckFieldMandatory()
    begin
        //TestField("Magazine Item Nos.");
        //TestField("Ads. Item Nos.");
        //TestField("Unit Price");
        //TestField("Ads. Closing Interval");
        TestField("Default Gen. Prod. Posting");
        TestField("Dimension 1 Code");
        TestField("Product Code");
    end;
}

