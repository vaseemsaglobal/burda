TableExtension 50011 tableextension50011 extends "Sales Header"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF ("Sell-to Customer No." <> xRec."Sell-to Customer No.") AND
           (xRec."Sell-to Customer No." <> '')
        #4..110
        "Sell-to Customer Name 2" := Cust."Name 2";
        "Sell-to Address" := Cust.Address;
        "Sell-to Address 2" := Cust."Address 2";
        "Sell-to City" := Cust.City;
        "Sell-to Post Code" := Cust."Post Code";
        "Sell-to County" := Cust.County;
        #117..161

        PostCodeCheck.CopyAddressID(
          DATABASE::Customer,Cust.GETPOSITION,0,DATABASE::"Sales Header",Rec.GETPOSITION,3);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..113
        // KKE : #001 +
        "Sell-to Address (Thai)" := COPYSTR(Cust."Address (Thai)",1,50);
        "Sell-to Address 3" := Cust."Address 3";
        "Sell-to Name (Thai)" := COPYSTR(Cust."Name (Thai)",1,50);
        // KKE : #001 -
        #114..164
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Customer No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF (xRec."Bill-to Customer No." <> "Bill-to Customer No.") AND
           (xRec."Bill-to Customer No." <> '')
        #4..75
        "Bill-to Name 2" := Cust."Name 2";
        "Bill-to Address" := Cust.Address;
        "Bill-to Address 2" := Cust."Address 2";
        "Bill-to City" := Cust.City;
        "Bill-to Post Code" := Cust."Post Code";
        "Bill-to County" := Cust.County;
        "Bill-to Country/Region Code" := Cust."Country/Region Code";
        "VAT Country/Region Code" := Cust."Country/Region Code";
        IF NOT SkipBillToContact THEN
          "Bill-to Contact" := Cust.Contact;
        "Payment Terms Code" := Cust."Payment Terms Code";
        #87..148

        PostCodeCheck.CopyAddressID(
          DATABASE::Customer,Cust.GETPOSITION,0,DATABASE::"Sales Header",Rec.GETPOSITION,1);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..78
        // KKE : #001 +
        "Bill-to Address (Thai)" := Cust."Address (Thai)";
        "Bill-to Address 3" := Cust."Address 3";
        "Bill-to Name (Thai)" := Cust."Name (Thai)";
        // KKE : #001 -
        #79..83
        // KKE : #002 +
        Subscriber.SETCURRENTKEY("Customer No.");
        Subscriber.SETRANGE("Customer No.",Cust."No.");
        IF NOT Subscriber.FIND('-') THEN
          CLEAR(Subscriber);
        IF Subscriber."Bill-to Name" <> '' THEN BEGIN
          "Bill-to Name" := Subscriber."Bill-to Name";
          "Bill-to Name 2" := Subscriber."Bill-to Name 2";
          "Bill-to Address" := Subscriber."Bill-to Address 1";
          "Bill-to Address 2" := Subscriber."Bill-to Address 2";
          "Bill-to Address 3" := Subscriber."Bill-to Address 3";
        END;
        IF Subscriber."Name (Thai)" <> '' THEN BEGIN
          "Bill-to Name (Thai)" := Subscriber."Name (Thai)";
          "Bill-to Address (Thai)" := Subscriber."Address (Thai)";
        END;
        // KKE : #002 -
        #84..151
        */
        //end;


        //Unsupported feature: Code Modification on ""Ship-to Code"(Field 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Document Type" = "Document Type"::Order) AND
           (xRec."Ship-to Code" <> "Ship-to Code")
        THEN BEGIN
        #4..26
            "Ship-to Name 2" := ShipToAddr."Name 2";
            "Ship-to Address" := ShipToAddr.Address;
            "Ship-to Address 2" := ShipToAddr."Address 2";
            "Ship-to City" := ShipToAddr.City;
            "Ship-to Post Code" := ShipToAddr."Post Code";
            "Ship-to County" := ShipToAddr.County;
        #33..48
              "Ship-to Name 2" := Cust."Name 2";
              "Ship-to Address" := Cust.Address;
              "Ship-to Address 2" := Cust."Address 2";
              "Ship-to City" := Cust.City;
              "Ship-to Post Code" := Cust."Post Code";
              "Ship-to County" := Cust.County;
        #55..82
            IF xRec."Tax Liable" <> "Tax Liable" THEN
              VALIDATE("Tax Liable");
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..29
            // KKE : #001 +
            "Ship-to Address (Thai)" := ShipToAddr."Address (Thai)";
            "Ship-to Address 3" := ShipToAddr."Address 3";
            "Ship-to Name (Thai)" := ShipToAddr."Name (Thai)";
            // KKE : #001 -
        #30..51
              // KKE : #001 +
              "Ship-to Address (Thai)" := Cust."Address (Thai)";
              "Ship-to Address 3" := Cust."Address 3";
              "Ship-to Name (Thai)" := Cust."Name (Thai)";
              // KKE : #001 -
        #52..85
        */
        //end;
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
        field(50003; "Sell-to Address 3"; Text[150])
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
        field(50006; "Bill-to Address 3"; Text[150])
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
        field(50009; "Ship-to Address 3"; Text[150])
        {
            Caption = 'Ship-to Address 3';
        }
        field(50010; "Applied-to Tax Invoice"; Code[20])
        {
            Caption = 'Applied-to Tax Invoice';
            TableRelation = "Sales Invoice Header";
        }
        field(50023; "Ads. Sales Type"; Code[10])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "General Master Setup".Code where(Type = const("Customer Type"));
        }
        field(50024; "Zone Area"; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Zone Area";
        }
        field(50025; "PO No."; Code[20])
        {
            Description = 'Burda1.00';
        }
        field(50026; "Remark 1"; Text[100])
        {
            Description = 'Burda1.00';
        }
        field(50027; "Remark 2"; Text[100])
        {
            Description = 'Burda1.00';
        }
        field(50096; "Invoice Type"; Option)
        {
            OptionMembers = ,Revenue,Deferred,Accrued;
        }
        field(50097; "Remark from Accountant"; Text[120])
        {

        }
        field(50098; Brand; text[50])
        {

        }
    }
    keys
    {
        // Unsupported feature: Key containing base fields
        // key(Key1;"Customer Posting Group","Sell-to Customer No.")
        // {
        // }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PaymentTransLogMgt.ValidateCanDeleteDocument("Payment Method Code","Document Type",FORMAT("Document Type"),"No.");

    IF NOT UserMgt.CheckRespCenter(0,"Responsibility Center") THEN
      ERROR(
        Text022,
        RespCenter.TABLECAPTION,UserMgt.GetSalesFilter);

    IF ("Opportunity No." <> '') AND
       ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order])
    THEN BEGIN
    #11..125
        END;
    END;
    PostCodeCheck.DeleteAllAddressID(DATABASE::"Sales Header",Rec.GETPOSITION);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    //KKE : #002 +
    SubscriberContractLE.RESET;
    SubscriberContractLE.SETCURRENTKEY("Paid Sales Order No.");
    SubscriberContractLE.SETRANGE("Paid Sales Order No.","No.");
    IF SubscriberContractLE.FIND('-') THEN BEGIN
      SubscriberContract.GET(SubscriberContractLE."Subscriber Contract No.");
      SubscriberContract."Payment Status" := SubscriberContract."Payment Status"::Open;
      SubscriberContract.MODIFY;
      SubscriberContractLE.MODIFYALL("Paid Flag",FALSE);
      SubscriberContractLE.MODIFYALL("Paid Sales Order No.",'');
    END;
    SubscriberContractLE.RESET;
    SubscriberContractLE.SETCURRENTKEY("Sales Order No.");
    SubscriberContractLE.SETRANGE("Sales Order No.","No.");
    IF SubscriberContractLE.FIND('-') THEN
      REPEAT
        SubscriberContractLE."Sales Order Flag" := FALSE;
        SubscriberContractLE."Sales Order Date" := 0D;
        SubscriberContractLE."Sales Order Line No." := 0;
        SubscriberContractLE."Sales Order No." := '';
        SubscriberContractLE.MODIFY;
      UNTIL SubscriberContractLE.NEXT=0;
    //KKE : #002 -

    #8..128
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateSellToCust(PROCEDURE 25)".

    //procedure UpdateSellToCust();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Cont.GET(ContactNo) THEN
      "Sell-to Contact No." := Cont."No."
    ELSE BEGIN
    #4..28
        "Ship-to Name 2" := ContComp."Name 2";
        "Ship-to Address" := ContComp.Address;
        "Ship-to Address 2" := ContComp."Address 2";
        "Ship-to City" := ContComp.City;
        "Ship-to Post Code" := ContComp."Post Code";
        "Ship-to County" := ContComp.County;
    #35..62
      END;
      "Sell-to Address" := Cont.Address;
      "Sell-to Address 2" := Cont."Address 2";
      "Sell-to City" := Cont.City;
      "Sell-to Post Code" := Cont."Post Code";
      "Sell-to County" := Cont.County;
    #69..71
       ("Bill-to Customer No." = '')
    THEN
      VALIDATE("Bill-to Contact No.","Sell-to Contact No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..31
        // KKE : #001 +
        "Ship-to Address (Thai)" := ContComp."Address (Thai)";
        "Ship-to Address 3" := ContComp."Address 3";
        "Ship-to Name (Thai)" := ContComp."Name (Thai)";
        // KKE : #001 -
    #32..65
      // KKE : #001 +
      "Sell-to Address (Thai)" := COPYSTR(Cont."Address (Thai)",1,50);
      "Sell-to Address 3" := Cont."Address 3";
      "Sell-to Name (Thai)" := COPYSTR(Cont."Name (Thai)",1,50);
      // KKE : #001 -
    #66..74
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateBillToCust(PROCEDURE 26)".

    //procedure UpdateBillToCust();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Cont.GET(ContactNo) THEN BEGIN
      "Bill-to Contact No." := Cont."No.";
      IF Cont.Type = Cont.Type::Person THEN
    #4..32
        "Bill-to Name 2" := ContComp."Name 2";
        "Bill-to Address" := ContComp.Address;
        "Bill-to Address 2" := ContComp."Address 2";
        "Bill-to City" := ContComp.City;
        "Bill-to Post Code" := ContComp."Post Code";
        "Bill-to County" := ContComp.County;
    #39..46
      END ELSE
        ERROR(Text039,Cont."No.",Cont.Name);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..35
        // KKE : #001 +
        "Bill-to Address (Thai)" := ContComp."Address (Thai)";
        "Bill-to Address 3" := ContComp."Address 3";
        "Bill-to Name (Thai)" := ContComp."Name (Thai)";
        // KKE : #001 -
    #36..49
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateShipToAddress(PROCEDURE 31)".

    //procedure UpdateShipToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
      IF "Location Code" <> '' THEN BEGIN
        Location.GET("Location Code");
        "Ship-to Name" := Location.Name;
        "Ship-to Name 2" := Location."Name 2";
        "Ship-to Address" := Location.Address;
        "Ship-to Address 2" := Location."Address 2";
        "Ship-to City" := Location.City;
        "Ship-to Post Code" := Location."Post Code";
        "Ship-to County" := Location.County;
    #11..16
        "Ship-to Name 2" := CompanyInfo."Ship-to Name 2";
        "Ship-to Address" := CompanyInfo."Ship-to Address";
        "Ship-to Address 2" := CompanyInfo."Ship-to Address 2";
        "Ship-to City" := CompanyInfo."Ship-to City";
        "Ship-to Post Code" := CompanyInfo."Ship-to Post Code";
        "Ship-to County" := CompanyInfo."Ship-to County";
        "Ship-to Country/Region Code" := CompanyInfo."Ship-to Country/Region Code";
        "Ship-to Contact" := CompanyInfo."Ship-to Contact";
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
        // KKE : #001 +
        "Ship-to Name (Thai)" := Location."Name (Thai)";
        "Ship-to Address (Thai)" := Location."Address (Thai)";
        "Ship-to Address 3" := Location."Address 3";
        // KKE : #001 -
    #8..19
        // KKE : #001 +
        "Ship-to Name (Thai)" := CompanyInfo."Company Name (Thai)";
        "Ship-to Address (Thai)" := CompanyInfo."Company Address (Thai)";
        "Ship-to Address 3" := CompanyInfo."Ship-to Address 3";
        // KKE : #001 -
    #20..26
    */
    //end;

    var
        Subscriber: Record "Subscriber";

    var
        SubscriberContractLE: Record "Subscriber Contract L/E";
        SubscriberContract: Record "Subscriber Contract";
}

