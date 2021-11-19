Table 50052 "Archived Ads. Billing Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   01.06.2007   KKE   New table for "Archived Ads. Billing Header" - Ads. Sales Module

    LookupPageID = "Archived Ads. Billing List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Billing Date"; Date)
        {
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            var
            //TempDocDim: Record "Document Dimension" temporary;
            begin
            end;
        }
        field(5; "Bill-to Name"; Text[50])
        {
            Caption = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name';
        }
        field(7; "Bill-to Address"; Text[50])
        {
            Caption = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(9; "Bill-to Address 3"; Text[30])
        {
            Caption = 'Bill-to Address 3';
        }
        field(10; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
        }
        field(11; "Bill-to Contact"; Text[50])
        {
            Caption = 'Bill-to Contact';
        }
        field(12; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(13; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
        }
        field(14; "Bill-to Country Code"; Code[10])
        {
            Caption = 'Bill-to Country Code';
            TableRelation = "Country/Region";
        }
        field(15; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(16; "Due Date"; Date)
        {
        }
        field(20; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Release;
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; Remark; Text[100])
        {
        }
        field(23; Comment; Boolean)
        {
            CalcFormula = exist("Sales Comment Line" where("Document Type" = const("Ads. Billing"),
                                                            "No." = field("No.")));
            Caption = 'Comment';
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
}

