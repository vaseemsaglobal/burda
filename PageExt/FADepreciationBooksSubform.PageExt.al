PageExtension 50084 pageextension50084 extends "FA Depreciation Books Subform" 
{
    Caption = 'Lines';
    layout
    {
        addafter("No. of Depreciation Months")
        {
            field("Salvage Value";"Salvage Value")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        modify("Main &Asset Statistics")
        {
            Caption = 'Main &Asset Statistics';
        }
    }


    //Unsupported feature: Property Modification (Id) on ""Book Value"(Control 2).OnDrillDown.FALedgEntry(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //"Book Value" : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"Book Value" : 1000000001;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "GLSetup(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //GLSetup : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GLSetup : 1000000000;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "FALedgEntry(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //FALedgEntry : 1001;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //FALedgEntry : 1000000001;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "MaintenanceLedgEntry(Variable 1002)".

    //var
        //>>>> ORIGINAL VALUE:
        //MaintenanceLedgEntry : 1002;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MaintenanceLedgEntry : 1000000002;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "FADeprBook(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //FADeprBook : 1003;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //FADeprBook : 1000000003;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DepreciationCalc(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //DepreciationCalc : 1004;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //DepreciationCalc : 1000000004;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ChangeExchangeRate(Variable 1005)".

    //var
        //>>>> ORIGINAL VALUE:
        //ChangeExchangeRate : 1005;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ChangeExchangeRate : 1000000005;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "AddCurrCodeIsFound(Variable 1006)".

    //var
        //>>>> ORIGINAL VALUE:
        //AddCurrCodeIsFound : 1006;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //AddCurrCodeIsFound : 1000000006;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Disposed(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //Disposed : 1007;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Disposed : 1000000007;
        //Variable type has not been exported.
}

