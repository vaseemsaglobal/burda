Table 50042 "Agent Customer Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Agent Customer Line" - Circulation Module


    fields
    {
        field(1; "Agent Customer No."; Code[20])
        {
            TableRelation = "Agent Customer Header";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if not Cust.Get("Sell-to Customer No.") then
                    Clear(Cust);
                "Bill-to Customer No." := Cust."Bill-to Customer No.";
                "Customer Posting Group" := Cust."Customer Posting Group";
            end;
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
        field(5; "Ship-to Customer No."; Code[20])
        {
            Caption = 'Ship-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            var
            //TempDocDim: Record "Document Dimension" temporary;
            begin
            end;
        }
        field(6; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * "Unit Price" * (1 - "Discount %" / 100);
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;

            trigger OnValidate()
            begin
                Validate(Quantity);
            end;
        }
        field(8; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                Validate(Quantity);
            end;
        }
        field(11; "Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(15; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(20; "Delivered Flag"; Boolean)
        {
            Editable = false;
        }
        field(21; "Delivered Date"; Date)
        {
            Editable = false;
        }
        field(22; "Delivered Document No."; Code[20])
        {
            Editable = false;
        }
        field(23; "Delivered Document Line No."; Integer)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Agent Customer No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Quantity, "Line Amount";
        }
        key(Key2; "Sell-to Customer No.", "Bill-to Customer No.")
        {
            SumIndexFields = Quantity, "Line Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Delivered Flag", false);
    end;

    trigger OnModify()
    begin
        TestField("Delivered Flag", false);
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Cust: Record Customer;
        Text000: label 'You cannot rename a %1.';
}

