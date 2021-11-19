codeunit 50022 Tb5051Ext
{
    [EventSubscriber(ObjectType::Table, Database::"Interaction Log Entry", 'OnAfterCopyFromSegment', '', false, false)]
    local procedure OnAfterCopyFromSegment(var InteractionLogEntry: Record "Interaction Log Entry"; SegmentLine: Record "Segment Line");
    var
        SalesSetup: record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        //TSA001
        InteractionLogEntry."Start Time" := InteractionLogEntry."Time of Interaction";
        InteractionLogEntry."End Time" := TIME;
        SalesSetup.GET;
        SalesSetup.TESTFIELD("Complaint Nos.");
        InteractionLogEntry."Reference No." := NoSeriesMgt.GetNextNo(SalesSetup."Complaint Nos.", WORKDATE, TRUE);
        //TSA001
    end;

}
