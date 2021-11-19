page 50064 "Deals Overview"
{

    Caption = 'Deals Overview';
    PageType = List;
    SourceTable = "Ads. Booking Header";
    UsageCategory = Tasks;
    ApplicationArea = all;
    Editable = false;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Deal No.';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        AdsBookingLine: Record "Ads. Booking Line";
                        AdsSaleSubDealOverview: Page "Subdeals Overview";
                    begin
                        AdsBookingLine.Reset();
                        AdsBookingLine.SetRange("Deal No.", rec."No.");
                        AdsSaleSubDealOverview.SetTableView(AdsBookingLine);
                        AdsSaleSubDealOverview.SetRecord(AdsBookingLine);
                        AdsSaleSubDealOverview.Run();
                    end;
                }
                field("Client Name"; ClientName)
                {
                    ApplicationArea = All;

                }
                field("Deal Value"; "Deal Value")
                {
                    Caption = 'Deal Value';
                    ApplicationArea = All;

                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Deal Value (LCY)"; DealValueLCY)
                {
                    ApplicationArea = All;
                }
                field("Revenue Recognized Amount"; ABS(RevRecoAmt))
                {
                    Editable = false;
                    Caption = 'Revenue Recognized Amount';
                    //Style = Favorable;
                    StyleExpr = RevRecogStyle;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        GLEntry: Record "G/L Entry";
                        AdsBookingLine: Record "Ads. Booking Line";
                        FilterTxt: Text;
                        GenLedgerEntries: Page "General Ledger Entries";
                    begin
                        clear(FilterTxt);
                        AdsBookingLine.Reset();
                        AdsBookingLine.SetRange("Deal No.", "No.");
                        AdsBookingLine.SetFilter("Bill Revenue G/L Account", '<>%1', '');
                        if AdsBookingLine.FindSet() then
                            repeat
                                if FilterTxt = '' then
                                    FilterTxt := AdsBookingLine."Bill Revenue G/L Account"
                                else
                                    FilterTxt += '|' + AdsBookingLine."Bill Revenue G/L Account";
                            until AdsBookingLine.next = 0;
                        GLEntry.Reset();
                        GLEntry.SetRange("Deal No.", "No.");
                        GLEntry.Setfilter("Ads Sales Document Type", '%1|%2|%3', GLEntry."Ads Sales Document Type"::Revenue, GLEntry."Ads Sales Document Type"::"JV(Revenue)", GLEntry."Ads Sales Document Type"::Deferred);
                        GLEntry.SetFilter("G/L Account No.", FilterTxt);
                        GenLedgerEntries.SetTableView(GLEntry);
                        GenLedgerEntries.Run();
                    end;
                }
                field("Revenue Recognized (in %)"; RevRecPerc)
                {
                    Caption = 'Revenue Recognized (in %)';
                    ApplicationArea = All;

                }
                field("Invoiced Amount"; InvoicedAmt)
                {
                    Caption = 'Invoiced Amount';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        PostedSalesInvoiceLines: Page "Posted Sales Invoice Lines";
                        SalesInvLine: Record "Sales Invoice Line";
                    begin
                        SalesInvLine.reset;
                        SalesInvLine.SetRange("Deal No.", "No.");
                        PostedSalesInvoiceLines.SetTableView(SalesInvLine);
                        PostedSalesInvoiceLines.Run();
                    end;
                }
                field("Invoiced (in %)"; InvAmtPerc)
                {
                    Caption = 'Invoiced (in %)';
                    ApplicationArea = All;

                }
                field("Amount Remaining to Invoice"; AmtRemToInvoice)
                {
                    Caption = 'Amount Remaining to Invoice';
                    ApplicationArea = All;

                }
                field("Amount Paid"; "Amount Paid")
                {
                    Caption = 'Amount Paid';
                    ApplicationArea = All;
                    //Style = Favorable;
                    StyleExpr = AmountPaidStyle;

                }
                field("Deferred/Prepayment"; "Deferred/Prepayment")
                {
                    ApplicationArea = All;
                    //Style = StrongAccent;
                    StyleExpr = DefPreStyle;
                    Caption = 'Deferred/Prepayment';
                    ToolTip = 'Invoice issued but no revenue recognized because service yet to complete. Deferred revenue: invoice amount is greater than revenue recognized. Action to be done:  Deferred payment should be 0 at the deal completion -> invoiced amount = revenue recognized';
                }
                field("Accrued Amount"; "Accrued Amount")
                {
                    ApplicationArea = All;
                    //Style = Unfavorable;
                    StyleExpr = AccruedAmtStyle;
                    Caption = 'Accrued Amount';
                    ToolTip = 'Revenue recognized but not (or partially) invoiced. Accrued revenue: recognized revenue amount is greater than amount invoiced. Action to be done: Issue invoice.';
                }
                field("Accountant Remark For Manual Inv. "; "Accountant Remark For Manual Inv. ")
                {
                    Caption = 'Remark from Accountant';
                    ApplicationArea = All;

                }
                field("Remark By Ad Traffic"; Remark)
                {
                    ApplicationArea = All;

                }
                field("Manual Invoice Status"; "Manual Invoice Status")
                {
                    ApplicationArea = All;

                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = basic;

                }

            }

        }

    }

    actions
    {
        area(Processing)
        {
            action(DealCard)
            {
                Caption = 'Open Deal';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Document;

                trigger OnAction()
                var
                    AdsBookingHdr: Record "Ads. Booking header";
                    AdsBooking: Page "Ads. Booking";
                begin
                    AdsBookingHdr.Reset();
                    AdsBookingHdr.SetRange("No.", rec."No.");
                    AdsBookingHdr.FindFirst();
                    AdsBooking.SetTableView(AdsBookingHdr);
                    AdsBooking.SetRecord(AdsBookingHdr);
                    AdsBooking.Run();
                end;
            }
            action(AdsSalesSubDealOverview)
            {
                Caption = 'Subdeals Overview';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = ViewServiceOrder;

                trigger OnAction()
                var
                    AdsBookingLine: Record "Ads. Booking Line";
                    AdsSaleSubDealOverview: Page "Subdeals Overview";
                begin
                    AdsBookingLine.Reset();
                    AdsBookingLine.SetFilter("Line Status", '%1|%2', AdsBookingLine."Line Status"::Approved, AdsBookingLine."Line Status"::"Invoice Generated");
                    AdsBookingLine.SetFilter("Posting Status", '%1|%2|%3|%4', AdsBookingLine."Posting Status"::Open, AdsBookingLine."Posting Status"::"Rev. Pending", AdsBookingLine."Posting Status"::"Rev. Pending", AdsBookingLine."Posting Status"::Rejected);
                    //if AdsBookingLine.FindSet() then;
                    AdsSaleSubDealOverview.SetTableView(AdsBookingLine);
                    AdsSaleSubDealOverview.SetRecord(AdsBookingLine);
                    AdsSaleSubDealOverview.Run();
                end;
            }
            action(GLEntries)
            {
                Caption = 'Posted entries in accounting';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = GeneralLedger;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    GenLedgerEntries: Page "General Ledger Entries";
                begin
                    GLEntry.Reset();
                    GLEntry.SetRange("Deal No.", rec."No.");
                    GenLedgerEntries.SetTableView(GLEntry);
                    GenLedgerEntries.SetRecord(GLEntry);
                    GenLedgerEntries.Run();
                end;
            }
            action(ManualInvoice)
            {
                Caption = 'Issue a manual invoice', MaxLength = 45;
                ToolTip = 'Amount can be different from subdeal amount.Revenue will not be recognized (=Deferred/Accrued Revenue)';
                Image = NewSalesInvoice;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    AdsBookingHdr: Record "Ads. Booking Header";
                    CreateManualInv: Report "Create Manual Invoice";
                    AdsBookingLineCopy: Record "Ads. Booking Line";
                    DealNo: code[20];
                begin
                    CurrPage.SetSelectionFilter(AdsBookingHdr);
                    if (Rec."Manual Invoice Status" = rec."Manual Invoice Status"::"Manual Inv. Pending") then
                        error('Two requests are not allowed for the same subdeal. Accountant to post or reject the first request.');
                    if AdsBookingHdr.count > 1 then
                        Error('Multiple selection is not allowed. Select single deal to issue a manual invoice');
                    if rec."Email Validation" <> rec."Email Validation"::Approved then
                        Error('Validation status for deal no %1 should be approved', rec."No.");
                    Clear(DealNo);
                    Clear(CreateManualInv);
                    Clear(AdsBookingLineCopy);
                    //CurrPage.SetSelectionFilter(AdsBookingHdr);
                    //AdsBookingLineCopy.copy(AdsBookingLine);
                    //AdsBookingHdr.SETPERMISSIONFILTER;
                    //CreateManualInv.SetTableview(Rec);
                    CreateManualInv.InitRequest(Rec."No.");
                    CreateManualInv.RunModal();
                end;
            }
            action(OverviewPendReq)
            {
                ApplicationArea = All;
                Caption = 'Overview of pending requests';
                Image = PrintReport;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger onaction()
                var
                    OverViewofPendReq: Report "Overview of Pending Requests";
                begin
                    Clear(OverViewofPendReq);
                    OverViewofPendReq.UseRequestPage := false;
                    OverViewofPendReq.Run();

                    //report.RunModal(report::"Overview of Pending Requests", false);
                end;
            }
        }


    }
    trigger OnAfterGetRecord()
    var
        GLEntry: Record "G/L Entry";
        AdsBookingLine: Record "Ads. Booking Line";
        FilterTxt: Text;
        GenLedgerEntries: Page "General Ledger Entries";
        GLEntryDeal: Record "G/L Entry";
        AdsBLine: Record "Ads. Booking Line";
        AmtLCYTot: Decimal;
        AdsSaleSetup: Record "Ads. Item Setup";
        GLDealTot: Decimal;
    begin
        Clear(RevRecoAmt);
        clear(FilterTxt);
        Clear(InvoicedAmt);
        Clear(InvAmtPerc);
        Clear(RevRecPerc);
        clear(AmtLCYTot);
        Clear(ClientName);
        Clear(GLDealTot);
        AdsBookingLine.Reset();
        AdsBookingLine.SetRange("Deal No.", "No.");
        AdsBookingLine.SetFilter("Bill Revenue G/L Account", '<>%1', '');
        if AdsBookingLine.FindSet() then
            repeat
                if FilterTxt = '' then
                    FilterTxt := AdsBookingLine."Bill Revenue G/L Account"
                else
                    FilterTxt += '|' + AdsBookingLine."Bill Revenue G/L Account";
            until AdsBookingLine.next = 0;
        GLEntry.Reset();
        GLEntry.SetRange("Deal No.", "No.");
        GLEntry.Setfilter("Ads Sales Document Type", '%1|%2|%3', GLEntry."Ads Sales Document Type"::Revenue, GLEntry."Ads Sales Document Type"::"JV(Revenue)", GLEntry."Ads Sales Document Type"::Deferred);
        GLEntry.SetFilter("G/L Account No.", FilterTxt);
        if GLEntry.FindSet() then
            repeat
                RevRecoAmt += GLEntry.Amount;
            until GLEntry.next = 0;

        CalcFields("Invoiced Amount", "Invoiced Amount Cr");
        InvoicedAmt := "Invoiced Amount" - "Invoiced Amount Cr";
        CalcFields("Deal Value");
        if "Deal Value" <> 0 then begin
            //RevRecPerc := round(abs(RevRecoAmt) * 100 / "Deal Value", 0.01);
            InvAmtPerc := Round(InvoicedAmt * 100 / "Deal Value", 0.01);
        end;
        AmtRemToInvoice := "Deal Value" - "Invoiced Amount";

        //calculate Deal LCY
        AdsBLine.Reset();
        AdsBLine.SetRange("Deal No.", rec."No.");
        //AdsBLine.SetFilter("Posting Status", '<>%1', AdsBLine."Posting Status"::"Rev. Posted");
        if AdsBLine.FindSet() then
            repeat
                if AdsBLine."Posting Status" IN [AdsBLine."Posting Status"::"Inv.+Rev. Posted", AdsBLine."Posting Status"::"Rev. Posted"] then begin
                    GLEntryDeal.Reset();
                    GLEntryDeal.SetRange("Deal No.", "No.");
                    GLEntryDeal.SetRange("G/L Account No.", AdsBLine."Bill Revenue G/L Account");
                    GLEntryDeal.SetRange("Sub Deal No.", AdsBLine."Subdeal No.");
                    if GLEntryDeal.FindSet() then
                        repeat
                            GLDealTot += GLEntryDeal.Amount;
                        until GLEntryDeal.Next() = 0;
                end else
                    AmtLCYTot += AdsBLine."Amount (LCY)"
            until AdsBLine.Next() = 0;
        AdsSaleSetup.Get();
        /*GLEntryDeal.Reset();
        GLEntryDeal.SetRange("Deal No.", "No.");
        GLEntry.SetRange("G/L Account No.",rec."Bill Revenue G/L Account");
        //GLEntryDeal.SetRange("Journal Batch Name", AdsSaleSetup."Ads. Sales Batch");
        //GLEntryDeal.SetFilter(Amount, '>0');
        if GLEntryDeal.FindSet() then
            repeat
                GLDealTot += GLEntryDeal.Amount;
            until GLEntryDeal.Next() = 0;*/
        DealValueLCY := AmtLCYTot + abs(GLDealTot);
        if DealValueLCY <> 0 then
            RevRecPerc := round(abs(RevRecoAmt) * 100 / DealValueLCY, 0.01);
        if Cust.get("Bill-to Customer No.") then
            ClientName := cust.Name;

        if RevRecoAmt <> 0 then
            RevRecogStyle := 'Favorable'
        else
            RevRecogStyle := 'standard';
        if "Deferred/Prepayment" <> 0 then
            DefPreStyle := 'StrongAccent'
        else
            DefPreStyle := 'standard';
        if "Accrued Amount" <> 0 then
            AccruedAmtStyle := 'Unfavorable'
        else
            AccruedAmtStyle := 'standard';
        if "Amount Paid" <> 0 then
            AmountPaidStyle := 'Favorable'
        else
            AmountPaidStyle := 'standard';
    end;

    var
        RevRecoAmt: Decimal;
        InvoicedAmt: Decimal;
        RevRecPerc: Decimal;
        InvAmtPerc: Decimal;
        AmtRemToInvoice: Decimal;
        DealValueLCY: Decimal;
        ClientName: text;
        Cust: Record Customer;
        RevRecogStyle: Text;
        DefPreStyle: text;
        AccruedAmtStyle: Text;
        AmountPaidStyle: Text;


}
