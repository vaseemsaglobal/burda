codeunit 50047 Pg306Ext
{
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", 'OnSetUsageFilterOnAfterSetFiltersByReportUsage', '', false, false)]
    local procedure OnSetUsageFilterOnAfterSetFiltersByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Option);
    var
        NewReportUsage: Enum "Report Selection Usage";
    begin
        case ReportUsage2 of
            "Report Selection Usage Sales"::"Invoice Ciculation":
                Rec.SetRange(Usage, "Report Selection Usage"::"Invoice Ciculation");
            "Report Selection Usage Sales"::"Receipt Subscription":
                Rec.SetRange(Usage, "Report Selection Usage"::"Receipt Subscription");
            "Report Selection Usage Sales"::Receipt:
                Rec.SetRange(Usage, "Report Selection Usage"::Receipt);
            "Report Selection Usage Sales"::"Tax Invoice":
                Rec.SetRange(Usage, "Report Selection Usage"::"Tax Invoice");
        end;

    end;

}
