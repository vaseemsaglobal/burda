Table 50005 "Subscriber Contract"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // GKU : Goragot Kuanmuang
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   07.03.2007   KKE   New table for Subscriber Contract.
    // 002   04.10.2007   GKU   Use 'Credit Charge Amount(Cust.)' instead 'Credit Card Charge Fee' in caluate
    // 003   29.04.2008   KKE   Allow create Subscriber Contract which Net Price is zero for Contract Type Complimentary.

    DrillDownPageID = "Subscriber Contract List";
    LookupPageID = "Subscriber Contract List";


    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SubscriptionSetup.Get;
                    NoSeriesMgt.TestManual(SubscriptionSetup."Subscriber Contract Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Subscriber No."; Code[20])
        {
            TableRelation = Subscriber;

            trigger OnValidate()
            begin
                SSContractLE.SETPERMISSIONFILTER;
                SSContractLE.Reset;
                SSContractLE.SetRange("Subscriber Contract No.", "No.");
                if SSContractLE.Find('-') then
                    Error(Text018, FieldCaption("Subscriber No."));
            end;
        }
        field(3; "Subscription Date"; Date)
        {

            trigger OnValidate()
            begin
                Validate("Credit Card Bank Amount");
            end;
        }
        field(4; "Contract Type"; Option)
        {
            OptionMembers = " ",Subscriber,Complimentary;
        }
        field(5; "Contract Sub Type"; Option)
        {
            OptionMembers = " ","SALES & MKT VIP","SP CHANNEL","MD VIP","VIP ED",Member,"EVENT",EMBASSY,PRESS;
        }
        field(6; "VIP Type"; Code[10])
        {
        }
        field(7; "Contract Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,Confirm,Released,Closed,Cancelled;
        }
        field(8; "Payment Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,Paid;
        }
        field(9; "Contract Category"; Option)
        {
            OptionMembers = New,Renew,Promotion;
        }
        field(10; "Renew Contract From"; Code[20])
        {
            Editable = false;
            TableRelation = "Subscriber Contract";
        }
        field(11; "Renew Contract To"; Code[20])
        {
            Editable = false;
            TableRelation = "Subscriber Contract";
        }
        field(12; "Related Contract No."; Code[20])
        {
            TableRelation = "Subscriber Contract";

            trigger OnValidate()
            begin
                if "Related Contract No." <> '' then
                    TestField("Free Magazine Flag", true)
                else begin
                    "Free Other Magazine Code" := '';
                    "Free Other Magazine Quantity" := 0;
                end;
            end;
        }
        field(13; "Resource Lead"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Resource Lead"));
        }
        field(14; "Resource Channel"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Resource Channel"));
        }
        field(15; "Shipping Agent Code"; Code[20])
        {
            TableRelation = Customer where("Shipping Agent" = const(true));
        }
        field(16; "Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";

            trigger OnValidate()
            begin
                if "Starting Magazine Item No." <> '' then begin
                    Item.Get("Starting Magazine Item No.");
                    TestField("Magazine Code", Item."Magazine Code");
                end else
                    if "Ending Magazine Item No." <> '' then begin
                        Item.Get("Ending Magazine Item No.");
                        TestField("Magazine Code", Item."Magazine Code");
                    end;
                if Promotion.Get("Promotion Code") then
                    TestField("Magazine Code", Promotion."Magazine Code");
            end;
        }
        field(17; "Promotion Code"; Code[20])
        {
            TableRelation = Promotion;

            trigger OnValidate()
            begin
                if Promotion.Get("Promotion Code") then begin
                    "Promotion Type" := Promotion."Promotion Type";
                    "Promotion Price" := Promotion."Promotion Price";
                    "Discount Type" := Promotion."Discount Type";
                    "Discount Value" := Promotion."Discount Value";
                    "Promotion Net Price" := Promotion."Promotion Net Price";
                    Validate("Promotion Quantity", Promotion."Promotion Quantity");
                    "Promotion Duration" := Promotion."Promotion Duration";
                    "Premium Flag" := Promotion."Premium Flag";
                    "Premium Item 1" := Promotion."Premium Item 1";
                    "Premium Quantity 1" := Promotion."Premium Quantity 1";
                    "Premium Item 2" := Promotion."Premium Item 2";
                    "Premium Quantity 2" := Promotion."Premium Quantity 2";
                    "Premium Item 3" := Promotion."Premium Item 3";
                    "Premium Quantity 3" := Promotion."Premium Quantity 3";
                    "Premium Item 4" := Promotion."Premium Item 4";
                    "Premium Quantity 4" := Promotion."Premium Quantity 4";
                    "Premium Item 5" := Promotion."Premium Item 5";
                    "Premium Quantity 5" := Promotion."Premium Quantity 5";
                    "Free Magazine Flag" := Promotion."Free Magazine Flag";
                    "Free Magazine Code" := Promotion."Free Magazine Code";
                    "Free Magazine Quantity" := Promotion."Free Magazine Quantity";
                    "Free Other Magazine Code" := Promotion."Free Other Magazine Code";
                    "Free Other Magazine Quantity" := Promotion."Free Other Magazine Quantity";
                    TestField("Magazine Code", Promotion."Magazine Code");
                end else begin
                    "Promotion Type" := Promotion."promotion type"::" ";
                    "Promotion Price" := 0;
                    "Discount Type" := 0;
                    "Discount Value" := 0;
                    "Promotion Net Price" := 0;
                    Validate("Promotion Quantity", 0);
                    "Promotion Duration" := 0;
                    "Premium Flag" := false;
                    "Premium Item 1" := '';
                    "Premium Quantity 1" := 0;
                    "Premium Item 2" := '';
                    "Premium Quantity 2" := 0;
                    "Premium Item 3" := '';
                    "Premium Quantity 3" := 0;
                    "Premium Item 4" := '';
                    "Premium Quantity 4" := 0;
                    "Premium Item 5" := '';
                    "Premium Quantity 5" := 0;
                    "Free Magazine Flag" := false;
                    "Free Magazine Code" := '';
                    "Free Magazine Quantity" := 0;
                    "Free Other Magazine Code" := '';
                    "Free Other Magazine Quantity" := 0;
                end;
                Validate("Credit Card Charge Fee");
                Validate("Promotion Quantity");
            end;
        }
        field(18; "Promotion Price"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                if "Discount Type" = "discount type"::Percentage then
                    "Promotion Net Price" := "Promotion Price" - ROUND("Promotion Price" * "Discount Value" / 100)
                else
                    "Promotion Net Price" := "Promotion Price" - "Discount Value";
                Validate("Promotion Net Price");
            end;
        }
        field(19; "Discount Type"; Option)
        {
            OptionMembers = " ",Amount,Percentage;

            trigger OnValidate()
            begin
                Validate("Discount Value");
                Validate("Promotion Price");
            end;
        }
        field(20; "Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            MinValue = 0;

            trigger OnValidate()
            begin
                if (("Discount Value" > 100) or ("Discount Value" < 0)) and ("Discount Type" = "discount type"::Percentage) then
                    Error(Text002);
                Validate("Promotion Price");
            end;
        }
        field(21; "Promotion Net Price"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;

            trigger OnValidate()
            begin
                Validate("Credit Card Charge Fee");
            end;
        }
        field(22; "Promotion Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Contract Quantity" := "Promotion Quantity" + "Free Magazine Quantity";
            end;
        }
        field(23; "Promotion Duration"; Option)
        {
            OptionMembers = " ","2 Months","3 Months","6 Months","1 Year","2 Years","18 Months","3 Years";
        }
        field(24; "Contract Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(25; "Contract Net Price"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;

            trigger OnValidate()
            begin
                //GKU : #002 +
                //"Contract Net Price" := "Promotion Net Price" + "Credit Card Charge Fee";
                "Contract Net Price" := "Promotion Net Price" + "Credit Charge Amount (Cust.)";
            end;
        }
        field(26; "Starting Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine),
                                        "Magazine Code" = field("Magazine Code"));

            trigger OnValidate()
            var
                l_Item: Record Item;
            begin
                "Starting Volume No." := '';
                "Starting Issue No." := '';
                "Starting Issue Date" := 0D;
                if Item.Get("Starting Magazine Item No.") then begin
                    TestField("Magazine Code", Item."Magazine Code");
                    "Starting Volume No." := Item."Volume No.";
                    "Starting Issue No." := Item."Issue No.";
                    "Starting Issue Date" := Item."Issue Date";
                end;
                ItemFilter := StrSubstNo('%1..%2', "Starting Magazine Item No.", "Ending Magazine Item No.");
                if ItemFilter = '..' then
                    exit;
                l_Item.SetFilter("No.", ItemFilter);
                l_Item.Find('-');
            end;
        }
        field(27; "Starting Volume No."; Code[20])
        {
            Editable = false;
            TableRelation = Volume;

            trigger OnValidate()
            begin
                Validate("Starting Issue No.");
            end;
        }
        field(28; "Starting Issue No."; Code[20])
        {
            Editable = false;
            TableRelation = "Issue No.";

            trigger OnValidate()
            begin
                "Starting Issue Date" := 0D;
                if MagazineVolumeIssue.Get("Magazine Code", "Starting Volume No.", "Starting Issue No.") then
                    "Starting Issue Date" := MagazineVolumeIssue."Issue Date";
            end;
        }
        field(29; "Starting Issue Date"; Date)
        {
            Editable = false;
        }
        field(30; "Ending Magazine Item No."; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Magazine),
                                        "Magazine Code" = field("Magazine Code"));

            trigger OnValidate()
            var
                l_Item: Record Item;
            begin
                "Ending Volume No." := '';
                "Ending Issue No." := '';
                "Ending Issue Date" := 0D;
                if Item.Get("Ending Magazine Item No.") then begin
                    TestField("Magazine Code", Item."Magazine Code");
                    "Ending Volume No." := Item."Volume No.";
                    "Ending Issue No." := Item."Issue No.";
                    "Ending Issue Date" := Item."Issue Date";
                end;
                ItemFilter := StrSubstNo('%1..%2', "Starting Magazine Item No.", "Ending Magazine Item No.");
                if ItemFilter = '..' then
                    exit;
                l_Item.SetFilter("No.", ItemFilter);
                l_Item.Find('-');
            end;
        }
        field(31; "Ending Volume No."; Code[20])
        {
            Editable = false;
            TableRelation = Volume;
        }
        field(32; "Ending Issue No."; Code[20])
        {
            Editable = false;
            TableRelation = "Issue No.";

            trigger OnValidate()
            begin
                "Ending Issue Date" := 0D;
                if MagazineVolumeIssue.Get("Magazine Code", "Ending Volume No.", "Ending Issue No.") then
                    "Ending Issue Date" := MagazineVolumeIssue."Issue Date";
            end;
        }
        field(33; "Ending Issue Date"; Date)
        {
            Editable = false;
        }
        field(34; "Expired Date"; Date)
        {
        }
        field(35; "Premium Flag"; Boolean)
        {
        }
        field(36; "Premium Item 1"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 1" = '' then
                    "Premium Quantity 1" := 0
                else
                    "Premium Quantity 1" := 1;
            end;
        }
        field(37; "Premium Quantity 1"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Premium Quantity 1" <> 0 then
                    TestField("Premium Item 1");
            end;
        }
        field(38; "Premium Item 2"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 2" = '' then
                    "Premium Quantity 2" := 0
                else
                    "Premium Quantity 2" := 1;
            end;
        }
        field(39; "Premium Quantity 2"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Premium Quantity 2" <> 0 then
                    TestField("Premium Item 2");
            end;
        }
        field(40; "Premium Item 3"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 3" = '' then
                    "Premium Quantity 3" := 0
                else
                    "Premium Quantity 3" := 1;
            end;
        }
        field(41; "Premium Quantity 3"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Premium Quantity 3" <> 0 then
                    TestField("Premium Item 3");
            end;
        }
        field(42; "Premium Item 4"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 4" = '' then
                    "Premium Quantity 4" := 0
                else
                    "Premium Quantity 4" := 1;
            end;
        }
        field(43; "Premium Quantity 4"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Premium Quantity 4" <> 0 then
                    TestField("Premium Item 4");
            end;
        }
        field(44; "Premium Item 5"; Code[20])
        {
            TableRelation = Item where("Item Type" = const(Premium));

            trigger OnValidate()
            begin
                if "Premium Item 5" = '' then
                    "Premium Quantity 5" := 0
                else
                    "Premium Quantity 5" := 1;
            end;
        }
        field(45; "Premium Quantity 5"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Premium Quantity 5" <> 0 then
                    TestField("Premium Item 5");
            end;
        }
        field(46; "Free Magazine Flag"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Free Magazine Flag" = false then begin
                    TestField("Free Magazine Code", '');
                    TestField("Related Contract No.", '');
                end;
            end;
        }
        field(47; "Free Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";

            trigger OnValidate()
            begin
                if "Free Magazine Code" <> '' then begin
                    TestField("Free Magazine Flag", true);
                    TestField("Free Magazine Code", "Magazine Code");
                end else
                    Validate("Free Magazine Quantity", 0);
            end;
        }
        field(48; "Free Magazine Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Free Magazine Quantity" <> 0 then
                    TestField("Free Magazine Code");

                "Contract Quantity" := "Promotion Quantity" + "Free Magazine Quantity";
            end;
        }
        field(49; "Premium Start Volume No."; Code[20])
        {
            TableRelation = Volume;

            trigger OnValidate()
            begin
                Validate("Premium Start Issue No.");
            end;
        }
        field(50; "Premium Start Issue No."; Code[20])
        {
            TableRelation = "Issue No.";

            trigger OnValidate()
            begin
                "Premium Start Issue Date" := 0D;
                if MagazineVolumeIssue.Get("Magazine Code", "Premium Start Volume No.", "Premium Start Issue No.") then
                    "Premium Start Issue Date" := MagazineVolumeIssue."Issue Date";
            end;
        }
        field(51; "Premium Start Issue Date"; Date)
        {
            Editable = false;
        }
        field(52; "Premium End Volume No."; Code[20])
        {
            TableRelation = Volume;

            trigger OnValidate()
            begin
                Validate("Premium End Issue No.");
            end;
        }
        field(53; "Premium End Issue No."; Code[20])
        {
            TableRelation = "Issue No.";

            trigger OnValidate()
            begin
                "Premium End Issue Date" := 0D;
                if MagazineVolumeIssue.Get("Magazine Code", "Premium End Volume No.", "Premium End Issue No.") then
                    "Premium End Issue Date" := MagazineVolumeIssue."Issue Date";
            end;
        }
        field(54; "Premium End Issue Date"; Date)
        {
            Editable = false;
        }
        field(55; "Payment Remark"; Text[50])
        {
        }
        field(56; "Payment Method Code"; Code[10])
        {
            TableRelation = "Payment Method";
        }
        field(57; "Receipt No."; Code[20])
        {
        }
        field(58; "Receipt Amount"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(59; "Credit Card Bank"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Credit Card Bank"));

            trigger OnValidate()
            begin
                Validate("Credit Card Bank Amount");
            end;
        }
        field(60; "Credit Card Type"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Credit Card Type"));

            trigger OnValidate()
            begin
                Validate("Credit Card Bank Amount");
            end;
        }
        field(61; "Credit Card No."; Code[20])
        {
        }
        field(62; "Credit Card 3Last No."; Text[3])
        {
        }
        field(63; "Credit Card Expire Date"; Text[30])
        {

            trigger OnValidate()
            begin
                Validate("Credit Card Base Amount");
            end;
        }
        field(64; "Credit Card Bank Amount"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;

            trigger OnValidate()
            begin
                /*---
                "Credit Card Charge Fee" := 0;
                "Credit Card Amount" := 0;
                IF "Credit Card Bank Amount" <> 0 THEN BEGIN
                  TESTFIELD("Subscription Date");
                  CreditCard.SETRANGE(Bank,"Credit Card Bank");
                  CreditCard.SETRANGE("Credit Card Type","Credit Card Type");
                  CreditCard.SETFILTER("End Date",'>=%1',"Subscription Date");
                  IF CreditCard.FIND('-') THEN
                    "Credit Card Charge Fee" :=
                      ROUND(("Credit Card Bank Amount" * CreditCard."% Charge Fee"/100) * (1 + CreditCard."VAT % for Charge Fee"/100));
                  "Credit Card Amount" := "Credit Card Bank Amount" + "Credit Card Charge Fee";
                END;
                VALIDATE("Credit Card Charge Fee");
                ---*/

            end;
        }
        field(65; "Credit Card Charge Fee"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;

            trigger OnValidate()
            begin
                //GKU : #002
                //"Contract Net Price" := "Promotion Net Price" + "Credit Card Charge Fee";
                "Contract Net Price" := "Promotion Net Price" + "Credit Charge Amount (Cust.)";
            end;
        }
        field(66; "Credit Card Amount"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(67; "Bank Code"; Code[20])
        {
        }
        field(68; "Bank Branch"; Code[20])
        {
        }
        field(69; "Check No."; Code[20])
        {
        }
        field(70; "Check Date"; Date)
        {
        }
        field(71; "Check Amount"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(72; "Last SO Magazine Item No."; Code[20])
        {
            Editable = false;
        }
        field(73; "Last SO Date"; Date)
        {
            Editable = false;
        }
        field(74; "Last SO Doc. No."; Code[20])
        {
            Editable = false;
        }
        field(75; "Last Shipment Magazine Item No"; Code[20])
        {
            Editable = false;
        }
        field(76; "Last Shipment Date"; Date)
        {
            Editable = false;
        }
        field(77; "Last Shipment Doc. No."; Code[20])
        {
            Editable = false;
        }
        field(78; Block; Boolean)
        {
        }
        field(79; "Free Other Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";

            trigger OnValidate()
            begin
                if "Free Other Magazine Code" <> '' then begin
                    TestField("Related Contract No.");
                    if "Free Other Magazine Code" = "Magazine Code" then
                        Error(Text016, FieldCaption("Free Other Magazine Code"), FieldCaption("Magazine Code"));
                end else
                    Validate("Free Other Magazine Quantity", 0);
            end;
        }
        field(80; "Free Other Magazine Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Free Other Magazine Quantity" <> 0 then
                    TestField("Free Other Magazine Code");
            end;
        }
        field(90; "Promotion Type"; Option)
        {
            Caption = 'Promotion Type';
            Editable = false;
            OptionMembers = " ",Discount,Premium,Both;
        }
        field(100; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const("Subscriber Contract"),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(200; "Credit Card Base Amount"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                "Credit Charge Amount (Cust.)" := 0;
                "Credit Card Bank Amount" := 0;
                "Credit Card Charge Fee" := 0;
                "Credit Card Amount" := 0;
                if "Credit Card Base Amount" <> 0 then begin
                    TestField("Subscription Date");
                    CreditCard.Reset;
                    CreditCard.SetRange(Bank, "Credit Card Bank");
                    CreditCard.SetRange("Credit Card Type", "Credit Card Type");
                    CreditCard.SetFilter("End Date", '>=%1', "Subscription Date");
                    if not CreditCard.Find('-') then
                        CreditCard.Init;

                    //A
                    "Credit Charge Amount (Cust.)" :=
                      ROUND("Credit Card Base Amount" * CreditCard."% Charge Fee (Cust.)" / 100, 1);  //need integer value
                                                                                                      //B
                    "Credit Card Amount" := "Credit Card Base Amount" + "Credit Charge Amount (Cust.)";
                    //C = (B* %[Charge Fee (Bank)]) + (B* %[Charge Fee (Bank)] * %7%VAT)
                    "Credit Card Charge Fee" :=
                      ROUND(("Credit Card Amount" * CreditCard."% Charge Fee (Bank)" / 100) * (1 + CreditCard."VAT % for Charge Fee" / 100));
                    //Incl. VAT
                    //D = B - C
                    "Credit Card Bank Amount" := "Credit Card Amount" - "Credit Card Charge Fee";
                end;
                Validate("Credit Card Charge Fee");
            end;
        }
        field(201; "Credit Charge Amount (Cust.)"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(202; "Payment Method (Charge Fee)"; Code[10])
        {
            TableRelation = "Payment Method";
        }
        field(203; "Payment Option"; Option)
        {
            OptionMembers = " ",Cash,Transfer,"Postal Order";
        }
        field(204; "Postal Order"; Text[30])
        {
        }
        field(50000; "Rem. Qty"; Decimal)
        {
            Editable = false;
        }
        field(50001; "Total L/E Qty"; Integer)
        {
            CalcFormula = count("Subscriber Contract L/E" where("Subscriber Contract No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Rem Qty Lisa"; Integer)
        {
            CalcFormula = count("Subscriber Contract L/E" where("Subscriber Contract No." = field("No."),
                                                                 "Magazine Item No." = filter(> 'LS0828'),
                                                                 "Magazine Code" = field("Magazine Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Rem Qty HELLO"; Integer)
        {
            CalcFormula = count("Subscriber Contract L/E" where("Subscriber Contract No." = field("No."),
                                                                 "Magazine Item No." = filter(> 'HL0215'),
                                                                 "Magazine Code" = field("Magazine Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Rem Qty AUTOBILD"; Integer)
        {
            CalcFormula = count("Subscriber Contract L/E" where("Subscriber Contract No." = field("No."),
                                                                 "Magazine Item No." = filter(> 'AB0414'),
                                                                 "Magazine Code" = field("Magazine Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Rem Qty Wedding"; Integer)
        {
            CalcFormula = count("Subscriber Contract L/E" where("Subscriber Contract No." = field("No."),
                                                                 "Magazine Item No." = filter(> 'WD0025'),
                                                                 "Magazine Code" = field("Magazine Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Subscriber Name"; Text[50])
        {
            CalcFormula = lookup(Subscriber.Name where("No." = field("Subscriber No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Contract Issue No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Contract Category", "No.")
        {
        }
        key(Key3; "Magazine Code", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        RenewFromSubContract: Record "Subscriber Contract";
    begin
        if "Contract Status" in ["contract status"::Confirm, "contract status"::Released] then
            Error(Text010);

        SSContractLE.SETPERMISSIONFILTER;
        SSContractLE.Reset;
        SSContractLE.SetRange("Subscriber Contract No.", "No.");
        if SSContractLE.Find('-') then
            Error(Text010, "No.");

        if "Renew Contract From" <> '' then begin
            RenewFromSubContract.Get("Renew Contract From");
            RenewFromSubContract."Renew Contract To" := '';
            RenewFromSubContract.Modify;
        end;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SubscriptionSetup.Get;
            SubscriptionSetup.TestField("Subscriber Contract Nos.");
            NoSeriesMgt.InitSeries(SubscriptionSetup."Subscriber Contract Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Subscription Date" := WorkDate;
    end;

    trigger OnModify()
    begin
        if "Payment Option" = xRec."Payment Option" then
            TestField("Contract Status", "contract status"::Open);
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        SubscriptionSetup: Record "Subscription Setup";
        SSContractLE: Record "Subscriber Contract L/E";
        CreditCard: Record "Credit Card";
        Promotion: Record Promotion;
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        Item: Record Item;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: label 'You cannot rename a %1.';
        Text001: label 'Do you want to renew subscriber contract?';
        Text002: label 'Contract Status must not be %1.';
        Text003: label 'New subscriber contract no. %1 has been created.';
        Text004: label 'Do you want to cancel subscriber contract %1?';
        Text005: label 'Balance amount must be zero.';
        Text006: label 'Do you want to create subscriber contract ledger entries?';
        Text007: label 'Create Subscriber Contract L/E...\\';
        Text008: label 'Subscriber No.    #1##########';
        Text009: label 'Create completed. The number of created is %1 record(s).';
        Text010: label 'You cannot delete %1 because there are one or more ledger entries for this subscriber contract.';
        Text011: label 'There is nothing to create.';
        Text012: label 'Total %1 on subscriber contract L/E does not match %2.';
        Text013: label 'Invalid Discount Value.';
        Text014: label 'Contract Status must be Confirm or Released.';
        Text015: label 'Number of magazine item does not match contract quantity.';
        Text016: label '%1 and %2 must be different.';
        Text017: label 'You have already created subscriber contract ledger entries. Do you want to continue?';
        Text018: label 'Subscriber contract ledger entries has been created. You cannot change %1.';
        Text019: label '%1 of Subscriber Contract L/E does not found in the range between %2 and %3.';
        ItemFilter: Text[250];
        Text020: label 'Subscriber contract no. %1 has been renewed.';
        Text021: label 'You do not have this permission.';


    procedure AssistEdit(OldSubsContract: Record "Subscriber Contract"): Boolean
    var
        SubsContract: Record "Subscriber Contract";
    begin
        with SubsContract do begin
            SubsContract := Rec;
            SubscriptionSetup.Get;
            SubscriptionSetup.TestField("Subscriber Contract Nos.");
            if NoSeriesMgt.SelectSeries(SubscriptionSetup."Subscriber Contract Nos.", OldSubsContract."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := SubsContract;
                exit(true);
            end;
        end;
    end;


    procedure GetSubscriberName(): Text[50]
    var
        Subscriber: Record Subscriber;
    begin
        if Subscriber.Get("Subscriber No.") then
            exit(Subscriber.Name);
        exit('');
    end;


    procedure CreateSubscriberContractLE()
    var
        SSContractLE: Record "Subscriber Contract L/E";
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        Window: Dialog;
        NoOfCreated: Integer;
    begin
        if not Confirm(Text006, false) then
            exit;

        TestField("Contract Status", "contract status"::Confirm);
        //GKU : #002 +
        /*--IF "Promotion Net Price" + "Credit Card Charge Fee" <> "Receipt Amount" + "Credit Card Amount" + "Check Amount" THEN--*/
        if "Promotion Net Price" + "Credit Charge Amount (Cust.)" <> "Receipt Amount" + "Credit Card Amount" + "Check Amount" then
            Error(Text005);
        //GKU : #002 -
        if "Contract Type" <> "contract type"::Complimentary then begin  //KKE : #003
            TestField("Promotion Net Price");
            TestField("Contract Quantity");
            TestField("Contract Net Price");
            TestField("Payment Method Code");
        end;  //KKE : #003

        SSContractLE.Reset;
        SSContractLE.SetRange("Subscriber Contract No.", "No.");
        SSContractLE.SetRange("Subscriber No.", "Subscriber No.");
        if SSContractLE.Find('-') then
            if not Confirm(Text017, false) then
                exit;
        SSContractLE.Reset;

        Window.Open(Text007 + Text008);

        MagazineVolumeIssue.SETPERMISSIONFILTER;
        MagazineVolumeIssue.Reset;
        MagazineVolumeIssue.SetRange("Magazine Code", "Magazine Code");
        MagazineVolumeIssue.SetRange("Magazine Item No.", "Starting Magazine Item No.", "Ending Magazine Item No.");
        MagazineVolumeIssue.SetRange("Volume No.", "Starting Volume No.", "Ending Volume No.");
        //MagazineVolumeIssue.SETRANGE("Issue No.","Starting Issue No.","Ending Issue No.");
        MagazineVolumeIssue.SetRange("Create as Item", true);
        if not MagazineVolumeIssue.Find('-') then begin
            Window.Close;
            Error(Text011);
        end;

        repeat
            SSContractLE.Init;
            SSContractLE."Subscriber Contract No." := "No.";
            SSContractLE."Subscriber No." := "Subscriber No.";
            SSContractLE."Magazine Code" := MagazineVolumeIssue."Magazine Code";
            SSContractLE."Volume No." := MagazineVolumeIssue."Volume No.";
            SSContractLE."Issue No." := MagazineVolumeIssue."Issue No.";
            SSContractLE."Issue Date" := MagazineVolumeIssue."Issue Date";
            SSContractLE."Magazine Item No." := MagazineVolumeIssue."Magazine Item No.";
            SSContractLE.Quantity := 1;
            if "Contract Quantity" <> 0 then  //KKE : #003
                SSContractLE."Unit Price" := "Contract Net Price" / "Contract Quantity";
            SSContractLE."Shipping Agent Code" := "Shipping Agent Code";
            SSContractLE."System-Created Entry" := true;
            if SSContractLE.Insert then
                NoOfCreated += 1;
        //ELSE
        //SSContractLE.MODIFY;
        until MagazineVolumeIssue.Next = 0;

        Window.Close;
        Commit;
        Message(StrSubstNo(Text009, NoOfCreated));

    end;


    procedure RenewSubscriberContract()
    var
        NewSSContract: Record "Subscriber Contract";
    begin
        if not Confirm(Text001, false) then
            exit;

        //Can renew subscriber contract when status = release or closed.
        if not ("Contract Status" in ["contract status"::Released, "contract status"::Closed]) then
            Error(Text002, "Contract Status");

        if "Renew Contract To" <> '' then
            Error(Text020, "No.");

        //TESTFIELD("Contract Status","Contract Status"::Released);

        NewSSContract.Init;
        SubscriptionSetup.Get;
        SubscriptionSetup.TestField("Subscriber Contract Nos.");
        if NoSeriesMgt.SelectSeries(SubscriptionSetup."Subscriber Contract Nos.", '', "No. Series") then
            NoSeriesMgt.SetSeries(NewSSContract."No.");

        NewSSContract."Subscriber No." := "Subscriber No.";
        NewSSContract."Subscription Date" := "Subscription Date";
        NewSSContract."Contract Type" := "Contract Type";
        NewSSContract."Contract Sub Type" := "Contract Sub Type";
        NewSSContract."VIP Type" := "VIP Type";
        NewSSContract."Contract Category" := "contract category"::Renew;
        NewSSContract."Renew Contract From" := "No.";
        NewSSContract."Resource Lead" := "Resource Lead";
        NewSSContract."Resource Channel" := "Resource Channel";
        NewSSContract."Shipping Agent Code" := "Shipping Agent Code";
        NewSSContract."Magazine Code" := "Magazine Code";
        NewSSContract.Insert(true);

        "Renew Contract To" := NewSSContract."No.";
        //"Contract Status" := "Contract Status"::Closed;
        Modify;

        Message(Text003, NewSSContract."No.");
        Rec := NewSSContract;
        Commit;
    end;


    procedure ConfirmContract()
    var
        SSContractLE: Record "Subscriber Contract L/E";
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        Window: Dialog;
        NoOfCreated: Integer;
    begin
        TestField("Contract Status", "contract status"::Open);
        //GKU : #002 +
        /*IF "Promotion Net Price" + "Credit Card Charge Fee" <> "Receipt Amount" + "Credit Card Amount" + "Check Amount" THEN
          ERROR(Text005);*/
        if "Promotion Net Price" + "Credit Charge Amount (Cust.)" <> "Receipt Amount" + "Credit Card Amount" + "Check Amount" then
            Error(Text005);
        //GKU : #002 -
        if "Contract Type" <> "contract type"::Complimentary then begin  //KKE : #003
            TestField("Promotion Net Price");
            TestField("Contract Quantity");
            TestField("Contract Net Price");
            TestField("Payment Method Code");
        end;
        TestField("Shipping Agent Code");

        if "Receipt Amount" <> 0 then
            TestField("Receipt No.");

        if "Credit Card Bank Amount" <> 0 then begin
            TestField("Credit Card Bank");
            TestField("Credit Card Type");
            TestField("Credit Card No.");
            TestField("Credit Card 3Last No.");
            TestField("Credit Card Expire Date");
        end;

        if "Check Amount" <> 0 then begin
            TestField("Bank Code");
            TestField("Bank Branch");
            TestField("Check No.");
            TestField("Check Date");
        end;

        MagazineVolumeIssue.SETPERMISSIONFILTER;
        MagazineVolumeIssue.Reset;
        MagazineVolumeIssue.SetRange("Magazine Code", "Magazine Code");
        MagazineVolumeIssue.SetRange("Magazine Item No.", "Starting Magazine Item No.", "Ending Magazine Item No.");
        MagazineVolumeIssue.SetRange("Volume No.", "Starting Volume No.", "Ending Volume No.");
        //MagazineVolumeIssue.SETRANGE("Issue No.","Starting Issue No.","Ending Issue No.");
        MagazineVolumeIssue.SetRange("Create as Item", true);
        if MagazineVolumeIssue.Count < "Contract Quantity" then
            Error(Text015);

        "Contract Status" := "contract status"::Confirm;
        Modify;

    end;


    procedure Release()
    begin
        TestField("Contract Status", "contract status"::Confirm);

        Validate("Free Other Magazine Code");
        //GKU : #002 +
        /*--IF "Promotion Net Price" + "Credit Card Charge Fee" - ("Receipt Amount" + "Credit Card Amount" + "Check Amount") <> 0 THEN--*/
        if "Promotion Net Price" + "Credit Charge Amount (Cust.)" - ("Receipt Amount" + "Credit Card Amount" + "Check Amount") <> 0 then
            Error(Text005);
        //GKU : #002 -
        if "Contract Type" <> "contract type"::Complimentary then begin  //KKE : #003
            TestField("Contract Quantity");
            TestField("Contract Net Price");
            TestField("Shipping Agent Code");
            TestField("Payment Method Code");
        end;
        if "Credit Card Charge Fee" <> 0 then
            TestField("Payment Method (Charge Fee)");

        if "Receipt Amount" <> 0 then
            TestField("Receipt No.");

        if "Credit Card Bank Amount" <> 0 then begin
            TestField("Credit Card Bank");
            TestField("Credit Card Type");
            TestField("Credit Card No.");
            TestField("Credit Card 3Last No.");
            TestField("Credit Card Expire Date");
        end;

        if "Check Amount" <> 0 then begin
            TestField("Bank Code");
            TestField("Bank Branch");
            TestField("Check No.");
            TestField("Check Date");
        end;

        SSContractLE.SETPERMISSIONFILTER;
        SSContractLE.Reset;
        SSContractLE.SetRange("Subscriber Contract No.", "No.");
        SSContractLE.SetRange("Magazine Code", "Magazine Code");
        SSContractLE.CalcSums(Quantity, "Unit Price");
        if ROUND(SSContractLE."Unit Price") <> "Contract Net Price" then
            Error(Text012, SSContractLE.FieldCaption("Unit Price"), FieldCaption("Contract Net Price"));
        if ROUND(SSContractLE.Quantity) <> "Contract Quantity" then
            Error(Text012, SSContractLE.FieldCaption(Quantity), FieldCaption("Contract Quantity"));
        SSContractLE.Find('-');
        repeat
            if (SSContractLE."Magazine Item No." < "Starting Magazine Item No.") or
               (SSContractLE."Magazine Item No." > "Ending Magazine Item No.")
             then
                Error(Text019, SSContractLE."Magazine Item No.",
                  FieldCaption("Starting Magazine Item No."),
                  FieldCaption("Ending Magazine Item No."));
        until SSContractLE.Next = 0;

        "Contract Status" := "contract status"::Released;
        Modify;

    end;


    procedure Reopen()
    begin
        if ("Contract Status" <> "contract status"::Confirm) and ("Contract Status" <> "contract status"::Released) then
            Error(Text014);


        if ("Payment Status" = "payment status"::Paid) //AND ("Contract Status" = "Contract Status"::Released)
              and (UpperCase(UserId) <> 'SA') then begin
            Error(Text021);
        end;

        "Contract Status" := "contract status"::Open;
        Modify;
    end;


    procedure Cancel()
    begin
        if not Confirm(StrSubstNo(Text004, "No."), false) then
            exit;

        if "Contract Status" <> "contract status"::Open then
            TestField("Contract Status", "contract status"::Released);
        if "Contract Status" <> "contract status"::Released then
            TestField("Contract Status", "contract status"::Open);

        "Contract Status" := "contract status"::Cancelled;
        Modify;
    end;
}

