TableExtension 50014 tableextension50014 extends "Purchase Line"
{
    fields
    {

        //Unsupported feature: Code Modification on "Amount(Field 29).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        Amount := ROUND(Amount,Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              "VAT Base Amount" :=
                ROUND(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                ROUND(Amount + "VAT Base Amount" * "VAT %" / 100,Currency."Amount Rounding Precision");
              "VAT Base (ACY)" :=
        #12..50

        InitOutstandingAmount;
        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
              //KKE : #002 +
              IF Type = Type::Item THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
                IF VATPostingSetup."Use Announce Price for I/P VAT" THEN BEGIN
                  ItemVATAnnPrice.RESET;
                  ItemVATAnnPrice.SETRANGE("Item No.","No.");
                  ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Input VAT");
                  ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',PurchHeader."Posting Date");
                  IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                    "Use VAT Announce Price" := TRUE;
                    "Org. VAT Base Amount" := "VAT Base Amount";
                    "VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                  END ELSE
                    ERROR(Text50000,"No.","Line No.");
                END;
              END;
              //KKE : #002 -
        #9..53
        */
        //end;


        //Unsupported feature: Code Modification on ""Amount Including VAT"(Field 30).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        "Amount Including VAT" := ROUND("Amount Including VAT",Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
        #4..10
                  Currency."Amount Rounding Precision");
              "VAT Base Amount" :=
                ROUND(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
            END;
          "VAT Calculation Type"::"Full VAT":
            BEGIN
        #17..41

        InitOutstandingAmount;
        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13
              //KKE : #002 +
              IF Type = Type::Item THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
                IF VATPostingSetup."Use Announce Price for I/P VAT" THEN BEGIN
                  ItemVATAnnPrice.RESET;
                  ItemVATAnnPrice.SETRANGE("Item No.","No.");
                  ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Input VAT");
                  ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',PurchHeader."Posting Date");
                  IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                    "Use VAT Announce Price" := TRUE;
                    "Org. VAT Base Amount" := "VAT Base Amount";
                    "VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                  END ELSE
                    ERROR(Text50000,"No.","Line No.");
                END;
              END;
              //KKE : #002 -
        #14..44
        */
        //end;
        field(50000; "Applies-to Doc. No."; Code[20])
        {
        }
        field(50001; "Applies-to Line No."; Integer)
        {
            TableRelation = "Purch. Inv. Line"."Line No." where("Document No." = field("Applies-to Doc. No."));
        }
        field(50020; "VAT Claim %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50021; "VAT Unclaim %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Burda1.00';
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50022; "Avg. VAT Amount"; Decimal)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50024; "Average VAT Year"; Integer)
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Average VAT Setup";
        }
        field(50090; "Use VAT Announce Price"; Boolean)
        {
        }
        field(50091; "Org. VAT Base Amount"; Decimal)
        {
        }

    }

    //Unsupported feature: Parameter Insertion (Parameter: Qty) (ParameterCollection) on "CalcBaseQty(PROCEDURE 14)".


    //Unsupported feature: Parameter Insertion (Parameter: NewPurchHeader) (ParameterCollection) on "SetPurchHeader(PROCEDURE 12)".


    //Unsupported feature: Parameter Insertion (Parameter: CalledByFieldNo) (ParameterCollection) on "UpdateDirectUnitCost(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "UpdateVATAmounts(PROCEDURE 38)".

    //procedure UpdateVATAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchLine2.SETRANGE("Document Type","Document Type");
    PurchLine2.SETRANGE("Document No.","Document No.");
    PurchLine2.SETFILTER("Line No.",'<>%1',"Line No.");
    #4..60
                ROUND(
                  Amount * (1 - PurchHeader."VAT Base Discount %" / 100),
                  Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                TotalLineAmount + "Line Amount" -
                ROUND(
    #67..104
              Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
              "VAT Base Amount" :=
                ROUND(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                TotalAmount + Amount +
                ROUND(
    #111..157
            END;
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..63
              //KKE : #001 +
              IF Type = Type::Item THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
                IF VATPostingSetup."Use Announce Price for I/P VAT" THEN BEGIN



                  ItemVATAnnPrice.RESET;
                  ItemVATAnnPrice.SETRANGE("Item No.","No.");
                  ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Input VAT");
                  ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',PurchHeader."Posting Date");
                  IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                    "Use VAT Announce Price" := TRUE;
                    "Org. VAT Base Amount" := "VAT Base Amount";
                    "VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                  END ELSE
                    ERROR(Text50000,"No.","Line No.");
                END;
              END;
              //KKE : #001 -
    #64..107
              //KKE : #001 +
              IF Type = Type::Item THEN BEGIN
                VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
                IF VATPostingSetup."Use Announce Price for I/P VAT" THEN BEGIN
                  ItemVATAnnPrice.RESET;
                  ItemVATAnnPrice.SETRANGE("Item No.","No.");
                  ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Input VAT");
                  ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',PurchHeader."Posting Date");
                  IF ItemVATAnnPrice.FIND('+') THEN BEGIN
                    "Use VAT Announce Price" := TRUE;
                    "Org. VAT Base Amount" := "VAT Base Amount";
                    "VAT Base Amount" := ItemVATAnnPrice."Announce Price";
                  END ELSE
                    ERROR(Text50000,"No.","Line No.");
                END;
              END;
              //KKE : #001 -
    #108..160
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: Modal) (ParameterCollection) on "ShowReservationEntries(PROCEDURE 21)".


    //Unsupported feature: Parameter Insertion (Parameter: Value) (ParameterCollection) on "Signed(PROCEDURE 20)".


    //Unsupported feature: Parameter Insertion (Parameter: AvailabilityType) (ParameterCollection) on "ItemAvailability(PROCEDURE 22)".


    //Unsupported feature: Parameter Insertion (Parameter: SetBlock) (ParameterCollection) on "BlockDynamicTracking(PROCEDURE 23)".


    //Unsupported feature: Parameter Insertion (Parameter: Type1) (ParameterCollection) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Parameter Insertion (Parameter: No1) (ParameterCollection) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Parameter Insertion (Parameter: Type2) (ParameterCollection) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Parameter Insertion (Parameter: No2) (ParameterCollection) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Parameter Insertion (Parameter: Type3) (ParameterCollection) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Parameter Insertion (Parameter: No3) (ParameterCollection) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Parameter Insertion (Parameter: Type4) (ParameterCollection) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Parameter Insertion (Parameter: No4) (ParameterCollection) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Parameter Insertion (Parameter: FieldNumber) (ParameterCollection) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Parameter Insertion (Parameter: ShortcutDimCode) (ParameterCollection) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Parameter Insertion (Parameter: FieldNumber) (ParameterCollection) on "LookupShortcutDimCode(PROCEDURE 30)".


    //Unsupported feature: Parameter Insertion (Parameter: ShortcutDimCode) (ParameterCollection) on "LookupShortcutDimCode(PROCEDURE 30)".


    //Unsupported feature: Parameter Insertion (Parameter: ShortcutDimCode) (ParameterCollection) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Parameter Insertion (Parameter: DocType) (ParameterCollection) on "DeleteItemChargeAssgnt(PROCEDURE 5802)".


    //Unsupported feature: Parameter Insertion (Parameter: DocNo) (ParameterCollection) on "DeleteItemChargeAssgnt(PROCEDURE 5802)".


    //Unsupported feature: Parameter Insertion (Parameter: DocLineNo) (ParameterCollection) on "DeleteItemChargeAssgnt(PROCEDURE 5802)".


    //Unsupported feature: Parameter Insertion (Parameter: DocType) (ParameterCollection) on "DeleteChargeChargeAssgnt(PROCEDURE 5804)".


    //Unsupported feature: Parameter Insertion (Parameter: DocNo) (ParameterCollection) on "DeleteChargeChargeAssgnt(PROCEDURE 5804)".


    //Unsupported feature: Parameter Insertion (Parameter: DocLineNo) (ParameterCollection) on "DeleteChargeChargeAssgnt(PROCEDURE 5804)".


    //Unsupported feature: Parameter Insertion (Parameter: FieldNumber) (ParameterCollection) on "GetFieldCaption(PROCEDURE 31)".


    //Unsupported feature: Parameter Insertion (Parameter: FieldNumber) (ParameterCollection) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Parameter Insertion (Parameter: Suspend) (ParameterCollection) on "SuspendStatusCheck(PROCEDURE 42)".


    //Unsupported feature: Parameter Insertion (Parameter: PurchDate) (ParameterCollection) on "InternalLeadTimeDays(PROCEDURE 35)".


    //Unsupported feature: Parameter Insertion (Parameter: QtyType) (ParameterCollection) on "UpdateVATOnLines(PROCEDURE 32)".


    //Unsupported feature: Parameter Insertion (Parameter: PurchHeader) (ParameterCollection) on "UpdateVATOnLines(PROCEDURE 32)".


    //Unsupported feature: Parameter Insertion (Parameter: PurchLine) (ParameterCollection) on "UpdateVATOnLines(PROCEDURE 32)".


    //Unsupported feature: Parameter Insertion (Parameter: VATAmountLine) (ParameterCollection) on "UpdateVATOnLines(PROCEDURE 32)".



    //Unsupported feature: Code Modification on "UpdateVATOnLines(PROCEDURE 32)".

    //procedure UpdateVATOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF QtyType = QtyType::Shipping THEN
      EXIT;
    IF PurchHeader."Currency Code" = '' THEN
    #4..188
                "Amount Including VAT (ACY)" := ROUND(NewAmountIncludingVATACY,AddCurrency."Amount Rounding Precision");
                "VAT Base (ACY)" := NewVATBaseAmountACY;
                "Amount (ACY)" := NewAmountACY;
              END;
              InitOutstanding;
              IF NOT ((Type = Type::"Charge (Item)") AND ("Quantity Invoiced" <> "Qty. Assigned")) THEN BEGIN
    #195..213
          END;
        UNTIL NEXT = 0;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..191
              //KKE : #003 +
              IF VATAmountLine."VAT Claim %" <> 0 THEN BEGIN
                "VAT Claim %" := VATAmountLine."VAT Claim %";
                "VAT Unclaim %" := VATAmountLine."VAT Unclaim %";
                "Avg. VAT Amount" :=
                  //"VAT Difference" +
                  ROUND(("Amount Including VAT" - Amount) * VATAmountLine."VAT Claim %"/100,
                    Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                {---
                "Avg. VAT Amount (ACY)" :=
                  //"VAT Difference (ACY)" +
                  ROUND(("Amount Including VAT (ACY)" - "Amount (ACY)") * VATAmountLine."VAT Claim %"/100,
                    AddCurrency."Amount Rounding Precision");
                ---}
                "Average VAT Year" := VATAmountLine."Average VAT Year";
              END ELSE BEGIN
                "VAT Claim %" := 0;
                "VAT Unclaim %" := 0;
                "Avg. VAT Amount" := 0;
                "Average VAT Year" := 0;
              END;
              //KKE : #003 -





















    #192..216
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: QtyType) (ParameterCollection) on "CalcVATAmountLines(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: PurchHeader) (ParameterCollection) on "CalcVATAmountLines(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: PurchLine) (ParameterCollection) on "CalcVATAmountLines(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: VATAmountLine) (ParameterCollection) on "CalcVATAmountLines(PROCEDURE 24)".


    //Unsupported feature: Variable Insertion (Variable: AverageVATSetup) (VariableCollection) on "CalcVATAmountLines(PROCEDURE 24)".


    //Unsupported feature: Variable Insertion (Variable: VATProdPostingGrp) (VariableCollection) on "CalcVATAmountLines(PROCEDURE 24)".



    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 24)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF PurchHeader."Currency Code" = '' THEN
      Currency.InitRoundingPrecision
    ELSE
    #4..50
              VATAmountLine.Positive := "Line Amount" >= 0;
              VATAmountLine.INSERT;
            END;
            CASE QtyType OF
              QtyType::General:
                BEGIN
    #57..324
              "VAT Calculation Type"::"Reverse Charge VAT":
                BEGIN
                  "VAT Base" := "Line Amount" - "Invoice Discount Amount";
                  "VAT Amount" :=
                    "VAT Difference" +
                    ROUND(
    #331..411
          END;
          IF RoundingLineInserted THEN
            TotalVATAmount := TotalVATAmount - "VAT Amount";
          "Calculated VAT Amount" := "VAT Amount" - "VAT Difference";
          "Calculated VAT Amount (ACY)" := "VAT Amount (ACY)" - "VAT Difference (ACY)";
          MODIFY;
    #418..425
        VATAmountLine."Calculated VAT Amount" := VATAmountLine."Calculated VAT Amount" + TotalVATAmount;
        VATAmountLine.MODIFY;
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..53
          //KKE : #001 +
          IF Type = Type::Item THEN BEGIN
            VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
            IF VATPostingSetup."Use Announce Price for I/P VAT" THEN BEGIN
              ItemVATAnnPrice.RESET;
              ItemVATAnnPrice.SETRANGE("Item No.","No.");
              ItemVATAnnPrice.SETRANGE("VAT Type",ItemVATAnnPrice."VAT Type"::"Input VAT");
              ItemVATAnnPrice.SETFILTER("Starting Date",'<=%1',PurchHeader."Posting Date");
              IF ItemVATAnnPrice.FIND('+') THEN
                VATAmountLine."VAT Announce Price" += ItemVATAnnPrice."Announce Price"
              ELSE
                ERROR(Text50000,"No.","Line No.");
            END;
          END;
          //KKE : #001 -

          //KKE : #003 +
          IF GLSetup."Enable VAT Average" THEN BEGIN
            IF NOT VATProdPostingGrp.GET("VAT Prod. Posting Group") THEN
              VATProdPostingGrp.INIT;
            IF VATProdPostingGrp."Average VAT" THEN BEGIN
              VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
              AverageVATSetup.RESET;
              AverageVATSetup.SETFILTER("From Date",'<=%1',PurchHeader."Posting Date");
              AverageVATSetup.SETFILTER("To Date",'>=%1',PurchHeader."Posting Date");
              IF AverageVATSetup.FIND('+') THEN BEGIN
                AverageVATSetup.TESTFIELD("VAT Claim %");
                VATAmountLine."VAT Claim %" := AverageVATSetup."VAT Claim %";
                VATAmountLine."VAT Unclaim %" := AverageVATSetup."VAT Unclaim %";
                VATAmountLine."Average VAT Year" := AverageVATSetup.Year;
              END;
            END;
          END;
          //KKE : #003 -

    #54..327
                  //KKE : #001 +
                  IF "VAT Announce Price" <> 0 THEN
                    "VAT Base" := "VAT Announce Price";
                  //KKE : #001 -
    #328..414
          //KKE : #003 +
          IF "VAT Claim %" <> 0 THEN BEGIN
            "Avg. VAT Amount" :=
              //"VAT Difference" +
              ROUND(("Amount Including VAT" - "Line Amount") * "VAT Claim %"/100,
                Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
            "Avg. VAT Amount (ACY)" :=
              //"VAT Difference (ACY)" +
              ROUND(("Amount Including VAT (ACY)" - "Amount (ACY)") * "VAT Claim %"/100,
                AddCurrency."Amount Rounding Precision");
          END;
          //KKE : #003 -

    #415..428
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: DateFormulatoAdjust) (ParameterCollection) on "AdjustDateFormula(PROCEDURE 48)".


    //Unsupported feature: Parameter Insertion (Parameter: LocationCode) (ParameterCollection) on "GetLocation(PROCEDURE 7300)".


    //Unsupported feature: Parameter Insertion (Parameter: ItemNo) (ParameterCollection) on "ItemExists(PROCEDURE 52)".


    //Unsupported feature: Parameter Insertion (Parameter: QtyToHandle) (ParameterCollection) on "GetAbsMin(PROCEDURE 56)".


    //Unsupported feature: Parameter Insertion (Parameter: QtyHandled) (ParameterCollection) on "GetAbsMin(PROCEDURE 56)".


    //Unsupported feature: Parameter Insertion (Parameter: GetPrices) (ParameterCollection) on "CreateTempJobJnlLine(PROCEDURE 55)".


    //Unsupported feature: Parameter Insertion (Parameter: UpdateFromVAT2) (ParameterCollection) on "SetUpdateFromVAT(PROCEDURE 58)".


    //Unsupported feature: Parameter Insertion (Parameter: NoText) (ParameterCollection) on "FormatNoText(PROCEDURE 1500003)".


    //Unsupported feature: Parameter Insertion (Parameter: No) (ParameterCollection) on "FormatNoText(PROCEDURE 1500003)".


    //Unsupported feature: Parameter Insertion (Parameter: CurrencyCode) (ParameterCollection) on "FormatNoText(PROCEDURE 1500003)".


    //Unsupported feature: Parameter Insertion (Parameter: QtyType) (ParameterCollection) on "ZeroAmountLine(PROCEDURE 66)".


    //Unsupported feature: Parameter Insertion (Parameter: NoText) (ParameterCollection) on "FormatNoTextTH(PROCEDURE 1500002)".


    //Unsupported feature: Parameter Insertion (Parameter: No) (ParameterCollection) on "FormatNoTextTH(PROCEDURE 1500002)".


    //Unsupported feature: Parameter Insertion (Parameter: CurrencyCode) (ParameterCollection) on "FormatNoTextTH(PROCEDURE 1500002)".


    //Unsupported feature: Parameter Insertion (Parameter: NoText) (ParameterCollection) on "AddToNoText(PROCEDURE 1500004)".


    //Unsupported feature: Parameter Insertion (Parameter: NoTextIndex) (ParameterCollection) on "AddToNoText(PROCEDURE 1500004)".


    //Unsupported feature: Parameter Insertion (Parameter: PrintExponent) (ParameterCollection) on "AddToNoText(PROCEDURE 1500004)".


    //Unsupported feature: Parameter Insertion (Parameter: AddText) (ParameterCollection) on "AddToNoText(PROCEDURE 1500004)".


    //Unsupported feature: Property Modification (Id) on "InitOutstandingAmount(PROCEDURE 19).AmountInclVAT(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "InitOutstandingAmount(PROCEDURE 19).AmountInclVATACY(Variable 1500000)".


    //Unsupported feature: Property Modification (Id) on "CalcInvDiscToInvoice(PROCEDURE 33).OldInvDiscAmtToInv(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CalcBaseQty(PROCEDURE 14).Qty(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "SelectItemEntry(PROCEDURE 7).ItemLedgEntry(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "SetPurchHeader(PROCEDURE 12).NewPurchHeader(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "UpdateDirectUnitCost(PROCEDURE 2).CalledByFieldNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "UpdateUnitCost(PROCEDURE 5).DiscountAmountPerQty(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATAmounts(PROCEDURE 38).PurchLine2(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATAmounts(PROCEDURE 38).TotalLineAmount(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATAmounts(PROCEDURE 38).TotalInvDiscAmount(Variable 1004)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATAmounts(PROCEDURE 38).TotalAmount(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATAmounts(PROCEDURE 38).TotalAmountInclVAT(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATAmounts(PROCEDURE 38).TotalQuantityBase(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATAmounts(PROCEDURE 38).TotalLineAmountACY(Variable 1500002)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATAmounts(PROCEDURE 38).TotalAmountACY(Variable 1500001)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATAmounts(PROCEDURE 38).TotalAmountInclVATACY(Variable 1500000)".


    //Unsupported feature: Property Modification (Id) on "GetFAPostingGroup(PROCEDURE 10).LocalGLAcc(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "GetFAPostingGroup(PROCEDURE 10).FAPostingGr(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "ShowReservationEntries(PROCEDURE 21).Modal(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "Signed(PROCEDURE 20).Value(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "ItemAvailability(PROCEDURE 22).AvailabilityType(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "BlockDynamicTracking(PROCEDURE 23).SetBlock(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "ShowDimensions(PROCEDURE 25).DocDim(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "ShowDimensions(PROCEDURE 25).DocDimensions(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateDim(PROCEDURE 26).Type1(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateDim(PROCEDURE 26).No1(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateDim(PROCEDURE 26).Type2(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateDim(PROCEDURE 26).No2(Parameter 1003)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateDim(PROCEDURE 26).Type3(Parameter 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateDim(PROCEDURE 26).No3(Parameter 1005)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateDim(PROCEDURE 26).Type4(Parameter 1006)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateDim(PROCEDURE 26).No4(Parameter 1007)".


    //Unsupported feature: Property Modification (Id) on "CreateDim(PROCEDURE 26).SourceCodeSetup(Variable 1008)".


    //Unsupported feature: Property Modification (Id) on "CreateDim(PROCEDURE 26).TableID(Variable 1009)".


    //Unsupported feature: Property Modification (Id) on "CreateDim(PROCEDURE 26).No(Variable 1010)".


    //Unsupported feature: Deletion (ParameterCollection) on "ValidateShortcutDimCode(PROCEDURE 29).FieldNumber(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "ValidateShortcutDimCode(PROCEDURE 29).ShortcutDimCode(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "LookupShortcutDimCode(PROCEDURE 30).FieldNumber(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "LookupShortcutDimCode(PROCEDURE 30).ShortcutDimCode(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "ShowShortcutDimCode(PROCEDURE 27).ShortcutDimCode(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "ShowItemChargeAssgnt(PROCEDURE 5801).ItemChargeAssgnts(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "ShowItemChargeAssgnt(PROCEDURE 5801).AssignItemChargePurch(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "UpdateItemChargeAssgnt(PROCEDURE 5807).ShareOfVAT(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "DeleteItemChargeAssgnt(PROCEDURE 5802).DocType(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "DeleteItemChargeAssgnt(PROCEDURE 5802).DocNo(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "DeleteItemChargeAssgnt(PROCEDURE 5802).DocLineNo(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "DeleteChargeChargeAssgnt(PROCEDURE 5804).DocType(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "DeleteChargeChargeAssgnt(PROCEDURE 5804).DocNo(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "DeleteChargeChargeAssgnt(PROCEDURE 5804).DocLineNo(Parameter 1002)".


    //Unsupported feature: Property Modification (Id) on "CheckItemChargeAssgnt(PROCEDURE 5800).ItemChargeAssgntPurch(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetFieldCaption(PROCEDURE 31).FieldNumber(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "GetFieldCaption(PROCEDURE 31).Field(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetCaptionClass(PROCEDURE 34).FieldNumber(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "SuspendStatusCheck(PROCEDURE 42).Suspend(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "UpdateLeadTimeFields(PROCEDURE 11).StartingDate(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "InternalLeadTimeDays(PROCEDURE 35).PurchDate(Parameter 1002)".


    //Unsupported feature: Property Modification (Id) on "InternalLeadTimeDays(PROCEDURE 35).SafetyLeadTime(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "InternalLeadTimeDays(PROCEDURE 35).TotalDays(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "UpdateVATOnLines(PROCEDURE 32).QtyType(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "UpdateVATOnLines(PROCEDURE 32).PurchHeader(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "UpdateVATOnLines(PROCEDURE 32).PurchLine(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "UpdateVATOnLines(PROCEDURE 32).VATAmountLine(Parameter 1003)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).TempVATAmountLineRemainder(Variable 1004)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).Currency(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).ChangeLogMgt(Variable 1013)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).RecRef(Variable 1015)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).xRecRef(Variable 1014)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).NewAmount(Variable 1006)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).NewAmountIncludingVAT(Variable 1007)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).NewVATBaseAmount(Variable 1008)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).VATAmount(Variable 1009)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).VATDifference(Variable 1010)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).InvDiscAmount(Variable 1011)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).LineAmountToInvoice(Variable 1012)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).NewAmountACY(Variable 1500008)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).NewAmountIncludingVATACY(Variable 1500007)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).NewVATBaseAmountACY(Variable 1500006)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).VATAmountACY(Variable 1500005)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).VATDifferenceACY(Variable 1500004)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).LineAmountToInvoiceACY(Variable 1500003)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).AddCurrency(Variable 1500002)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).CurrencyFactor(Variable 1500001)".


    //Unsupported feature: Property Modification (Id) on "UpdateVATOnLines(PROCEDURE 32).UseDate(Variable 1500000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CalcVATAmountLines(PROCEDURE 24).QtyType(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CalcVATAmountLines(PROCEDURE 24).PurchHeader(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CalcVATAmountLines(PROCEDURE 24).PurchLine(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "CalcVATAmountLines(PROCEDURE 24).VATAmountLine(Parameter 1003)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).PrevVatAmountLine(Variable 1007)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).Currency(Variable 1004)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).Vendor(Variable 1012)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).VendorPostingGroup(Variable 1013)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).PurchSetup(Variable 1008)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).SalesTaxCalculate(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).QtyToHandle(Variable 1006)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).RoundingLineInserted(Variable 1010)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).TotalVATAmount(Variable 1011)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).AddCurrency(Variable 1500002)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).CurrencyFactor(Variable 1500001)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).UseDate(Variable 1500000)".


    //Unsupported feature: Property Modification (Id) on "CalcVATAmountLines(PROCEDURE 24).TotalVATAmountACY(Variable 150000)".


    //Unsupported feature: Property Modification (Id) on "CheckWarehouse(PROCEDURE 47).Location2(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "CheckWarehouse(PROCEDURE 47).WhseSetup(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "CheckWarehouse(PROCEDURE 47).ShowDialog(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "CheckWarehouse(PROCEDURE 47).DialogText(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "GetOverheadRateFCY(PROCEDURE 40).QtyPerUOM(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "AdjustDateFormula(PROCEDURE 48).DateFormulatoAdjust(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetLocation(PROCEDURE 7300).LocationCode(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "RowID1(PROCEDURE 49).ItemTrackingMgt(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "GetDefaultBin(PROCEDURE 50).WMSManagement(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "CrossReferenceNoLookUp(PROCEDURE 51).ItemCrossReference(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "ItemExists(PROCEDURE 52).ItemNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "ItemExists(PROCEDURE 52).Item2(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetAbsMin(PROCEDURE 56).QtyToHandle(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetAbsMin(PROCEDURE 56).QtyHandled(Parameter 1001)".


    //Unsupported feature: Property Modification (Id) on "CheckApplToItemLedgEntry(PROCEDURE 53).ItemLedgEntry(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "CheckApplToItemLedgEntry(PROCEDURE 53).ApplyRec(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on "CheckApplToItemLedgEntry(PROCEDURE 53).QtyBase(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "CheckApplToItemLedgEntry(PROCEDURE 53).RemainingQty(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "CheckApplToItemLedgEntry(PROCEDURE 53).ReturnedQty(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "CheckApplToItemLedgEntry(PROCEDURE 53).RemainingtobeReturnedQty(Variable 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateTempJobJnlLine(PROCEDURE 55).GetPrices(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "SetUpdateFromVAT(PROCEDURE 58).UpdateFromVAT2(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "FormatNoText(PROCEDURE 1500003).NoText(Parameter 1500000)".


    //Unsupported feature: Deletion (ParameterCollection) on "FormatNoText(PROCEDURE 1500003).No(Parameter 1500001)".


    //Unsupported feature: Deletion (ParameterCollection) on "FormatNoText(PROCEDURE 1500003).CurrencyCode(Parameter 1500002)".


    //Unsupported feature: Property Modification (Id) on "FormatNoText(PROCEDURE 1500003).PrintExponent(Variable 1500003)".


    //Unsupported feature: Property Modification (Id) on "FormatNoText(PROCEDURE 1500003).Ones(Variable 1500004)".


    //Unsupported feature: Property Modification (Id) on "FormatNoText(PROCEDURE 1500003).Tens(Variable 1500005)".


    //Unsupported feature: Property Modification (Id) on "FormatNoText(PROCEDURE 1500003).Hundreds(Variable 1500006)".


    //Unsupported feature: Property Modification (Id) on "FormatNoText(PROCEDURE 1500003).Exponent(Variable 1500007)".


    //Unsupported feature: Property Modification (Id) on "FormatNoText(PROCEDURE 1500003).NoTextIndex(Variable 1500008)".


    //Unsupported feature: Property Modification (Id) on "ShowLineComments(PROCEDURE 62).PurchCommentLine(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "ShowLineComments(PROCEDURE 62).PurchCommentSheet(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "SetDefaultQuantity(PROCEDURE 63).PurchSetup(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "UpdatePrePaymentAmounts(PROCEDURE 65).ReceiptLine(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "UpdatePrePaymentAmounts(PROCEDURE 65).PurchOrderLine(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "ZeroAmountLine(PROCEDURE 66).QtyType(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "FormatNoTextTH(PROCEDURE 1500002).NoText(Parameter 1500000)".


    //Unsupported feature: Deletion (ParameterCollection) on "FormatNoTextTH(PROCEDURE 1500002).No(Parameter 1500001)".


    //Unsupported feature: Deletion (ParameterCollection) on "FormatNoTextTH(PROCEDURE 1500002).CurrencyCode(Parameter 1500002)".


    //Unsupported feature: Property Modification (Id) on "FormatNoTextTH(PROCEDURE 1500002).PrintExponent(Variable 1500003)".


    //Unsupported feature: Property Modification (Id) on "FormatNoTextTH(PROCEDURE 1500002).Ones(Variable 1500004)".


    //Unsupported feature: Property Modification (Id) on "FormatNoTextTH(PROCEDURE 1500002).Tens(Variable 1500005)".


    //Unsupported feature: Property Modification (Id) on "FormatNoTextTH(PROCEDURE 1500002).Hundreds(Variable 1500006)".


    //Unsupported feature: Property Modification (Id) on "FormatNoTextTH(PROCEDURE 1500002).Exponent(Variable 1500007)".


    //Unsupported feature: Property Modification (Id) on "FormatNoTextTH(PROCEDURE 1500002).NoTextIndex(Variable 1500008)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddToNoText(PROCEDURE 1500004).NoText(Parameter 1500000)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddToNoText(PROCEDURE 1500004).NoTextIndex(Parameter 1500001)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddToNoText(PROCEDURE 1500004).PrintExponent(Parameter 1500002)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddToNoText(PROCEDURE 1500004).AddText(Parameter 1500003)".



    //Unsupported feature: Property Modification (Id) on ""No."(Field 6).OnValidate.ICPartner(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"No." : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"No." : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""No."(Field 6).OnValidate.ItemCrossReference(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //"No." : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"No." : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""No."(Field 6).OnValidate.PrepmtMgt(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //"No." : 1002;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"No." : 1000000002;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Job No."(Field 45).OnValidate.Job(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Job No." : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Job No." : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Outstanding Amount"(Field 57).OnValidate.Currency2(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Outstanding Amount" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Outstanding Amount" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Amt. Rcd. Not Invoiced"(Field 59).OnValidate.Currency2(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Amt. Rcd. Not Invoiced" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Amt. Rcd. Not Invoiced" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""IC Partner Reference"(Field 108).OnLookup.ICGLAccount(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"IC Partner Reference" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"IC Partner Reference" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""IC Partner Reference"(Field 108).OnLookup.ItemCrossReference(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //"IC Partner Reference" : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"IC Partner Reference" : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""IC Partner Reference"(Field 108).OnLookup.ItemVendorCatalog(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //"IC Partner Reference" : 1003;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"IC Partner Reference" : 1000000002;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Prepayment %"(Field 109).OnValidate.GenPostingSetup(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Prepayment %" : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Prepayment %" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Prepayment %"(Field 109).OnValidate.GLAcc(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Prepayment %" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Prepayment %" : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Bin Code"(Field 5403).OnLookup.WMSManagement(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Bin Code" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Bin Code" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Bin Code"(Field 5403).OnLookup.BinCode(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Bin Code" : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Bin Code" : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Bin Code"(Field 5403).OnValidate.WMSManagement(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Bin Code" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Bin Code" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Unit of Measure Code"(Field 5407).OnValidate.UnitOfMeasureTranslation(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Unit of Measure Code" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Unit of Measure Code" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Cross-Reference No."(Field 5705).OnValidate.ReturnedCrossRef(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Cross-Reference No." : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Cross-Reference No." : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Return Shpd. Not Invd."(Field 5807).OnValidate.Currency2(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Return Shpd. Not Invd." : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Return Shpd. Not Invd." : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Operation No."(Field 99000751).OnValidate.ProdOrderRtngLine(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Operation No." : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Operation No." : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "OnDelete.DocDim(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //OnDelete.DocDim : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnDelete.DocDim : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "OnDelete.PurchCommentLine(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //OnDelete.PurchCommentLine : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnDelete.PurchCommentLine : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "OnInsert.DocDim(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //OnInsert.DocDim : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnInsert.DocDim : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text000(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text001(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text002(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : 1002;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : 1000000002;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text003(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : 1003;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : 1000000003;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text004(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : 1004;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : 1000000004;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text006(Variable 1005)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : 1005;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : 1000000005;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text007(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : 1006;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : 1000000006;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text008(Variable 1007)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : 1007;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : 1000000007;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text009(Variable 1008)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : 1008;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : 1000000008;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text010(Variable 1009)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : 1009;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : 1000000009;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text011(Variable 1010)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : 1010;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : 1000000010;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text012(Variable 1011)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : 1011;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : 1000000011;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text014(Variable 1012)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : 1012;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : 1000000012;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text016(Variable 1014)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : 1014;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : 1000000013;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text017(Variable 1015)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : 1015;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : 1000000014;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text018(Variable 1016)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : 1016;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : 1000000015;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text020(Variable 1018)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : 1018;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : 1000000016;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text021(Variable 1019)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : 1019;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : 1000000017;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text022(Variable 1020)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : 1020;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : 1000000018;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text023(Variable 1072)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text023 : 1072;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text023 : 1000000019;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text029(Variable 1077)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : 1077;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : 1000000020;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text030(Variable 1076)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text030 : 1076;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text030 : 1000000021;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text031(Variable 1056)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text031 : 1056;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text031 : 1000000022;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text032(Variable 1017)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text032 : 1017;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text032 : 1000000023;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text033(Variable 1078)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text033 : 1078;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text033 : 1000000024;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text034(Variable 1079)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text034 : 1079;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text034 : 1000000025;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text035(Variable 1048)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text035 : 1048;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text035 : 1000000026;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text036(Variable 1081)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text036 : 1081;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text036 : 1000000027;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text037(Variable 1082)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text037 : 1082;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text037 : 1000000028;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text038(Variable 1083)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text038 : 1083;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text038 : 1000000029;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text039(Variable 1084)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : 1084;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : 1000000030;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text99000000(Variable 1021)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000000 : 1021;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000000 : 1000000031;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchHeader(Variable 1022)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchHeader : 1022;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchHeader : 1000000032;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchLine2(Variable 1023)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchLine2 : 1023;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchLine2 : 1000000033;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TempPurchLine(Variable 1024)".

    //var
    //>>>> ORIGINAL VALUE:
    //TempPurchLine : 1024;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TempPurchLine : 1000000034;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GLAcc(Variable 1025)".

    //var
    //>>>> ORIGINAL VALUE:
    //GLAcc : 1025;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GLAcc : 1000000035;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Item(Variable 1026)".

    //var
    //>>>> ORIGINAL VALUE:
    //Item : 1026;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Item : 1000000036;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Currency(Variable 1027)".

    //var
    //>>>> ORIGINAL VALUE:
    //Currency : 1027;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Currency : 1000000037;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CurrExchRate(Variable 1028)".

    //var
    //>>>> ORIGINAL VALUE:
    //CurrExchRate : 1028;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CurrExchRate : 1000000038;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemTranslation(Variable 1029)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemTranslation : 1029;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemTranslation : 1000000039;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SalesOrderLine(Variable 1033)".

    //var
    //>>>> ORIGINAL VALUE:
    //SalesOrderLine : 1033;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesOrderLine : 1000000040;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "VATPostingSetup(Variable 1034)".

    //var
    //>>>> ORIGINAL VALUE:
    //VATPostingSetup : 1034;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VATPostingSetup : 1000000041;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "StdTxt(Variable 1035)".

    //var
    //>>>> ORIGINAL VALUE:
    //StdTxt : 1035;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //StdTxt : 1000000042;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "FA(Variable 1036)".

    //var
    //>>>> ORIGINAL VALUE:
    //FA : 1036;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //FA : 1000000043;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "FADeprBook(Variable 1037)".

    //var
    //>>>> ORIGINAL VALUE:
    //FADeprBook : 1037;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //FADeprBook : 1000000044;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "FASetup(Variable 1038)".

    //var
    //>>>> ORIGINAL VALUE:
    //FASetup : 1038;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //FASetup : 1000000045;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GenBusPostingGrp(Variable 1039)".

    //var
    //>>>> ORIGINAL VALUE:
    //GenBusPostingGrp : 1039;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GenBusPostingGrp : 1000000046;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GenProdPostingGrp(Variable 1040)".

    //var
    //>>>> ORIGINAL VALUE:
    //GenProdPostingGrp : 1040;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GenProdPostingGrp : 1000000047;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ReservEntry(Variable 1041)".

    //var
    //>>>> ORIGINAL VALUE:
    //ReservEntry : 1041;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReservEntry : 1000000048;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "UnitOfMeasure(Variable 1043)".

    //var
    //>>>> ORIGINAL VALUE:
    //UnitOfMeasure : 1043;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UnitOfMeasure : 1000000049;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemCharge(Variable 1044)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemCharge : 1044;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemCharge : 1000000050;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemChargeAssgntPurch(Variable 1045)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemChargeAssgntPurch : 1045;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemChargeAssgntPurch : 1000000051;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SKU(Variable 1046)".

    //var
    //>>>> ORIGINAL VALUE:
    //SKU : 1046;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SKU : 1000000052;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "WorkCenter(Variable 1047)".

    //var
    //>>>> ORIGINAL VALUE:
    //WorkCenter : 1047;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WorkCenter : 1000000053;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchasingCode(Variable 1049)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchasingCode : 1049;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchasingCode : 1000000054;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "InvtSetup(Variable 1050)".

    //var
    //>>>> ORIGINAL VALUE:
    //InvtSetup : 1050;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvtSetup : 1000000055;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Location(Variable 1051)".

    //var
    //>>>> ORIGINAL VALUE:
    //Location : 1051;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Location : 1000000056;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GLSetup(Variable 1074)".

    //var
    //>>>> ORIGINAL VALUE:
    //GLSetup : 1074;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GLSetup : 1000000057;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ReturnReason(Variable 1068)".

    //var
    //>>>> ORIGINAL VALUE:
    //ReturnReason : 1068;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReturnReason : 1000000058;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemVend(Variable 1031)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemVend : 1031;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemVend : 1000000059;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CalChange(Variable 1062)".

    //var
    //>>>> ORIGINAL VALUE:
    //CalChange : 1062;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalChange : 1000000060;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "JobJnlLine(Variable 1071)".

    //var
    //>>>> ORIGINAL VALUE:
    //JobJnlLine : 1071;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //JobJnlLine : 1000000061;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Reservation(Variable 1052)".

    //var
    //>>>> ORIGINAL VALUE:
    //Reservation : 1052;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Reservation : 1000000062;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemAvailByDate(Variable 1053)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemAvailByDate : 1053;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemAvailByDate : 1000000063;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemAvailByVar(Variable 1054)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemAvailByVar : 1054;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemAvailByVar : 1000000064;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemAvailByLoc(Variable 1055)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemAvailByLoc : 1055;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemAvailByLoc : 1000000065;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SalesTaxCalculate(Variable 1057)".

    //var
    //>>>> ORIGINAL VALUE:
    //SalesTaxCalculate : 1057;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesTaxCalculate : 1000000066;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ReservEngineMgt(Variable 1058)".

    //var
    //>>>> ORIGINAL VALUE:
    //ReservEngineMgt : 1058;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReservEngineMgt : 1000000067;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ReservePurchLine(Variable 1059)".

    //var
    //>>>> ORIGINAL VALUE:
    //ReservePurchLine : 1059;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReservePurchLine : 1000000068;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "UOMMgt(Variable 1060)".

    //var
    //>>>> ORIGINAL VALUE:
    //UOMMgt : 1060;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UOMMgt : 1000000069;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "AddOnIntegrMgt(Variable 1061)".

    //var
    //>>>> ORIGINAL VALUE:
    //AddOnIntegrMgt : 1061;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AddOnIntegrMgt : 1000000070;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DimMgt(Variable 1064)".

    //var
    //>>>> ORIGINAL VALUE:
    //DimMgt : 1064;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DimMgt : 1000000071;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DistIntegration(Variable 1065)".

    //var
    //>>>> ORIGINAL VALUE:
    //DistIntegration : 1065;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DistIntegration : 1000000072;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "NonstockItemMgt(Variable 1066)".

    //var
    //>>>> ORIGINAL VALUE:
    //NonstockItemMgt : 1066;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NonstockItemMgt : 1000000073;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "WhseValidateSourceLine(Variable 1067)".

    //var
    //>>>> ORIGINAL VALUE:
    //WhseValidateSourceLine : 1067;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WhseValidateSourceLine : 1000000074;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "LeadTimeMgt(Variable 1069)".

    //var
    //>>>> ORIGINAL VALUE:
    //LeadTimeMgt : 1069;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LeadTimeMgt : 1000000075;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchPriceCalcMgt(Variable 1030)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchPriceCalcMgt : 1030;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchPriceCalcMgt : 1000000076;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CalendarMgmt(Variable 1032)".

    //var
    //>>>> ORIGINAL VALUE:
    //CalendarMgmt : 1032;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalendarMgmt : 1000000077;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CheckDateConflict(Variable 1013)".

    //var
    //>>>> ORIGINAL VALUE:
    //CheckDateConflict : 1013;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CheckDateConflict : 1000000078;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TrackingBlocked(Variable 1070)".

    //var
    //>>>> ORIGINAL VALUE:
    //TrackingBlocked : 1070;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TrackingBlocked : 1000000079;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "StatusCheckSuspended(Variable 1073)".

    //var
    //>>>> ORIGINAL VALUE:
    //StatusCheckSuspended : 1073;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //StatusCheckSuspended : 1000000080;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GLSetupRead(Variable 1075)".

    //var
    //>>>> ORIGINAL VALUE:
    //GLSetupRead : 1075;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GLSetupRead : 1000000081;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "UnitCostCurrency(Variable 1063)".

    //var
    //>>>> ORIGINAL VALUE:
    //UnitCostCurrency : 1063;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UnitCostCurrency : 1000000082;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "UpdateFromVAT(Variable 1087)".

    //var
    //>>>> ORIGINAL VALUE:
    //UpdateFromVAT : 1087;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdateFromVAT : 1000000083;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text042(Variable 1088)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text042 : 1088;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text042 : 1000000084;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text043(Variable 1089)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text043 : 1089;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text043 : 1000000085;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text044(Variable 1080)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text044 : 1080;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text044 : 1000000086;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "AddCurrency(Variable 1500067)".

    //var
    //>>>> ORIGINAL VALUE:
    //AddCurrency : 1500067;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AddCurrency : 1000000087;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "BASManagement(Variable 1500000)".

    //var
    //>>>> ORIGINAL VALUE:
    //BASManagement : 1500000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BASManagement : 1000000088;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500000(Variable 1500063)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500000 : 1500063;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500000 : 1000000089;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500001(Variable 1500062)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500001 : 1500062;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500001 : 1000000090;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500002(Variable 1500061)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500002 : 1500061;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500002 : 1000000091;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500003(Variable 1500060)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500003 : 1500060;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500003 : 1000000092;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500004(Variable 1500059)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500004 : 1500059;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500004 : 1000000093;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500005(Variable 1500058)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500005 : 1500058;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500005 : 1000000094;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500006(Variable 1500057)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500006 : 1500057;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500006 : 1000000095;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500007(Variable 1500056)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500007 : 1500056;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500007 : 1000000096;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500008(Variable 1500055)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500008 : 1500055;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500008 : 1000000097;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500009(Variable 1500054)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500009 : 1500054;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500009 : 1000000098;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500010(Variable 1500053)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500010 : 1500053;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500010 : 1000000099;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500011(Variable 1500052)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500011 : 1500052;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500011 : 1000000100;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500012(Variable 1500051)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500012 : 1500051;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500012 : 1000000101;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500013(Variable 1500050)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500013 : 1500050;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500013 : 1000000102;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500014(Variable 1500049)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500014 : 1500049;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500014 : 1000000103;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500015(Variable 1500048)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500015 : 1500048;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500015 : 1000000104;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500016(Variable 1500047)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500016 : 1500047;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500016 : 1000000105;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500017(Variable 1500046)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500017 : 1500046;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500017 : 1000000106;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500018(Variable 1500045)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500018 : 1500045;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500018 : 1000000107;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500019(Variable 1500044)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500019 : 1500044;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500019 : 1000000108;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500020(Variable 1500043)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500020 : 1500043;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500020 : 1000000109;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500021(Variable 1500042)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500021 : 1500042;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500021 : 1000000110;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500022(Variable 1500041)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500022 : 1500041;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500022 : 1000000111;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500023(Variable 1500040)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500023 : 1500040;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500023 : 1000000112;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500024(Variable 1500039)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500024 : 1500039;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500024 : 1000000113;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500025(Variable 1500038)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500025 : 1500038;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500025 : 1000000114;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500026(Variable 1500037)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500026 : 1500037;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500026 : 1000000115;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500027(Variable 1500036)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500027 : 1500036;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500027 : 1000000116;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500028(Variable 1500035)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500028 : 1500035;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500028 : 1000000117;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500029(Variable 1500034)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500029 : 1500034;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500029 : 1000000118;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500030(Variable 1500033)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500030 : 1500033;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500030 : 1000000119;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500031(Variable 1500032)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500031 : 1500032;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500031 : 1000000120;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500032(Variable 1500031)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500032 : 1500031;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500032 : 1000000121;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500033(Variable 1500030)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500033 : 1500030;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500033 : 1000000122;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500034(Variable 1500029)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500034 : 1500029;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500034 : 1000000123;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500035(Variable 1500028)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500035 : 1500028;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500035 : 1000000124;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500036(Variable 1500027)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500036 : 1500027;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500036 : 1000000125;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500037(Variable 1500026)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500037 : 1500026;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500037 : 1000000126;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500038(Variable 1500025)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500038 : 1500025;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500038 : 1000000127;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500039(Variable 1500024)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500039 : 1500024;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500039 : 1000000128;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500040(Variable 1500023)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500040 : 1500023;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500040 : 1000000129;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500041(Variable 1500022)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500041 : 1500022;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500041 : 1000000130;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500042(Variable 1500021)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500042 : 1500021;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500042 : 1000000131;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500043(Variable 1500020)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500043 : 1500020;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500043 : 1000000132;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500044(Variable 1500019)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500044 : 1500019;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500044 : 1000000133;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500045(Variable 1500018)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500045 : 1500018;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500045 : 1000000134;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500046(Variable 1500017)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500046 : 1500017;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500046 : 1000000135;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500047(Variable 1500016)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500047 : 1500016;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500047 : 1000000136;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500048(Variable 1500015)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500048 : 1500015;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500048 : 1000000137;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500049(Variable 1500014)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500049 : 1500014;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500049 : 1000000138;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500050(Variable 1500013)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500050 : 1500013;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500050 : 1000000139;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500051(Variable 1500012)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500051 : 1500012;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500051 : 1000000140;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500052(Variable 1500011)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500052 : 1500011;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500052 : 1000000141;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500053(Variable 1500010)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500053 : 1500010;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500053 : 1000000142;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500054(Variable 1500009)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500054 : 1500009;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500054 : 1000000143;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500055(Variable 1500008)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500055 : 1500008;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500055 : 1000000144;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500056(Variable 1500007)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500056 : 1500007;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500056 : 1000000145;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500057(Variable 1500006)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500057 : 1500006;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500057 : 1000000146;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500058(Variable 1500005)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500058 : 1500005;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500058 : 1000000147;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500059(Variable 1500004)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500059 : 1500004;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500059 : 1000000149;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500060(Variable 1500003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500060 : 1500003;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500060 : 1000000151;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500061(Variable 1500002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500061 : 1500002;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500061 : 1000000152;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text1500062(Variable 1500001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text1500062 : 1500001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text1500062 : 1000000153;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "OnesText(Variable 1500066)".

    //var
    //>>>> ORIGINAL VALUE:
    //OnesText : 1500066;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnesText : 1000000154;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TensText(Variable 1500065)".

    //var
    //>>>> ORIGINAL VALUE:
    //TensText : 1500065;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TensText : 1000000155;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ExponentText(Variable 1500064)".

    //var
    //>>>> ORIGINAL VALUE:
    //ExponentText : 1500064;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ExponentText : 1000000156;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CurrencyFactor(Variable 1500068)".

    //var
    //>>>> ORIGINAL VALUE:
    //CurrencyFactor : 1500068;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CurrencyFactor : 1000000157;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "RecPurchLine(Variable 1500069)".

    //var
    //>>>> ORIGINAL VALUE:
    //RecPurchLine : 1500069;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RecPurchLine : 1000000158;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "VATAmt(Variable 1500070)".

    //var
    //>>>> ORIGINAL VALUE:
    //VATAmt : 1500070;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VATAmt : 1000000159;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "VATBase(Variable 1500071)".

    //var
    //>>>> ORIGINAL VALUE:
    //VATBase : 1500071;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VATBase : 1000000160;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DiscAmt(Variable 1500073)".

    //var
    //>>>> ORIGINAL VALUE:
    //DiscAmt : 1500073;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DiscAmt : 1000000161;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DiscAmt1(Variable 1500072)".

    //var
    //>>>> ORIGINAL VALUE:
    //DiscAmt1 : 1500072;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DiscAmt1 : 1000000162;
    //Variable type has not been exported.

    var
        Text50000: label 'Announce price for item no. %1 line no. %2 has not been set.';

    var
        ItemVATAnnPrice: Record "Item VAT Announce Price";
}

