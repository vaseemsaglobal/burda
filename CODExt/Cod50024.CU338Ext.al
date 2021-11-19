codeunit 50024 CU338Ext
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VAT Entry - Edit", 'OnBeforeVATEntryModify', '', false, false)]
    local procedure OnBeforeVATEntryModify(var VATEntry: Record "VAT Entry"; FromVATEntry: Record "VAT Entry");
    begin

        //KKE : #001 +
        VATEntry."Tax Invoice No." := FromVATEntry."Tax Invoice No.";
        VATEntry."Tax Invoice Date" := FromVATEntry."Tax Invoice Date";
        VATEntry."Submit Date" := FromVATEntry."Submit Date";
        //KKE : #001 -

    end;

}
