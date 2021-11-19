Table 50009 "Issue No."
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New table for Issue No. - Magazine Sales Module

    LookupPageID = "Issue No.";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Dimension 4 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(4, ShortcutDimCode);
                Validate("Dimension 4 Code", ShortcutDimCode);
            end;
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
        //TestField("Dimension 4 Code"); //VAH
    end;

    trigger OnModify()
    begin
        //TestField("Dimension 4 Code"); //VAH
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: Code[20];
}

