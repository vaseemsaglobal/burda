Table 50029 "Ads. Position"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Ads. Position" - Ads. Sales Module

    LookupPageID = "Ads. Position";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";
        }
        field(3; "Position Type"; Option)
        {
            OptionMembers = "Fixed",ROP;
        }
        field(4; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            begin
                LookupShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(5; Description; Text[50])
        {
        }
        field(10; Closed; Boolean)
        {
        }
        field(11; PositionPrint; Boolean)
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

    trigger OnInsert()
    begin
        TestField("Shortcut Dimension 5 Code");
    end;

    trigger OnModify()
    begin
        TestField("Shortcut Dimension 5 Code");
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: Code[20];


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    end;
}

