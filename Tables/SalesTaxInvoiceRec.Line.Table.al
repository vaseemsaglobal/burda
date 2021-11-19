Table 50055 "Sales Tax Invoice/Rec. Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   15.05.2007   KKE   New table for "Sales Tax Invoice/Receipt Line" - Ads. Sales Module

    Caption = 'Sales Tax Invoice/Rec. Line';
    PasteIsValid = false;

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Tax Invoice/Rec. Header";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";

            trigger OnValidate()
            begin
                TestStatusOpen;
                GetSalesHeader;
                TestField("Posted Document No.", '');

                TempSalesLine := Rec;
                //DimMgt.DeletePostedDocDim(Database::"Sales Tax Invoice/Rec. Line","Document No.","Line No.");
                Init;
                Type := TempSalesLine.Type;
            end;
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
            if (Type = const(Resource)) Resource
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge";

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Cross Reference";
            begin
                TestStatusOpen;
                TestField("Posted Document No.", '');

                TempSalesLine := Rec;
                Init;
                Type := TempSalesLine.Type;
                "No." := TempSalesLine."No.";
                if "No." = '' then
                    exit;
                if Type <> Type::" " then
                    Quantity := TempSalesLine.Quantity;

                GetSalesHeader;
                SalesTaxInvHeader.TestField("Sell-to Customer No.");

                "Sell-to Customer No." := SalesTaxInvHeader."Sell-to Customer No.";
                "Job No." := SalesTaxInvHeader."Job No.";
                "Location Code" := SalesTaxInvHeader."Location Code";
                "Customer Price Group" := SalesTaxInvHeader."Customer Price Group";
                "Customer Disc. Group" := SalesTaxInvHeader."Customer Disc. Group";
                "Allow Line Disc." := SalesTaxInvHeader."Allow Line Disc.";
                "Transaction Type" := SalesTaxInvHeader."Transaction Type";
                "Transport Method" := SalesTaxInvHeader."Transport Method";
                "Bill-to Customer No." := SalesTaxInvHeader."Bill-to Customer No.";
                "Gen. Bus. Posting Group" := SalesTaxInvHeader."Gen. Bus. Posting Group";
                "WHT Business Posting Group" := SalesTaxInvHeader."WHT Business Posting Group";
                "VAT Bus. Posting Group" := SalesTaxInvHeader."VAT Bus. Posting Group";
                "Exit Point" := SalesTaxInvHeader."Exit Point";
                Area := SalesTaxInvHeader.Area;
                "Transaction Specification" := SalesTaxInvHeader."Transaction Specification";
                "Tax Area Code" := SalesTaxInvHeader."Tax Area Code";
                "Tax Liable" := SalesTaxInvHeader."Tax Liable";
                "Responsibility Center" := SalesTaxInvHeader."Responsibility Center";

                case Type of
                    Type::" ":
                        begin
                            StdTxt.Get("No.");
                            Description := StdTxt.Description;
                        end;
                    Type::"G/L Account":
                        begin
                            GLAcc.Get("No.");
                            GLAcc.CheckGLAcc;
                            if not "System-Created Entry" then
                                GLAcc.TestField("Direct Posting", true);
                            Description := GLAcc.Name;
                            "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
                            "WHT Product Posting Group" := GLAcc."WHT Product Posting Group";
                            "Tax Group Code" := GLAcc."Tax Group Code";
                            "Allow Invoice Disc." := false;
                        end;
                    Type::Item:
                        begin
                            GetItem;
                            Item.TestField(Blocked, false);
                            Item.TestField("Inventory Posting Group");
                            Item.TestField("Gen. Prod. Posting Group");

                            "Posting Group" := Item."Inventory Posting Group";
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";
                            GetUnitCost;
                            "Allow Invoice Disc." := Item."Allow Invoice Disc.";
                            "Units per Parcel" := Item."Units per Parcel";
                            "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                            "WHT Product Posting Group" := Item."WHT Product Posting Group";
                            "Tax Group Code" := Item."Tax Group Code";
                            "Item Category Code" := Item."Item Category Code";
                            //"Product Group Code" := Item."Product Group Code";
                            Nonstock := Item."Created From Nonstock Item";

                            if SalesTaxInvHeader."Language Code" <> '' then
                                GetItemTranslation;

                            "Unit of Measure Code" := Item."Sales Unit of Measure";
                        end;
                    Type::Resource:
                        begin
                            Res.Get("No.");
                            Res.TestField(Blocked, false);
                            Res.TestField("Gen. Prod. Posting Group");
                            Description := Res.Name;
                            "Unit of Measure Code" := Res."Base Unit of Measure";
                            "Unit Cost (LCY)" := Res."Unit Cost";
                            "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := Res."VAT Prod. Posting Group";
                            "WHT Product Posting Group" := Res."WHT Product Posting Group";
                            "Tax Group Code" := Res."Tax Group Code";
                            FindResUnitCost;
                        end;
                    Type::"Fixed Asset":
                        begin
                            FA.Get("No.");
                            FA.TestField(Inactive, false);
                            FA.TestField(Blocked, false);
                            GetFAPostingGroup;
                            Description := FA.Description;
                            "Description 2" := FA."Description 2";
                            "Allow Invoice Disc." := false;
                        end;
                    Type::"Charge (Item)":
                        begin
                            ItemCharge.Get("No.");
                            Description := ItemCharge.Description;
                            "Gen. Prod. Posting Group" := ItemCharge."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := ItemCharge."VAT Prod. Posting Group";
                            "WHT Product Posting Group" := ItemCharge."WHT Product Posting Group";
                            "Tax Group Code" := ItemCharge."Tax Group Code";
                            "Allow Invoice Disc." := false;
                        end;
                end;

                if Type <> Type::" " then begin
                    if Type <> Type::"Fixed Asset" then
                        Validate("VAT Prod. Posting Group");
                    Validate("WHT Product Posting Group");
                    Validate("Unit of Measure Code");
                end;

                CreateDim(
                  DimMgt.TypeToTableID3(Type), "No.",
                  Database::Job, "Job No.",
                  Database::"Responsibility Center", "Responsibility Center");
            end;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));

            trigger OnValidate()
            begin
                TestStatusOpen;

                GetSalesHeader;

                if Type = Type::Item then
                    GetUnitCost;
            end;
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = if (Type = const(Item)) "Inventory Posting Group"
            else
            if (Type = const("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestStatusOpen;

                "Quantity (Base)" := CalcBaseQty(Quantity);

                Validate("Line Discount %");

                if (xRec.Quantity <> Quantity) and (Quantity = 0) and
                  ((Amount <> 0) or ("Amount Including VAT" <> 0) or ("VAT Base Amount" <> 0))
                then begin
                    Amount := 0;
                    "Amount Including VAT" := 0;
                    "VAT Base Amount" := 0;
                end;
            end;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FIELDNO("Unit Price"));
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                TestStatusOpen;
                Validate("Line Discount %");
            end;
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';

            trigger OnValidate()
            begin
                GetSalesHeader;
                "Unit Cost" := "Unit Cost (LCY)";
            end;
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestStatusOpen;
                "Line Discount Amount" :=
                  ROUND(
                    ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") *
                    "Line Discount %" / 100, Currency."Amount Rounding Precision");
                "Inv. Discount Amount" := 0;
                UpdateAmounts;
            end;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TestField(Quantity);
                if ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") <> 0 then
                    "Line Discount %" :=
                      ROUND(
                       "Line Discount Amount" / ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") * 100,
                        0.00001)
                else
                    "Line Discount %" := 0;
                "Inv. Discount Amount" := 0;
                UpdateAmounts;
            end;
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;

            trigger OnValidate()
            begin
                TestStatusOpen;
                if ("Allow Invoice Disc." <> xRec."Allow Invoice Disc.") and
                   (not "Allow Invoice Disc.")
                then begin
                    "Inv. Discount Amount" := 0;
                    UpdateAmounts;
                end;
            end;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
            end;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(42; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            Editable = false;
            TableRelation = "Customer Price Group";
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(46; "Appl.-to Job Entry"; Integer)
        {
            Caption = 'Appl.-to Job Entry';
        }
        field(47; "Phase Code"; Code[10])
        {
            Caption = 'Phase Code';
            //TableRelation = Table161;
        }
        field(48; "Task Code"; Code[10])
        {
            Caption = 'Task Code';
            //TableRelation = Table162;
        }
        field(49; "Step Code"; Code[10])
        {
            Caption = 'Step Code';
            //TableRelation = Table163;
        }
        field(50; "Job Applies-to ID"; Code[20])
        {
            Caption = 'Job Applies-to ID';
        }
        field(51; "Apply and Close (Job)"; Boolean)
        {
            Caption = 'Apply and Close (Job)';
        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
            Editable = false;
        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
            Editable = false;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Quantity);
                UpdateAmounts;
            end;
        }
        field(73; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            Editable = true;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                TestStatusOpen;
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";

            trigger OnValidate()
            begin
                UpdateAmounts;
            end;
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';

            trigger OnValidate()
            begin
                UpdateAmounts;
            end;
        }
        field(87; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";

            trigger OnValidate()
            begin
                TestStatusOpen;
                UpdateAmounts;
            end;
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                Validate("VAT Prod. Posting Group");
            end;
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                TestStatusOpen;
                VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                "VAT Difference" := 0;
                "VAT %" := VATPostingSetup."VAT %";
                "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                "VAT Identifier" := VATPostingSetup."VAT Identifier";
                case "VAT Calculation Type" of
                    "vat calculation type"::"Reverse Charge VAT",
                  "vat calculation type"::"Sales Tax":
                        "VAT %" := 0;
                    "vat calculation type"::"Full VAT":
                        begin
                            TestField(Type, Type::"G/L Account");
                            VATPostingSetup.TestField("Sales VAT Account");
                            TestField("No.", VATPostingSetup."Sales VAT Account");
                        end;
                end;
                if SalesTaxInvHeader."Prices Including VAT" and (Type in [Type::Item, Type::Resource]) then
                    "Unit Price" :=
                      ROUND(
                        "Unit Price" * (100 + "VAT %") / (100 + xRec."VAT %"),
                        Currency."Unit-Amount Rounding Precision");
                UpdateAmounts;
            end;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
            Caption = 'Line Amount';

            trigger OnValidate()
            begin
                TestField(Type);
                TestField(Quantity);
                TestField("Unit Price");
                GetSalesHeader;
                "Line Amount" := ROUND("Line Amount", Currency."Amount Rounding Precision");
                Validate(
                  "Line Discount Amount", ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") - "Line Amount");
            end;
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            Caption = 'IC Partner Ref. Type';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.";

            trigger OnValidate()
            begin
                if "IC Partner Ref. Type" <> xRec."IC Partner Ref. Type" then
                    "IC Partner Reference" := '';
                if "IC Partner Ref. Type" = "ic partner ref. type"::"Common Item No." then begin
                    if Item."No." <> "No." then
                        Item.Get("No.");
                    "IC Partner Reference" := Item."Common Item No.";
                end;
            end;
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            Caption = 'IC Partner Reference';

            trigger OnLookup()
            var
                ICGLAccount: Record "IC G/L Account";
                ItemCrossReference: Record "Item Cross Reference";
            begin
                if "No." <> '' then
                    case "IC Partner Ref. Type" of
                        "ic partner ref. type"::"G/L Account":
                            if Page.RunModal(Page::"IC G/L Account List", ICGLAccount) = Action::LookupOK then
                                Validate("IC Partner Reference", ICGLAccount."No.");
                        "ic partner ref. type"::Item:
                            if Page.RunModal(Page::"Item List", Item) = Action::LookupOK then
                                Validate("IC Partner Reference", Item."No.");
                        "ic partner ref. type"::"Cross Reference":
                            begin
                                ItemCrossReference.Reset;
                                ItemCrossReference.SetCurrentkey("Cross-Reference Type", "Cross-Reference Type No.");
                                ItemCrossReference.SetFilter(
                                  "Cross-Reference Type", '%1|%2',
                                  ItemCrossReference."cross-reference type"::Customer,
                                  ItemCrossReference."cross-reference type"::" ");
                                ItemCrossReference.SetFilter("Cross-Reference Type No.", '%1|%2', "Sell-to Customer No.", '');
                                if Page.RunModal(Page::"Cross Reference List", ItemCrossReference) = Action::LookupOK then
                                    Validate("IC Partner Reference", ItemCrossReference."Cross-Reference No.");
                            end;
                    end;
            end;
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
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));

            trigger OnValidate()
            begin
                if "Variant Code" <> '' then
                    TestField(Type, Type::Item);
                TestStatusOpen;

                if Type = Type::Item then begin
                    GetUnitCost;
                    //UpdateUnitPrice((FIELDNO("Variant Code")));
                end;

                if "Variant Code" = '' then begin
                    if Type = Type::Item then begin
                        Item.Get("No.");
                        Description := Item.Description;
                        "Description 2" := Item."Description 2";
                        GetItemTranslation;
                    end;
                    exit;
                end;

                ItemVariant.Get("No.", "Variant Code");
                Description := ItemVariant.Description;
                "Description 2" := ItemVariant."Description 2";

                GetSalesHeader;
                if SalesTaxInvHeader."Language Code" <> '' then
                    GetItemTranslation;
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
                ResUnitofMeasure: Record "Resource Unit of Measure";
            begin
                TestStatusOpen;

                if "Unit of Measure Code" = '' then
                    "Unit of Measure" := ''
                else begin
                    if not UnitOfMeasure.Get("Unit of Measure Code") then
                        UnitOfMeasure.Init;
                    "Unit of Measure" := UnitOfMeasure.Description;
                    GetSalesHeader;
                    if SalesTaxInvHeader."Language Code" <> '' then begin
                        UnitOfMeasureTranslation.SetRange(Code, "Unit of Measure Code");
                        UnitOfMeasureTranslation.SetRange("Language Code", SalesTaxInvHeader."Language Code");
                        if UnitOfMeasureTranslation.Find('-') then
                            "Unit of Measure" := UnitOfMeasureTranslation.Description;
                    end;
                end;
                Validate(Quantity);
            end;
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate(Quantity, "Quantity (Base)");
            end;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";

            trigger OnValidate()
            begin
                GetFAPostingGroup;
            end;
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";

            trigger OnValidate()
            begin
                "Use Duplication List" := false;
            end;
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';

            trigger OnValidate()
            begin
                "Duplicate in Depreciation Book" := '';
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                CreateDim(
                  Database::"Responsibility Center", "Responsibility Center",
                  DimMgt.TypeToTableID3(Type), "No.",
                  Database::Job, "Job No.");
            end;
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';

            trigger OnValidate()
            var
                ReturnedCrossRef: Record "Item Cross Reference";
            begin
            end;
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."));
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
        }
        field(5709; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            Editable = false;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code where("Item Category Code" = field("Item Category Code"));
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7002; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(17110; "S/T Exempt"; Boolean)
        {
            Caption = 'S/T Exempt';
        }
        field(28040; "WHT Business Posting Group"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            TableRelation = "WHT Business Posting Group";
        }
        field(28041; "WHT Product Posting Group"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            TableRelation = "WHT Product Posting Group";
        }
        field(28042; "WHT Absorb Base"; Decimal)
        {
            Caption = 'WHT Absorb Base';
        }
        field(50058; "Posted Document Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Invoice,Credit Memo';
            OptionMembers = Invoice,"Credit Memo";
        }
        field(50059; "Posted Document No."; Code[20])
        {
            Caption = 'Posted Document No.';
            Editable = false;
            TableRelation = if ("Posted Document Type" = const(Invoice)) "Sales Invoice Header"
            else
            if ("Posted Document Type" = const("Credit Memo")) "Sales Cr.Memo Header";
        }
        field(50060; "Posted Document Line No."; Integer)
        {
            Caption = 'Posted Document No.';
            Editable = false;
            TableRelation = if ("Posted Document Type" = const(Invoice)) "Sales Invoice Line"."Line No." where("Document No." = field("Posted Document No."))
            else
            if ("Posted Document Type" = const("Credit Memo")) "Sales Cr.Memo Line"."Line No." where("Document No." = field("Posted Document No."));
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount Including VAT";
        }
        key(Key2; "Sell-to Customer No.")
        {
        }
        key(Key3; "Sell-to Customer No.", Type, "Document No.")
        {
        }
        key(Key4; "Shipment No.", "Shipment Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        //DocDim: Record "Document Dimension";
        CapableToPromise: Codeunit "Capable to Promise";
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        TestStatusOpen;
        SalesPost.UpdateSalesTaxInvoice(Rec);
        /*---
        SalesInvLine.SETCURRENTKEY("Sales Tax Invoice/Receipt No.","Sales Tax Invoice/Receipt Line");
        SalesInvLine.SETRANGE("Sales Tax Invoice/Receipt No.","Document No.");
        SalesInvLine.SETRANGE("Sales Tax Invoice/Receipt Line","Line No.");
        IF SalesInvLine.FIND('-') THEN
          REPEAT
            SalesInvLine."Sales Tax Invoice/Receipt No." := '';
            SalesInvLine."Sales Tax Invoice/Receipt Line" := 0;
            SalesInvLine.MODIFY;
          UNTIL SalesInvLine.NEXT=0;
        
        SalesCrMemoLine.SETCURRENTKEY("Sales Tax Invoice/Receipt No.","Sales Tax Invoice/Receipt Line");
        SalesCrMemoLine.SETRANGE("Sales Tax Invoice/Receipt No.","Document No.");
        SalesCrMemoLine.SETRANGE("Sales Tax Invoice/Receipt Line","Line No.");
        IF SalesCrMemoLine.FIND('-') THEN
          REPEAT
            SalesCrMemoLine."Sales Tax Invoice/Receipt No." := '';
            SalesCrMemoLine."Sales Tax Invoice/Receipt Line" := 0;
            SalesCrMemoLine.MODIFY;
          UNTIL SalesCrMemoLine.NEXT=0;
        ---*/
        //DimMgt.DeletePostedDocDim(Database::"Sales Tax Invoice/Rec. Line", "Document No.", "Line No.");

    end;

    trigger OnInsert()
    var
    // DocDim: Record "Document Dimension";
    begin
        TestStatusOpen;
        //DocDim.LockTable;
        LockTable;
        SalesTaxInvHeader."No." := '';

        //DimMgt.UpdatePostedDocDefaultDim(
        //Database::"Sales Tax Invoice/Rec. Line", "Document No.", "Line No.",
        //"Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        TestStatusOpen;
    end;

    trigger OnRename()
    begin
        Error(Text001, TableCaption);
    end;

    var
        Text000: label 'You cannot delete the order line because it is associated with purchase order %1 line %2.';
        Text001: label 'You cannot rename a %1.';
        Text002: label 'You cannot change %1 because the order line is associated with purchase order %2 line %3.';
        Text003: label 'must not be less than %1';
        Text005: label 'You cannot invoice more than %1 units.';
        Text006: label 'You cannot invoice more than %1 base units.';
        Text007: label 'You cannot ship more than %1 units.';
        Text008: label 'You cannot ship more than %1 base units.';
        Text009: label ' must be 0 when %1 is %2.';
        Text011: label 'Automatic reservation is not possible.\Reserve items manually?';
        Text012: label 'Change %1 from %2 to %3?';
        Text014: label '%1 %2 is before Work Date %3';
        Text016: label '%1 is required for %2 = %3.';
        Text017: label '\The entered information will be disregarded by warehouse operations.';
        Text018: label 'must not be specified when %1 = %2';
        Text020: label 'You cannot return more than %1 units.';
        Text021: label 'You cannot return more than %1 base units.';
        Text023: label '%1 %2 cannot be found in the %3 or %4 table.';
        Text024: label '%1 and %2 cannot both be empty when %3 is used.';
        Text025: label 'No %1 has been posted for %2 %3 and %4 %5.';
        Text026: label 'You cannot change %1 if the item charge has already been posted.';
        Text028: label 'You cannot change the %1 when the %2 has been filled in.';
        Text029: label 'must be positive';
        Text030: label 'must be negative';
        Text031: label 'You must either specify %1 or %2.';
        Text032: label 'You must select a %1 that applies to a range of entries when the related service contract is %2.';
        Text033: label 'You cannot modify the %1 field if the %2 and/or %3 fields are empty.';
        Text034: label 'The value of %1 field must be a whole number for the item included in the service item group if the %2 field in the Service Item Groups window contains a check mark.';
        Text035: label 'Warehouse ';
        Text036: label 'Inventory ';
        SalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header";
        SalesTaxInvLine2: Record "Sales Tax Invoice/Rec. Line";
        TempSalesLine: Record "Sales Tax Invoice/Rec. Line";
        StdTxt: Record "Standard Text";
        GLAcc: Record "G/L Account";
        Currency: Record Currency;
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        Item: Record Item;
        ItemCharge: Record "Item Charge";
        ItemVariant: Record "Item Variant";
        SKU: Record "Stockkeeping Unit";
        ItemTranslation: Record "Item Translation";
        UnitOfMeasure: Record "Unit of Measure";
        FA: Record "Fixed Asset";
        Res: Record Resource;
        ResCost: Record "Resource Cost";
        ResFindUnitCost: Codeunit "Resource-Find Cost";
        DimMgt: Codeunit DimensionManagement;
        UOMMgt: Codeunit "Unit of Measure Management";
    //SalesPost: Codeunit "Sales-Post";


    procedure GetCurrencyCode(): Code[10]
    var
        SalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header";
    begin
        if ("Document No." = SalesTaxInvHeader."No.") then
            exit(SalesTaxInvHeader."Currency Code")
        else
            if SalesTaxInvHeader.Get("Document No.") then
                exit(SalesTaxInvHeader."Currency Code")
            else
                exit('');
    end;


    /*procedure ShowDimensions()
    var
        PostedDocDim: Record "Posted Document Dimension";
        PostedDocDimensions: Page UnknownPage547;
    begin
        TestField("No.");
        TestField("Line No.");
        PostedDocDim.SetRange("Table ID", Database::"Sales Tax Invoice/Rec. Line");
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


    procedure CalcVATAmountLines(var SalesInvHeader: Record "Sales Tax Invoice/Rec. Header"; var VATAmountLine: Record "VAT Amount Line")
    begin
        VATAmountLine.DeleteAll;
        SetRange("Document No.", SalesInvHeader."No.");
        if Find('-') then
            repeat
                VATAmountLine.Init;
                VATAmountLine."VAT Identifier" := "VAT Identifier";
                VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                VATAmountLine."Tax Group Code" := "Tax Group Code";
                VATAmountLine."VAT %" := "VAT %";
                VATAmountLine."VAT Base" := Amount;
                VATAmountLine."VAT Amount" := "Amount Including VAT" - Amount + "VAT Difference";
                VATAmountLine."Amount Including VAT" := "Amount Including VAT" + "VAT Difference";
                VATAmountLine."Line Amount" := "Line Amount";
                if "Allow Invoice Disc." then
                    VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                VATAmountLine.Quantity := "Quantity (Base)";
                VATAmountLine."Calculated VAT Amount" := "Amount Including VAT" - Amount;
                VATAmountLine."VAT Difference" := "VAT Difference";
                VATAmountLine.InsertLine;
            until Next = 0;
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record "Field";
    begin
        Field.Get(Database::"Sales Tax Invoice/Rec. Line", FieldNumber);
        exit(Field."Field Caption");
    end;

    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    var
        SalesInvHeader: Record "Sales Tax Invoice/Rec. Header";
    begin
        if not SalesInvHeader.Get("Document No.") then
            SalesInvHeader.Init;
        if SalesInvHeader."Prices Including VAT" then
            exit('2,1,' + GetFieldCaption(FieldNumber))
        else
            exit('2,0,' + GetFieldCaption(FieldNumber));
    end;

    local procedure TestStatusOpen()
    begin
        GetSalesHeader;
        SalesTaxInvHeader.TestField("Issued Tax Invoice/Receipt", false);
        SalesTaxInvHeader.TestField("Cancel Tax Invoice", false);
    end;


    procedure GetSalesHeader()
    begin
        SalesTaxInvHeader.Get("Document No.");
    end;

    local procedure GetItem()
    begin
        TestField("No.");
        if "No." <> Item."No." then
            Item.Get("No.");
    end;

    local procedure GetUnitCost()
    begin
        TestField(Type, Type::Item);
        TestField("No.");
        GetItem;
        "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
        if GetSKU then
            Validate("Unit Cost (LCY)", SKU."Unit Cost" * "Qty. per Unit of Measure")
        else
            Validate("Unit Cost (LCY)", Item."Unit Cost" * "Qty. per Unit of Measure");
    end;

    local procedure GetSKU(): Boolean
    begin
        if (SKU."Location Code" = "Location Code") and
           (SKU."Item No." = "No.") and
           (SKU."Variant Code" = "Variant Code")
        then
            exit(true);
        if SKU.Get("Location Code", "No.", "Variant Code") then
            exit(true)
        else
            exit(false);
    end;


    procedure GetItemTranslation()
    begin
        GetSalesHeader;
        if ItemTranslation.Get("No.", "Variant Code", SalesTaxInvHeader."Language Code") then begin
            Description := ItemTranslation.Description;
            "Description 2" := ItemTranslation."Description 2";
        end;
    end;

    local procedure FindResUnitCost()
    begin
        ResCost.Init;
        ResCost.Code := "No.";
        ResCost."Work Type Code" := "Work Type Code";
        ResFindUnitCost.Run(ResCost);
        Validate("Unit Cost (LCY)", ResCost."Unit Cost" * "Qty. per Unit of Measure");
    end;

    local procedure GetFAPostingGroup()
    var
        LocalGLAcc: Record "G/L Account";
        FASetup: Record "FA Setup";
        FAPostingGr: Record "FA Posting Group";
        FADeprBook: Record "FA Depreciation Book";
    begin
        if (Type <> Type::"Fixed Asset") or ("No." = '') then
            exit;
        if "Depreciation Book Code" = '' then begin
            FASetup.Get;
            "Depreciation Book Code" := FASetup."Default Depr. Book";
            if not FADeprBook.Get("No.", "Depreciation Book Code") then
                "Depreciation Book Code" := '';
            if "Depreciation Book Code" = '' then
                exit;
        end;
        FADeprBook.Get("No.", "Depreciation Book Code");
        FADeprBook.TestField("FA Posting Group");
        FAPostingGr.Get(FADeprBook."FA Posting Group");
        FAPostingGr.TestField("Acq. Cost Acc. on Disposal");
        LocalGLAcc.Get(FAPostingGr."Acq. Cost Acc. on Disposal");
        LocalGLAcc.CheckGLAcc;
        LocalGLAcc.TestField("Gen. Prod. Posting Group");
        "Posting Group" := FADeprBook."FA Posting Group";
        "Gen. Prod. Posting Group" := LocalGLAcc."Gen. Prod. Posting Group";
        "Tax Group Code" := LocalGLAcc."Tax Group Code";
        Validate("VAT Prod. Posting Group", LocalGLAcc."VAT Prod. Posting Group");
    end;


    /*procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        
        DimMgt.GetPreviousDocDefaultDim(
          DATABASE::"Sales Header","Document Type","Document No.",0,
          DATABASE::Customer,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        
        DimMgt.GetPreviousPostedDocDefaultDim(
          Database::"Sales Tax Invoice/Rec. Header", "Document No.", 0,
          Database::Customer, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        DimMgt.GetDefaultDim(
          TableID, No, SourceCodeSetup.Sales,
          "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if "Line No." <> 0 then
            DimMgt.UpdatePostedDocDefaultDim(
              Database::"Sales Tax Invoice/Rec. Line", "Document No.", "Line No.",
              "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

    end;
    */
    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        IsHandled: Boolean;
        SalesTaxInvoiceHeader: Record "Sales Tax Invoice/Rec. Header";
    begin


        SourceCodeSetup.Get();
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        //OnAfterCreateDimTableIDs(Rec, CurrFieldNo, TableID, No);

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        //GetSalesHeader();
        SalesTaxInvoiceHeader.Get("Document No.");
        "Dimension Set ID" :=
          DimMgt.GetRecDefaultDimID(
            Rec, CurrFieldNo, TableID, No, SourceCodeSetup.Sales,
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", SalesTaxInvoiceHeader."Dimension Set ID", DATABASE::Customer);
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //ATOLink.UpdateAsmDimFromSalesLine(Rec);

        //OnAfterCreateDim(Rec, CurrFieldNo);
    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TestField("Qty. per Unit of Measure");
        exit(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;


    procedure UpdateAmounts()
    begin
        if CurrFieldNo <> FieldNo("Allow Invoice Disc.") then
            TestField(Type);
        GetSalesHeader;

        if "Line Amount" <> ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") - "Line Discount Amount" then begin
            "Line Amount" := ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") - "Line Discount Amount";
            "VAT Difference" := 0;
        end;
        CalcAmountLines;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        /*
        IF "Line No." <> 0 THEN
          DimMgt.SaveDocDim(
            DATABASE::"Sales Line","Document Type","Document No.",
            "Line No.",FieldNumber,ShortcutDimCode)
        ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
        */

    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
    end;


    procedure CalcAmountLines()
    var
        PrevVatAmountLine: Record "VAT Amount Line";
        Currency: Record Currency;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        QtyFactor: Decimal;
        VATAmount: Decimal;
    begin
        if SalesTaxInvHeader."Prices Including VAT" then begin
            case "VAT Calculation Type" of
                "vat calculation type"::"Normal VAT",
                "vat calculation type"::"Reverse Charge VAT":
                    begin
                        "VAT Base Amount" :=
                           ROUND(
                             ("Line Amount" - "Inv. Discount Amount") / (1 + "VAT %" / 100),
                             Currency."Amount Rounding Precision") - "VAT Difference";
                        Amount :=
                           ROUND("VAT Base Amount" *
                             (1 - SalesTaxInvHeader."VAT Base Discount %" / 100),
                             Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                        "Amount Including VAT" := "VAT Base Amount" + Amount;
                    end;
                "vat calculation type"::"Full VAT":
                    begin
                        "VAT Base Amount" := 0;
                        Amount := "VAT Difference" + "Line Amount" - "Inv. Discount Amount";
                        "Amount Including VAT" := Amount;
                    end;
                "vat calculation type"::"Sales Tax":
                    begin
                        "Amount Including VAT" := "Line Amount" - "Inv. Discount Amount";
                        /*
                        "VAT Base amount" :=
                           ROUND(
                             SalesTaxCalculate.ReverseCalculateTax(
                             SalesHeader."Tax Area Code","Tax Group Code",SalesHeader."Tax Liable",
                             SalesHeader."Posting Date","Amount Including VAT",Quantity,SalesHeader."Currency Factor"),
                             Currency."Amount Rounding Precision");
                        "VAT Amount" := "VAT Difference" + "Amount Including VAT" - "VAT Base amount";
                        IF "VAT Base amount" = 0 THEN
                          "VAT %" := 0
                        ELSE
                          "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base amount",0.00001);
                        */
                    end;
            end;
        end else begin
            case "VAT Calculation Type" of
                "vat calculation type"::"Normal VAT",
                "vat calculation type"::"Reverse Charge VAT":
                    begin
                        "VAT Base Amount" := "Line Amount" - "Inv. Discount Amount";
                        VATAmount :=
                           "VAT Difference" +
                           ROUND(
                             "VAT Base Amount" * "VAT %" / 100 * (1 - SalesTaxInvHeader."VAT Base Discount %" / 100),
                             Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                        "Amount Including VAT" := "Line Amount" - "Inv. Discount Amount" + VATAmount;
                        Amount := "Line Amount" - "Inv. Discount Amount";
                    end;
            /*
          "VAT Calculation Type"::"Full VAT":
            BEGIN
              "VAT Base amount" := 0;
              "Amount" := "VAT Difference" + "Line Amount" - "Invoice Discount Amount";
              "Amount Including VAT" := "Amount";
            END;
          "VAT Calculation Type"::"Sales Tax":
            BEGIN
              "VAT Base" := "Line Amount" - "Invoice Discount Amount";
              "VAT Amount" :=
                  SalesTaxCalculate.CalculateTax(
                    SalestaxinvHeader."Tax Area Code","Tax Group Code",SalestaxinvHeader."Tax Liable",
                    SalestaxinvHeader."Posting Date","VAT Base",Quantity,SalestaxinvHeader."Currency Factor");
              IF "VAT Base" = 0 THEN
                  "VAT %" := 0
              ELSE
                  "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base",0.00001);
              "VAT Amount" :=
                "VAT Difference" +
                ROUND("VAT Amount",Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                "Amount Including VAT" := "VAT Base" + "VAT Amount";
            END;
          */
            end;
        end;

    end;


    procedure UpdateVATOnLines(QtyType: Option General,Invoicing,Shipping; var SalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header"; var SalesTaxInvLine: Record "Sales Tax Invoice/Rec. Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        TempVATAmountLineRemainder: Record "VAT Amount Line" temporary;
        Currency: Record Currency;
        RecRef: RecordRef;
        xRecRef: RecordRef;
        ChangeLogMgt: Codeunit "Change Log Management";
        NewAmount: Decimal;
        NewAmountIncludingVAT: Decimal;
        NewVATBaseAmount: Decimal;
        VATAmount: Decimal;
        VATDifference: Decimal;
        InvDiscAmount: Decimal;
        LineAmountToInvoice: Decimal;
    begin
        if SalesTaxInvHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision
        else
            Currency.Get(SalesTaxInvHeader."Currency Code");

        TempVATAmountLineRemainder.DeleteAll;

        with SalesTaxInvLine do begin
            SetRange("Document No.", SalesTaxInvHeader."No.");
            SetFilter(Type, '>0');
            SetFilter(Quantity, '<>0');
            LockTable;
            if Find('-') then
                repeat
                    VATAmountLine.Get("VAT Identifier", "VAT Calculation Type", "Tax Group Code", false, "Line Amount" >= 0);
                    if VATAmountLine.Modified then begin
                        xRecRef.GetTable(SalesTaxInvLine);
                        if not TempVATAmountLineRemainder.Get(
                          "VAT Identifier", "VAT Calculation Type", "Tax Group Code", false, "Line Amount" >= 0)
                        then begin
                            TempVATAmountLineRemainder := VATAmountLine;
                            TempVATAmountLineRemainder.Init;
                            TempVATAmountLineRemainder.Insert;
                        end;

                        LineAmountToInvoice := "Line Amount";

                        if "Allow Invoice Disc." then begin
                            if VATAmountLine."Inv. Disc. Base Amount" = 0 then
                                InvDiscAmount := 0
                            else begin
                                TempVATAmountLineRemainder."Invoice Discount Amount" :=
                                  TempVATAmountLineRemainder."Invoice Discount Amount" +
                                  VATAmountLine."Invoice Discount Amount" * LineAmountToInvoice /
                                  VATAmountLine."Inv. Disc. Base Amount";
                                InvDiscAmount :=
                                  ROUND(
                                    TempVATAmountLineRemainder."Invoice Discount Amount", Currency."Amount Rounding Precision");
                                TempVATAmountLineRemainder."Invoice Discount Amount" :=
                                  TempVATAmountLineRemainder."Invoice Discount Amount" - InvDiscAmount;
                            end;
                            if QtyType = Qtytype::General then begin
                                "Inv. Discount Amount" := InvDiscAmount;
                                //CalcInvDiscToInvoice;
                            end;// ELSE
                                //"Inv. Disc. Amount to Invoice" := InvDiscAmount;
                        end else
                            InvDiscAmount := 0;

                        if QtyType = Qtytype::General then
                            if SalesTaxInvHeader."Prices Including VAT" then begin
                                if (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount" = 0) or
                                   ("Line Amount" = 0)
                                then begin
                                    VATAmount := 0;
                                    NewAmountIncludingVAT := 0;
                                end else begin
                                    VATAmount :=
                                      TempVATAmountLineRemainder."VAT Amount" +
                                      VATAmountLine."VAT Amount" *
                                      ("Line Amount" - "Inv. Discount Amount") /
                                      (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
                                    NewAmountIncludingVAT :=
                                      TempVATAmountLineRemainder."Amount Including VAT" +
                                      VATAmountLine."Amount Including VAT" *
                                      ("Line Amount" - "Inv. Discount Amount") /
                                      (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
                                end;
                                NewAmount :=
                                  ROUND(NewAmountIncludingVAT, Currency."Amount Rounding Precision") -
                                  ROUND(VATAmount, Currency."Amount Rounding Precision");
                                NewVATBaseAmount :=
                                  ROUND(
                                    NewAmount * (1 - SalesTaxInvHeader."VAT Base Discount %" / 100),
                                    Currency."Amount Rounding Precision");
                            end else begin
                                if "VAT Calculation Type" = "vat calculation type"::"Full VAT" then begin
                                    VATAmount := "Line Amount" - "Inv. Discount Amount";
                                    NewAmount := 0;
                                    NewVATBaseAmount := 0;
                                end else begin
                                    NewAmount := "Line Amount" - "Inv. Discount Amount";
                                    NewVATBaseAmount :=
                                      ROUND(
                                        NewAmount * (1 - SalesTaxInvHeader."VAT Base Discount %" / 100),
                                        Currency."Amount Rounding Precision");
                                    if VATAmountLine."VAT Base" = 0 then
                                        VATAmount := 0
                                    else
                                        VATAmount :=
                                          TempVATAmountLineRemainder."VAT Amount" +
                                          VATAmountLine."VAT Amount" * NewAmount / VATAmountLine."VAT Base";
                                end;
                                NewAmountIncludingVAT := NewAmount + ROUND(VATAmount, Currency."Amount Rounding Precision");
                            end
                        else begin
                            if (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount") = 0 then
                                VATDifference := 0
                            else
                                VATDifference :=
                                  TempVATAmountLineRemainder."VAT Difference" +
                                  VATAmountLine."VAT Difference" * (LineAmountToInvoice - InvDiscAmount) /
                                  (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
                            if LineAmountToInvoice = 0 then
                                "VAT Difference" := 0
                            else
                                "VAT Difference" := ROUND(VATDifference, Currency."Amount Rounding Precision");
                        end;
                        /*
                        IF (QtyType = QtyType::General) AND (SalesTaxInvHeader.Status = SalesTaxInvHeader.Status::Released) THEN BEGIN
                          Amount := NewAmount;
                          "Amount Including VAT" := ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision");
                          "VAT Base Amount" := NewVATBaseAmount;
                        END;
                        */
                        //SalesTaxInvLine.InitOutstanding;
                        Modify;
                        RecRef.GetTable(SalesTaxInvLine);
                        //ChangeLogMgt.LogModification(RecRef, xRecRef);
                        ChangeLogMgt.LogModification(RecRef);

                        TempVATAmountLineRemainder."Amount Including VAT" :=
                          NewAmountIncludingVAT - ROUND(NewAmountIncludingVAT, Currency."Amount Rounding Precision");
                        TempVATAmountLineRemainder."VAT Amount" := VATAmount - NewAmountIncludingVAT + NewAmount;
                        TempVATAmountLineRemainder."VAT Difference" := VATDifference - "VAT Difference";
                        TempVATAmountLineRemainder.Modify;
                    end;
                until Next = 0;
            SetRange(Type);
            SetRange(Quantity);
        end;

    end;

    var
        SalesPost: Codeunit CU80Ext;
}

