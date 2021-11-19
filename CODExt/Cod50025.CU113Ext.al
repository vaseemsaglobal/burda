codeunit 50025 CU113Ext
{
    PROCEDURE ResetAppliestoIDOnCloseEntry();
    VAR
        RecRef: RecordRef;
        xRecRef: RecordRef;
    BEGIN
        //KKE : #001 +
        VendLedgEntry.RESET;
        VendLedgEntry.SETCURRENTKEY(Open);
        VendLedgEntry.SETRANGE(Open, FALSE);
        VendLedgEntry.SETFILTER("Applies-to ID", '<>%1', '');
        VendLedgEntry.LOCKTABLE;
        IF VendLedgEntry.FIND('-') THEN
            REPEAT
                xRecRef.GETTABLE(VendLedgEntry);
                VendLedgEntry."Applies-to ID" := '';
                VendLedgEntry.MODIFY;
                RecRef.GETTABLE(VendLedgEntry);
                ChangeLogMgt.LogModification(RecRef);
            UNTIL VendLedgEntry.NEXT = 0;
        COMMIT;
        //KKE : #001 +
    END;

    var

        VendLedgEntry: Record "Vendor Ledger Entry";
        ChangeLogMgt: Codeunit "Change Log Management";
}
