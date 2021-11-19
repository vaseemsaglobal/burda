Table 50037 "Ads. Booking Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Ads. Booking Header" - Ads. Sales Module
    // 002   09.11.2007   KKE   Allow change Bill-to Cust. No. if Ads. Booking has not been invoiced.

    LookupPageID = "Ads. Booking List";

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AdsItemSetup.Get;
                    NoSeriesMgt.TestManual(AdsItemSetup."Booking Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Booking Date"; Date)
        {
        }
        field(3; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                if "Salesperson Code" <> xRec."Salesperson Code" then begin
                    AdsBookingLine.Reset;
                    AdsBookingLine.SETPERMISSIONFILTER;
                    AdsBookingLine.SetRange("Deal No.", "No.");
                    if AdsBookingLine.Find('-') then
                        AdsBookingLine.ModifyAll("Salesperson Code", "Salesperson Code");
                end;
            end;
        }
        field(4; "Final Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if ("Final Customer No." <> xRec."Final Customer No.") or ("Final Customer No." = '') then begin
                    AdsBookingLine.Reset;
                    AdsBookingLine.SETPERMISSIONFILTER;
                    AdsBookingLine.SetRange("Deal No.", "No.");
                    //AdsBookingLine.SETFILTER("Line Status",'<>%1',AdsBookingLine."Line Status"::Booking);
                    AdsBookingLine.SetFilter("Line Status", '%1|%2',
                      AdsBookingLine."line status"::Invoiced,
                      AdsBookingLine."line status"::Closed);  //KKE : #002
                    if AdsBookingLine.Find('-') then
                        Error(Text003, 'Sell-to Customer No.');

                end;

                CheckCredit("Final Customer No.");
                if "Bill-to Customer No." = '' then begin
                    "Bill-to Customer No." := "Final Customer No.";
                    "Bill-to Customer Type" := "Client Type";
                end;
            end;
        }
        field(5; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            var
            // TempDocDim: Record "Document Dimension" temporary;
            begin
                if ("Bill-to Customer No." <> xRec."Bill-to Customer No.") or ("Bill-to Customer No." = '') then begin
                    AdsBookingLine.Reset;
                    AdsBookingLine.SETPERMISSIONFILTER;
                    AdsBookingLine.SetRange("Deal No.", "No.");
                    //AdsBookingLine.SETFILTER("Line Status",'<>%1',AdsBookingLine."Line Status"::Booking);
                    AdsBookingLine.SetFilter("Line Status", '%1|%2',
                      AdsBookingLine."line status"::Invoiced,
                      AdsBookingLine."line status"::Closed);  //KKE : #002
                    if AdsBookingLine.Find('-') then
                        Error(Text003, 'Bill-to Customer No.');
                end;

                CheckCredit("Bill-to Customer No.");
            end;
        }
        field(6; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(7; "Client Type"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Customer Type"));
        }
        field(8; "Bill-to Customer Type"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Customer Type"));
        }
        field(9; "Zone Area"; Code[20])
        {
            TableRelation = "Zone Area";
        }
        field(10; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(11; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(12; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(13; "Mobile No."; Text[30])
        {
        }
        field(14; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(15; Remark; Text[250])
        {
            Caption = 'Remark By Ad Traffic';
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(30; "Header Remark"; Text[250])
        {
            Caption = 'Header Remark';
        }
        field(40; "Booking Type"; Option)
        {
            OptionCaption = ',One-dimension Deal,Multi-dimensions Deal';
            OptionMembers = ,"One-dimension Deal","Multi-dimensions Deal";
        }
        field(50; "Contract Submitted"; Boolean)
        {
            Caption = 'Contract Submitted';
        }
        field(60; "Email Validation"; Option)
        {
            OptionCaption = ' ,Rejected,Approved,Approval In-Progress';
            OptionMembers = ,Rejected,Approved,"Approval In-Progress";
        }
        field(70; "Deffered A/c No."; Code[20])
        {
            TableRelation = "G/L Account";

        }
        field(80; "Accrued A/c No."; code[20])
        {
            TableRelation = "G/L Account";
        }

        field(90; "Deal Value"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Ads. Booking Line".Amount where("Deal No." = field("No.")));
        }
        field(100; "Revenue Recognized Amount"; Decimal)
        {
            Editable = false;

        }
        field(110; "Invoiced Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Sales Invoice Line".Amount where("Deal No." = field("No."),
            Amount = filter(> 0)));
        }
        field(111; "Invoiced Amount Cr"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Sales Invoice Line".Amount where("Deal No." = field("No."),
            Amount = filter(< 0)));
        }
        field(120; "Amount Paid"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("G/L Entry".Amount where("Document Type" = filter(Payment | Refund), "Deal No." = field("No."), "Source Type" = const("Bank Account")
            ));
        }
        field(130; "Accrued Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("g/l entry".Amount where("Deal No." = field("No."),
    "G/L Account No." = field("Accrued A/c No."),
    "Ads Sales Document Type" = filter(Deferred | "JV(Accrued)")));
        }
        field(140; "Deferred/Prepayment"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("g/l entry".Amount where("Deal No." = field("No."),
    "G/L Account No." = field("Deffered A/c No."),
    "Ads Sales Document Type" = filter(Deferred | "JV(Deferred)")));
        }
        field(150; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            var
                StandardCodesMgt: Codeunit "Standard Codes Mgt.";
            begin
                if (CurrFieldNo <> FieldNo("Currency Code")) and ("Currency Code" = xRec."Currency Code") then
                    UpdateCurrencyFactor
                else
                    if "Currency Code" <> xRec."Currency Code" then
                        UpdateCurrencyFactor
                    else
                        if "Currency Code" <> '' then begin
                            UpdateCurrencyFactor;
                            if "Currency Factor" <> xRec."Currency Factor" then
                                ConfirmCurrencyFactorUpdate();
                        end;

                // if ("No." <> '') and ("Currency Code" <> xRec."Currency Code") then
                //   StandardCodesMgt.CheckShowSalesRecurringLinesNotification(Rec);
            end;
        }
        field(160; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Currency Factor" <> xRec."Currency Factor" then
                    ;//  UpdateSalesLinesByFieldNo(FieldNo("Currency Factor"), false);
            end;
        }
        field(170; "Manual Invoice Status"; Option)
        {
            OptionMembers = ,"Manual Inv. Pending",Rejected,"Manual Inv. Posted";
        }
        field(180; "Accountant Remark For Manual Inv. "; Text[120])
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
        field(700; "Revenue Invoice"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Ads. Booking Line" where("Deal No." = field("No."), "posting status" = filter("Rev. Pending" | "Inv.+Rev. Pending" | Rejected)));
        }
        field(710; "Deal Completed"; Boolean)
        {

        }
        field(720; "Contract No."; Text[35])
        {

        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Bill-to Customer No.", "Final Customer No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        AdsBookingLine.SETPERMISSIONFILTER;
        AdsBookingLine.SetRange("Deal No.", "No.");
        AdsBookingLine.SetFilter("Line Status", '<>%1', AdsBookingLine."line status"::Booking);
        if AdsBookingLine.Find('-') then
            Error(Text002, "No.");

        AdsBookingLine.Reset;
        AdsBookingLine.SetRange("Deal No.", "No.");
        AdsBookingLine.SETPERMISSIONFILTER;
        AdsBookingLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            AdsItemSetup.Get;
            AdsItemSetup.TestField("Booking Nos.");
            NoSeriesMgt.InitSeries(AdsItemSetup."Booking Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Booking Date" := WorkDate;
        "Deffered A/c No." := AdsItemSetup."Deffered A/c No.";//VAH
        "Accrued A/c No." := AdsItemSetup."Accrued A/c No.";//VAH
        UserSetup.Get(UserId);
        if UserSetup."Ads. Booking Filter" = UserSetup."ads. booking filter"::Salesperson then
            Validate("Salesperson Code", UserSetup."Salesperson Code");
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        if ("Email Validation" = "Email Validation"::Approved) or ("Email Validation" = "Email Validation"::"Approval In-Progress") then
            Error('Document is %1', Format(("Email Validation")));
    end;

    var
        AdsItemSetup: Record "Ads. Item Setup";
        Cust: Record Customer;
        AdsBookingLine: Record "Ads. Booking Line";
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: label 'You cannot rename a %1.';
        Text001: label 'Customer %1 has credit problem.';
        Text002: label 'You cannot delete %1 because the document still has one or more lines.';
        Text003: label 'You cannot reset %1 because the document still has one or more lines.';


    procedure AssistEdit(OldAdsBookingHdr: Record "Ads. Booking Header"): Boolean
    var
        AdsBookingHdr: Record "Ads. Booking Header";
    begin
        with AdsBookingHdr do begin
            AdsBookingHdr := Rec;
            AdsItemSetup.Get;
            AdsItemSetup.TestField("Booking Nos.");
            if NoSeriesMgt.SelectSeries(AdsItemSetup."Booking Nos.", OldAdsBookingHdr."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := AdsBookingHdr;
                exit(true);
            end;
        end;
    end;


    procedure CheckCredit(CustNo: Code[20])
    var
        Cust: Record Customer;
    begin
        if Cust.Get(CustNo) then begin
            if Cust."Have Credit Problem" then
                Message(Text001, CustNo);
        end else
            Clear(Cust);

        Validate("Client Type", Cust."Customer Type");
        Validate("Zone Area", Cust."Zone Area");
        Contact := Cust.Contact;
        "Phone No." := Cust."Phone No.";
        "Fax No." := Cust."Fax No.";
        "E-Mail" := Cust."E-Mail";
        "Payment Terms Code" := Cust."Payment Terms Code";
    end;

    procedure UpdateCurrencyFactor()
    var
        UpdateCurrencyExchangeRates: Codeunit "Update Currency Exchange Rates";
        Updated: Boolean;
    begin

        if "Currency Code" <> '' then begin
            if "booking Date" <> 0D then
                CurrencyDate := "booking Date"
            else
                CurrencyDate := WorkDate;

            if UpdateCurrencyExchangeRates.ExchangeRatesForCurrencyExist(CurrencyDate, "Currency Code") then begin
                "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
                if "Currency Code" <> xRec."Currency Code" then
                    UpdateCurrencyInBookingLines;
            end else
                UpdateCurrencyExchangeRates.ShowMissingExchangeRatesNotification("Currency Code");
        end else begin
            "Currency Factor" := 0;
            if "Currency Code" <> xRec."Currency Code" then
                UpdateCurrencyInBookingLines;
        end;

    end;

    procedure ConfirmCurrencyFactorUpdate()
    var
        Confirmed: Boolean;
        Text021: Label 'Do you want to update the exchange rate?';
    begin

        Confirmed := Confirm(Text021, false);
        if Confirmed then
            Validate("Currency Factor")
        else
            "Currency Factor" := xRec."Currency Factor";
    end;

    local procedure UpdateCurrencyInBookingLines()
    var
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        AdsBookingLine.Reset();
        AdsBookingLine.SetRange("Deal No.", "No.");
        if AdsBookingLine.FindSet() then
            repeat
                AdsBookingLine.Validate("Currency Code", "Currency Code");
                AdsBookingLine.Validate(Quantity);
                AdsBookingLine.Modify(true);
            until AdsBookingLine.Next() = 0;
    end;

    procedure EmailValidations(var Rec: record "Ads. Booking Header")
    var
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        rec.TestField("No.");
        rec.TestField("Final Customer No.");
        rec.TestField("Bill-to Customer No.");
        AdsBookingLine.Reset();
        AdsBookingLine.SetRange("Deal No.", Rec."No.");
        if AdsBookingLine.FindSet() then
            repeat
                AdsBookingLine.TestField("Subdeal No.");
                AdsBookingLine.TestField("Product Code");
                AdsBookingLine.TestField("Sub Product Code");
                AdsBookingLine.TestField("Brand Code");
                AdsBookingLine.TestField("Industry Category Code");
                //AdsBookingLine.TestField(Amount);
                //AdsBookingLine.TestField("Booking Revenue Type");
                AdsBookingLine.TestField("Publication Month");
                AdsBookingLine.TestField("Ads. Position Code");
                AdsBookingLine.TestField("Ads. Size Code");

            until AdsBookingLine.Next() = 0;
    end;

    var
        CurrencyDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";

}

