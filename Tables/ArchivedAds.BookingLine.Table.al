Table 50040 "Archived Ads. Booking Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   09.05.2007   KKE   New table for "Archived Ads. Booking Line" - Ads. Sales Module
    // 002   19.10.2010   GKU   Add field "Status Date"

    DrillDownPageID = "Archived Ads. Booking Lines";
    LookupPageID = "Archived Ads. Booking Lines";

    fields
    {
        field(1; "Booking No."; Code[20])
        {
            TableRelation = "Archived Ads. Booking Header";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Ads. Item No."; Code[20])
        {
            TableRelation = "Ads. Item";

            trigger OnValidate()
            var
                TempAdsBookingLine: Record "Ads. Booking Line";
            begin
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
        field(8; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            begin
                LookupShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(9; "Ads. Closing Date"; Date)
        {
        }
        field(10; "Booking Revenue Code"; Code[20])
        {
            TableRelation = "Booking Revenue Type";
        }
        field(11; "Booking Revenue Type"; Option)
        {
            OptionMembers = Billable,"Non-Billable","House-Ads.";
        }
        field(12; "Ads. Size"; Code[20])
        {
            TableRelation = "Ads. Size";
        }
        field(13; "Ads. Type"; Code[20])
        {
            TableRelation = "Ads. Type";
        }
        field(14; "Ads. Sub-Type"; Code[20])
        {
            TableRelation = "Ads. Sub Type".Code where("Ads. Type" = field("Ads. Type"));
        }
        field(15; "Ads. Position"; Code[20])
        {
            TableRelation = "Ads. Position" where("Magazine Code" = field("Magazine Code"));
        }
        field(16; "Ads. Product"; Code[20])
        {
            TableRelation = Brand;
        }
        field(17; "Owner Customer"; Code[20])
        {
            TableRelation = Customer;
        }
        field(18; "Product Category"; Code[20])
        {
            TableRelation = "Product Category";
        }
        field(19; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            InitValue = 1;
        }
        field(20; "Unit Price Excl. VAT"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(21; Amount; Decimal)
        {
            AutoFormatType = 1;
        }
        field(22; "Amount Including VAT"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(23; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(24; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(25; "Create Sales Invoice"; Boolean)
        {
            Editable = false;
        }
        field(26; "Cash Invoice Amount"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(27; "Bill Revenue G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(28; "Barter Amount"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(29; "Barter G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(30; "Barter Required Document"; Boolean)
        {
            Editable = false;
        }
        field(31; "Line Status"; Option)
        {
            Editable = false;
            OptionMembers = Booking,"Waiting List",Confirmed,Approved,Hold,Cancelled,Invoiced,Closed," ";
        }
        field(32; "Waiting List No."; Integer)
        {
            Editable = false;
        }
        field(33; "Scheduled Invoice Date"; Date)
        {
        }
        field(34; "Cash Invoice No."; Code[20])
        {
            Editable = false;
        }
        field(35; "Barter Invoice No."; Code[20])
        {
            Editable = false;
        }
        field(36; Closed; Boolean)
        {
            Editable = false;
        }
        field(37; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(38; "Booking Date"; Date)
        {
        }
        field(39; "Counting Unit"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(40; "Require Contract"; Boolean)
        {
        }
        field(41; "Have Artwork"; Boolean)
        {
        }
        field(42; "Contact person for artwork"; Text[50])
        {
        }
        field(43; "Total Number of Insertion"; Integer)
        {
        }
        field(44; "Actual Volume No."; Code[20])
        {
            Editable = false;
            TableRelation = Volume;
        }
        field(45; "Actual Issue No."; Code[20])
        {
            TableRelation = "Issue No.";
        }
        field(46; "Actual Page No."; Integer)
        {
        }
        field(47; "Actual Sub Page No."; Integer)
        {
        }
        field(48; "Complimentary Offer"; Text[50])
        {
        }
        field(50; Remark; Text[100])
        {
            Description = '50-->100';
        }
        field(52; "Planning Status"; Option)
        {
            Editable = false;
            OptionMembers = " ",Picked,Occupied,Approved;
        }
        field(60; "Total Counting Unit"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = '=CountingUnit * Quantity, used on Booking Overview';
        }
        field(100; "Salesperson Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(101; "Sell-to Customer No."; Code[20])
        {
            CalcFormula = lookup("Ads. Booking Header"."Final Customer No." where("No." = field("Booking No.")));
            Caption = 'Sell-to Customer No.';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Customer;
        }
        field(102; "Bill-to Customer No."; Code[20])
        {
            CalcFormula = lookup("Ads. Booking Header"."Bill-to Customer No." where("No." = field("Booking No.")));
            Caption = 'Bill-to Customer No.';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Customer;

            trigger OnValidate()
            var
            //TempDocDim: Record "Document Dimension" temporary;
            begin
            end;
        }
        field(120; "Ads. Product Description 2"; Text[50])
        {
        }
        field(121; "Last Status Date"; DateTime)
        {
        }
        field(122; "Cancelled Date"; DateTime)
        {
            Editable = false;
        }
        field(500; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Booking No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Ads. Item No.", "Line Status", "Magazine Code")
        {
            SumIndexFields = "Total Counting Unit";
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    end;
}

