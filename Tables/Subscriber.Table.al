Table 50001 Subscriber
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New table for Subscriber Master
    // 002   25.07.2008   KKE   Add new field "Provice"

    LookupPageID = "Subscriber List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SubscriptionSetup.Get;
                    NoSeriesMgt.TestManual(SubscriptionSetup."Subscriber Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            var
                ContBusRel: Record "Contact Business Relation";
                Cust: Record Customer;
                Vend: Record Vendor;
            begin
                if not (CurrFieldNo in [FieldNo("First Name"), FieldNo("Middle Name"), FieldNo("Last Name")]) then
                    NameBreakdown;
                UpdateSearchName;
            end;
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "First Name"; Text[30])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                Validate(Name, CopyStr(CalculatedName, 1, 50));
                Validate("Name 2", CopyStr(CalculatedName, 51, 50));
            end;
        }
        field(5; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';

            trigger OnValidate()
            begin
                Validate(Name, CopyStr(CalculatedName, 1, 50));
                Validate("Name 2", CopyStr(CalculatedName, 51, 50));
            end;
        }
        field(6; "Last Name"; Text[30])
        {
            Caption = 'Last Name';

            trigger OnValidate()
            begin
                Validate(Name, CopyStr(CalculatedName, 1, 50));
                Validate("Name 2", CopyStr(CalculatedName, 51, 50));
            end;
        }
        field(7; "Salutation Code"; Code[10])
        {
            Caption = 'Salutation Code';
            TableRelation = Salutation;
        }
        field(8; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';

            trigger OnValidate()
            begin
                if "Date of Birth" <> 0D then begin
                    Age := CalcAge("Date of Birth", Today);
                end else
                    Age := 0;
            end;
        }
        field(9; Age; Integer)
        {
            Caption = 'Age';
        }
        field(10; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(11; Occupation; Code[10])
        {
            Caption = 'Occupation';
            TableRelation = "General Master Setup".Code where(Type = const(Occupation));
        }
        field(12; Position; Code[10])
        {
            Caption = 'Position';
            TableRelation = "General Master Setup".Code where(Type = const(Position));
        }
        field(13; "Company Name"; Text[50])
        {
        }
        field(14; Education; Code[10])
        {
            Caption = 'Education';
            TableRelation = "General Master Setup".Code where(Type = const(Education));
        }
        field(15; "Estimate Revenue"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Estimate Revenue';
        }
        field(16; "Estimate Family Revenue"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Estimate Family Revenue';
        }
        field(17; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            InitValue = Single;
            OptionCaption = ' ,Single,Married,Divorce,Widow';
            OptionMembers = " ",Single,Married,Divorce,Widow;
        }
        field(18; "No. of Children"; Integer)
        {
            Caption = 'No. of Children';
        }
        field(19; "Zone Area"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Zone Area"));
        }
        field(22; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(24; "Address 1"; Text[50])
        {
            Caption = 'Address 1';
        }
        field(25; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(26; "Address 3"; Text[150])
        {
            Caption = 'Address 3';
            Description = '50->30';
        }
        field(27; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(28; "Mobile No."; Text[30])
        {
            Caption = 'Mobile No.';
        }
        field(29; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(30; "Bill-to Address 1"; Text[50])
        {
            Caption = 'Bill-to Address 1';
        }
        field(31; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(32; "Bill-to Address 3"; Text[30])
        {
            Caption = 'Bill-to Address 3';
            Description = '50->30';
        }
        field(33; "Bill-to Phone No."; Text[30])
        {
            Caption = 'Bill-to Phone No.';
        }
        field(34; "Bill-to Mobile No."; Text[30])
        {
            Caption = 'Bill-to Mobile No.';
        }
        field(35; "Bill-to Fax No."; Text[30])
        {
            Caption = 'Bill-to Fax No.';
        }
        field(36; "Ship-to Address 1"; Text[50])
        {
            Caption = 'Ship-to Address 1';
        }
        field(37; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(38; "Ship-to Address 3"; Text[30])
        {
            Caption = 'Ship-to Address 3';
            Description = '50->30';
        }
        field(39; "Ship-to Phone No."; Text[30])
        {
            Caption = 'Ship-to Phone No.';
        }
        field(40; "Ship-to Mobile No."; Text[30])
        {
            Caption = 'Ship-to Mobile No.';
        }
        field(41; "Ship-to Fax No."; Text[30])
        {
            Caption = 'Ship-to Fax No.';
        }
        field(42; "Bill-to Name"; Text[50])
        {
            Caption = 'Bill-to Name';

            trigger OnValidate()
            var
                ContBusRel: Record "Contact Business Relation";
                Cust: Record Customer;
                Vend: Record Vendor;
            begin
                if not (CurrFieldNo in [FieldNo("First Name"), FieldNo("Middle Name"), FieldNo("Last Name")]) then
                    NameBreakdown;
                UpdateSearchName;
            end;
        }
        field(43; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';

            trigger OnValidate()
            var
                ContBusRel: Record "Contact Business Relation";
                Cust: Record Customer;
                Vend: Record Vendor;
            begin
                if not (CurrFieldNo in [FieldNo("First Name"), FieldNo("Middle Name"), FieldNo("Last Name")]) then
                    NameBreakdown;
                UpdateSearchName;
            end;
        }
        field(44; "Name (Thai)"; Text[120])
        {
        }
        field(45; "Address (Thai)"; Text[200])
        {
        }
        field(49; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Subscriber),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(51; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;

            trigger OnValidate()
            var
                ContBusRel: Record "Contact Business Relation";
                NewContBusRel: Record "Contact Business Relation";
            begin
                if "Customer No." = '' then
                    exit;
                if xRec."Contact No." <> '' then begin
                    if not Confirm(StrSubstNo(Text004, xRec."Contact No."), false) then begin
                        "Contact No." := xRec."Contact No.";
                        exit;
                    end;
                    ContBusRel.Reset;
                    ContBusRel.SetCurrentkey("Link to Table", "Contact No.");
                    ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
                    ContBusRel.SetRange("Contact No.", xRec."Contact No.");
                    ContBusRel.SetRange("No.", "Customer No.");
                    if ContBusRel.Find('-') then begin
                        ContBusRel.Delete;
                        if "Contact No." <> '' then begin
                            NewContBusRel := ContBusRel;
                            NewContBusRel."Contact No." := "Contact No.";
                            NewContBusRel.Insert(true);
                        end;
                    end;
                end else
                    if "Contact No." <> '' then begin
                        RMSetup.Get;
                        RMSetup.TestField("Burda-Bus. Rel. Code for Cust.");
                        ContBusRel.Init;
                        ContBusRel."Contact No." := "Contact No.";
                        ContBusRel."Business Relation Code" := RMSetup."Burda-Bus. Rel. Code for Cust.";
                        ContBusRel."Link to Table" := ContBusRel."link to table"::Customer;
                        ContBusRel."No." := "Customer No.";
                        ContBusRel.Insert(true);
                    end;
            end;
        }
        field(52; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(53; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(55; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
            Editable = false;
        }
        field(100; "Old Subscriber No."; Code[20])
        {
            Editable = false;
        }
        field(101; "No. Of Subscriber Contract"; Integer)
        {
            CalcFormula = count("Subscriber Contract" where("Subscriber No." = field("No."),
                                                             "Magazine Code" = field("Magazine Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "Magazine Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Sub Product";
        }
        field(103; Sex; Option)
        {
            Caption = 'Sex';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(104; "Province/City"; Text[30])
        {
        }
        field(105; "Bill-to Province/City"; Text[30])
        {
        }
        field(106; "Ship-to Province/City"; Text[30])
        {
        }
        field(107; "Comment Text"; Text[120])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Contact No.")
        {
        }
        key(Key4; "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        SSContract: Record "Subscriber Contract";
        SSContractLE: Record "Subscriber Contract L/E";
    begin
        SSContract.SETPERMISSIONFILTER;
        SSContract.Reset;
        SSContract.SetRange("Subscriber No.", "No.");
        if SSContract.Find('-') then
            Error(Text010, "No.");

        SSContractLE.SETPERMISSIONFILTER;
        SSContractLE.Reset;
        SSContractLE.SetRange("Subscriber No.", "No.");
        if SSContractLE.Find('-') then
            Error(Text010, "No.");
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SubscriptionSetup.Get;
            SubscriptionSetup.TestField("Subscriber Nos.");
            NoSeriesMgt.InitSeries(SubscriptionSetup."Subscriber Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Application Date" := WorkDate;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Last Time Modified" := Time;
        if ("First Name" <> xRec."First Name") or
           ("Middle Name" <> xRec."Middle Name") or
           ("Last Name" <> xRec."Last Name") or
           ("Date of Birth" <> xRec."Date of Birth") or
           ("Phone No." <> xRec."Phone No.") or
           ("Mobile No." <> xRec."Mobile No.")
        then
            CheckDupl;
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';
        Text001: label 'Please key in %1!';
        Text002: label 'Subscriber %1 has been created as customer %2.';
        Text003: label 'Do you want to create subscriber contract for %1?';
        Text004: label 'Contact No. %1 has been related to customer %2.\Do you want to continue?';
        Text005: label 'Duplicate Subscribers were found.';
        Text009: label '%1 %2 has been created.';
        Text010: label 'You cannot delete %1 because there are one or more ledger entries in subscriber contract.';
        Text020: label 'Do you want to create subscriber %1 as a customer using a customer template?';
        Text022: label 'The Creation of the customer has been aborted.';
        Text029: label 'The combined length of first name, middle name and surname exceeds the maximum length allowed for the name field by %1 character(s).';
        Text032: label 'The length of %1 exceeds the maximum length allowed for the %1 field by %2 character(s).';
        SubscriptionSetup: Record "Subscription Setup";
        Contact: Record Contact;
        RMSetup: Record "Marketing Setup";
        DuplMgt: Codeunit DuplicateManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;


    procedure AssistEdit(OldSubscriber: Record Subscriber): Boolean
    var
        Subscriber: Record Subscriber;
    begin
        with Subscriber do begin
            Subscriber := Rec;
            SubscriptionSetup.Get;
            SubscriptionSetup.TestField("Subscriber Nos.");
            if NoSeriesMgt.SelectSeries(SubscriptionSetup."Subscriber Nos.", OldSubscriber."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Subscriber;
                exit(true);
            end;
        end;
    end;


    procedure CalculatedName() NewName: Text[250]
    var
        NewName250: Text[250];
    begin
        if "First Name" <> '' then
            NewName250 := "First Name";
        if "Middle Name" <> '' then
            NewName250 := NewName250 + ' ' + "Middle Name";
        if "Last Name" <> '' then
            NewName250 := NewName250 + ' ' + "Last Name";

        NewName250 := DelChr(NewName250, '<', ' ');

        if StrLen(NewName250) > MaxStrLen(Name) + MaxStrLen("Name 2") then
            Error(Text029, StrLen(NewName250) - (MaxStrLen(Name) + MaxStrLen("Name 2")));

        NewName := NewName250;
    end;


    procedure UpdateSearchName()
    begin
        if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
            "Search Name" := Name;
    end;


    procedure NameBreakdown()
    var
        NamePart: array[30] of Text[250];
        TempName: Text[250];
        FirstName250: Text[250];
        i: Integer;
        NoOfParts: Integer;
    begin
        TempName := Name;
        while StrPos(TempName, ' ') > 0 do begin
            if StrPos(TempName, ' ') > 1 then begin
                i := i + 1;
                NamePart[i] := CopyStr(TempName, 1, StrPos(TempName, ' ') - 1);
            end;
            TempName := CopyStr(TempName, StrPos(TempName, ' ') + 1);
        end;
        i := i + 1;
        NamePart[i] := TempName;
        NoOfParts := i;

        "First Name" := '';
        "Middle Name" := '';
        "Last Name" := '';
        for i := 1 to NoOfParts do begin
            if (i = NoOfParts) and (NoOfParts > 1) then begin
                if StrLen(NamePart[i]) > MaxStrLen("Last Name") then
                    Error(Text032, FieldCaption("Last Name"), StrLen(NamePart[i]) - MaxStrLen("Last Name"));
                "Last Name" := NamePart[i]
            end else
                if (i = NoOfParts - 1) and (NoOfParts > 2) then begin
                    if StrLen(NamePart[i]) > MaxStrLen("Middle Name") then
                        Error(Text032, FieldCaption("Middle Name"), StrLen(NamePart[i]) - MaxStrLen("Middle Name"));
                    "Middle Name" := NamePart[i]
                end else begin
                    FirstName250 := DelChr("First Name" + ' ' + NamePart[i], '<', ' ');
                    if StrLen(FirstName250) > MaxStrLen("First Name") then
                        Error(Text032, FieldCaption("First Name"), StrLen(FirstName250) - MaxStrLen("First Name"));
                    "First Name" := FirstName250;
                end;
        end;
    end;


    procedure CreateCustomer(CustomerTemplate: Code[10])
    var
        Cust: Record Customer;
        CustTemplate: Record "Customer Template";
        DefaultDim: Record "Default Dimension";
        DefaultDim2: Record "Default Dimension";
        ContBusRel: Record "Contact Business Relation";
    begin
        if CustomerTemplate = '' then
            exit;
        if "Customer No." <> '' then
            Error(Text002, "No.", "Customer No.");

        RMSetup.Get;
        RMSetup.TestField("Bus. Rel. Code for Customers", '');
        RMSetup.TestField("Burda-Bus. Rel. Code for Cust.");

        if CustomerTemplate <> '' then
            CustTemplate.Get(CustomerTemplate);

        SubscriptionSetup.Get;
        SubscriptionSetup.TestField("Customer Nos.");

        Cust.Init;
        Cust."No." := NoSeriesMgt.GetNextNo(SubscriptionSetup."Customer Nos.", WorkDate, true);
        Cust.Insert(true);

        Cust.Validate(Name, Name);
        Cust."Name 2" := "Name 2";
        Cust."Search Name" := "Search Name";
        Cust.Address := "Address 1";
        Cust."Address 2" := "Address 2";
        Cust."Address 3" := "Address 3";
        Cust."Phone No." := "Phone No.";
        Cust."Fax No." := "Fax No.";
        Cust.Modify;
        if CustTemplate.Code <> '' then begin
            Cust."Customer Posting Group" := CustTemplate."Customer Posting Group";
            Cust."Customer Price Group" := CustTemplate."Customer Price Group";
            Cust."Invoice Disc. Code" := CustTemplate."Invoice Disc. Code";
            Cust."Customer Disc. Group" := CustTemplate."Customer Disc. Group";
            Cust."Allow Line Disc." := CustTemplate."Allow Line Disc.";
            Cust."Gen. Bus. Posting Group" := CustTemplate."Gen. Bus. Posting Group";
            Cust."VAT Bus. Posting Group" := CustTemplate."VAT Bus. Posting Group";
            Cust."WHT Business Posting Group" := CustTemplate."WHT Business Posting Group";
            Cust."Payment Terms Code" := CustTemplate."Payment Terms Code";
            Cust."Payment Method Code" := CustTemplate."Payment Method Code";
            Cust."Shipment Method Code" := CustTemplate."Shipment Method Code";
            Cust.Modify;

            DefaultDim.SetRange("Table ID", Database::"Customer Template");
            DefaultDim.SetRange(DefaultDim."No.", CustTemplate.Code);
            if DefaultDim.Find('-') then
                repeat
                    Clear(DefaultDim2);
                    DefaultDim2.Init;
                    DefaultDim2.Validate("Table ID", Database::Customer);
                    DefaultDim2."No." := Cust."No.";
                    DefaultDim2.Validate("Dimension Code", DefaultDim."Dimension Code");
                    DefaultDim2.Validate("Dimension Value Code", DefaultDim."Dimension Value Code");
                    DefaultDim2."Value Posting" := DefaultDim."Value Posting";
                    DefaultDim2.Insert(true);
                until DefaultDim.Next = 0;
        end;

        if "Contact No." <> '' then begin
            ContBusRel.Init;
            ContBusRel."Contact No." := "Contact No.";
            ContBusRel."Business Relation Code" := RMSetup."Burda-Bus. Rel. Code for Cust.";
            ContBusRel."Link to Table" := ContBusRel."link to table"::Customer;
            ContBusRel."No." := Cust."No.";
            ContBusRel.Insert(true);
        end;

        "Customer No." := Cust."No.";
        Modify;
        Commit;
        Message(Text009, Cust.TableCaption, Cust."No.");
    end;


    procedure CheckDupl()
    var
        Subscriber: Record Subscriber;
    begin
        Subscriber.SetFilter("No.", '<>%1', "No.");
        Subscriber.SetRange("First Name", "First Name");
        Subscriber.SetRange("Middle Name", "Middle Name");
        Subscriber.SetRange("Last Name", "Last Name");
        Subscriber.SetRange("Date of Birth", "Date of Birth");
        Subscriber.SetRange("Phone No.", "Phone No.");
        Subscriber.SetRange("Mobile No.", "Mobile No.");
        if Subscriber.Find('-') then
            Error(Text005);
    end;


    procedure CalcAge(DateOfBirth: Date; CurrentDate: Date): Integer
    var
        Age: Integer;
    begin
        if DateOfBirth = 0D then
            Error(Text001, 'Date of Birth');
        Age := (CurrentDate - DateOfBirth) DIV 365;
        exit(Age);
    end;


    procedure ChooseCustomerTemplate() ChooseCustTemplate: Code[10]
    var
        CustTemplate: Record "Customer Template";
    begin
        if Confirm(Text020, true, "No.", Name) then begin
            if Page.RunModal(0, CustTemplate) = Action::LookupOK then
                exit(CustTemplate.Code)
            else
                Error(Text022);
        end else
            exit;
    end;


    procedure CreateSubscriberContract()
    var
        Subscriber: Record Subscriber;
        SubsContract: Record "Subscriber Contract";
    begin
        if not Confirm(Text003, false, "No.") then
            exit;

        TestField("Customer No.");

        with SubsContract do begin
            Init;
            SubscriptionSetup.Get;
            SubscriptionSetup.TestField("Subscriber Contract Nos.");
            if NoSeriesMgt.SelectSeries(SubscriptionSetup."Subscriber Contract Nos.", '', "No. Series") then begin
                NoSeriesMgt.SetSeries(SubsContract."No.");
                "Subscriber No." := Rec."No.";
                Insert(true);
            end;
        end;
        Commit;
        Page.Run(Page::"Subscriber Contracts", SubsContract);
    end;
}

