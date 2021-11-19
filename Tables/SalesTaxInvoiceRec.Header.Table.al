Table 50054 "Sales Tax Invoice/Rec. Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   15.05.2007   KKE   New table for "Sales Tax Invoice/Receipt Header" - Ads. Sales Module

    Caption = 'Sales Tax Invoice/Rec. Header';
    DataCaptionFields = "No.", "Sell-to Customer Name";
    DrillDownPageID = "Sales Tax Invoice/Receipts";
    LookupPageID = "Sales Tax Invoice/Receipts";
    Permissions = TableData "Sales Invoice Line" = m,
                  TableData "Sales Cr.Memo Line" = m;

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                TestField("Issued Tax Invoice/Receipt", false);
                TestField("Cancel Tax Invoice", false);
                if ("Sell-to Customer No." <> xRec."Sell-to Customer No.") and
                   (xRec."Sell-to Customer No." <> '')
                then begin
                    if HideValidationDialog then
                        Confirmed := true
                    else
                        Confirmed := Confirm(Text001, false, FieldCaption("Sell-to Customer No."));
                    if Confirmed then begin
                        SalesTaxInvLine.SetRange("Document No.", "No.");
                        if "Sell-to Customer No." = '' then begin
                            if SalesTaxInvLine.Find('-') then
                                Error(
                                  Text002,
                                  FieldCaption("Sell-to Customer No."));
                            //DimMgt.DeletePostedDocDim(Database::"Sales Tax Invoice/Rec. Header", "No.", 0);

                            Init;
                            SalesSetup.Get;
                            "No. Series" := xRec."No. Series";
                            InitRecord;
                            exit;
                        end;
                    end else begin
                        Rec := xRec;
                        exit;
                    end;
                end;

                Cust.Get("Sell-to Customer No.");

                Cust.TestField("Gen. Bus. Posting Group");
                "Sell-to Customer Name" := Cust.Name;
                "Sell-to Customer Name 2" := Cust."Name 2";
                "Sell-to Name (Thai)" := CopyStr(Cust."Name (Thai)", 1, 50);
                "Sell-to Address (Thai)" := CopyStr(Cust."Address (Thai)", 1, 50);
                "Sell-to Address 3" := Cust."Address 3";
                "Sell-to Address" := Cust.Address;
                "Sell-to Address 2" := Cust."Address 2";
                "Sell-to City" := Cust.City;
                "Sell-to Post Code" := Cust."Post Code";
                "Sell-to County" := Cust.County;
                "Sell-to Country Code" := Cust."Country/Region Code";
                "Sell-to Contact" := Cust.Contact;
                "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                "WHT Business Posting Group" := Cust."WHT Business Posting Group";
                "Tax Area Code" := Cust."Tax Area Code";
                "Tax Liable" := Cust."Tax Liable";
                "VAT Registration No." := Cust."VAT Registration No.";
                "Responsibility Center" := UserMgt.GetRespCenter(0, Cust."Responsibility Center");
                Validate("Location Code", UserMgt.GetLocation(0, Cust."Location Code", "Responsibility Center"));

                if Cust."Bill-to Customer No." <> '' then
                    Validate("Bill-to Customer No.", Cust."Bill-to Customer No.")
                else
                    Validate("Bill-to Customer No.", "Sell-to Customer No.");
                Validate("Ship-to Code", '');

                if (xRec."Sell-to Customer No." <> "Sell-to Customer No.") or
                   (xRec."Currency Code" <> "Currency Code") or
                   (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") or
                   (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
                then
                    RecreateSalesLines(FieldCaption("Sell-to Customer No."));
            end;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                TestField("Issued Tax Invoice/Receipt", false);
                TestField("Cancel Tax Invoice", false);
                if (xRec."Bill-to Customer No." <> "Bill-to Customer No.") and
                   (xRec."Bill-to Customer No." <> '')
                then begin
                    if HideValidationDialog then
                        Confirmed := true
                    else
                        Confirmed := Confirm(Text004, false, FieldCaption("Bill-to Customer No."));
                    if not Confirmed then begin
                        "Bill-to Customer No." := xRec."Bill-to Customer No.";
                        if "Customer Posting Group" <> '' then
                            exit;
                    end;
                end;

                Cust.Get("Bill-to Customer No.");
                Cust.TestField("Customer Posting Group");

                "Bill-to Name" := Cust.Name;
                "Bill-to Name 2" := Cust."Name 2";
                "Bill-to Address" := Cust.Address;
                "Bill-to Address 2" := Cust."Address 2";
                "Bill-to Name (Thai)" := Cust."Name (Thai)";
                "Bill-to Address (Thai)" := Cust."Address (Thai)";
                "Bill-to Address 3" := Cust."Address 3";
                "Bill-to City" := Cust.City;
                "Bill-to Post Code" := Cust."Post Code";
                "Bill-to County" := Cust.County;
                "Bill-to Country Code" := Cust."Country/Region Code";
                "Bill-to Contact" := Cust.Contact;
                "Payment Terms Code" := Cust."Payment Terms Code";
                "Payment Method Code" := Cust."Payment Method Code";

                "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                "WHT Business Posting Group" := Cust."WHT Business Posting Group";
                "Customer Posting Group" := Cust."Customer Posting Group";
                "Currency Code" := Cust."Currency Code";
                "Customer Price Group" := Cust."Customer Price Group";
                "Prices Including VAT" := Cust."Prices Including VAT";
                "Allow Line Disc." := Cust."Allow Line Disc.";
                "Invoice Disc. Code" := Cust."Invoice Disc. Code";
                "Customer Disc. Group" := Cust."Customer Disc. Group";
                "Language Code" := Cust."Language Code";
                "Salesperson Code" := Cust."Salesperson Code";
                "VAT Registration No." := Cust."VAT Registration No.";
                CreateDim(
  DATABASE::Customer, "Bill-to Customer No.",
  DATABASE::"Salesperson/Purchaser", "Salesperson Code",
  DATABASE::Campaign, "Campaign No.",
  DATABASE::"Responsibility Center", "Responsibility Center",
  DATABASE::"Customer Template", '');

                /* CreateDim(
                   Database::Customer, "Bill-to Customer No.",
                   Database::Job, "Job No.",
                   Database::"Salesperson/Purchaser", "Salesperson Code",
                   Database::Campaign, "Campaign No.",
                   Database::"Responsibility Center", "Responsibility Center",
                   Database::"Customer Template", '');*/// SAG

                Validate("Payment Terms Code");
                Validate("Payment Method Code");
                Validate("Currency Code");

                if (xRec."Sell-to Customer No." = "Sell-to Customer No.") and
                   (xRec."Bill-to Customer No." <> "Bill-to Customer No.")
                then
                    RecreateSalesLines(FieldCaption("Bill-to Customer No."));
            end;
        }
        field(5; "Bill-to Name"; Text[50])
        {
            Caption = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[50])
        {
            Caption = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
        }
        field(10; "Bill-to Contact"; Text[50])
        {
            Caption = 'Bill-to Contact';
        }
        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Sell-to Customer No."));
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(21; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(31; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Editable = false;
            TableRelation = "Customer Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(34; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
        }
        field(40; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(43; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(44; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = exist("Sales Comment Line" where("Document Type" = const("Issued Tax Invoice"),
                                                            "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account";
        }
        field(56; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Tax Invoice/Rec. Line".Amount where("Document No." = field("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Tax Invoice/Rec. Line"."Amount Including VAT" where("Document No." = field("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(78; "VAT Country Code"; Code[10])
        {
            Caption = 'VAT Country Code';
            TableRelation = "Country/Region";
        }
        field(79; "Sell-to Customer Name"; Text[50])
        {
            Caption = 'Sell-to Customer Name';
        }
        field(80; "Sell-to Customer Name 2"; Text[50])
        {
            Caption = 'Sell-to Customer Name 2';
        }
        field(81; "Sell-to Address"; Text[50])
        {
            Caption = 'Sell-to Address';
        }
        field(82; "Sell-to Address 2"; Text[50])
        {
            Caption = 'Sell-to Address 2';
        }
        field(83; "Sell-to City"; Text[30])
        {
            Caption = 'Sell-to City';
        }
        field(84; "Sell-to Contact"; Text[50])
        {
            Caption = 'Sell-to Contact';
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(86; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
        }
        field(87; "Bill-to Country Code"; Code[10])
        {
            Caption = 'Bill-to Country Code';
            TableRelation = "Country/Region";
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            Caption = 'Sell-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(89; "Sell-to County"; Text[30])
        {
            Caption = 'Sell-to County';
        }
        field(90; "Sell-to Country Code"; Code[10])
        {
            Caption = 'Sell-to Country Code';
            TableRelation = "Country/Region";
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country Code"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(97; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(100; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(106; "Package Tracking No."; Text[30])
        {
            Caption = 'Package Tracking No.';
        }
        field(107; "Pre-Assigned No. Series"; Code[10])
        {
            Caption = 'Pre-Assigned No. Series';
            TableRelation = "No. Series";
        }
        field(108; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(110; "Order No. Series"; Code[10])
        {
            Caption = 'Order No. Series';
            TableRelation = "No. Series";
        }
        field(111; "Pre-Assigned No."; Code[20])
        {
            Caption = 'Pre-Assigned No.';
        }
        field(112; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
            //LoginMgt: Codeunit "Login Management";
            begin
            end;
        }
        field(113; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            Caption = 'Sell-to Contact No.';
            TableRelation = Contact;
        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';
            TableRelation = Contact;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5900; "Service Mgt. Document"; Boolean)
        {
            Caption = 'Service Mgt. Document';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
        }
        field(7200; "Get Shipment Used"; Boolean)
        {
            Caption = 'Get Shipment Used';
        }
        field(17110; "S/T Type"; Option)
        {
            Caption = 'S/T Type';
            OptionCaption = ' ,Annual,Confirmation';
            OptionMembers = " ",Annual,Confirmation;
        }
        field(17111; "S/T Expiry Date"; Date)
        {
            Caption = 'S/T Expiry Date';
        }
        field(28040; "WHT Business Posting Group"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            TableRelation = "WHT Business Posting Group";
        }
        field(50001; "Sell-to Name (Thai)"; Text[50])
        {
            Caption = 'Sell-to Name (Thai)';
            Description = 'Reduce Size 120->50';
        }
        field(50002; "Sell-to Address (Thai)"; Text[50])
        {
            Caption = 'Sell-to Address (Thai)';
            Description = 'Reduce Size 200->50';
        }
        field(50003; "Sell-to Address 3"; Text[30])
        {
            Caption = 'Sell-to Address 3';
        }
        field(50004; "Bill-to Name (Thai)"; Text[120])
        {
            Caption = 'Bill-to Name (Thai)';
        }
        field(50005; "Bill-to Address (Thai)"; Text[200])
        {
            Caption = 'Bill-to Address (Thai)';
        }
        field(50006; "Bill-to Address 3"; Text[30])
        {
            Caption = 'Bill-to Address 3';
        }
        field(50007; "Ship-to Name (Thai)"; Text[120])
        {
            Caption = 'Ship-to Name (Thai)';
        }
        field(50008; "Ship-to Address (Thai)"; Text[200])
        {
            Caption = 'Ship-to Address (Thai)';
        }
        field(50009; "Ship-to Address 3"; Text[30])
        {
            Caption = 'Ship-to Address 3';
        }
        field(50050; "Invoice Description"; Text[100])
        {
        }
        field(50051; "Issued Tax Invoice/Receipt"; Boolean)
        {
            Editable = false;
        }
        field(50052; "Issued Tax Invoice/Receipt No."; Code[20])
        {
            Editable = false;
        }
        field(50053; "Issued Date / Time"; DateTime)
        {
            Editable = false;
        }
        field(50054; "Issued by"; Code[20])
        {
            Editable = false;
        }
        field(50055; "Cancel Tax Invoice"; Boolean)
        {
            Editable = false;
        }
        field(50056; "Cancelled Date / Time"; DateTime)
        {
            Editable = false;
        }
        field(50057; "Cancelled by"; Code[20])
        {
            Editable = false;
        }
        field(50058; "Prepaid WHT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(99008509; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
        }
        field(99008510; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
        }
        field(99008516; "BizTalk Sales Invoice"; Boolean)
        {
            Caption = 'BizTalk Sales Invoice';
        }
        field(99008519; "Customer Order No."; Code[20])
        {
            Caption = 'Customer Order No.';
        }
        field(99008521; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
        }
        field(50150; "Work Description"; Text[250])
        {

        }
        field(50151; Brand; Text[50])
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Issued Tax Invoice/Receipt No.")
        {
        }
        key(Key3; "Cancel Tax Invoice", "Issued Tax Invoice/Receipt No.")
        {
        }
        key(Key4; "Service Mgt. Document")
        {
        }
        key(Key5; "Sell-to Customer No.", "External Document No.")
        {
        }
        key(Key6; "Sell-to Customer No.", "Order Date")
        {
        }
        key(Key7; "Sell-to Customer No.", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Issued Tax Invoice/Receipt", false);
        TestField("Cancel Tax Invoice", false);
        LockTable;

        SalesTaxInvLine.Reset;
        SalesTaxInvLine.LockTable;
        SalesTaxInvLine.SetRange("Document No.", "No.");
        if SalesTaxInvLine.Find('-') then
            repeat
                SalesTaxInvLine.Delete(true);
            until SalesTaxInvLine.Next = 0;

        SalesCommentLine.SetRange("Document Type", SalesCommentLine."document type"::"Issued Tax Invoice");
        SalesCommentLine.SetRange("No.", "No.");
        SalesCommentLine.DeleteAll;

        //DimMgt.DeletePostedDocDim(Database::"Sales Tax Invoice/Rec. Header", "No.", 0);
    end;

    trigger OnInsert()
    begin
        SalesSetup.Get;

        if "No." = '' then begin
            SalesSetup.TestField("Sales Tax Invoice Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Sales Tax Invoice Nos.", xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        if ("Sell-to Customer No." <> xRec."Sell-to Customer No.") or
           ("Bill-to Customer No." <> xRec."Bill-to Customer No.")
        then begin
            TestField("Issued Tax Invoice/Receipt", false);
            TestField("Cancel Tax Invoice", false);
        end;
    end;

    trigger OnRename()
    begin
        TestField("Issued Tax Invoice/Receipt", false);
        TestField("Cancel Tax Invoice", false);
    end;

    var
        SalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header";
        SalesTaxInvLine: Record "Sales Tax Invoice/Rec. Line";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        SalesCommentLine: Record "Sales Comment Line";
        DimMgt: Codeunit DimensionManagement;
        UserMgt: Codeunit "User Setup Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Text001: label 'Do you want to change %1?';
        Text002: label 'You cannot reset %1 because the document still has one or more lines.';
        Text003: label 'If you change %1, the existing sales tax invoice lines will be deleted.\\';
        Text004: label 'Do you want to change %1?';
        Text005: label 'You must delete the existing sales tax invoice lines before you can change %1.';
        Text006: label 'Do you want to cancel tax invoice?';
        Text007: label 'The sales tax invoice/receipt have been cancelled!';
        Text064: Label 'You may have changed a dimension.\\Do you want to update the lines?';

    procedure AssistEdit(OldTaxInvHeader: Record "Sales Tax Invoice/Rec. Header"): Boolean
    begin
        with SalesTaxInvHeader do begin
            SalesTaxInvHeader := Rec;
            SalesSetup.Get;
            SalesSetup.TestField("Sales Tax Invoice Nos.");
            if NoSeriesMgt.SelectSeries(SalesSetup."Sales Tax Invoice Nos.", OldTaxInvHeader."No. Series", "No. Series") then begin
                SalesSetup.Get;
                NoSeriesMgt.SetSeries("No.");
                Rec := SalesTaxInvHeader;
                exit(true);
            end;
        end;
    end;


    procedure InitRecord()
    begin
        "Shipment Date" := WorkDate;
        "Order Date" := WorkDate;
        "Posting Date" := WorkDate;
        "Document Date" := WorkDate;

        Validate("Location Code", UserMgt.GetLocation(0, Cust."Location Code", "Responsibility Center"));

        "Posting Description" := 'Sales Tax Invoice ' + "No.";
    end;


    procedure RecreateSalesLines(ChangedFieldName: Text[100])
    var
        SalesTaxInvLineTmp: Record "Sales Tax Invoice/Rec. Line" temporary;
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
        TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary;
        TempInteger: Record "Integer" temporary;
        ExtendedTextAdded: Boolean;
    begin
        if SalesLinesExist then begin
            if HideValidationDialog then
                Confirmed := true
            else
                Confirmed :=
                  Confirm(
                    Text003 +
                    Text004, false, ChangedFieldName);
            /*===
            IF Confirmed THEN BEGIN
              SalesTaxInvLine.LOCKTABLE;
              MODIFY;

              SalesTaxInvLine.RESET;
              SalesTaxInvLine.SETRANGE("Document No.","No.");
              IF SalesTaxInvLine.FIND('-') THEN BEGIN
                REPEAT
                  SalesTaxInvLineTmp := SalesTaxInvLine;
                  SalesTaxInvLineTmp.INSERT;
                UNTIL SalesTaxInvLine.NEXT = 0;

                SalesTaxInvLine.DELETEALL(TRUE);
                SalesTaxInvLine.INIT;
                SalesTaxInvLine."Line No." := 0;
                SalesTaxInvLineTmp.FIND('-');
                REPEAT
                  SalesTaxInvLine.INIT;
                  SalesTaxInvLine."Line No." := SalesTaxInvLine."Line No." + 10000;
                  SalesTaxInvLine.VALIDATE(Type,SalesTaxInvLineTmp.Type);
                  SalesTaxInvLine.VALIDATE("No.",SalesTaxInvLineTmp."No.");
                  SalesTaxInvLine.VALIDATE(Description,SalesTaxInvLineTmp.Description);
                  SalesTaxInvLine.VALIDATE("Description 2",SalesTaxInvLineTmp."Description 2");

                  SalesTaxInvLine.VALIDATE("Gen. Prod. Posting Group",SalesTaxInvLineTmp."Gen. Prod. Posting Group");
                  SalesTaxInvLine.VALIDATE("VAT Prod. Posting Group",SalesTaxInvLineTmp."VAT Prod. Posting Group");
                  SalesTaxInvLine.VALIDATE("WHT Product Posting Group",SalesTaxInvLineTmp."WHT Product Posting Group");
                  IF SalesTaxInvLine.Type <> SalesTaxInvLine.Type::" " THEN BEGIN
                    SalesTaxInvLine.VALIDATE("Unit of Measure Code",SalesTaxInvLineTmp."Unit of Measure Code");
                    SalesTaxInvLine.VALIDATE("Variant Code",SalesTaxInvLineTmp."Variant Code");
                    SalesTaxInvLine.VALIDATE("Location Code",SalesTaxInvLineTmp."Location Code");
                    IF SalesTaxInvLineTmp.Quantity <> 0 THEN
                      SalesTaxInvLine.VALIDATE(Quantity,SalesTaxInvLineTmp.Quantity);
                    SalesTaxInvLine.VALIDATE("Unit Price",SalesTaxInvLineTmp."Unit Price");
                    IF SalesTaxInvLineTmp."Line Discount %" <> 0 THEN
                      SalesTaxInvLine.VALIDATE("Line Discount %",SalesTaxInvLineTmp."Line Discount %");
                    IF SalesTaxInvLineTmp."Line Discount Amount" <> 0 THEN
                      SalesTaxInvLine.VALIDATE("Line Discount Amount",SalesTaxInvLineTmp."Line Discount Amount");
                  END;

                  SalesTaxInvLine.INSERT;
                UNTIL SalesTaxInvLineTmp.NEXT = 0;

                SalesTaxInvLineTmp.SETRANGE(Type);
                SalesTaxInvLineTmp.DELETEALL;
              END;
            END ELSE
            ===*/
            Error(
              Text005, ChangedFieldName);
        end;

    end;


    procedure SalesLinesExist(): Boolean
    begin
        SalesTaxInvLine.Reset;
        SalesTaxInvLine.SetRange("Document No.", "No.");
        exit(SalesTaxInvLine.Find('-'));
    end;


    /*procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20]; Type5: Integer; No5: Code[20]; Type6: Integer; No6: Code[20])
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
        TableID[4] := Type4;
        No[4] := No4;
        TableID[5] := Type5;
        No[5] := No5;
        TableID[6] := Type6;
        No[6] := No6;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        DimMgt.GetDefaultDim(
          TableID, No, SourceCodeSetup.Sales,
          "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if "No." <> '' then
            DimMgt.UpdatePostedDocDefaultDim(
              Database::"Sales Tax Invoice/Rec. Header", "No.", 0,
              "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;*/
    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20]; Type5: Integer; No5: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeCreateDim(Rec, IsHandled);
        if IsHandled then
            exit;

        SourceCodeSetup.Get();
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        TableID[5] := Type5;
        No[5] := No5;
        //OnAfterCreateDimTableIDs(Rec, CurrFieldNo, TableID, No);

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetRecDefaultDimID(
            Rec, CurrFieldNo, TableID, No, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

        //OnCreateDimOnBeforeUpdateLines(Rec, xRec, CurrFieldNo, OldDimSetID);

        if (OldDimSetID <> "Dimension Set ID") and SalesLinesExist then begin
            Modify;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ATOLink: Record "Assemble-to-Order Link";
        NewDimSetID: Integer;
        ShippedReceivedItemLineDimChangeConfirmed: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeUpdateAllLineDim(Rec, NewParentDimSetID, OldParentDimSetID, IsHandled, xRec);
        if IsHandled then
            exit;

        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not GetHideValidationDialog and GuiAllowed then
            if not ConfirmUpdateAllLineDim(NewParentDimSetID, OldParentDimSetID) then
                exit;

        SalesTaxInvLine.Reset();
        //SalesTaxInvLine.SetRange("Document Type", "Document Type");
        SalesTaxInvLine.SetRange("Document No.", "No.");
        SalesTaxInvLine.LockTable();
        if SalesTaxInvLine.Find('-') then
            repeat
                //OnUpdateAllLineDimOnBeforeGetSalesLineNewDimsetID(SalesLine, NewParentDimSetID, OldParentDimSetID);
                NewDimSetID := DimMgt.GetDeltaDimSetID(SalesTaxInvLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                //OnUpdateAllLineDimOnAfterGetSalesLineNewDimsetID(Rec, xRec, SalesLine, NewDimSetID, NewParentDimSetID, OldParentDimSetID);
                if SalesTaxInvLine."Dimension Set ID" <> NewDimSetID then begin
                    SalesTaxInvLine."Dimension Set ID" := NewDimSetID;

                    //if not GetHideValidationDialog and GuiAllowed then
                    //VerifyShippedReceivedItemLineDimChange(ShippedReceivedItemLineDimChangeConfirmed);

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      SalesTaxInvLine."Dimension Set ID", SalesTaxInvLine."Shortcut Dimension 1 Code", SalesTaxInvLine."Shortcut Dimension 2 Code");

                    //OnUpdateAllLineDimOnBeforeSalesLineModify(SalesLine);
                    SalesTaxInvLine.Modify();
                    //ATOLink.UpdateAsmDimFromSalesLine(SalesLine);
                end;
            until SalesTaxInvLine.Next = 0;
    end;

    procedure GetHideValidationDialog(): Boolean
    var
        EnvInfoProxy: Codeunit "Env. Info Proxy";
    begin
        exit(HideValidationDialog or EnvInfoProxy.IsInvoicing);
    end;

    local procedure ConfirmUpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer) Confirmed: Boolean;
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeConfirmUpdateAllLineDim(Rec, xRec, NewParentDimSetID, OldParentDimSetID, Confirmed, IsHandled);
        if not IsHandled then
            Confirmed := Confirm(Text064);
    end;

    procedure CancelTaxInvoice()
    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesTaxInvLine: Record "Sales Tax Invoice/Rec. Line";
    begin
        TestField("Issued Tax Invoice/Receipt", true);
        if "Cancel Tax Invoice" then
            Error(Text007);
        if not Confirm(Text006, false) then
            exit;

        SalesTaxInvLine.Reset;
        SalesTaxInvLine.SetRange("Document No.", "No.");
        if SalesTaxInvLine.Find('-') then
            repeat
                case SalesTaxInvLine."Posted Document Type" of
                    SalesTaxInvLine."posted document type"::Invoice:
                        begin
                            SalesInvLine.Reset;
                            SalesInvLine.SetRange("Document No.", SalesTaxInvLine."Posted Document No.");
                            SalesInvLine.SetRange("Sales Tax Invoice/Receipt No.", SalesTaxInvLine."Document No.");
                            SalesInvLine.SetRange("Sales Tax Invoice/Receipt Line", SalesTaxInvLine."Line No.");
                            if SalesInvLine.Find('-') then
                                repeat
                                    SalesInvLine."Sales Tax Invoice/Receipt No." := '';
                                    SalesInvLine."Sales Tax Invoice/Receipt Line" := 0;
                                    SalesInvLine.Modify;
                                until SalesInvLine.Next = 0;
                        end;
                    SalesTaxInvLine."posted document type"::"Credit Memo":
                        begin
                            SalesCrMemoLine.Reset;
                            SalesCrMemoLine.SetRange("Document No.", SalesTaxInvLine."Posted Document No.");
                            SalesCrMemoLine.SetRange("Sales Tax Invoice/Receipt No.", SalesTaxInvLine."Document No.");
                            SalesCrMemoLine.SetRange("Sales Tax Invoice/Receipt Line", SalesTaxInvLine."Line No.");
                            if SalesCrMemoLine.Find('-') then
                                repeat
                                    SalesCrMemoLine."Sales Tax Invoice/Receipt No." := '';
                                    SalesCrMemoLine."Sales Tax Invoice/Receipt Line" := 0;
                                    SalesCrMemoLine.Modify;
                                until SalesCrMemoLine.Next = 0;
                        end;
                end;
            until SalesTaxInvLine.Next = 0;

        "Cancel Tax Invoice" := true;
        "Cancelled Date / Time" := CurrentDatetime;
        "Cancelled by" := UserId;
        Modify(true);
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeShowDocDim(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1 ', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //OnShowDocDimOnBeforeUpdateSalesLines(Rec, xRec);
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            //if SalesLinesExist then
            //UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure ShowDimensions()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption, "No."));
    end;

    procedure SelltoCustomerNoOnAfterValidate(var SalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header"; var xSalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header")
    begin
        if SalesTaxInvHeader.GetFilter("Sell-to Customer No.") = xSalesTaxInvHeader."Sell-to Customer No." then
            if SalesTaxInvHeader."Sell-to Customer No." <> xSalesTaxInvHeader."Sell-to Customer No." then
                SalesTaxInvHeader.SetRange("Sell-to Customer No.");

        //OnAfterSelltoCustomerNoOnAfterValidate(Rec, xRec);
    end;

    procedure BilltoCustomerNoOnAfterValidate(var SalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header"; var xSalesTaxInvHeader: Record "Sales Tax Invoice/Rec. Header")
    begin
        if SalesTaxInvHeader.GetFilter("Bill-to Customer No.") = xSalesTaxInvHeader."Bill-to Customer No." then
            if SalesTaxInvHeader."Bill-to Customer No." <> xSalesTaxInvHeader."Bill-to Customer No." then
                SalesTaxInvHeader.SetRange("Bill-to Customer No.");

        //OnAfterSelltoCustomerNoOnAfterValidate(Rec, xRec);
    end;

}

