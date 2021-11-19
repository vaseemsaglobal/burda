TableExtension 50019 tableextension50019 extends "Gen. Journal Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Account Type"(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
            "Account Type"::"IC Partner"]) AND
           ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
        #4..47
          END;
        IF "Account Type" <> "Account Type"::Customer THEN
          VALIDATE("Credit Card No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //KKE : #001 +
        IF "Account Type" <> xRec."Account Type" THEN BEGIN
          TESTFIELD("Applies-to Doc. No.",'');
          TESTFIELD("Applies-to ID",'');
        END;
        //KKE : #001 -
        #1..50
        */
        //end;


        //Unsupported feature: Code Modification on ""Account No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Job No.",'');
        IF "Account No." = '' THEN BEGIN
          UpdateLineBalance;
        #4..85
                END;
              END;
              Description := Cust.Name;
              "Posting Group" := Cust."Customer Posting Group";
              "Salespers./Purch. Code" := Cust."Salesperson Code";
              "Payment Terms Code" := Cust."Payment Terms Code";
        #92..122
              END;
                "Skip WHT" := Vend.ABN <> '';
              Description := Vend.Name;
              "Posting Group" := Vend."Vendor Posting Group";
              "Salespers./Purch. Code" := Vend."Purchaser Code";
              "Payment Terms Code" := Vend."Payment Terms Code";
        #129..138
              "VAT Prod. Posting Group" := '';
              "WHT Business Posting Group" := Vend."WHT Business Posting Group";
              "WHT Product Posting Group" := '';
              IF (Vend."Pay-to Vendor No." <> '') AND (Vend."Pay-to Vendor No." <> "Account No.")  THEN BEGIN
                OK := CONFIRM(Text014,FALSE,Vend.TABLECAPTION,Vend."No.",Vend.FIELDCAPTION("Pay-to Vendor No."),
                Vend."Pay-to Vendor No.");
        #145..230
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //KKE : #001 +
        IF "Account No." <> xRec."Account No." THEN BEGIN
          TESTFIELD("Applies-to Doc. No.",'');
          TESTFIELD("Applies-to ID",'');
        END;
        //KKE : #001 -
        //KKE : #004 +
        IF "Account No." <> xRec."Account No." THEN
          VALIDATE("Customer/Vendor Bank",'');
        //KKE : #004 -

        #1..88
              //KKE : #002 +
              IF Cust.Name = '' THEN
                Description := COPYSTR(Cust."Name (Thai)",1,50);
              //KKE : #002 -
        #89..125
              //KKE : #002 +
              IF Vend.Name = '' THEN
                Description := COPYSTR(Vend."Name (Thai)",1,50);
              //KKE : #002 -
        #126..141
              //KKE : #001 +
              IF Vend."Name (Thai)" <> '' THEN
                "Payee Name" := Vend."Name (Thai)"
              ELSE
                "Payee Name" := Vend.Name + Vend."Name 2";
              "Dummy Vendor" := Vend."Dummy Vendor";
              //KKE : #001 -

        #142..233
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT %"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
        #4..29
                ROUND("VAT Amount",Currency."Amount Rounding Precision");
            END;
        END;
        "VAT Base Amount" := Amount - "VAT Amount";
        "VAT Difference" := 0;

        #36..43
        "VAT Base Amount (LCY)" := "Amount (LCY)" - "VAT Amount (LCY)";

        UpdateSalesPurchLCY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..32
        //KKE : #005 +
        IF ("VAT Amount" = 0) AND ("Bal. VAT Amount" = 0) THEN BEGIN
          "VAT Claim %" := 0;
          "Use Average VAT" := FALSE;
          "Average VAT Year" := 0;
        END ELSE BEGIN
          GenJnlTemplate.GET("Journal Template Name");
          IF ("Document Type" = "Document Type"::Invoice) AND (GenJnlTemplate.Type = GenJnlTemplate.Type::Purchases) THEN BEGIN
            GetGLSetup;
            IF GLSetup."Enable VAT Average" THEN BEGIN
              IF NOT VATProdPostingGrp.GET("VAT Prod. Posting Group") THEN
                VATProdPostingGrp.INIT;
              IF VATProdPostingGrp."Average VAT" THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
                AverageVATSetup.RESET;
                AverageVATSetup.SETFILTER("From Date",'<=%1',"Posting Date");
                AverageVATSetup.SETFILTER("To Date",'>=%1',"Posting Date");
                IF AverageVATSetup.FIND('+') THEN BEGIN
                  AverageVATSetup.TESTFIELD("VAT Claim %");
                  "VAT Claim %" := AverageVATSetup."VAT Claim %";
                  "Use Average VAT" := TRUE;
                  "Average VAT Year" := AverageVATSetup.Year;
                  "VAT Amount" :=
                      ROUND("VAT Amount" * "VAT Claim %"/100,
                        Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                  "VAT Posting" := "VAT Posting"::"Manual VAT Entry";
                END;
              END;
            END;
          END;
        END;
        //KKE : #005 -

        #33..46
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Account No."(Field 11).OnValidate".

        //trigger  Account No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Job No.",'');
        IF "Bal. Account No." = '' THEN BEGIN
          UpdateLineBalance;
        #4..222
           ("Bal. Account Type" = "Bal. Account Type"::"G/L Account")
        THEN
          "IC Partner G/L Acc. No." := GLAcc."Default IC Partner G/L Acc. No";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //KKE : #001 +
        IF "Bal. Account No." <> xRec."Bal. Account No." THEN BEGIN
          TESTFIELD("Applies-to Doc. No.",'');
          TESTFIELD("Applies-to ID",'');
        END;
        //KKE : #001 -

        #1..225
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Account Type"(Field 63).OnValidate".

        //trigger  Account Type"(Field 63)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
            "Account Type"::"IC Partner"]) AND
           ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
        #4..47
        END;
        IF "Bal. Account Type" <> "Bal. Account Type"::"Bank Account" THEN
          VALIDATE("Credit Card No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //KKE : #001 +
        IF "Bal. Account Type" <> xRec."Bal. Account Type" THEN BEGIN
          TESTFIELD("Applies-to Doc. No.",'');
          TESTFIELD("Applies-to ID",'');
        END;
        //KKE : #001 -
        #1..50
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. VAT %"(Field 68).OnValidate".

        //trigger  VAT %"(Field 68)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        CASE "Bal. VAT Calculation Type" OF
          "Bal. VAT Calculation Type"::"Normal VAT",
        #4..29
                ROUND("Bal. VAT Amount",Currency."Amount Rounding Precision");
            END;
        END;
        "Bal. VAT Base Amount" := -(Amount + "Bal. VAT Amount");
        "Bal. VAT Difference" := 0;

        #36..43
        "Bal. VAT Base Amount (LCY)" := -("Amount (LCY)" + "Bal. VAT Amount (LCY)");

        UpdateSalesPurchLCY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..32

        //KKE : #005 +
        IF ("VAT Amount" = 0) AND ("Bal. VAT Amount" = 0) THEN BEGIN
          "VAT Claim %" := 0;
          "Use Average VAT" := FALSE;
          "Average VAT Year" := 0;
        END ELSE BEGIN
          GenJnlTemplate.GET("Journal Template Name");
          IF ("Document Type" = "Document Type"::Invoice) AND (GenJnlTemplate.Type = GenJnlTemplate.Type::Purchases) THEN BEGIN
            GetGLSetup;
            IF GLSetup."Enable VAT Average" THEN BEGIN
              IF NOT VATProdPostingGrp.GET("Bal. VAT Prod. Posting Group") THEN
                VATProdPostingGrp.INIT;
              IF VATProdPostingGrp."Average VAT" THEN BEGIN
                VATPostingSetup.GET("Bal. VAT Bus. Posting Group","Bal. VAT Prod. Posting Group");
                AverageVATSetup.RESET;
                AverageVATSetup.SETFILTER("From Date",'<=%1',"Posting Date");
                AverageVATSetup.SETFILTER("To Date",'>=%1',"Posting Date");
                IF AverageVATSetup.FIND('+') THEN BEGIN
                  AverageVATSetup.TESTFIELD("VAT Claim %");
                  "VAT Claim %" := AverageVATSetup."VAT Claim %";
                  "Use Average VAT" := TRUE;
                  "Average VAT Year" := AverageVATSetup.Year;
                  "Bal. VAT Amount" :=
                      ROUND("Bal. VAT Amount" * "VAT Claim %"/100,
                        Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                  "VAT Posting" := "VAT Posting"::"Manual VAT Entry";
                END;
              END;
            END;
          END;
        END;
        //KKE : #005 -

        #33..46
        */
        //end;
        field(50000; "WHT Certificate No."; Code[20])
        {
            Description = '#003 Editable->refer Allow manual WHT certificate No.';
        }
        field(50001; "One Doc. Per WHT Slip"; Boolean)
        {
        }
        field(50002; "WHT Manual Fee"; Boolean)
        {

            trigger OnValidate()
            begin
                // ETT
                //GLSetup.Get;
                //GLSetup.TESTFIELD("WHT Manual Fee Acc.");
            end;
        }
        field(50003; "WHT Transaction No."; Integer)
        {
            Description = '#005';
        }
        field(50004; "Tax Invoice No."; Code[20])
        {
        }
        field(50005; "Tax Invoice Date"; Date)
        {
        }
        field(50006; "Real Customer/Vendor Name"; Text[150])
        {
        }
        field(50007; "Cheque Date"; Date)
        {
        }
        field(50008; "Bank Name"; Text[10])
        {
        }
        field(50009; "Bank Branch"; Text[50])
        {
        }
        field(50010; "Payee Name"; Text[120])
        {
            Caption = 'Payee Name';
        }
        field(50011; "Cash Advance"; Boolean)
        {

            trigger OnValidate()
            begin
                // ETT
                //GLSetup.GET;
                //GLSetup.TESTFIELD("Cash Advance Settlement Acc.");
            end;
        }
        field(50012; "Old Voucher No."; Code[20])
        {
        }
        field(50013; "Vendor Name (Eng.)"; Text[100])
        {
            Description = 'Vendor''s full name in English. This name will be shown in cheque / WHT Slip, WHT reports, VAT report';
        }
        field(50014; VATLineNo; Integer)
        {
            Caption = 'VATLineNo';
        }
        field(50015; "VAT Registration No.(Dummy)"; Text[20])
        {
            Caption = 'VAT Registration No.(Dummy)';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
            end;
        }
        field(50016; "Dummy Vendor"; Boolean)
        {
        }
        field(50100; "Use Average VAT"; Boolean)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50101; "Average VAT Year"; Integer)
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Average VAT Setup";
        }
        field(50102; "VAT Claim %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50103; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Description = 'Burda1.00';
        }
        field(50104; "Block Bank Cheque"; Boolean)
        {
            Description = 'Burda1.00 (New)';
            Editable = false;
        }
        field(50105; "Deal No."; Code[20])
        {
            TableRelation = "Ads. Booking Header";
        }
        field(50106; "Sub Deal No."; Text[20])
        {

        }
        field(50107; "Publication Month"; Text[10])
        {

        }
        field(50108; Brand; Code[20])
        {

        }
        field(50109; "Salesperson Code"; Code[20])
        {

        }
        field(50096; "Invoice Type"; Option)
        {
            OptionMembers = ,Revenue,Deferred,Accrued;
        }
        field(50097; "Remark from Accountant"; Text[120])
        {

        }
        field(50098; "Ads Sales Document Type"; Option)
        {
            OptionMembers = ,Revenue,Deferred,Accrued,"JV(Accrued)","JV(Deferred)","JV(Revenue)";
        }
    }
    keys
    {
        // Unsupported feature: Key containing base fields
        // key(Key1;"Journal Template Name","Journal Batch Name","Posting Date","Document No.","Shortcut Dimension 1 Code")
        // {
        // }
    }


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Check Printed",FALSE);
    IF ("Applies-to ID" = '') AND (xRec."Applies-to ID" <> '') THEN
      ClearCustVendApplnEntry;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //KKE : #001 +
    IF ("Certificate Printed" = xRec."Certificate Printed") AND
       ("WHT Certificate No." = xRec."WHT Certificate No.") AND
       ("One Doc. Per WHT Slip" = xRec."One Doc. Per WHT Slip") AND
       ("Skip WHT" = xRec."Skip WHT") AND
       ("External Document No." = xRec."External Document No.") AND  //Burda
       ("Shortcut Dimension 1 Code" <> xRec."Shortcut Dimension 1 Code") AND
       ("Shortcut Dimension 2 Code" <> xRec."Shortcut Dimension 2 Code") AND
       (Description = xRec.Description)
    THEN
    //KKE : #001 -
      TESTFIELD("Check Printed",FALSE);

    IF ("External Document No." = '') AND (xRec."External Document No." <> '') THEN
      TESTFIELD("Check Printed",FALSE);

    IF ("Applies-to ID" = '') AND (xRec."Applies-to ID" <> '') THEN
      ClearCustVendApplnEntry;
    */
    //end;

    procedure UnblockBankCheque()
    var
        UserSetup: Record "User Setup";
    begin
        //KKE : #007 +
        if "Block Bank Cheque" = false then
            exit;
        UserSetup.Get(UserId);
        if not UserSetup."Allow Unblock Bank Cheque" then
            Error(Text50000);

        GenJnlLine.Reset;
        GenJnlLine.SetCurrentkey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
        GenJnlLine.SetRange("Posting Date", "Posting Date");
        GenJnlLine.SetRange("Document No.", "Document No.");
        GenJnlLine.SetRange("Account Type", "Account Type");
        GenJnlLine.SetRange("Account No.", "Account No.");
        GenJnlLine.SetRange("Bal. Account Type", "Bal. Account Type");
        GenJnlLine.SetRange("Bal. Account No.", "Bal. Account No.");
        GenJnlLine.SetRange("Bank Payment Type", "Bank Payment Type");
        if GenJnlLine.Find('-') then
            GenJnlLine.ModifyAll("Block Bank Cheque", false);
        //KKE : #007 -
    end;


    var
        Text50000: label 'You do not have permission to unblock bank cheque.';
        VATProdPostingGrp: Record "VAT Product Posting Group";
        AverageVATSetup: Record "Average VAT Setup";
        GenJnlLine: Record "Gen. Journal Line";
}

