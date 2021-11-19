codeunit 50018 CUExt13
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeCheckDocNoBasedOnNoSeries', '', false, false)]
    local procedure OnBeforeCheckDocNoBasedOnNoSeries(var GenJournalLine: Record "Gen. Journal Line"; LastDocNo: Code[20]; NoSeriesCode: Code[20]; var NoSeriesMgtInstance: Codeunit NoSeriesManagement; var IsHandled: Boolean);
    var
        DocNo: Code[20];
    begin

        if NoSeriesCode = '' then
            exit;
        //DocNo := NoSeriesMgtInstance.GetNextNo(NoSeriesCode, GenJournalLine."Posting Date", false);//VAH
        if (LastDocNo = '') or (GenJournalLine."Document No." <> LastDocNo) then//VAH
            IF GenJournalLine."Check Printed" THEN begin
                DocNo := NoSeriesMgtInstance.GetNextNo(NoSeriesCode, GenJournalLine."Posting Date", false);//VAH
                if GenJournalLine."Document No." <> DocNo then begin
                    GenJournalLine.TESTFIELD("External Document No.", DocNo);//VAH
                    IsHandled := true;
                end
                else begin
                    //KKE : #001 -
                    // NoSeriesMgtInstance.TestManualWithDocumentNo(NoSeriesCode, GenJournalLine."Document No.");  // allow use of manual document numbers.
                    //NoSeriesMgtInstance.ClearNoSeriesLine();
                end;
            end;
        //IsHandled := true;

        /*
if (LastDocNo = '') or (GenJournalLine."Document No." <> LastDocNo) then
  //KKE : #001 +
  IF GenJournalLine."Check Printed" THEN
      GenJournalLine.TESTFIELD("External Document No.", NoSeriesMgtInstance.GetNextNo(NoSeriesCode, GenJournalLine."Posting Date", false))
//KKE : #001 -
*/

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnAfterPostReversingLines', '', false, false)]
    local procedure OnAfterPostReversingLines(var GenJournalLine: Record "Gen. Journal Line"; PreviewMode: Boolean);
    var
        xGenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        //KKE : #002 +
        IF GenJournalLine.MARKEDONLY THEN BEGIN
            xGenJnlLine.RESET;
            xGenJnlLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
            xGenJnlLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
            xGenJnlLine.SETRANGE("Is WHT", TRUE);
            IF xGenJnlLine.FIND('-') THEN
                REPEAT
                    GenJnlPostLine.RunWithoutCheck(xGenJnlLine);
                UNTIL xGenJnlLine.NEXT = 0;
            xGenJnlLine.DELETEALL;
        END;
        //KKE : #002 -
    end;

}
