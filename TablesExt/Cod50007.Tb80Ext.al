codeunit 50007 Tb80Ext
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Template", 'OnAfterValidateType', '', false, false)]
    local procedure OnAfterValidateType(var GenJournalTemplate: Record "Gen. Journal Template"; SourceCodeSetup: Record "Source Code Setup");
    begin
        case GenJournalTemplate.Type of
            //KKE : 001 + 
            GenJournalTemplate.Type::"Petty Cash":
                BEGIN
                    SourceCodeSetup.TESTFIELD("Petty Cash");
                    GenJournalTemplate."Source Code" := SourceCodeSetup."Petty Cash";
                    GenJournalTemplate."Page ID" := PAGE::"Refund Petty Cash";
                END;
            //KKE : 001 -
            //KKE : 002 +
            GenJournalTemplate.Type::"Cash Advance":
                BEGIN
                    SourceCodeSetup.TESTFIELD("Cash Advance");
                    GenJournalTemplate."Source Code" := SourceCodeSetup."Cash Advance";
                    //GenJournalTemplate."Page ID" := PAGE::"Cash Advance Payment";
                END;
        end;

    end;

}
