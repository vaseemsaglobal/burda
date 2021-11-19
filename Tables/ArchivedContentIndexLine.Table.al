Table 50046 "Archived Content Index Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   18.05.2007   KKE   New table for "Archived Content Index Line" - Editorial Module


    fields
    {
        field(1; "Content List No."; Code[20])
        {
            TableRelation = "Archived Content Index Header";
        }
        field(2; "Content List Line No."; Integer)
        {
        }
        field(4; "Content Code"; Code[20])
        {
            TableRelation = "Content Column";
        }
        field(5; Description; Text[50])
        {
        }
        field(6; "No. of Page"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(7; "Content Type"; Code[20])
        {
            TableRelation = "Content Group Setup";
        }
        field(8; "Content Sub Type"; Code[20])
        {
            TableRelation = "Content Sub Group Setup";
        }
        field(9; "Author Name"; Text[50])
        {
        }
        field(10; "Description 2"; Text[50])
        {
        }
        field(11; "Source of Information"; Text[50])
        {
        }
        field(12; "Cost (LCY)"; Decimal)
        {
            Editable = false;
        }
        field(13; "Content Receipt Date"; Date)
        {
        }
        field(14; Status; Option)
        {
            Editable = false;
            OptionMembers = " ",Picked,Occupied,Approved,Cancelled;
        }
        field(15; "Actual Page No."; Integer)
        {
            Editable = false;
        }
        field(16; "Actual Sub Page No."; Integer)
        {
            Editable = false;
        }
        field(17; "Actual Volume No."; Code[20])
        {
            Editable = false;
            TableRelation = Volume;
        }
        field(18; "Actual Issue No."; Code[20])
        {
            Editable = false;
        }
        field(21; Size; Code[20])
        {
            TableRelation = "Ads. Size";
        }
        field(22; Position; Code[20])
        {
            TableRelation = "Ads. Position" where("Magazine Code" = field("Magazine Code"));
        }
        field(23; "Column Name"; Text[50])
        {
        }
        field(24; "Own Customer"; Code[20])
        {
            TableRelation = Customer;
        }
        field(25; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(26; "Unit Price"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(100; "Magazine Item No."; Code[20])
        {
            CalcFormula = lookup("Content Index Header"."Magazine Item No." where("No." = field("Content List No."),
                                                                                   "Magazine Code" = field("Magazine Code")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Item where("Item Type" = const(Magazine));
        }
        field(101; "Magazine Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Sub Product";
        }
    }

    keys
    {
        key(Key1; "Content List No.", "Content List Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';


    procedure ShowPhotoExpense()
    var
        PhotoExpense: Record "Photo Expense";
        formPhtoExpense: Page "Photo Expense";
    begin
        PhotoExpense.SetRange("Content Index No.", "Content List No.");
        PhotoExpense.SetRange("Content Index Line No.", "Content List Line No.");
        formPhtoExpense.SetTableview(PhotoExpense);
        formPhtoExpense.Editable := false;
        formPhtoExpense.RunModal;
    end;


    procedure ShowContentCost()
    var
        ContentCost: Record "Content Cost";
        formContentCost: Page "Content Cost";
    begin
        ContentCost.SetRange("Content Index No.", "Content List No.");
        ContentCost.SetRange("Content Index Line No.", "Content List Line No.");
        formContentCost.SetTableview(ContentCost);
        formContentCost.Editable := false;
        formContentCost.RunModal;
    end;
}

