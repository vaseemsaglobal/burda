TableExtension 50009 tableextension50009 extends Item
{
    fields
    {
        field(50000; "Magazine Code"; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Sub Product";
        }
        field(50001; "Volume No."; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = Volume;
        }
        field(50002; "Issue No."; Code[20])
        {
            Description = 'Burda1.00';
            Editable = false;
            TableRelation = "Issue No.";
        }
        field(50003; "Issue Date"; Date)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50004; Closed; Boolean)
        {
            Description = 'Burda1.00';
        }
        field(50005; "Last Pick-up Date"; Date)
        {
            Description = 'Burda1.00';
            Editable = false;
        }
        field(50007; "Item Type"; Option)
        {
            Description = 'Burda1.00';
            OptionMembers = " ",Magazine,Premium;
        }
    }
    keys
    {
        key(Key1; "Item Type", "Magazine Code")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: MagazineVolumeIssue)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemJnlLine.SETRANGE("Item No.","No.");
    IF ItemJnlLine.FIND('-') THEN
      ERROR(Text023,TABLECAPTION,"No.",ItemJnlLine.TABLECAPTION);
    #4..159
    BinContent.DELETEALL;

    MobSalesMgt.ItemOnDelete(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..162

    //KKE : #003 +
    IF "Item Type" = "Item Type"::Magazine THEN BEGIN
      MagazineVolumeIssue.GET("Magazine Code","Volume No.","Issue No.");
      IF MagazineVolumeIssue."Magazine Item No." = "No." THEN BEGIN
        MagazineVolumeIssue."Create as Item" := FALSE;
        MagazineVolumeIssue."Magazine Item No." := '';
        MagazineVolumeIssue.MODIFY;
      END;
    END;
    //KKE : #003 +
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: ItemVend) (ParameterCollection) on "FindItemVend(PROCEDURE 5)".


    //Unsupported feature: Parameter Insertion (Parameter: LocationCode) (ParameterCollection) on "FindItemVend(PROCEDURE 5)".


    //Unsupported feature: Parameter Insertion (Parameter: FieldNumber) (ParameterCollection) on "ValidateShortcutDimCode(PROCEDURE 8)".


    //Unsupported feature: Parameter Insertion (Parameter: ShortcutDimCode) (ParameterCollection) on "ValidateShortcutDimCode(PROCEDURE 8)".


    //Unsupported feature: Parameter Insertion (Parameter: CurrentFieldName) (ParameterCollection) on "TestNoEntriesExist(PROCEDURE 1006)".


    //Unsupported feature: Parameter Insertion (Parameter: CurrentFieldName) (ParameterCollection) on "TestNoOpenEntriesExist(PROCEDURE 4)".


    //Unsupported feature: Parameter Insertion (Parameter: Item) (ParameterCollection) on "ItemSKUGet(PROCEDURE 11)".


    //Unsupported feature: Parameter Insertion (Parameter: LocationCode) (ParameterCollection) on "ItemSKUGet(PROCEDURE 11)".


    //Unsupported feature: Parameter Insertion (Parameter: VariantCode) (ParameterCollection) on "ItemSKUGet(PROCEDURE 11)".


    //Unsupported feature: Parameter Insertion (Parameter: ItemNo) (ParameterCollection) on "CheckSerialNoQty(PROCEDURE 15)".


    //Unsupported feature: Parameter Insertion (Parameter: FieldName) (ParameterCollection) on "CheckSerialNoQty(PROCEDURE 15)".


    //Unsupported feature: Parameter Insertion (Parameter: Quantity) (ParameterCollection) on "CheckSerialNoQty(PROCEDURE 15)".


    //Unsupported feature: Parameter Insertion (Parameter: ItemNo) (ParameterCollection) on "CheckForProductionOutput(PROCEDURE 17)".


    procedure GetItemName(ItemNo: Code[20]): Text[30]
    var
        Item: Record Item;
    begin
        //KKE : #001 +
        if Item.Get(ItemNo) then
            exit(Item.Description);
        exit('');
        //KKE : #001 -
    end;

    //Unsupported feature: Deletion (ParameterCollection) on "FindItemVend(PROCEDURE 5).ItemVend(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "FindItemVend(PROCEDURE 5).LocationCode(Parameter 1002)".


    //Unsupported feature: Property Modification (Id) on "FindItemVend(PROCEDURE 5).GetPlanningParameters(Variable 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "ValidateShortcutDimCode(PROCEDURE 8).FieldNumber(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "ValidateShortcutDimCode(PROCEDURE 8).ShortcutDimCode(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "TestNoEntriesExist(PROCEDURE 1006).CurrentFieldName(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "TestNoEntriesExist(PROCEDURE 1006).ItemLedgEntry(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "TestNoOpenEntriesExist(PROCEDURE 4).CurrentFieldName(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "TestNoOpenEntriesExist(PROCEDURE 4).ItemLedgEntry(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "ItemSKUGet(PROCEDURE 11).Item(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "ItemSKUGet(PROCEDURE 11).LocationCode(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "ItemSKUGet(PROCEDURE 11).VariantCode(Parameter 1002)".


    //Unsupported feature: Property Modification (Id) on "ItemSKUGet(PROCEDURE 11).SKU(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "PlanningTransferShptQty(PROCEDURE 9).ReqLine(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "PlanningReleaseQty(PROCEDURE 3).ReqLine(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "CalcSalesReturn(PROCEDURE 10).SalesLine(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "CalcResvQtyOnSalesReturn(PROCEDURE 13).ReservationEntry(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "CalcPurchReturn(PROCEDURE 12).PurchLine(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "CalcResvQtyOnPurchReturn(PROCEDURE 16).ReservationEntry(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CheckSerialNoQty(PROCEDURE 15).ItemNo(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CheckSerialNoQty(PROCEDURE 15).FieldName(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CheckSerialNoQty(PROCEDURE 15).Quantity(Parameter 1002)".


    //Unsupported feature: Property Modification (Id) on "CheckSerialNoQty(PROCEDURE 15).ItemRec(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "CheckSerialNoQty(PROCEDURE 15).ItemTrackingCode3(Variable 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "CheckForProductionOutput(PROCEDURE 17).ItemNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "CheckForProductionOutput(PROCEDURE 17).ItemLedgEntry(Variable 1001)".



    //Unsupported feature: Property Modification (Id) on ""Price Includes VAT"(Field 87).OnValidate.VATPostingSetup(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Price Includes VAT" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Price Includes VAT" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Service Item Group"(Field 5900).OnValidate.ResSkill(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Service Item Group" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Service Item Group" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Phys Invt Counting Period Code"(Field 7380).OnValidate.PhysInvtCountPeriod(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Phys Invt Counting Period Code" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Phys Invt Counting Period Code" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Phys Invt Counting Period Code"(Field 7380).OnValidate.PhysInvtCountPeriodMgt(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Phys Invt Counting Period Code" : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Phys Invt Counting Period Code" : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Kit BOM No."(Field 25000).OnLookup.ProdBOMHeader(Variable 1462000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Kit BOM No." : 1462000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Kit BOM No." : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Kit Disassembly BOM No."(Field 25001).OnLookup.ProdBOMHeader(Variable 1462000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Kit Disassembly BOM No." : 1462000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Kit Disassembly BOM No." : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Production BOM No."(Field 99000751).OnLookup.ProdBOMHeader(Variable 1462000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Production BOM No." : 1462000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Production BOM No." : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Production BOM No."(Field 99000751).OnValidate.MfgSetup(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Production BOM No." : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Production BOM No." : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Production BOM No."(Field 99000751).OnValidate.ProdBOMHeader(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Production BOM No." : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Production BOM No." : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Production BOM No."(Field 99000751).OnValidate.CalcLowLevel(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Production BOM No." : 1002;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Production BOM No." : 1000000002;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Order Tracking Policy"(Field 99000773).OnValidate.ReservEntry(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Order Tracking Policy" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Order Tracking Policy" : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Order Tracking Policy"(Field 99000773).OnValidate.ActionMessageEntry(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Order Tracking Policy" : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Order Tracking Policy" : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "OnDelete.BinContent(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //OnDelete.BinContent : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnDelete.BinContent : 1000000001;
    //Variable type has not been exported.

    var
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";


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


    //Unsupported feature: Property Modification (Id) on "Text003(Variable 1057)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : 1057;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : 1000000003;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text004(Variable 1064)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : 1064;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : 1000000004;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text006(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : 1003;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : 1000000005;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text007(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : 1004;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : 1000000006;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text008(Variable 1005)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : 1005;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : 1000000007;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text014(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : 1006;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : 1000000008;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text016(Variable 1008)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : 1008;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : 1000000009;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text017(Variable 1009)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : 1009;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : 1000000010;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text018(Variable 1010)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : 1010;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : 1000000011;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text019(Variable 1011)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : 1011;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : 1000000012;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text020(Variable 1012)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : 1012;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : 1000000013;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text021(Variable 1013)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : 1013;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : 1000000014;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text022(Variable 1014)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : 1014;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : 1000000015;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GLSetup(Variable 1053)".

    //var
    //>>>> ORIGINAL VALUE:
    //GLSetup : 1053;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GLSetup : 1000000016;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "InvtSetup(Variable 1015)".

    //var
    //>>>> ORIGINAL VALUE:
    //InvtSetup : 1015;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvtSetup : 1000000017;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text023(Variable 1066)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text023 : 1066;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text023 : 1000000018;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text024(Variable 1072)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text024 : 1072;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text024 : 1000000019;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text025(Variable 1055)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text025 : 1055;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text025 : 1000000020;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text026(Variable 1077)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text026 : 1077;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text026 : 1000000021;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text7380(Variable 1058)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text7380 : 1058;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text7380 : 1000000022;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text7381(Variable 1056)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text7381 : 1056;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text7381 : 1000000023;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text99000000(Variable 1017)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000000 : 1017;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000000 : 1000000024;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CommentLine(Variable 1018)".

    //var
    //>>>> ORIGINAL VALUE:
    //CommentLine : 1018;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CommentLine : 1000000025;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text99000001(Variable 1019)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000001 : 1019;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000001 : 1000000026;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemVend(Variable 1020)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemVend : 1020;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemVend : 1000000027;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text99000002(Variable 1021)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000002 : 1021;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000002 : 1000000028;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SalesPrice(Variable 1022)".

    //var
    //>>>> ORIGINAL VALUE:
    //SalesPrice : 1022;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesPrice : 1000000029;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SalesLineDisc(Variable 1059)".

    //var
    //>>>> ORIGINAL VALUE:
    //SalesLineDisc : 1059;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesLineDisc : 1000000030;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SalesPrepmtPct(Variable 1051)".

    //var
    //>>>> ORIGINAL VALUE:
    //SalesPrepmtPct : 1051;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesPrepmtPct : 1000000031;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchPrice(Variable 1060)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchPrice : 1060;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchPrice : 1000000032;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchLineDisc(Variable 1061)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchLineDisc : 1061;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchLineDisc : 1000000033;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchPrepmtPct(Variable 1076)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchPrepmtPct : 1076;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchPrepmtPct : 1000000034;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemTranslation(Variable 1023)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemTranslation : 1023;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemTranslation : 1000000035;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchOrderLine(Variable 1025)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchOrderLine : 1025;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchOrderLine : 1000000036;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SalesOrderLine(Variable 1026)".

    //var
    //>>>> ORIGINAL VALUE:
    //SalesOrderLine : 1026;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesOrderLine : 1000000037;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "VATPostingSetup(Variable 1027)".

    //var
    //>>>> ORIGINAL VALUE:
    //VATPostingSetup : 1027;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VATPostingSetup : 1000000038;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ExtTextHeader(Variable 1028)".

    //var
    //>>>> ORIGINAL VALUE:
    //ExtTextHeader : 1028;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ExtTextHeader : 1000000039;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GenProdPostingGrp(Variable 1029)".

    //var
    //>>>> ORIGINAL VALUE:
    //GenProdPostingGrp : 1029;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GenProdPostingGrp : 1000000040;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemUnitOfMeasure(Variable 1030)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemUnitOfMeasure : 1030;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemUnitOfMeasure : 1000000041;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemVariant(Variable 1031)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemVariant : 1031;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemVariant : 1000000042;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemJnlLine(Variable 1007)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemJnlLine : 1007;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemJnlLine : 1000000043;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ProdOrderLine(Variable 1032)".

    //var
    //>>>> ORIGINAL VALUE:
    //ProdOrderLine : 1032;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ProdOrderLine : 1000000044;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ProdOrderComp(Variable 1033)".

    //var
    //>>>> ORIGINAL VALUE:
    //ProdOrderComp : 1033;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ProdOrderComp : 1000000045;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PlanningAssignment(Variable 1035)".

    //var
    //>>>> ORIGINAL VALUE:
    //PlanningAssignment : 1035;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PlanningAssignment : 1000000046;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SKU(Variable 1036)".

    //var
    //>>>> ORIGINAL VALUE:
    //SKU : 1036;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SKU : 1000000047;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemTrackingCode(Variable 1037)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemTrackingCode : 1037;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemTrackingCode : 1000000048;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemTrackingCode2(Variable 1038)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemTrackingCode2 : 1038;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemTrackingCode2 : 1000000049;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ServInvLine(Variable 1039)".

    //var
    //>>>> ORIGINAL VALUE:
    //ServInvLine : 1039;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ServInvLine : 1000000050;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemSub(Variable 1040)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemSub : 1040;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemSub : 1000000051;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemCategory(Variable 1041)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemCategory : 1041;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemCategory : 1000000052;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TransLine(Variable 1042)".

    //var
    //>>>> ORIGINAL VALUE:
    //TransLine : 1042;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TransLine : 1000000053;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Vend(Variable 1016)".

    //var
    //>>>> ORIGINAL VALUE:
    //Vend : 1016;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Vend : 1000000054;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "NonstockItem(Variable 1034)".

    //var
    //>>>> ORIGINAL VALUE:
    //NonstockItem : 1034;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NonstockItem : 1000000055;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ProdBOMHeader(Variable 1062)".

    //var
    //>>>> ORIGINAL VALUE:
    //ProdBOMHeader : 1062;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ProdBOMHeader : 1000000056;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ProdBOMLine(Variable 1063)".

    //var
    //>>>> ORIGINAL VALUE:
    //ProdBOMLine : 1063;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ProdBOMLine : 1000000057;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemIdent(Variable 1065)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemIdent : 1065;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemIdent : 1000000058;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "RequisitionLine(Variable 1067)".

    //var
    //>>>> ORIGINAL VALUE:
    //RequisitionLine : 1067;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RequisitionLine : 1000000059;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemBudgetEntry(Variable 1075)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemBudgetEntry : 1075;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemBudgetEntry : 1000000060;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemAnalysisViewEntry(Variable 1074)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemAnalysisViewEntry : 1074;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemAnalysisViewEntry : 1000000061;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemAnalysisBudgViewEntry(Variable 1073)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemAnalysisBudgViewEntry : 1073;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemAnalysisBudgViewEntry : 1000000062;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "NoSeriesMgt(Variable 1043)".

    //var
    //>>>> ORIGINAL VALUE:
    //NoSeriesMgt : 1043;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoSeriesMgt : 1000000063;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "MoveEntries(Variable 1044)".

    //var
    //>>>> ORIGINAL VALUE:
    //MoveEntries : 1044;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MoveEntries : 1000000064;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DimMgt(Variable 1045)".

    //var
    //>>>> ORIGINAL VALUE:
    //DimMgt : 1045;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DimMgt : 1000000065;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "NonstockItemMgt(Variable 1046)".

    //var
    //>>>> ORIGINAL VALUE:
    //NonstockItemMgt : 1046;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NonstockItemMgt : 1000000066;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemCostMgt(Variable 1047)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemCostMgt : 1047;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemCostMgt : 1000000067;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ResSkillMgt(Variable 1071)".

    //var
    //>>>> ORIGINAL VALUE:
    //ResSkillMgt : 1071;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ResSkillMgt : 1000000068;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "MobSalesMgt(Variable 1054)".

    //var
    //>>>> ORIGINAL VALUE:
    //MobSalesMgt : 1054;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MobSalesMgt : 1000000069;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "HasInvtSetup(Variable 1049)".

    //var
    //>>>> ORIGINAL VALUE:
    //HasInvtSetup : 1049;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //HasInvtSetup : 1000000070;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TroubleshSetup(Variable 1050)".

    //var
    //>>>> ORIGINAL VALUE:
    //TroubleshSetup : 1050;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TroubleshSetup : 1000000071;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ServiceItem(Variable 1068)".

    //var
    //>>>> ORIGINAL VALUE:
    //ServiceItem : 1068;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ServiceItem : 1000000072;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ServiceContractLine(Variable 1069)".

    //var
    //>>>> ORIGINAL VALUE:
    //ServiceContractLine : 1069;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ServiceContractLine : 1000000073;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ServiceItemComponent(Variable 1070)".

    //var
    //>>>> ORIGINAL VALUE:
    //ServiceItemComponent : 1070;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ServiceItemComponent : 1000000074;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ProductGrp(Variable 1048)".

    //var
    //>>>> ORIGINAL VALUE:
    //ProductGrp : 1048;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ProductGrp : 1000000075;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GLSetupRead(Variable 1052)".

    //var
    //>>>> ORIGINAL VALUE:
    //GLSetupRead : 1052;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GLSetupRead : 1000000076;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text25000(Variable 1462000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text25000 : 1462000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text25000 : 1000000077;
    //Variable type has not been exported.
}

