codeunit 50009 TbExt49
{
    [EventSubscriber(ObjectType::Table, Database::"Invoice Post. Buffer", 'OnAfterInvPostBufferPreparePurchase', '', false, false)]
    local procedure OnAfterInvPostBufferPreparePurchase(var PurchaseLine: Record "Purchase Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer");
    begin

        IF (InvoicePostBuffer.Type = InvoicePostBuffer.Type::"G/L Account") OR (InvoicePostBuffer.Type = InvoicePostBuffer.Type::"Fixed Asset") THEN BEGIN
            InvoicePostBuffer."Posting Description" := PurchaseLine.Description;
            //"Line No." := PurchLine."Line No.";
            InvoicePostBuffer."Line No." := PurchaseLine."Applies-to Line No.";  //KKE : #005
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Invoice Post. Buffer", 'OnAfterInvPostBufferPrepareSales', '', false, false)]
    local procedure OnAfterInvPostBufferPrepareSales(var SalesLine: Record "Sales Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer");
    begin
        InvoicePostBuffer."Deal No." := SalesLine."Deal No.";
        InvoicePostBuffer."Sub Deal No." := salesline."Sub Deal No.";
        InvoicePostBuffer."Publication Month" := salesline."Publication Month";
        InvoicePostBuffer.Brand := SalesLine.Brand;
        InvoicePostBuffer."Salesperson Code" := SalesLine."Salesperson Code";
    end;
}
