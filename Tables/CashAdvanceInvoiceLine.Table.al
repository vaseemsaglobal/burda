Table 55055 "Cash Advance Invoice Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.
    // Burda
    // 002   14.08.2007   KKE   Average VAT.

    Caption = 'Cash Advance Invoice Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Cash Advance Invoice Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Cash Advance Vendor No."; Code[20])
        {
            Caption = 'Cash Advance Vendor No.';
            TableRelation = Vendor where("Cash Advance" = const(true));
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            InitValue = "G/L Account";
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item
            else
            if (Type = const(" ")) Resource
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge";

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Cross Reference";
            begin
            end;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(10; "Amount Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Incl. VAT';
        }
        field(11; "Amount (LCY) Incl. VAT"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY) Incl. VAT';
        }
        field(12; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(13; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
        }
        field(14; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(21; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(22; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(23; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(24; "WHT Business Posting Group"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            TableRelation = "WHT Business Posting Group";
        }
        field(25; "WHT Product Posting Group"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            TableRelation = "WHT Product Posting Group";
        }
        field(26; "WHT Absorb Base"; Decimal)
        {
            Caption = 'WHT Absorb Base';
        }
        field(30; "Real Customer/Vendor Name"; Text[120])
        {
            Caption = 'Real Customer/Vendor Name';
        }
        field(31; "Actual Vendor No."; Code[20])
        {
            Caption = 'Actual Vendor No.';
            TableRelation = Vendor;
        }
        field(32; "Skip WHT"; Boolean)
        {
            Caption = 'Skip WHT';
        }
        field(33; "WHT Certificate No."; Code[20])
        {
            Caption = 'WHT Certificate No.';
        }
        field(34; "Certificate Printed"; Boolean)
        {
            Caption = 'Certificate Printed';
            Editable = false;
        }
        field(35; "WHT Entry No."; Integer)
        {
            Caption = 'WHT Entry No.';
        }
        field(40; "Tax Invoice No."; Code[20])
        {
            Caption = 'Tax Invoice No.';
        }
        field(41; "Tax Invoice Date"; Date)
        {
            Caption = 'Tax Invoice Date';
        }
        field(42; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(50; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Amount (LCY)';
            Editable = false;
        }
        field(79; "VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Base Amount (LCY)';
            Editable = false;
        }
        field(85; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(100; "Balance Amount Settle"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance Amount Settle';
            Editable = false;
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(50020; "VAT Claim %"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50021; "VAT Unclaim %"; Decimal)
        {
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50022; "Avg. VAT Amount"; Decimal)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50024; "Average VAT Year"; Integer)
        {
            Description = 'Burda1.00';
            TableRelation = "Average VAT Setup";
        }
        field(50025; "Bank Code"; Text[30])
        {
            Description = 'Burda1.00';
        }
        field(50026; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
            Description = 'Burda1.00';
        }
        field(50027; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
            Description = 'Burda1.00';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Amount Incl. VAT", "Amount (LCY) Incl. VAT", "Balance Amount Settle";
        }
    }

    fieldgroups
    {
    }


    /*procedure ShowDimensions()
    var
        PostedDocDim: Record "Posted Document Dimension";
        PostedDocDimensions: Page UnknownPage547;
    begin
        TestField("No.");
        TestField("Line No.");
        PostedDocDim.SetRange("Table ID", Database::"Cash Advance Invoice Line");
        PostedDocDim.SetRange("Document No.", "Document No.");
        PostedDocDim.SetRange("Line No.", "Line No.");
        PostedDocDimensions.SetTableview(PostedDocDim);
        PostedDocDimensions.RunModal;
    end;*/
    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin


        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 ', "Document No.", "Line No."));
        //VerifyItemLineDim();
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //ATOLink.UpdateAsmDimFromSalesLine(Rec);
        IsChanged := OldDimSetID <> "Dimension Set ID";


    end;

    var
        DimMgt: Codeunit DimensionManagement;
}

