codeunit 50004 CU100Ext
{
    /*
    
Microsoft Business Solutions Navision
----------------------------------------
Project: Localization Demo TH
KKE : Kanoknard Ketnut

No.   Date         Sign  Description
----------------------------------------
001  09.08.2006  KKE  -Modify program to check G/L Account Where used when user need to set "Direct Posting".

Change in CheckGenPostingSetup
    */
    procedure CheckGLAccForDirectPosting(GLAccNo: code[20]): Boolean
    var
        CalcGLAccWhereUsed: Codeunit "Calc. G/L Acc. Where-Used";
        OldTableNo: Integer;
        Text50000: Label 'This G/L Account has been used in %1.\Do you need to set "Direct Posting"?';
        GLAccWhereUsed: Record "G/L Account Where-Used";
    begin

        //KKE : #001 +
        CalcGLAccWhereUsed.CheckPostingGroups(GLAccNo);
        GLAccWhereUsed.SETCURRENTKEY("Table Name");
        IF GLAccWhereUsed.FIND('-') THEN BEGIN
            REPEAT
                IF OldTableNo <> GLAccWhereUsed."Table ID" THEN BEGIN
                    OldTableNo := GLAccWhereUsed."Table ID";
                    IF CONFIRM(STRSUBSTNO(Text50000, GLAccWhereUsed."Table Name"), FALSE) THEN
                        EXIT(TRUE);
                END;
            UNTIL GLAccWhereUsed.NEXT = 0;
            EXIT(FALSE);
        END ELSE
            EXIT(TRUE);
        //KKE : #001 -
    end;

}
