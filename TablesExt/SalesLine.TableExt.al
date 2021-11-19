TableExtension 50012 tableextension50012 extends "Sales Line"
{
    fields
    {

        //Unsupported feature: Code Modification on "Type(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        TESTFIELD("Build Kit",FALSE);
        GetSalesHeader;

        TESTFIELD("Qty. Shipped Not Invoiced",0);
        #7..40
          "Allow Item Charge Assignment" := TRUE
        ELSE
          "Allow Item Charge Assignment" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //KKE : #004 +
        IF "Ads. Booking No." <> '' THEN
          ERROR(Text50001,"Ads. Booking No.","Ads. Booking Line No.");
        //KKE : #004 -

        #1..3



        #4..43
        */
        //end;


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        TESTFIELD("Build Kit",FALSE);
        CheckItemAvailable(FIELDNO("No."));

        IF (xRec."No." <> "No.") AND (Quantity <> 0) THEN BEGIN
        #7..296
          KitManagement.GetTotalKitPrice(KitUnitPrice,TempKitSalesLine);
          VALIDATE("Unit Price","Qty. per Unit of Measure" * KitUnitPrice);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //KKE : #004 +
        IF "Ads. Booking No." <> '' THEN
          ERROR(Text50001,"Ads. Booking No.","Ads. Booking Line No.");
        //KKE : #004 -
        #1..3


        #4..299
        */
        //end;


        //Unsupported feature: Code Modification on "Amount(Field 29).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Amount := ROUND(Amount,Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              "VAT Base Amount" :=
                ROUND(Amount * (1 - SalesHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                ROUND(Amount + "VAT Base Amount" * "VAT %" / 100,Currency."Amount Rounding Precision");
            END;
        #11..32
        END;

        InitOutstandingAmount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
              //KKE : #001 +
              IF Type = Type::Item THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
                IF VATPostingSetup."Use Announce Price for O/P VAT" THEN BEGIN
                  ItemVATAnnPrice.RESET;
                  ItemVATAnnPrice.SETRANGE("Item No.","No.");
                  ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Output VAT");
                  ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',SalesHeader."Posting Date");
                  IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                    "Use VAT Announce Price" := TRUE;
                    "Org. VAT Base Amount" := "VAT Base Amount";
                    "VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                  END ELSE
                    ERROR(Text50000,"No.","Line No.");
                END;
              END;
              //KKE : #001 -
        #8..35
        */
        //end;


        //Unsupported feature: Code Modification on ""Amount Including VAT"(Field 30).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Amount Including VAT" := ROUND("Amount Including VAT",Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
        #4..9
                  Currency."Amount Rounding Precision");
              "VAT Base Amount" :=
                ROUND(Amount * (1 - SalesHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
            END;
          "VAT Calculation Type"::"Full VAT":
            BEGIN
        #16..33
        END;

        InitOutstandingAmount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..12
              //KKE : #001 +
              IF Type = Type::Item THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
                IF VATPostingSetup."Use Announce Price for O/P VAT" THEN BEGIN
                  ItemVATAnnPrice.RESET;
                  ItemVATAnnPrice.SETRANGE("Item No.","No.");
                  ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Output VAT");
                  ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',SalesHeader."Posting Date");
                  IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                    "Use VAT Announce Price" := TRUE;
                    "Org. VAT Base Amount" := "VAT Base Amount";
                    "VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                  END ELSE
                    ERROR(Text50000,"No.","Line No.");
                END;
              END;
              //KKE : #001 -
        #13..36
        */
        //end;
        field(50020; "Subscriber Contract No."; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Subscriber Contract";
        }
        field(50021; "Agent Customer No."; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Agent Customer Header";
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
        field(50025; "Ads. Booking No."; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Ads. Booking Header";
        }
        field(50026; "Ads. Booking Line No."; Integer)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50090; "Use VAT Announce Price"; Boolean)
        {
        }
        field(50091; "Org. VAT Base Amount"; Decimal)
        {
        }
        field(50092; "Deal No."; Code[20])
        {
            TableRelation = "Ads. Booking Header"."No.";
        }
        field(50093; "Sub Deal No."; Text[30])
        {

        }
        field(50094; "Publication Month"; Text[10])
        {

        }
        field(50095; Brand; Code[20])
        {

        }
        field(50096; "Invoice Type"; Option)
        {
            OptionMembers = ,Revenue,Deferred;
        }
        field(50097; "Salesperson Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    IF NOT StatusCheckSuspended AND (SalesHeader.Status = SalesHeader.Status::Released) AND
       (Type IN [Type::"G/L Account",Type::"Charge (Item)",Type::Resource])
    #4..10
      KitManagement.DeleteKitSales(Rec,TRUE);
    DocDim.LOCKTABLE;

    IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
      ReserveSalesLine.DeleteLine(Rec);
      CALCFIELDS("Reserved Qty. (Base)");
    #17..58
    SalesCommentLine.SETRANGE("Document Line No.","Line No.");
    IF NOT SalesCommentLine.ISEMPTY THEN
      SalesCommentLine.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    //KKE : #002 +
    {
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
    }
    SubscriberContractLE.RESET;
    SubscriberContractLE.SETCURRENTKEY("Sales Order No.");
    SubscriberContractLE.SETRANGE("Sales Order No.","No.");
    SubscriberContractLE.SETRANGE("Sales Order Line No.","Line No.");
    IF SubscriberContractLE.FIND('-') THEN BEGIN
      SubscriberContract.GET(SubscriberContractLE."Subscriber Contract No.");
      SubscriberContract."Payment Status" := SubscriberContract."Payment Status"::Open;
      SubscriberContract.MODIFY;
      REPEAT
        SubscriberContractLE."Sales Order Flag" := FALSE;
        SubscriberContractLE."Sales Order Date" := 0D;
        SubscriberContractLE."Sales Order Line No." := 0;
        SubscriberContractLE."Sales Order No." := '';
        SubscriberContractLE.MODIFY;
      UNTIL SubscriberContractLE.NEXT=0;
    END;
    //KKE : #002 -

    //KKE : #003 +
    AgentCustLine.RESET;
    AgentCustLine.SETRANGE("Agent Customer No.","Agent Customer No.");
    AgentCustLine.SETRANGE("Delivered Document No.","Document No.");
    AgentCustLine.SETRANGE("Delivered Document Line No.","Line No.");
    IF AgentCustLine.FIND('-') THEN
      REPEAT
        AgentCustLine."Delivered Flag" := FALSE;
        AgentCustLine."Delivered Date" := 0D;
        AgentCustLine."Delivered Document Line No." := 0;
        AgentCustLine."Delivered Document No." := '';
        AgentCustLine.MODIFY;
      UNTIL AgentCustLine.NEXT=0;
    //KKE : #003 -

    //KKE : #004 +
    IF AdsBookingLine.GET("Ads. Booking No.","Ads. Booking Line No.") THEN BEGIN
      IF AdsBookingLine."Line Status" = AdsBookingLine."Line Status"::Invoiced THEN BEGIN
        AdsBookingLine."Line Status" := AdsBookingLine."Line Status"::Approved;
        AdsBookingLine."Cash Invoice No." := '';
        AdsBookingLine."Barter Invoice No." := '';
        AdsBookingLine.Closed := FALSE;
        AdsBookingLine.MODIFY;
      END;
    END;
    //KKE : #004 -

    #14..61
    */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Document Type" = "Document Type"::"Blanket Order") AND
       ((Type <> xRec.Type) OR ("No." <> xRec."No."))
    THEN BEGIN
    #4..19

    IF ((Quantity <> 0) OR (xRec.Quantity <> 0)) AND ItemExists(xRec."No.") THEN
      ReserveSalesLine.VerifyChange(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //KKE : #004 +
    IF ("Ads. Booking No." <> '') AND (Description = xRec.Description) THEN
      ERROR(Text50001,"Ads. Booking No.","Ads. Booking Line No.");
    //KKE : #004 -

    #1..22
    */
    //end;


    //procedure UpdateVATAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine2.SETRANGE("Document Type","Document Type");
    SalesLine2.SETRANGE("Document No.","Document No.");
    SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
    #4..57
                ROUND(
                  Amount * (1 - SalesHeader."VAT Base Discount %" / 100),
                  Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                TotalLineAmount + "Line Amount" +
                ROUND(
                  (TotalAmount + Amount) * (SalesHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
                  Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                TotalAmountInclVAT;
            END;
    #68..95
              Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
              "VAT Base Amount" :=
                ROUND(Amount * (1 - SalesHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                TotalAmount + Amount +
                ROUND(
                  (TotalAmount + Amount) * (1 - SalesHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
                  Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                TotalAmountInclVAT;
            END;
    #106..112
            BEGIN
              Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
              "VAT Base Amount" := Amount;
              "Amount Including VAT" :=
                TotalAmount + Amount +
                ROUND(
    #119..128
            END;
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..60
              //KKE : #001 +
              IF Type = Type::Item THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
                IF VATPostingSetup."Use Announce Price for O/P VAT" THEN BEGIN
                  ItemVATAnnPrice.RESET;
                  ItemVATAnnPrice.SETRANGE("Item No.","No.");
                  ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Output VAT");
                  ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',SalesHeader."Posting Date");
                  IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                    "Use VAT Announce Price" := TRUE;
                    "Org. VAT Base Amount" := "VAT Base Amount";
                    "VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                  END ELSE
                    ERROR(Text50000,"No.","Line No.");
                END;
              END;
              //KKE : #001 -
    #99..102

    #65..98
              //KKE : #001 +
              IF Type = Type::Item THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
                IF VATPostingSetup."Use Announce Price for O/P VAT" THEN BEGIN
                  ItemVATAnnPrice.RESET;
                  ItemVATAnnPrice.SETRANGE("Item No.","No.");
                  ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Output VAT");
                  ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',SalesHeader."Posting Date");
                  IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                    "Use VAT Announce Price" := TRUE;
                    "Org. VAT Base Amount" := "VAT Base Amount";
                    "VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                  END ELSE
                    ERROR(Text50000,"No.","Line No.");
                END;
              END;
              //KKE : #001 -
    #116..118
                  (TotalAmount + Amount) * (1 - SalesHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
    #103..131
    */
    //end;

    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 35)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLSetup.GET;
    IF SalesHeader."Currency Code" = '' THEN
      Currency.InitRoundingPrecision
    #4..34
              VATAmountLine.Positive := "Line Amount" >= 0;
              VATAmountLine.INSERT;
            END;
            CASE QtyType OF
              QtyType::General:
                BEGIN
    #41..219
              "VAT Calculation Type"::"Reverse Charge VAT":
                BEGIN
                  "VAT Base" := "Line Amount" - "Invoice Discount Amount";
                  "VAT Amount" :=
                    "VAT Difference" +
                    ROUND(
    #226..301
        VATAmountLine."Calculated VAT Amount" := VATAmountLine."Calculated VAT Amount" + TotalVATAmount;
        VATAmountLine.MODIFY;
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..37
          //KKE : #001 +
          IF Type = Type::Item THEN BEGIN
            VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
            IF VATPostingSetup."Use Announce Price for O/P VAT" THEN BEGIN
              ItemVATAnnPrice.RESET;
              ItemVATAnnPrice.SETRANGE("Item No.","No.");
              ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Output VAT");
              ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',SalesHeader."Posting Date");
              IF ItemVATAnnPrice.FIND('+') THEN
                VATAmountLine."VAT Announce Price" += ItemVATAnnPrice."Announce Price"
              ELSE
                ERROR(Text50000,"No.","Line No.");
            END;
          END;
          //KKE : #001 -
    #38..222
                  //KKE : #001 +
                  IF "VAT Announce Price" <> 0 THEN
                    "VAT Base" := "VAT Announce Price";
                  //KKE : #001 -
    #223..304
    */
    //end;

    var
        Text50000: label 'Announce price for item no. %1 line no. %2 has not been set.';

    var
        ItemVATAnnPrice: Record "Item VAT Announce Price";

    var
        SubscriberContractLE: Record "Subscriber Contract L/E";

    var
        SubscriberContract: Record "Subscriber Contract";

    var
        AgentCustLine: Record "Agent Customer Line";

    var
        AdsBookingLine: Record "Ads. Booking Line";

    var
        Text50001: label 'You cannot change the order line because it is associated with ads. booking %1 line %2.';
}

