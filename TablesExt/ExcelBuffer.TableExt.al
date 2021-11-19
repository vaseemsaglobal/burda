TableExtension 50051 tableextension50051 extends "Excel Buffer" 
{
    fields
    {
        field(50000;"Line Style";Integer)
        {
        }
        field(50001;"AutoFit Column";Boolean)
        {
        }
        field(50002;EdgeLeft;Boolean)
        {
        }
        field(50003;"Font Color Index";Integer)
        {
        }
        field(50004;"Blackground Color Index";Integer)
        {
        }
        field(50005;"Column Width";Decimal)
        {
        }
        field(50006;"Row Height";Decimal)
        {
        }
    }

    //Unsupported feature: Parameter Insertion (Parameter: FileName) (ParameterCollection) on "OpenBook(PROCEDURE 2)".


    //Unsupported feature: Parameter Insertion (Parameter: SheetName) (ParameterCollection) on "OpenBook(PROCEDURE 2)".


    //Unsupported feature: Parameter Insertion (Parameter: SheetName) (ParameterCollection) on "CreateSheet(PROCEDURE 5)".


    //Unsupported feature: Parameter Insertion (Parameter: ReportHeader) (ParameterCollection) on "CreateSheet(PROCEDURE 5)".


    //Unsupported feature: Parameter Insertion (Parameter: CompanyName) (ParameterCollection) on "CreateSheet(PROCEDURE 5)".


    //Unsupported feature: Parameter Insertion (Parameter: UserID2) (ParameterCollection) on "CreateSheet(PROCEDURE 5)".


    //Unsupported feature: Variable Insertion (Variable: XlEdgeLeft) (VariableCollection) on "CreateSheet(PROCEDURE 5)".


    //Unsupported feature: Variable Insertion (Variable: XlCenter) (VariableCollection) on "CreateSheet(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "CreateSheet(PROCEDURE 5)".

    //procedure CreateSheet();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Window.OPEN(
          Text005 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1,0);

        XlEdgeBottom := 9;
        XlContinuous := 1;
        XlLineStyleNone := -4142;
        #9..35
            IF Italic THEN
              XlWrkSht.Range(xlColID + xlRowID).Font.Italic := Italic;
            XlWrkSht.Range(xlColID + xlRowID).Borders.LineStyle := XlLineStyleNone;
            IF Underline THEN
              XlWrkSht.Range(xlColID + xlRowID).Borders.Item(XlEdgeBottom).LineStyle := XlContinuous;
          UNTIL NEXT = 0;
          XlWrkSht.Range(GetExcelReference(5) + ':' + xlColID + xlRowID).Columns.AutoFit;
        END;

        IF UseInfoSheed THEN BEGIN
          IF InfoExcelBuf.FIND('-') THEN BEGIN
            XlWrkSht := XlWrkBk.Worksheets.Add();
        #48..72
                XlWrkSht.Range(InfoExcelBuf.xlColID + InfoExcelBuf.xlRowID).Borders.Item(XlEdgeBottom).LineStyle :=
                 XlContinuous;
            UNTIL InfoExcelBuf.NEXT = 0;
            XlWrkSht.Range('A' + FORMAT(1) + ':' + xlColID + xlRowID).Columns.AutoFit;
          END;
        END;
        Window.CLOSE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        XlEdgeLeft := 7;   //KKE : #001
        XlCenter := -4108;  //KKE : #001
        #6..38
            //KKE : #002 +
            XlWrkSht.Range(xlColID + xlRowID).Interior.ColorIndex := "Blackground Color Index";
            XlWrkSht.Range(xlColID + xlRowID).Font.ColorIndex := "Font Color Index";
            //KKE : #002 -

            {---
            IF Underline THEN
              XlWrkSht.Range(xlColID + xlRowID).Borders.Item(XlEdgeBottom).LineStyle := XlContinuous;
            ---}

            //KKE : #001 +
            IF Underline THEN
              IF "Line Style" <> 0 THEN
                XlWrkSht.Range(xlColID + xlRowID).Borders.Item(XlEdgeBottom).LineStyle := "Line Style"
              ELSE
                XlWrkSht.Range(xlColID + xlRowID).Borders.Item(XlEdgeBottom).LineStyle := XlContinuous;
            IF EdgeLeft THEN
              XlWrkSht.Range(xlColID + xlRowID).Borders.Item(XlEdgeLeft).LineStyle := XlContinuous;
            IF "AutoFit Column" THEN
              XlWrkSht.Range(xlColID + FORMAT(1) + ':' + xlColID + xlRowID).Columns.AutoFit
            ELSE
              IF "Column Width" <> 0 THEN
                XlWrkSht.Range(xlColID + xlRowID).Columns.ColumnWidth := "Column Width";
            IF "Row Height" <> 0 THEN
              XlWrkSht.Range(xlColID + xlRowID).Rows.RowHeight := "Row Height";
            XlWrkSht.Range(xlColID + xlRowID).VerticalAlignment := XlCenter;
            //KKE : #001 -
          UNTIL NEXT = 0;
          //XlWrkSht.Range(GetExcelReference(5) + ':' + xlColID + xlRowID).Columns.AutoFit;
        END;
        #45..75
            IF "AutoFit Column" THEN  //KKE : #001
        #76..78

        {---
        XlWrkSht.Protect('arvato',TRUE,TRUE,TRUE,TRUE,FALSE,TRUE,TRUE);
        XlWrkSht.EnableSelection(1);
        //DrawingObjects:=True, Contents:=True, Scenarios:=True _
          //      , AllowFormattingColumns:=True, AllowFormattingRows:=True
        ---}  //Dummy plan

        Window.CLOSE;
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: RangeName) (ParameterCollection) on "CreateRangeName(PROCEDURE 9)".


    //Unsupported feature: Parameter Insertion (Parameter: FromColumnNo) (ParameterCollection) on "CreateRangeName(PROCEDURE 9)".


    //Unsupported feature: Parameter Insertion (Parameter: FromRowNo) (ParameterCollection) on "CreateRangeName(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "GiveUserControl(PROCEDURE 3)".

    //procedure GiveUserControl();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        XlApp.Visible(TRUE);
        XlApp.UserControl(TRUE);
        CLEAR(XlApp);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        XlApp.Visible(TRUE);
        XlApp.UserControl(FALSE);
        {---
        XlWrkBk.Protect('arvato',TRUE,FALSE);
        XlWrkSht.PrintPreview;
        ---}  //Dummy plan
        CLEAR(XlApp);
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: FileName) (ParameterCollection) on "SelectSheetsName(PROCEDURE 6)".


    //Unsupported feature: Parameter Insertion (Parameter: Filter) (ParameterCollection) on "FilterToFormula(PROCEDURE 7)".


    //Unsupported feature: Parameter Insertion (Parameter: Ref1) (ParameterCollection) on "FilterToFormula(PROCEDURE 7)".


    //Unsupported feature: Parameter Insertion (Parameter: Ref2) (ParameterCollection) on "FilterToFormula(PROCEDURE 7)".


    //Unsupported feature: ReturnValue Insertion (ReturnValue: Formula) (ReturnValueCollection) on "FilterToFormula(PROCEDURE 7)".


    //Unsupported feature: Parameter Insertion (Parameter: FormulaUnit) (ParameterCollection) on "NextValue(PROCEDURE 8)".


    //Unsupported feature: Parameter Insertion (Parameter: IsValue) (ParameterCollection) on "NextValue(PROCEDURE 8)".


    //Unsupported feature: Parameter Insertion (Parameter: j) (ParameterCollection) on "NextValue(PROCEDURE 8)".


    //Unsupported feature: Parameter Insertion (Parameter: Ref1) (ParameterCollection) on "SumIf(PROCEDURE 15)".


    //Unsupported feature: Parameter Insertion (Parameter: Operator) (ParameterCollection) on "SumIf(PROCEDURE 15)".


    //Unsupported feature: Parameter Insertion (Parameter: Value) (ParameterCollection) on "SumIf(PROCEDURE 15)".


    //Unsupported feature: Parameter Insertion (Parameter: Ref2) (ParameterCollection) on "SumIf(PROCEDURE 15)".


    //Unsupported feature: Parameter Insertion (Parameter: Which) (ParameterCollection) on "GetExcelReference(PROCEDURE 10)".


    //Unsupported feature: Parameter Insertion (Parameter: ExcelBuf) (ParameterCollection) on "ExportBudgetFilterToFormula(PROCEDURE 11)".


    //Unsupported feature: Parameter Insertion (Parameter: Text) (ParameterCollection) on "AddToFormula(PROCEDURE 12)".


    //Unsupported feature: Parameter Insertion (Parameter: LongFormula) (ParameterCollection) on "SetFormula(PROCEDURE 22)".


    //Unsupported feature: Parameter Insertion (Parameter: Value) (ParameterCollection) on "AddColumn(PROCEDURE 16)".


    //Unsupported feature: Parameter Insertion (Parameter: IsFormula) (ParameterCollection) on "AddColumn(PROCEDURE 16)".


    //Unsupported feature: Parameter Insertion (Parameter: CommentText) (ParameterCollection) on "AddColumn(PROCEDURE 16)".


    //Unsupported feature: Parameter Insertion (Parameter: IsBold) (ParameterCollection) on "AddColumn(PROCEDURE 16)".


    //Unsupported feature: Parameter Insertion (Parameter: IsItalics) (ParameterCollection) on "AddColumn(PROCEDURE 16)".


    //Unsupported feature: Parameter Insertion (Parameter: IsUnderline) (ParameterCollection) on "AddColumn(PROCEDURE 16)".


    //Unsupported feature: Parameter Insertion (Parameter: NumFormat) (ParameterCollection) on "AddColumn(PROCEDURE 16)".


    //Unsupported feature: Parameter Insertion (Parameter: RangeName) (ParameterCollection) on "CreateRange(PROCEDURE 45)".


    //Unsupported feature: Parameter Insertion (Parameter: RangeName) (ParameterCollection) on "AutoFit(PROCEDURE 20)".


    //Unsupported feature: Parameter Insertion (Parameter: RangeName) (ParameterCollection) on "BorderAround(PROCEDURE 39)".


    //Unsupported feature: Parameter Insertion (Parameter: Value) (ParameterCollection) on "AddInfoColumn(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: IsFormula) (ParameterCollection) on "AddInfoColumn(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: CommentText) (ParameterCollection) on "AddInfoColumn(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: IsBold) (ParameterCollection) on "AddInfoColumn(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: IsItalics) (ParameterCollection) on "AddInfoColumn(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: IsUnderline) (ParameterCollection) on "AddInfoColumn(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: NumFormat) (ParameterCollection) on "AddInfoColumn(PROCEDURE 24)".


    //Unsupported feature: Parameter Insertion (Parameter: globalVariable) (ParameterCollection) on "UTgetGlobalValue(PROCEDURE 35)".


    //Unsupported feature: Parameter Insertion (Parameter: value) (ParameterCollection) on "UTgetGlobalValue(PROCEDURE 35)".


    //Unsupported feature: Parameter Insertion (Parameter: NewCurrentRow) (ParameterCollection) on "SetCurrent(PROCEDURE 27)".


    //Unsupported feature: Parameter Insertion (Parameter: NewCurrentCol) (ParameterCollection) on "SetCurrent(PROCEDURE 27)".


    //Unsupported feature: Parameter Insertion (Parameter: Range) (ParameterCollection) on "CreateValidationRule(PROCEDURE 17)".


    //Unsupported feature: Parameter Insertion (Parameter: ValueAsText) (ParameterCollection) on "IsDecimal(PROCEDURE 28)".


    //Unsupported feature: Deletion (ParameterCollection) on "OpenBook(PROCEDURE 2).FileName(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OpenBook(PROCEDURE 2).SheetName(Parameter 1001)".


    //Unsupported feature: Property Modification (Id) on "OpenBook(PROCEDURE 2).i(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "OpenBook(PROCEDURE 2).EndOfLoop(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "OpenBook(PROCEDURE 2).Found(Variable 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateSheet(PROCEDURE 5).SheetName(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateSheet(PROCEDURE 5).ReportHeader(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateSheet(PROCEDURE 5).CompanyName(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateSheet(PROCEDURE 5).UserID2(Parameter 1003)".


    //Unsupported feature: Property Modification (Id) on "CreateSheet(PROCEDURE 5).XlEdgeBottom(Variable 1004)".


    //Unsupported feature: Property Modification (Id) on "CreateSheet(PROCEDURE 5).XlContinuous(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on "CreateSheet(PROCEDURE 5).XlLineStyleNone(Variable 1006)".


    //Unsupported feature: Property Modification (Id) on "CreateSheet(PROCEDURE 5).XlLandscape(Variable 1007)".


    //Unsupported feature: Property Modification (Id) on "CreateSheet(PROCEDURE 5).CRLF(Variable 1008)".


    //Unsupported feature: Property Modification (Id) on "CreateSheet(PROCEDURE 5).Window(Variable 1009)".


    //Unsupported feature: Property Modification (Id) on "CreateSheet(PROCEDURE 5).RecNo(Variable 1010)".


    //Unsupported feature: Property Modification (Id) on "CreateSheet(PROCEDURE 5).InfoRecNo(Variable 1012)".


    //Unsupported feature: Property Modification (Id) on "CreateSheet(PROCEDURE 5).TotalRecNo(Variable 1011)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateRangeName(PROCEDURE 9).RangeName(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateRangeName(PROCEDURE 9).FromColumnNo(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateRangeName(PROCEDURE 9).FromRowNo(Parameter 1002)".


    //Unsupported feature: Property Modification (Id) on "CreateRangeName(PROCEDURE 9).TempExcelBuf(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "CreateRangeName(PROCEDURE 9).ToxlRowID(Variable 1004)".


    //Unsupported feature: Property Modification (Id) on "GiveUserControl(PROCEDURE 3).TempFile(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "GiveUserControl(PROCEDURE 3).FileName(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "GiveUserControl(PROCEDURE 3).ToFile(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "ReadSheet(PROCEDURE 4).i(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "ReadSheet(PROCEDURE 4).j(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "ReadSheet(PROCEDURE 4).Maxi(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "ReadSheet(PROCEDURE 4).Maxj(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "ReadSheet(PROCEDURE 4).Window(Variable 1004)".


    //Unsupported feature: Property Modification (Id) on "ReadSheet(PROCEDURE 4).CellValueDecimal(Variable 1005)".


    //Unsupported feature: Deletion (ParameterCollection) on "SelectSheetsName(PROCEDURE 6).FileName(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "SelectSheetsName(PROCEDURE 6).i(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "SelectSheetsName(PROCEDURE 6).SheetName(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "SelectSheetsName(PROCEDURE 6).EndOfLoop(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "SelectSheetsName(PROCEDURE 6).SheetsList(Variable 1004)".


    //Unsupported feature: Property Modification (Id) on "SelectSheetsName(PROCEDURE 6).OptionNo(Variable 1005)".


    //Unsupported feature: Deletion (ParameterCollection) on "FilterToFormula(PROCEDURE 7).Filter(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "FilterToFormula(PROCEDURE 7).Ref1(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "FilterToFormula(PROCEDURE 7).Ref2(Parameter 1003)".


    //Unsupported feature: Deletion (ReturnValueCollection) on "FilterToFormula(PROCEDURE 7).Formula(ReturnValue 1000)".


    //Unsupported feature: Property Modification (Id) on "FilterToFormula(PROCEDURE 7).FormulaUnit(Variable 1004)".


    //Unsupported feature: Property Modification (Id) on "FilterToFormula(PROCEDURE 7).IsValue(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on "FilterToFormula(PROCEDURE 7).i(Variable 1006)".


    //Unsupported feature: Property Modification (Id) on "FilterToFormula(PROCEDURE 7).j(Variable 1007)".


    //Unsupported feature: Property Modification (Id) on "FilterToFormula(PROCEDURE 7).CountComparison(Variable 1008)".


    //Unsupported feature: Deletion (ParameterCollection) on "NextValue(PROCEDURE 8).FormulaUnit(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "NextValue(PROCEDURE 8).IsValue(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "NextValue(PROCEDURE 8).j(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "SumIf(PROCEDURE 15).Ref1(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "SumIf(PROCEDURE 15).Operator(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "SumIf(PROCEDURE 15).Value(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "SumIf(PROCEDURE 15).Ref2(Parameter 1003)".


    //Unsupported feature: Property Modification (Id) on "SumIf(PROCEDURE 15).Symbol(Variable 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetExcelReference(PROCEDURE 10).Which(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "ExportBudgetFilterToFormula(PROCEDURE 11).ExcelBuf(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "ExportBudgetFilterToFormula(PROCEDURE 11).ExcelBufFormula(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "ExportBudgetFilterToFormula(PROCEDURE 11).FirstRow(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "ExportBudgetFilterToFormula(PROCEDURE 11).LastRow(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "ExportBudgetFilterToFormula(PROCEDURE 11).HasFormulaError(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on "ExportBudgetFilterToFormula(PROCEDURE 11).ThisCellHasFormulaError(Variable 1006)".


    //Unsupported feature: Property Modification (Id) on "ExportBudgetFilterToFormula(PROCEDURE 11).ExcelBufFormula2(Variable 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddToFormula(PROCEDURE 12).Text(Parameter 1001)".


    //Unsupported feature: Property Modification (Id) on "AddToFormula(PROCEDURE 12).Overflow(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "AddToFormula(PROCEDURE 12).LongFormula(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "SetFormula(PROCEDURE 22).LongFormula(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddColumn(PROCEDURE 16).Value(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddColumn(PROCEDURE 16).IsFormula(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddColumn(PROCEDURE 16).CommentText(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddColumn(PROCEDURE 16).IsBold(Parameter 1003)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddColumn(PROCEDURE 16).IsItalics(Parameter 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddColumn(PROCEDURE 16).IsUnderline(Parameter 1005)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddColumn(PROCEDURE 16).NumFormat(Parameter 1006)".


    //Unsupported feature: Property Modification (Id) on "StartRange(PROCEDURE 19).TempExcelBuf(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "EndRange(PROCEDURE 23).TempExcelBuf(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateRange(PROCEDURE 45).RangeName(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "AutoFit(PROCEDURE 20).RangeName(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "AutoFit(PROCEDURE 20).XlRange1(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "BorderAround(PROCEDURE 39).RangeName(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "BorderAround(PROCEDURE 39).XlRange1(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddInfoColumn(PROCEDURE 24).Value(Parameter 1006)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddInfoColumn(PROCEDURE 24).IsFormula(Parameter 1005)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddInfoColumn(PROCEDURE 24).CommentText(Parameter 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddInfoColumn(PROCEDURE 24).IsBold(Parameter 1003)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddInfoColumn(PROCEDURE 24).IsItalics(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddInfoColumn(PROCEDURE 24).IsUnderline(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "AddInfoColumn(PROCEDURE 24).NumFormat(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "UTgetGlobalValue(PROCEDURE 35).globalVariable(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "UTgetGlobalValue(PROCEDURE 35).value(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "SetCurrent(PROCEDURE 27).NewCurrentRow(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "SetCurrent(PROCEDURE 27).NewCurrentCol(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CreateValidationRule(PROCEDURE 17).Range(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "CreateValidationRule(PROCEDURE 17).XLValidation(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "CreateValidationRule(PROCEDURE 17).XLRange(Variable 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "IsDecimal(PROCEDURE 28).ValueAsText(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "IsDecimal(PROCEDURE 28).i(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "IsDecimal(PROCEDURE 28).c(Variable 1004)".


    //Unsupported feature: Property Modification (Id) on "IsDecimal(PROCEDURE 28).c0(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on "IsDecimal(PROCEDURE 28).ThousandSeparator(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "IsDecimal(PROCEDURE 28).DecimalSeparator(Variable 1003)".


    //Unsupported feature: Property Modification (Id) on "IsDecimal(PROCEDURE 28).DecimalSeparatorExists(Variable 1006)".



    //Unsupported feature: Property Modification (Id) on ""Column No."(Field 3).OnValidate.x(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //"Column No." : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"Column No." : 1000000000;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Column No."(Field 3).OnValidate.i(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //"Column No." : 1001;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"Column No." : 1000000001;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Column No."(Field 3).OnValidate.y(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //"Column No." : 1003;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"Column No." : 1000000002;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Column No."(Field 3).OnValidate.c(Variable 1002)".

    //var
        //>>>> ORIGINAL VALUE:
        //"Column No." : 1002;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"Column No." : 1000000003;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""Column No."(Field 3).OnValidate.t(Variable 1102601000)".

    //var
        //>>>> ORIGINAL VALUE:
        //"Column No." : 1102601000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"Column No." : 1000000004;
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


    //Unsupported feature: Property Modification (Id) on "Text005(Variable 1005)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text005 : 1005;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text005 : 1000000005;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text006(Variable 1006)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text006 : 1006;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text006 : 1000000006;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text007(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text007 : 1007;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text007 : 1000000007;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text008(Variable 1008)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text008 : 1008;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text008 : 1000000008;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text009(Variable 1009)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text009 : 1009;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text009 : 1000000009;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text010(Variable 1010)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text010 : 1010;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text010 : 1000000010;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text011(Variable 1011)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text011 : 1011;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text011 : 1000000011;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text012(Variable 1012)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text012 : 1012;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text012 : 1000000012;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text013(Variable 1013)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text013 : 1013;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text013 : 1000000013;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text014(Variable 1014)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text014 : 1014;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text014 : 1000000014;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text015(Variable 1015)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text015 : 1015;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text015 : 1000000015;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text016(Variable 1016)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text016 : 1016;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text016 : 1000000016;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text017(Variable 1017)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text017 : 1017;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text017 : 1000000017;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text018(Variable 1018)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text018 : 1018;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text018 : 1000000018;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text019(Variable 1019)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text019 : 1019;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text019 : 1000000019;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text020(Variable 1020)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text020 : 1020;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text020 : 1000000020;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text021(Variable 1021)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text021 : 1021;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text021 : 1000000021;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "InfoExcelBuf(Variable 1036)".

    //var
        //>>>> ORIGINAL VALUE:
        //InfoExcelBuf : 1036;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //InfoExcelBuf : 1000000022;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "XlApp(Variable 1022)".

    //var
        //>>>> ORIGINAL VALUE:
        //XlApp : 1022;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //XlApp : 1000000023;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "XlWrkBk(Variable 1023)".

    //var
        //>>>> ORIGINAL VALUE:
        //XlWrkBk : 1023;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //XlWrkBk : 1000000024;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "XlWrkSht(Variable 1024)".

    //var
        //>>>> ORIGINAL VALUE:
        //XlWrkSht : 1024;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //XlWrkSht : 1000000025;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "XlWrkshts(Variable 1025)".

    //var
        //>>>> ORIGINAL VALUE:
        //XlWrkshts : 1025;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //XlWrkshts : 1000000026;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "XlRange(Variable 1026)".

    //var
        //>>>> ORIGINAL VALUE:
        //XlRange : 1026;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //XlRange : 1000000027;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "FormulaUnitErr(Variable 1027)".

    //var
        //>>>> ORIGINAL VALUE:
        //FormulaUnitErr : 1027;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //FormulaUnitErr : 1000000028;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "RangeStartXlRow(Variable 1034)".

    //var
        //>>>> ORIGINAL VALUE:
        //RangeStartXlRow : 1034;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //RangeStartXlRow : 1000000029;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "RangeStartXlCol(Variable 1033)".

    //var
        //>>>> ORIGINAL VALUE:
        //RangeStartXlCol : 1033;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //RangeStartXlCol : 1000000030;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "RangeEndXlRow(Variable 1032)".

    //var
        //>>>> ORIGINAL VALUE:
        //RangeEndXlRow : 1032;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //RangeEndXlRow : 1000000031;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "RangeEndXlCol(Variable 1031)".

    //var
        //>>>> ORIGINAL VALUE:
        //RangeEndXlCol : 1031;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //RangeEndXlCol : 1000000032;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CurrentRow(Variable 1029)".

    //var
        //>>>> ORIGINAL VALUE:
        //CurrentRow : 1029;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CurrentRow : 1000000033;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CurrentCol(Variable 1030)".

    //var
        //>>>> ORIGINAL VALUE:
        //CurrentCol : 1030;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CurrentCol : 1000000034;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "UseInfoSheed(Variable 1035)".

    //var
        //>>>> ORIGINAL VALUE:
        //UseInfoSheed : 1035;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //UseInfoSheed : 1000000035;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text023(Variable 1037)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text023 : 1037;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text023 : 1000000036;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text026(Variable 1028)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text026 : 1028;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text026 : 1000000037;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text033(Variable 1038)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text033 : 1038;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text033 : 1000000038;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text034(Variable 1039)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text034 : 1039;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text034 : 1000000039;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Text11600(Variable 1500000)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text11600 : 1500000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text11600 : 1000000040;
        //Variable type has not been exported.
}

