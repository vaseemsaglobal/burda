codeunit 50043 TbExt254
{
    [EventSubscriber(ObjectType::Table, Database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyFromGenJnlLine(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        VATEntry."Tax Invoice No." := GenJournalLine."Tax Invoice No.";
        VATEntry."Tax Invoice Date" := GenJournalLine."Tax Invoice Date";
    end;

}
