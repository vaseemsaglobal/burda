codeunit 50038 "Create Ads Sales Journal"
{
    TableNo = "Ads. Booking Line";
    Permissions = tabledata "dimension set entry" = rimd;
    trigger OnRun()
    begin

    end;

    procedure CreateGenJnlLines(var AdsBookingLine: record "Ads. Booking Line")
    var

        AdsSalesSetup: Record "Ads. Item Setup";
        AdsBookingHeader: Record "Ads. Booking Header";
        GenJnlBatch: Record "Gen. Journal Batch";
        DocNo: Code[20];
        NoSereiesMgnt: Codeunit NoSeriesManagement;
        GenJnlTemplate: Record "Gen. Journal Template";
        SubProduct: Record "Sub Product";
        AdsPosition: Record "Ads. Position";
        BookingRevenueType: Record "Booking Revenue Type";
    begin
        //AdsBookingLine.MarkedOnly(true);
        clear(LineNo);
        AdsSalesSetup.Get();
        AdsSalesSetup.TestField("Ads. Sales Template");
        AdsSalesSetup.TestField("Ads. Sales Batch");
        GenJnlBatch.get(AdsSalesSetup."Ads. Sales Template", AdsSalesSetup."Ads. Sales Batch");
        GenJnlTemplate.get(AdsSalesSetup."Ads. Sales Template");
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", AdsSalesSetup."Ads. Sales Template");
        GenJnlLine.SetRange("Journal Batch Name", AdsSalesSetup."Ads. Sales Batch");
        if GenJnlLine.FindLast() then
            LineNo := GenJnlLine."Line No.";
        if AdsBookingLine.FindSet() then
            repeat
                Clear(DimSetEntry);
                Clear(DimSetID);
                //if SubProduct.Get(AdsBookingLine."Sub Product Code") then
                //  InsertDim('PRODUCT', SubProduct."Dimension 1 Code");//VAH
                if BookingRevenueType.get(AdsBookingLine."Ads. Type Code (Revenue Type Code)", AdsBookingLine."Shortcut Dimension 7 Code") and (BookingRevenueType."Shortcut Dimension 1 Code" <> '') then
                    InsertDim('SUB-PRODUCT', BookingRevenueType."Shortcut Dimension 1 Code")//VAH 
                else
                    if SubProduct.Get(AdsBookingLine."Sub Product Code") then
                        InsertDim('SUB-PRODUCT', SubProduct."Dimension 1 Code");//VAH

                InsertDim('SEGMENT', AdsBookingLine."Shortcut Dimension 7 Code");
                //InsertDim('ADS.POSITION', AdsBookingLine."Ads. Position Code");//VAH
                if AdsPosition.Get(AdsBookingLine."Ads. Position Code") then
                    InsertDim('ADS.POSITION', AdsPosition."Shortcut Dimension 5 Code"); //VAH
                InsertDim('REVENUE-TYPE', AdsBookingLine."Ads. Type code (Revenue type Code)");
                // GenJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntry);
                DimSetID := DimMgt.GetDimensionSetID(DimSetEntry);
                DocNo := NoSereiesMgnt.GetNextNo(GenJnlBatch."No. Series", WorkDate(), true);
                AdsBookingHeader.Get(AdsBookingLine."Deal No.");
                AdsBookingHeader.CalcFields("Deferred/Prepayment");
                LineNo += 10000;
                GenJnlLine.Init();
                GenJnlLine.validate("Journal Template Name", AdsSalesSetup."Ads. Sales Template");
                GenJnlLine.validate("Journal Batch Name", AdsSalesSetup."Ads. Sales Batch");
                GenJnlLine.Validate("Source Code", GenJnlTemplate."Source Code");
                GenJnlLine.validate("Document No.", DocNo);
                GenJnlLine.Validate("Posting Date", WorkDate());
                GenJnlLine.Validate("Shortcut Dimension 1 Code", AdsBookingLine."Product Code");
                GenJnlLine."Deal No." := AdsBookingLine."Deal No.";
                GenJnlLine."Sub Deal No." := AdsBookingLine."Subdeal No.";
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Salesperson Code" := AdsBookingLine."Salesperson Code";
                GenJnlLine."Publication Month" := AdsBookingLine."Publication Month";
                GenJnlLine.validate("Currency Code", AdsBookingLine."Currency Code");
                //GenJnlLine.validate("Currency Factor", AdsBookingLine."Currency Factor");

                GenJnlLine.insert(true);
                if abs(AdsBookingHeader."Deferred/Prepayment") > AdsBookingLine.Amount then begin
                    GenJnlLine.validate("Account No.", AdsBookingHeader."Deffered A/c No.");
                    GenJnlLine.validate("Currency Code", AdsBookingLine."Currency Code");
                    GenJnlLine.Validate(Amount, abs(AdsBookingLine.Amount));
                    GenJnlLine.Validate("Ads Sales Document Type", GenJnlLine."Ads Sales Document Type"::"JV(Deferred)");
                    AdsDocumentType := AdsDocumentType::"JV(Revenue)";
                    CreateDimensions := true;
                    CreateGenJnlLine1(AdsBookingLine."Bill Revenue G/L Account", -AdsBookingLine.Amount);
                    //LineNo += 10000;
                end else
                    if abs(AdsBookingHeader."Deferred/Prepayment") <> 0 then begin
                        GenJnlLine.Validate("Account No.", AdsBookingHeader."Deffered A/c No.");
                        GenJnlLine.validate("Currency Code", AdsBookingLine."Currency Code");
                        GenJnlLine.validate(Amount, AdsBookingHeader."Deferred/Prepayment");
                        GenJnlLine.Validate("Ads Sales Document Type", GenJnlLine."Ads Sales Document Type"::"JV(Deferred)");
                        if (AdsBookingLine.Amount - abs(AdsBookingHeader."Deferred/Prepayment") <> 0) then begin
                            CreateDimensions := false;
                            AdsDocumentType := AdsDocumentType::"JV(Accrued)";
                            CreateGenJnlLine1(AdsBookingHeader."Accrued A/c No.", abs(AdsBookingLine.Amount - abs(AdsBookingHeader."Deferred/Prepayment")));
                            //LineNo += 10000;
                        end;
                        CreateDimensions := true;
                        AdsDocumentType := AdsDocumentType::"JV(Revenue)";
                        CreateGenJnlLine1(AdsBookingLine."Bill Revenue G/L Account", -AdsBookingLine.Amount);
                        LineNo += 10000;
                    end else begin
                        GenJnlLine.validate("Account No.", AdsBookingHeader."Accrued A/c No.");
                        GenJnlLine.validate("Currency Code", AdsBookingLine."Currency Code");
                        GenJnlLine.Validate(Amount, AdsBookingLine.Amount);
                        GenJnlLine.Validate("Ads Sales Document Type", GenJnlLine."Ads Sales Document Type"::"JV(Accrued)");
                        AdsDocumentType := AdsDocumentType::"JV(Revenue)";
                        CreateDimensions := true;
                        CreateGenJnlLine1(AdsBookingLine."Bill Revenue G/L Account", -AdsBookingLine.Amount);
                        //LineNo += 10000;
                    end;
                //GenJnlLine."Dimension Set ID" := 0;
                GenJnlLine.Modify(true);
                AdsBookingLine."Request Date & Time" := CurrentDateTime;
                AdsBookingLine."Created By" := UserId;
                AdsBookingLine."Posting Status" := AdsBookingLine."Posting Status"::"Rev. Pending";
                AdsBookingLine."Remark from Accountant" := '';
                AdsBookingLine.Modify();
            until AdsBookingLine.Next() = 0;
        Message('Journal lines are ready for review and posting under Ads. Sales Journal. %1', AdsSalesSetup."Ads. Sales Batch");
        // page.Run(page::"Ads. Sales Journal");
        //Message('Journal Created ');
    end;

    local procedure CreateGenJnlLine1(AccNo: Code[20]; Amt: Decimal)
    var
        GJL: Record "Gen. Journal Line";
    begin
        LineNo += 10000;
        GJL.Init();
        GJL.TransferFields(GenJnlLine);

        GJL."Line No." := LineNo;
        gjl.insert(true);
        GJL.validate("Account No.", AccNo);
        GJL.Validate("Currency Code", GenJnlLine."Currency Code");
        gjl.validate(Amount, Amt);
        GJL.Validate("Ads Sales Document Type", AdsDocumentType);
        if CreateDimensions then
            GJL.Validate("Dimension Set ID", DimSetID);
        //GJL."Dimension Set ID" := DimSetID;
        GJL.Modify(true);
    end;

    local procedure InsertDim(DimCode: Code[20]; DimValue: Code[20])

    begin
        DimSetEntry.Init();
        DimSetEntry.validate("Dimension Code", dimCode);
        DimSetEntry.Validate("Dimension Value Code", DimValue);
        DimSetEntry."Dimension Set ID" := -1;
        if not DimSetEntry.Insert() then DimSetEntry.Modify();
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DimSetEntry: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        DimSetID: Integer;
        CreateDimensions: Boolean;
        AdsDocumentType: option ,Revenue,Deferred,Accrued,"JV(Accrued)","JV(Deferred)","JV(Revenue)";

}
