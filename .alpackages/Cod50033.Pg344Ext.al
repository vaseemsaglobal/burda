codeunit 50033 Pg344Ext
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   22.09.2005   KKE   Modify program to find data on WHT Entry.
      002   18.08.2006   KKE   Petty Cash.
      003   30.08.2006   KKE   Cash Advance.
    */
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    local procedure OnAfterNavigateFindRecords(var Sender: Page Navigate; var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text);
    var
        PettyCashInvHdr: Record "Petty Cash Header";
        CashAdvInvHdr: Record "Cash Advance Invoice Header";
        Text55000: Label 'Posted Petty Cash Invoice';
        Text55050: Label 'Posted Cash Advance Invoice';
        WHTEntry: Record "WHT Entry";
    begin
        //KKE : #002 +
        IF PettyCashInvHdr.READPERMISSION THEN BEGIN
            PettyCashInvHdr.RESET;
            PettyCashInvHdr.SETFILTER("No.", DocNoFilter);
            PettyCashInvHdr.SETFILTER("Posting Date", PostingDateFilter);
            Sender.InsertIntoDocEntry(DocumentEntry,
              DATABASE::"Petty Cash Invoice Header", 0, Text55000, PettyCashInvHdr.COUNT);
        END;
        //KKE : #002 -
        //KKE : #003 +
        IF CashAdvInvHdr.READPERMISSION THEN BEGIN
            CashAdvInvHdr.RESET;
            CashAdvInvHdr.SETFILTER("No.", DocNoFilter);
            CashAdvInvHdr.SETFILTER("Posting Date", PostingDateFilter);
            sender.InsertIntoDocEntry(DocumentEntry,
              DATABASE::"Cash Advance Invoice Header", 0, Text55050, CashAdvInvHdr.COUNT);
        END;
        //KKE : #003 -
        IF WHTEntry.READPERMISSION THEN BEGIN
            WHTEntry.RESET;
            WHTEntry.SETCURRENTKEY("Document No.", "Posting Date");
            WHTEntry.SETFILTER("Document No.", DocNoFilter);
            WHTEntry.SETFILTER("Posting Date", PostingDateFilter);
            //KKE : #001 +
            IF WHTEntry.COUNT = 0 THEN BEGIN
                WHTEntry.SETRANGE("Document No.");
                WHTEntry.SETFILTER("Original Document No.", DocNoFilter);
                //KKE : #001 -
                sender.InsertIntoDocEntry(DocumentEntry,
                  DATABASE::"WHT Entry", 0, WHTEntry.TABLECAPTION, WHTEntry.COUNT);
            END;

        END;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', false, false)]
    local procedure OnAfterNavigateShowRecords(var Sender: Page Navigate; TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry"; SalesInvoiceHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; ServiceInvoiceHeader: Record "Service Invoice Header"; ServiceCrMemoHeader: Record "Service Cr.Memo Header"; ContactType: Enum "Navigate Contact Type"; ContactNo: Code[250]; ExtDocNo: Code[250]);
    var
        PettyCashInvHdr: Record "Petty Cash Header";
        CashAdvInvHdr: Record "Cash Advance Invoice Header";
    begin
        if not ItemTrackingSearch then
            case TableID of
                //KKE : #002 +
                DATABASE::"Petty Cash Invoice Header":
                    begin
                        PettyCashInvHdr.RESET;
                        PettyCashInvHdr.SETFILTER("No.", DocNoFilter);
                        PettyCashInvHdr.SETFILTER("Posting Date", PostingDateFilter);
                        PAGE.RUN(0, PettyCashInvHdr);
                    end;
                //KKE : #002 -
                //KKE : #003 +
                DATABASE::"Cash Advance Invoice Header":
                    begin
                        CashAdvInvHdr.RESET;
                        CashAdvInvHdr.SETFILTER("No.", DocNoFilter);
                        CashAdvInvHdr.SETFILTER("Posting Date", PostingDateFilter);
                        PAGE.RUN(0, CashAdvInvHdr);
                    end;
            //KKE : #003 -
            end;

    end;

}
