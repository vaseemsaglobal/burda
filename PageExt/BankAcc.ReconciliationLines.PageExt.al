PageExtension 50064 pageextension50064 extends "Bank Acc. Reconciliation Lines"
{
    /*
          Microsoft Business Solutions Navision
          ----------------------------------------
          Project: Localization TH
          KKE : Kanoknard Ketnut

          No.   Date         Sign  Description
          ----------------------------------------
          001   11.04.2005   KKE   Add new fields for localization.
    */
    layout
    {
        addafter(Description)
        {
            field("Outstanding Check"; "Outstanding Check")
            {
                ApplicationArea = Basic;
            }
            field("Statement Check"; "Statement Check")
            {
                ApplicationArea = Basic;
            }
            field("Applied Check"; "Applied Check")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {

        modify(ShowStatementLineDetails)
        {
            Visible = false;
        }
        modify(ApplyEntries)
        {
            Visible = false;
        }
    }


    //Unsupported feature: Property Modification (Id) on "BankAccRecon(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //BankAccRecon : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BankAccRecon : 1000000000;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "StmtApplyEntries(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //StmtApplyEntries : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //StmtApplyEntries : 1000000001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TotalDiff(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //TotalDiff : 1002;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TotalDiff : 1000000002;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Balance(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Balance : 1003;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Balance : 1000000003;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TotalBalance(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //TotalBalance : 1004;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TotalBalance : 1000000004;
    //Variable type has not been exported.

    //Unsupported feature: Parameter Insertion (Parameter: BankAccReconLineNo) (ParameterCollection) on "CalcBalance(PROCEDURE 3)".


    //Unsupported feature: Deletion (ParameterCollection) on "CalcBalance(PROCEDURE 3).BankAccReconLineNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "CalcBalance(PROCEDURE 3).TempBankAccReconLine(Variable 1001)".

}

