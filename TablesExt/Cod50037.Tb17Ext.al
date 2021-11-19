codeunit 50037 Cod50037Tb17Ext
{
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line");
    var
        AdsBookingLine: Record "Ads. Booking Line";
        AdsSaleSetup: Record "Ads. Item Setup";
        Cust: Record Customer;
        Vend: Record Vendor;
        BankAccount: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
    begin
        GLEntry."Deal No." := GenJournalLine."Deal No.";
        GLEntry."Sub Deal No." := GenJournalLine."Sub Deal No.";
        GLEntry."Publication Month" := GenJournalLine."Publication Month";
        GLEntry.Brand := GenJournalLine.Brand;
        GLEntry."Salesperson Code" := GenJournalLine."Salesperson Code";
        GLEntry."Description 2" := GenJournalLine.Comment;
        case GenJournalLine."Invoice Type" of
            GenJournalLine."Invoice Type"::Revenue:
                GLEntry."Ads Sales Document Type" := GLEntry."Ads Sales Document Type"::Revenue;
            GenJournalLine."Invoice Type"::Deferred:
                GLEntry."Ads Sales Document Type" := GLEntry."Ads Sales Document Type"::Deferred;
        end;
        AdsSaleSetup.Get();
        if (GenJournalLine."Journal Template Name" = AdsSaleSetup."Ads. Sales Template") and (GenJournalLine."Journal Batch Name" = AdsSaleSetup."Ads. Sales Batch") then begin
            GLEntry."Ads Sales Document Type" := GenJournalLine."Ads Sales Document Type";
            AdsBookingLine.Reset();
            AdsBookingLine.SetRange("Deal No.", GenJournalLine."Deal No.");
            AdsBookingLine.SetRange("Subdeal No.", GenJournalLine."Sub Deal No.");
            if AdsBookingLine.FindFirst() then begin
                AdsBookingLine."Posting Status" := AdsBookingLine."Posting Status"::"Rev. Posted";
                AdsBookingLine.Modify();
            end;
        end;
        if (GLEntry."Document Type" = GLEntry."Document Type"::"Credit Memo") and (GLEntry."Deal No." <> '') then
            GLEntry."Ads Sales Document Type" := GLEntry."Ads Sales Document Type"::Deferred;
        case GLEntry."Source Type" of
            GLEntry."Source Type"::Customer:
                IF Cust.GET(GLEntry."Source No.") THEN
                    GLEntry."Source Name" := Cust.Name;
            GLEntry."Source Type"::Vendor:
                IF Vend.GET(GLEntry."Source No.") THEN
                    GLEntry."Source Name" := Vend.Name;
            GLEntry."Source Type"::"Bank Account":
                IF BankAccount.GET(GLEntry."Source No.") THEN
                    GLEntry."Source Name" := BankAccount.Name;
            GLEntry."Source Type"::"Fixed Asset":
                IF FixedAsset.GET(GLEntry."Source No.") THEN
                    GLEntry."Source Name" := FixedAsset.Description;
        end;
    end;
}
