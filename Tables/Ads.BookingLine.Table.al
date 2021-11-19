Table 50038 "Ads. Booking Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Ads. Booking Line" - Ads. Sales Module
    // 002   07.09.2007   KKE   Allow "Unit Price Excl. VAT" is zero.
    // 009   04.01.2008   KKE   If Ads. Invoiced has been cancelled by Credit Note, system must allow Cancel Ads booking line.
    // 010   19.10.2010   GKU   Add field "Status Date"

    DrillDownPageID = "Ads. Booking Lines";
    LookupPageID = "Ads. Booking Lines";

    fields
    {
        field(1; "Deal No."; Code[20])
        {
            TableRelation = "Ads. Booking Header";
            trigger OnValidate()
            var
                AdsBookingLine: Record "Ads. Booking Line";
            begin
                AdsBookingLine.Reset();
                AdsBookingLine.SetCurrentKey("Deal No.", "Subdeal No.");
                AdsBookingLine.SetRange("Deal No.", "Deal No.");
                if AdsBookingLine.FindLast() then begin
                    "Subdeal No." := IncStr(AdsBookingLine."Subdeal No.")
                end else
                    "Subdeal No." := "Deal No." + '-01';
                "Line Status" := "Line Status"::Confirmed;//VAH
            end;
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Ads. Item No."; Code[20])
        {
            TableRelation = "Ads. Item"."Ads. Item No." where("Product Code" = field("Product Code"));

            trigger OnValidate()
            var
                TempAdsBookingLine: Record "Ads. Booking Line";
            begin
                if not ("Line Status" in ["line status"::Booking, "line status"::"Waiting List"]) then
                    Error(Text002, FieldCaption("Line Status"), "Line Status");
                if "Ads. Item No." = xRec."Ads. Item No." then
                    exit;
                if not AdsItem.Get("Ads. Item No.") then
                    Clear(AdsItem);

                TempAdsBookingLine := Rec;
                Init;
                "Deal No." := TempAdsBookingLine."Deal No.";
                "Line No." := TempAdsBookingLine."Line No.";
                "Ads. Item No." := AdsItem."Ads. Item No.";
                if "Ads. Item No." = '' then
                    exit;

                "Sub Product Code" := AdsItem."Sub Product Code";
                "Volume No." := AdsItem."Volume No.";
                "Issue No." := AdsItem."Issue No.";
                "Issue Date" := AdsItem."Issue Date";
                "Base Unit of Measure" := AdsItem."Base Unit of Measure";
                "Ads. Closing Date" := AdsItem."Ads. Closing Date";

                GetAdsBookingHdr;
                if AdsBookingHdr."Bill-to Customer No." <> '' then
                    Cust.Get(AdsBookingHdr."Bill-to Customer No.")
                else
                    Cust.Get(AdsBookingHdr."Final Customer No.");
                "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                "VAT Prod. Posting Group" := AdsItem."VAT Prod. Posting Group";
                "Booking Date" := AdsBookingHdr."Booking Date";
                "Salesperson Code" := AdsBookingHdr."Salesperson Code";  //Issue #21 06.01.2009
                "Currency Code" := AdsBookingHdr."Currency Code";

                Validate("VAT Prod. Posting Group");
                CheckWaitingList;
            end;
        }
        field(4; "Sub Product Code"; Code[20])
        {
            //Editable = false;
            TableRelation = "Sub Product" where("Product Code" = field("Product Code"));
            trigger OnValidate()
            var
                SubProduct: Record "Sub Product";
            begin
                if SubProduct.Get("Sub Product Code") then begin
                    "VAT Prod. Posting Group" := SubProduct."VAT Prod. Posting Group";
                    "Base Unit of Measure" := SubProduct."Unit Of Measure Code";
                    "Shortcut Dimension 7 Code" := SubProduct."Shortcut Dimension 7 Code";
                    "Sub Product Name" := SubProduct.Description;
                end;
                GetAdsBookingHdr;
                Cust.Get(AdsBookingHdr."Final Customer No.");
                "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";

            end;
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
        field(10; "Ads. Type Code (Revenue Type Code)"; Code[20])
        {
            TableRelation = "Booking Revenue Type" where("Shortcut Dimension 7 Code" = field("Shortcut Dimension 7 Code"));

            trigger OnValidate()
            begin
                if not BookingRevType.Get("Ads. Type code (Revenue type Code)", "Shortcut Dimension 7 Code") then
                    Clear(BookingRevType);
                if (BookingRevType."Magazine Code" <> "Sub Product Code") and
                   (BookingRevType."Magazine Code" <> '')
                then
                    Error(Text006, BookingRevType.Code, "Sub Product Code");

                validate("Ads. Type", BookingRevType."Ads. Type");
                "Booking Revenue Type" := BookingRevType.Type;
                "Create Sales Invoice" := BookingRevType."Create Sale Invoice";
                "Barter Required Document" := BookingRevType."Required Barter G/L Account";
                "Bill Revenue G/L Account" := BookingRevType."Bill Revenue G/L Account";
                "Barter G/L Account" := BookingRevType."Barter G/L Account";
            end;
        }
        field(11; "Booking Revenue Type"; Option)
        {
            OptionMembers = Billable,"Non-Billable","House-Ads.";
        }
        field(12; "Ads. Size Code"; Code[20])
        {
            TableRelation = "Ads. Size".Code where("Ads Type Code" = field("Ads. Type code (Revenue type Code)"));

            trigger OnValidate()
            begin
                if not AdsSize.Get("Ads. Type", "Ads. Size Code") then
                    Clear(AdsSize);
                Validate("Counting Unit", AdsSize."Counting Unit");
            end;
        }
        field(13; "Ads. Type"; Code[20])
        {
            TableRelation = "Ads. Type";
            trigger onvalidate()
            var
                AdsType: Record "Ads. Type";
            begin
                if AdsType.Get("Ads. Type") then
                    "Ads. Type Description" := AdsType.Description;
            end;
        }
        field(14; "Ads. Sub-Type"; Code[20])
        {
            TableRelation = "Ads. Sub Type".Code where("Ads. Type" = field("Ads. Type"));
        }
        field(15; "Ads. Position Code"; Code[20])
        {
            TableRelation = "Ads. Position" where("Magazine Code" = field("Sub Product Code"));

            trigger OnValidate()
            var
                AdsBookingLine: Record "Ads. Booking Line";
            begin
                if ("Ads. Position Code" <> '') and ("Publication Month" <> '') then begin
                    AdsBookingLine.Reset();
                    //adsbookingline.setrange("deal No.", rec."Deal No.");
                    AdsBookingLine.SetRange("Ads. Position Code", rec."Ads. Position Code");
                    AdsBookingLine.SetRange("Publication Month", rec."Publication Month");
                    AdsBookingLine.SetFilter("Line Status", '<>%1', AdsBookingLine."Line Status"::Cancelled);//VAH Added 08/18/2021
                    if AdsBookingLine.FindFirst() then
                        //if AdsBookingLine."Deal No." <> rec."Deal No." then
                            Error('Booking ads. position aready exists');
                end;
                if not ("Line Status" in ["line status"::booking, "line status"::Confirmed, "line status"::"Waiting List"]) then
                    Error(Text002, FieldCaption("Line Status"), "Line Status");
                if "Ads. Position Code" = xRec."Ads. Position Code" then
                    exit;
                if not AdsPosition.Get("Ads. Position Code") then
                    Clear(AdsPosition);
                Validate("Shortcut Dimension 5 Code", AdsPosition."Shortcut Dimension 5 Code");

                CheckWaitingList;
            end;
        }
        field(16; "Brand Code"; Code[20])
        {
            TableRelation = Brand;

            trigger OnValidate()
            begin
                if not AdsProduct.Get("Brand Code") then
                    Clear(AdsProduct);
                "Owner Customer" := AdsProduct."Owner Customer";
                "Industry Category Code" := AdsProduct."Indutry Category";
            end;
        }
        field(17; "Owner Customer"; Code[20])
        {
            TableRelation = Customer;
        }
        field(18; "Industry Category Code"; Code[20])
        {
            TableRelation = "Product Category";
        }
        field(19; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            InitValue = 1;

            trigger OnValidate()
            begin
                UpdateAmounts;
                "Total Counting Unit" := Quantity * "Counting Unit";
            end;
        }
        field(20; "Unit Price Excl. VAT"; Decimal)
        {
            AutoFormatType = 2;

            trigger OnValidate()
            begin
                UpdateAmounts;
            end;
        }
        field(21; Amount; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(22; "Amount Including VAT"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(23; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                Validate("VAT Prod. Posting Group");
            end;
        }
        field(24; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                TestStatusOpen;
                VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                UpdateAmounts;
            end;
        }
        field(25; "Create Sales Invoice"; Boolean)
        {
            Editable = false;
        }
        field(26; "Cash Invoice Amount"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                TestField("Create Sales Invoice", true);
            end;
        }
        field(27; "Bill Revenue G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(28; "Barter Amount"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                //TESTFIELD("Barter Required Document",TRUE);
            end;
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
            OptionMembers = Booking,"Waiting List",Confirmed,Approved,Hold,Cancelled,Invoiced,Closed,"Invoice Generated"," ";
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

            trigger OnValidate()
            begin
                "Total Counting Unit" := Quantity * "Counting Unit";
            end;
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
        field(51; "Shortcut Dimension 7 Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), Blocked = const(false));
            CaptionClass = '1,2,7';
        }
        field(52; "Planning Status"; Option)
        {
            Editable = false;
            OptionMembers = " ",Picked,Occupied,Approved;
        }
        field(53; "No. Of Revision"; Integer)
        {
            CalcFormula = count("Booking List" where("From Type" = const(Ads),
                                                      "Booking No." = field("Deal No."),
                                                      "Booking Line No." = field("Line No.")));
            Editable = false;
            FieldClass = FlowField;
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
            CalcFormula = lookup("Ads. Booking Header"."Final Customer No." where("No." = field("Deal No.")));
            Caption = 'Sell-to Customer No.';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Customer;
        }
        field(102; "Bill-to Customer No."; Code[20])
        {
            CalcFormula = lookup("Ads. Booking Header"."Bill-to Customer No." where("No." = field("Deal No.")));
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
        field(510; "Subdeal No."; Code[20])
        {
            Editable = false;

        }
        field(520; "Product Name"; Text[50])
        {
            Caption = 'Product Name';
        }
        field(530; "Publication Date"; Date)
        {
            trigger OnValidate()
            var
                YearText: Text;
            begin
                YearText := Format(Date2DMY("Publication Date", 3));
                "Publication Month" := copystr(FORMAT("Publication Date", 0, '<Month Text>'), 1, 3) + '-' + CopyStr(YearText, StrLen(YearText) - 1, 2);
                //"Publication Month" := FORMAT("Publication Date", 0, '<Month Text,3>-<Year2>')
            end;
        }
        field(531; "Publication Month"; code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Publication Month"));
            trigger OnValidate()
            var
                AdsBookingLine: Record "Ads. Booking Line";
                DateRec: Record date;
            begin
                if ("Ads. Position Code" <> '') and ("Publication Month" <> '') then begin
                    AdsBookingLine.Reset();
                    //adsbookingline.setrange("deal No.", rec."Deal No.");
                    AdsBookingLine.SetRange("Ads. Position Code", rec."Ads. Position Code");
                    AdsBookingLine.SetRange("Publication Month", rec."Publication Month");
                    AdsBookingLine.SetFilter("Line Status", '<>%1', AdsBookingLine."Line Status"::Cancelled);//VAH Added 08/18/2021
                    if AdsBookingLine.FindFirst() then
                        //if AdsBookingLine."Deal No." <> rec."Deal No." then
                            Error('Booking ads. position aready exists');
                end;

                if "Publication Month" <> '' then begin
                    evaluate("Publication Date", Format("Publication Month") + '-01');
                    "Publication Date" := CalcDate('1M-1D', "Publication Date");
                end;

            end;
        }
        field(540; "Booking Status"; Option)
        {
            Caption = 'Booking Status';
            OptionCaption = ',Deal Completed,Prepayment,Accrual';
            OptionMembers = ,"Deal Completed",Prepayment,Accrual;
        }

        field(560; "Revenue Status"; Option)
        {
            Caption = 'Invoice Status';
            OptionCaption = 'Pending,Recognized';
            OptionMembers = Pending,Issued,Recognized;
        }

        field(580; "Job Proof Submitted"; Boolean)
        {
            Caption = 'Job Proof Submitted';
        }

        field(600; "Remark for Accountant"; Text[300])
        {
            Caption = 'Remark By Ad Traffic';
        }
        field(610; "Line Remark (If any)"; Text[50])
        {

        }
        field(620; "Product Code"; Code[20])
        {
            TableRelation = Product;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Product: Record Product;
                AdsBH: Record "Ads. Booking Header";
            begin
                if Product.Get(("Product Code")) then
                    "Product Name" := Product."Product Name";
                "Sub Product Code" := '';
                AdsBH.Get("Deal No.");
                if AdsBH."Currency Factor" <> 0 then
                    "Currency Factor" := AdsBH."Currency Factor"
                else
                    "Currency Factor" := 1;
                "Currency Code" := AdsBH."Currency Code";

            end;
        }
        field(630; "Posted Invoice No."; Code[20])
        {
            TableRelation = "Sales Invoice Header";
        }
        field(640; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(650; "Posting Status"; Option)
        {
            OptionMembers = Open,"Rev. Pending","Inv.+Rev. Pending",Rejected,"Inv.+Rev. Posted","Rev. Posted";

        }
        field(660; "Remark from Accountant"; Text[120])
        {

        }
        field(670; "Sub Product Name"; Text[50])
        {

        }
        field(680; "Request Date & Time"; Datetime)
        {
            DataClassification = ToBeClassified;
        }
        field(690; "Created By"; Code[20])
        {
            TableRelation = User;
        }
        field(700; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
            trigger onvalidate()
            begin
                "Currency Factor" := CurrExchRate.ExchangeRate("Publication Date", "Currency Code");
            end;
        }
        field(710; "Currency Factor"; Decimal)
        {
            trigger OnValidate()
            begin

                "Amount (LCY)" := Amount / "Currency Factor";
            end;
        }
        field(720; "Amount (LCY)"; decimal)
        {

        }
        field(730; "Ads. Type Description"; Text[50])
        {

        }
        field(740; "Sub Deal Invoiced Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Sales Invoice Line".Amount where("Deal No." = field("Deal No."), "Sub Deal No." = field("Subdeal No.")));
        }
        field(750; "Agency Commission %"; Decimal)
        {
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                "Agency Commission Amount" := (Amount * "Agency Commission %") / 100;
            end;
        }
        field(760; "Agency Commission Amount"; Decimal)
        {
            Editable = false;
        }
        field(770; "Contract No."; Text[35])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Ads. Booking Header"."Contract No." where("No." = field("Deal No.")));
        }

    }

    keys
    {
        key(Key1; "Deal No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Sub Product Code", "Volume No.", "Issue No.", "Line Status", "Ads. Type code (Revenue type Code)", "Ads. Size Code", "Ads. Type", "Ads. Position Code", "Salesperson Code")
        {
            SumIndexFields = "Total Counting Unit";
        }
        key(Key3; "Ads. Item No.", "Line Status", "Sub Product Code")
        {
            SumIndexFields = "Total Counting Unit";
        }
        key(Key4; "Ads. Item No.", "Ads. Position Code", "Line Status", "Waiting List No.")
        {
        }
        key(Key5; "Ads. Item No.", "Ads. Type", "Ads. Position Code")
        {
        }
        key(Key6; "Deal No.", "Subdeal No.")
        {

        }
        key(Key7; "Publication Month", "deal no.")
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        if not ("Line Status" in ["line status"::Booking, "line status"::"Waiting List", "line status"::Confirmed]) then
            Error(Text002, FieldCaption("Line Status"), "Line Status");
        AdsBookingLine.Reset();
        AdsBookingLine.SetCurrentKey("Deal No.", "Subdeal No.");
        AdsBookingLine.SetRange("Deal No.", "Deal No.");
        if AdsBookingLine.FindLast() then
            if AdsBookingLine."Subdeal No." <> "Subdeal No." then
                Error('Pls delete Sub Deal No. %1', AdsBookingLine."Subdeal No.");
    end;

    trigger OnInsert()
    begin
        if "Shortcut Dimension 5 Code" = '' then begin
            GLSetup.GetShortcutDimCode(GLSetupShortcutDimCode);
            Error(Text001, GLSetupShortcutDimCode[5]);
        end;

        //TestField("Ads. Item No."); //VAH
        TestField("Ads. Position Code");
        CheckWaitingList;

        GetAdsBookingHdr;
        //AdsBookingHdr.TESTFIELD("Ads. Sales Type");
        "Salesperson Code" := AdsBookingHdr."Salesperson Code";

        "Last Date Modified" := CurrentDatetime; //18.06.2012
    end;

    trigger OnModify()
    var
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        "Last Date Modified" := CurrentDatetime; //18.06.2012
        if "Posting Status" IN ["Posting Status"::"Inv.+Rev. Posted", "Posting Status"::"Inv.+Rev. Pending", "Posting Status"::"Rev. Posted", "Posting Status"::"Rev. Pending"]
        then
            Error('Line can not be modified because subdeal already posted');
        /*
        TESTFIELD("Ads. Item No.");
        TESTFIELD("Ads. Position");
        IF "Line Status" <> xRec."Line Status" THEN
          EXIT;
        IF NOT ("Line Status" IN ["Line Status"::Booking,"Line Status"::"Waiting List"]) THEN
          IF Remark <> xRec.Remark THEN BEGIN
            AdsBookingLine := Rec;
            Rec := xRec;
            Rec.Remark := AdsBookingLine.Remark;
            GetAdsBookingHdr;
            Rec."Salesperson Code" := AdsBookingHdr."Salesperson Code";
            EXIT;
          END ELSE
            ERROR(Text002,FIELDCAPTION("Line Status"),"Line Status");
        
        IF "Shortcut Dimension 5 Code" = '' THEN BEGIN
          GLSetup.GetShortcutDimCode(GLSetupShortcutDimCode);
          ERROR(Text001,GLSetupShortcutDimCode[5]);
        END;
        
        TESTFIELD(Closed,FALSE);
        "Total Counting Unit" := Quantity * "Counting Unit";
        GetAdsBookingHdr;
        "Salesperson Code" := AdsBookingHdr."Salesperson Code";
         */

    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        AdsBookingHdr: Record "Ads. Booking Header";
        AdsItem: Record "Ads. Item";
        AdsProduct: Record Brand;
        AdsPosition: Record "Ads. Position";
        AdsSize: Record "Ads. Size";
        Cust: Record Customer;
        VATPostingSetup: Record "VAT Posting Setup";
        BookingRevType: Record "Booking Revenue Type";
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        GLSetupShortcutDimCode: array[8] of Code[20];
        CurrExchRate: Record "Currency Exchange Rate";
        Text000: label 'You cannot rename a %1.';
        Text001: label '%1 must be specify.';
        Text002: label '%1 must not be %2.';
        Text003: label 'You do not have permission to %1 Ads. Booking Line.';
        Text004: label 'Ads. Item No. %1 for Ads. Position %2 has been %3.';
        Text005: label 'The %1 and %2 are not correct.';
        Text006: label 'You cannot use booking revenue type %1 for magazine code %2.';
        Text007: label 'The %1 is zero. Do you want to continue?';


    procedure GetAdsBookingHdr()
    begin
        if not AdsBookingHdr.Get("Deal No.") then
            Clear(AdsBookingHdr);
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    end;


    procedure TestStatusOpen()
    begin
        if not ("Line Status" in ["line status"::Booking, "line status"::"Waiting List", "Line Status"::Confirmed]) then
            Error(Text002, FieldCaption("Line Status"), "Line Status");
    end;


    procedure UpdateAmounts()
    begin
        //TestField("Ads. Item No.");

        if Amount <> ROUND(Quantity * "Unit Price Excl. VAT") then
            Amount := ROUND(Quantity * "Unit Price Excl. VAT");
        UpdateVATAmounts;
        "Cash Invoice Amount" := "Unit Price Excl. VAT";//VAH
        "Amount (LCY)" := Amount / "Currency Factor";

    end;

    local procedure UpdateVATAmounts()
    var
        AdsBookingLine2: Record "Ads. Booking Line";
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
    begin
        AdsBookingLine2.SETPERMISSIONFILTER;
        AdsBookingLine2.SetRange("Deal No.", "Deal No.");
        AdsBookingLine2.SetFilter("Line No.", '<>%1', "Line No.");
        if Amount = 0 then
            if xRec.Amount >= 0 then
                AdsBookingLine2.SetFilter(Amount, '>%1', 0)
            else
                AdsBookingLine2.SetFilter(Amount, '<%1', 0)
        else
            if AdsBookingLine2.Amount > 0 then
                AdsBookingLine2.SetFilter(Amount, '>%1', 0)
            else
                AdsBookingLine2.SetFilter(Amount, '<%1', 0);

        VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group");
        TotalAmount := 0;
        TotalAmountInclVAT := 0;
        if (VATPostingSetup."VAT Calculation Type" = VATPostingSetup."vat calculation type"::"Sales Tax") or
           ((VATPostingSetup."VAT Calculation Type" in
            [VATPostingSetup."vat calculation type"::"Normal VAT", VATPostingSetup."vat calculation type"::"Reverse Charge VAT"]) and
            (VATPostingSetup."VAT %" <> 0))
        then begin
            if AdsBookingLine2.Find('-') then
                repeat
                    TotalAmount := TotalAmount + AdsBookingLine2.Amount;
                    TotalAmountInclVAT := TotalAmountInclVAT + AdsBookingLine2."Amount Including VAT";
                until AdsBookingLine2.Next = 0;
        end;

        case VATPostingSetup."VAT Calculation Type" of
            VATPostingSetup."vat calculation type"::"Normal VAT",
            VATPostingSetup."vat calculation type"::"Reverse Charge VAT":
                begin
                    "Amount Including VAT" :=
                      TotalAmount + Amount +
                      ROUND(
                        (TotalAmount + Amount) * VATPostingSetup."VAT %" / 100) -
                      TotalAmountInclVAT;
                end;
            VATPostingSetup."vat calculation type"::"Full VAT":
                begin
                    Amount := 0;
                    "Amount Including VAT" := Amount;
                end;
        /*
        VATPostingSetup."VAT Calculation Type"::"Sales Tax":
          BEGIN
            "Amount Including VAT" :=
              TotalAmount + Amount +
              ROUND(
                SalesTaxCalculate.CalculateTax(
                  "Tax Area Code","Tax Group Code","Tax Liable",SalesHeader."Posting Date",
                  (TotalAmount + Amount),(TotalQuantityBase + "Quantity (Base)"),
                  SalesHeader."Currency Factor"),Currency."Amount Rounding Precision") -
              TotalAmountInclVAT;
            IF "VAT Base Amount" <> 0 THEN
              "VAT %" :=
                ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
            ELSE
              "VAT %" := 0;
          END;
        */
        end;

    end;


    procedure CheckWaitingList()
    var
        AdsBookingLine2: Record "Ads. Booking Line";
    begin
        if "Ads. Item No." = '' then
            exit;
        if "Ads. Position Code" = '' then
            exit;
        AdsBookingLine2.SETPERMISSIONFILTER;
        AdsBookingLine2.SetCurrentkey("Ads. Item No.", "Ads. Position Code", "Line Status", "Waiting List No.");
        AdsBookingLine2.SetRange("Ads. Item No.", "Ads. Item No.");
        AdsBookingLine2.SetRange("Ads. Position Code", "Ads. Position Code");
        if not AdsBookingLine2.Find('-') then begin
            //"Line Status" := "line status"::Booking;//VAH
            "Line Status" := "line status"::Confirmed;//VAH
            "Last Status Date" := CurrentDatetime;//GKU:010
            "Last Date Modified" := CurrentDatetime; //18.06.2012
            "Waiting List No." := 0;
            exit;
        end;
        //case 1 Invoiced,Closed
        AdsBookingLine2.SetFilter("Line Status", '%1|%2',
          AdsBookingLine2."line status"::Invoiced,
          AdsBookingLine2."line status"::Closed);
        if AdsBookingLine2.Find('-') then
            Error(Text004, "Ads. Item No.", "Ads. Position Code", "Line Status");
        //case 2 Waiting List (not include case 1)
        AdsBookingLine2.SetRange("Line Status", AdsBookingLine2."line status"::"Waiting List");
        if AdsBookingLine2.Find('+') then begin
            "Line Status" := "line status"::"Waiting List";
            "Last Status Date" := CurrentDatetime;//GKU:010
            "Last Date Modified" := CurrentDatetime; //18.06.2012
            "Waiting List No." := AdsBookingLine2."Waiting List No." + 1;
            exit;
        end;
        //case Booking,Confirm,Approve,Hold (not include case 1,2)
        AdsBookingLine2.SetFilter("Line Status", '%1|%2|%3|%4',
          AdsBookingLine2."line status"::Booking,
          AdsBookingLine2."line status"::Confirmed,
          AdsBookingLine2."line status"::Approved,
          AdsBookingLine2."line status"::Hold);
        if AdsBookingLine2.Find('-') then begin
            "Line Status" := "line status"::"Waiting List";
            "Last Status Date" := CurrentDatetime;//GKU:010
            "Last Date Modified" := CurrentDatetime; //18.06.2012
            "Waiting List No." := 1;
            exit;
        end;
        //case Cancel (not include case 1,2,3)
        AdsBookingLine2.SetRange("Line Status", AdsBookingLine2."line status"::Cancelled);
        if AdsBookingLine2.Find('-') then begin
            //"Line Status" := "line status"::Booking;
            "Line Status" := "line status"::Confirmed;
            "Last Status Date" := CurrentDatetime;//GKU:010
            "Last Date Modified" := CurrentDatetime; //18.06.2012
            "Cancelled Date" := CurrentDatetime;//GKU:010
            exit;
        end;
    end;


    procedure ConfirmBooking()
    begin
        GetAdsBookingHdr;
        AdsBookingHdr.TestField("Client Type");

        //TestField("Ads. Item No.");
        TestField("Line Status", "line status"::Booking);
        TestField(Quantity);
        if "Booking Revenue Type" <> "booking revenue type"::"Non-Billable" then begin
            //TESTFIELD("Unit Price Excl. VAT");
            //KKE : #002 +
            if "Unit Price Excl. VAT" = 0 then
                if not Confirm(StrSubstNo(Text007, FieldCaption("Unit Price Excl. VAT")), false) then
                    exit;
            //KKE : #002 -
        end;

        if not UserSetup.Get(UserId) then
            Clear(UserSetup);
        if not UserSetup."Allow Confirm Ads. Booking" then
            Error(Text003, 'Confirm');

        if "Create Sales Invoice" then begin
            TestField("Bill Revenue G/L Account");
            //TESTFIELD("Cash Invoice Amount");
            //KKE : #002 +
            if "Cash Invoice Amount" = 0 then
                if not Confirm(StrSubstNo(Text007, FieldCaption("Cash Invoice Amount")), false) then
                    exit;
            //KKE : #002 -
        end;
        if "Barter Required Document" then begin
            TestField("Barter G/L Account");
            //TESTFIELD("Barter Amount");
            //KKE : #002 +
            if "Barter Amount" = 0 then
                if not Confirm(StrSubstNo(Text007, FieldCaption("Barter Amount")), false) then
                    exit;
            //KKE : #002 -
        end;
        if "Create Sales Invoice" or "Barter Required Document" then begin
            //IF ("Cash Invoice Amount" + "Barter Amount") <> "Amount Including VAT" THEN
            if ("Cash Invoice Amount" + "Barter Amount") <> Amount then
                Error(Text005, FieldCaption("Cash Invoice Amount"), FieldCaption("Barter Amount"));
        end;

        "Line Status" := "line status"::Confirmed;
        "Last Status Date" := CurrentDatetime;//GKU:010
        "Last Date Modified" := CurrentDatetime; //18.06.2012
        Modify;
    end;


    procedure ApproveBooking()
    begin
        //TestField("Ads. Item No.");
        TestField("Line Status", "line status"::Confirmed);

        if not UserSetup.Get(UserId) then
            Clear(UserSetup);
        if not UserSetup."Allow Approve Ads. Booking" then
            Error(Text003, 'Approve');

        "Line Status" := "line status"::Approved;
        "Last Status Date" := CurrentDatetime;//GKU:010
        "Last Date Modified" := CurrentDatetime; //18.06.2012
        Modify;
    end;


    procedure UnApproveBooking()
    begin
        //TestField("Ads. Item No.");
        TestField("Line Status", "line status"::Approved);

        if not UserSetup.Get(UserId) then
            Clear(UserSetup);
        UserSetup.TestField("Allow Approve Ads. Booking", true);

        "Line Status" := "line status"::Confirmed;
        "Last Status Date" := CurrentDatetime;//GKU:010
        "Last Date Modified" := CurrentDatetime; //18.06.2012
        Modify;
    end;


    procedure RejectBooking()
    begin
        //TestField("Ads. Item No.");
        TestField("Line Status", "line status"::Confirmed);

        if not UserSetup.Get(UserId) then
            Clear(UserSetup);
        if not UserSetup."Allow Hold Ads. Booking" then
            Error(Text003, 'Hold');

        "Line Status" := "line status"::Hold;
        "Last Status Date" := CurrentDatetime;//GKU:010
        "Last Date Modified" := CurrentDatetime; //18.06.2012
        Modify;
    end;


    procedure UnRejectBooking()
    begin
        //TestField("Ads. Item No.");
        TestField("Line Status", "line status"::Hold);

        if not UserSetup.Get(UserId) then
            Clear(UserSetup);
        UserSetup.TestField("Allow Hold Ads. Booking", true);

        "Line Status" := "line status"::Confirmed;
        "Last Status Date" := CurrentDatetime;//GKU:010
        "Last Date Modified" := CurrentDatetime; //18.06.2012
        Modify;
    end;


    procedure CancelBooking()
    var
        SalesInvHdr: Record "Sales Invoice Header";
        SalesCreMemoHdr: Record "Sales Cr.Memo Header";
    begin
        //TestField("Ads. Item No.");

        //KKE : #009 +
        if "Line Status" = "line status"::Invoiced then begin //check Credit Memo
            SalesInvHdr.SetRange("Pre-Assigned No.", "Cash Invoice No.");
            if SalesInvHdr.Find('-') then begin
                SalesCreMemoHdr.SetRange("Applied-to Tax Invoice", SalesInvHdr."No.");
                if not SalesCreMemoHdr.Find('-') then
                    Error(Text002, FieldCaption("Line Status"), "Line Status");
            end;
        end else
            //KKE : #009 -

            if "Line Status" in
              ["line status"::Approved, "line status"::Hold, "line status"::Invoiced, "line status"::Closed]
            then
                Error(Text002, FieldCaption("Line Status"), "Line Status");

        if not UserSetup.Get(UserId) then
            Clear(UserSetup);
        if not UserSetup."Allow Cancel Ads. Booking" then
            Error(Text003, 'Cancel');

        "Line Status" := "line status"::Cancelled;
        "Last Status Date" := CurrentDatetime;//GKU:010
        "Last Date Modified" := CurrentDatetime; //18.06.2012
        "Cancelled Date" := CurrentDatetime;//GKU:010
        Closed := true;
        Modify;
    end;


    procedure CloseBooking()
    begin
        //for Non-Bill and Barter Required Doc = No only
        //TestField("Ads. Item No.");
        TestField("Line Status", "line status"::Approved);
        TestField("Booking Revenue Type", "booking revenue type"::"Non-Billable");
        TestField("Barter Required Document", false);

        if not UserSetup.Get(UserId) then
            Clear(UserSetup);

        if not UserSetup."Allow Close Ads. Booking" then
            Error(Text003, 'Close');

        "Line Status" := "line status"::Closed;
        "Last Status Date" := CurrentDatetime;//GKU:010
        "Last Date Modified" := CurrentDatetime; //18.06.2012
        Closed := true;
        Modify;
    end;


    procedure ReopenConfirm()
    begin
        //TestField("Ads. Item No.");
        TestField("Line Status", "line status"::Confirmed);

        if not UserSetup.Get(UserId) then
            Clear(UserSetup);
        if not UserSetup."Allow Confirm Ads. Booking" then
            Error(Text003, 'Confirm');

        "Line Status" := "line status"::Booking;
        "Last Status Date" := CurrentDatetime;//GKU:010
        "Last Date Modified" := CurrentDatetime; //18.06.2012
        Modify;
    end;
}

