Table 50017 "Content Column"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New table for "Content Setup" - Editorial Module

    LookupPageID = "Column Name Setup";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "No. of Page"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(5; "Content Group"; Code[20])
        {
            TableRelation = "Content Group Setup";
        }
        field(6; "Content Sub Group"; Code[20])
        {
            TableRelation = "Content Sub Group Setup";
        }
        field(7; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            begin
                LookupShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(8; Remark; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: Code[20];


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    end;
}

