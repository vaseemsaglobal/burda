codeunit 50040 "Cod50040.CU11601Ext"
{
    procedure CheckBASPeriod(DocDate: Date; InvDocDate: Date): Boolean
    var
        CompanyInfo: Record "Company Information";
        Date: Record Date;
    begin
        CompanyInfo.Get();
        if InvDocDate < 20000701D then
            exit(false);
        case CompanyInfo."Tax Period" of
            CompanyInfo."Tax Period"::Monthly:
                exit(InvDocDate < CalcDate('<D1-1M>', DocDate));
            CompanyInfo."Tax Period"::Quarterly:
                begin
                    Date.SetRange("Period Type", Date."Period Type"::Quarter);
                    Date.SetFilter("Period Start", '..%1', DocDate);
                    Date.FindLast;
                    exit(InvDocDate < Date."Period Start");
                end;
        end;
    end;

}
