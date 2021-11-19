codeunit 50013 TbExt179
{
    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnInsertFromVendLedgEntryOnBeforeTempReversalEntryInsert', '', false, false)]
    local procedure OnInsertFromVendLedgEntryOnBeforeTempReversalEntryInsert(var TempReversalEntry: Record "Reversal Entry"; VendorLedgerEntry: Record "Vendor Ledger Entry");
    var
        Vend: Record Vendor;
    begin
        //KKE : #001 +
        Vend.Get(VendorLedgerEntry."Vendor No.");
        IF TempReversalEntry."Journal Batch Name" = '' THEN
            IF Vend."Petty Cash" OR Vend."Cash Advance" THEN
                TempReversalEntry."Journal Batch Name" := 'DEFAULT';
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnInsertFromGLEntryOnBeforeTempReversalEntryInsert', '', false, false)]
    local procedure OnInsertFromGLEntryOnBeforeTempReversalEntryInsert(var TempReversalEntry: Record "Reversal Entry"; GLEntry: Record "G/L Entry");
    var
        Vend: Record Vendor;
    begin
        //KKE : #001 +
        if not Vend.get(GLEntry."Source No.") then
            exit;
        IF TempReversalEntry."Journal Batch Name" = '' THEN
            IF Vend."Petty Cash" OR Vend."Cash Advance" THEN
                TempReversalEntry."Journal Batch Name" := 'DEFAULT';
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnBeforeCheckEntries', '', false, false)]
    local procedure OnBeforeCheckEntries(ReversalEntry: Record "Reversal Entry"; TableID: Integer; var SkipCheck: Boolean);
    var
        Vend: Record Vendor;
    begin
        IF Vend.GET(ReversalEntry."Source No.") THEN
            IF NOT (Vend."Petty Cash" OR Vend."Cash Advance") THEN
                SkipCheck := false
            else
                SkipCheck := true;
    end;

}
