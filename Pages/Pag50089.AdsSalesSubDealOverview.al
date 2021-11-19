page 50089 "Subdeals Overview"
{

    Caption = 'Subdeals Overview';
    PageType = List;
    SourceTable = "Ads. Booking Line";
    UsageCategory = Tasks;
    ApplicationArea = all;
    Editable = false;
    SourceTableView = sorting("Publication Month", "Deal No.");
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sub Deal No."; Rec."Subdeal No.")
                {
                    ToolTip = 'Specifies the value of the Sub Deal No. field';
                    ApplicationArea = All;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ToolTip = 'Specifies the value of the Product Name field';
                    ApplicationArea = All;
                }
                field("Sub Product Name"; "Sub Product Name")
                {
                    ApplicationArea = All;

                }
                field("Client Name"; ClientName)
                {
                    ApplicationArea = All;
                }
                field("Ads. Type"; Rec."Ads. Type Description")
                {
                    Caption = 'Ads. Type';
                    ToolTip = 'Specifies the value of the Ads. Type field';
                    ApplicationArea = All;
                }
                field(BrandName; BrandName)
                {
                    Caption = 'Brand';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Subdeal Amount';
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field("Publication Month"; Rec."Publication Month")
                {
                    ToolTip = 'Specifies the value of the Publication Month field';
                    ApplicationArea = All;
                }
                field("Revenue Recognized"; ABS(RevRecoAmt))
                {
                    ApplicationArea = All;
                    trigger ondrilldown()
                    var
                        GLEntry1: Record "G/L Entry";
                        GenLedgerEntries: page "General Ledger Entries";
                    begin
                        GLEntry1.Reset();
                        GLEntry1.SetRange("Deal No.", rec."deal no.");
                        GLEntry1.SetRange("Sub Deal No.", Rec."Subdeal No.");
                        GLEntry1.Setfilter("Ads Sales Document Type", '%1|%2', GLEntry1."Ads Sales Document Type"::Revenue, GLEntry."Ads Sales Document Type"::"JV(Revenue)");
                        GLEntry1.SetFilter("G/L Account No.", rec."Bill Revenue G/L Account");
                        GenLedgerEntries.SetTableView(GLEntry1);
                        GenLedgerEntries.Run();
                    end;
                }
                field("Invoiced"; Invoiced)
                {
                    Caption = 'Invoiced';
                    ToolTip = 'Specifies the value of the Posting Status field';
                    ApplicationArea = All;
                }
                field("Posting Status"; rec."Posting Status")
                {
                    ApplicationArea = All;

                }
                field(Remark; Rec."Remark from Accountant")
                {
                    ToolTip = 'Specifies the value of the Remark from Accountant field';
                    ApplicationArea = All;
                    Style = StrongAccent;
                }
                field("Remark for Accountant"; "Remark for Accountant")
                {
                    ApplicationArea = All;
                    Style = AttentionAccent;


                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = basic;
                }
                field(SalesPersonName; SalesPersonName)
                {
                    Caption = 'Salesperson Name';
                    ApplicationArea = basic;

                }
                field("Contract No."; "Contract No.")
                {
                    ApplicationArea = basic;

                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = basic;

                }
                field("Agency Commission %"; "Agency Commission %")
                {
                    ApplicationArea = basic;

                }
                field("Agency Commission Amount"; "Agency Commission Amount")
                {
                    ApplicationArea = basic;

                }
                field(AdsSizeDec; AdsSizeDec)
                {
                    Caption = 'Ads. Size Description';
                    ApplicationArea = basic;

                }
                field(FinalCustName; FinalCustName)
                {
                    Caption = 'Final Customer Name';
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
                    AdsBookingHdr.SetRange("No.", rec."deal No.");
                    AdsBookingHdr.FindFirst();
                    AdsBooking.SetTableView(AdsBookingHdr);
                    AdsBooking.SetRecord(AdsBookingHdr);
                    AdsBooking.Run();
                end;
            }
            action(CreateAdsInvoice)
            {

                ApplicationArea = Basic;
                Caption = 'Issue an invoice and recognize revenue';
                Image = NewSalesInvoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    AdsBookingLine: Record "Ads. Booking Line";
                    CreateSalesInv: Report "Create Ads Invoice Recog Rev";
                    AdsBookingLineCopy: Record "Ads. Booking Line";
                    DealNo: code[20];
                begin
                    Clear(DealNo);
                    Clear(CreateSalesInv);
                    Clear(AdsBookingLineCopy);
                    if (Rec."Posting Status" <> Rec."Posting Status"::Open) and (Rec."Posting Status" <> Rec."Posting Status"::Rejected) then
                        error('Two requests are not allowed for the same subdeal. Accountant to post or reject the first request.');

                    CurrPage.SetSelectionFilter(AdsBookingLine);
                    AdsBookingLineCopy.copy(AdsBookingLine);
                    if AdsBookingLineCopy.FindSet() then begin
                        DealNo := AdsBookingLineCopy."Deal No.";
                        repeat
                            if DealNo <> AdsBookingLineCopy."Deal No." then
                                Error('Deal no. for all the selected lines should be same');
                            AdsBookingLineCopy.TestField("Line Status", AdsBookingLineCopy."Line Status"::Approved);
                        until AdsBookingLineCopy.next = 0;
                    end;
                    AdsBookingLine.SETPERMISSIONFILTER;
                    CreateSalesInv.SetTableview(AdsBookingLine);
                    CreateSalesInv.InitRequest(rec."Deal No.");
                    CreateSalesInv.RunModal();
                end;
            }
            action(RecogRevenue)
            {
                ApplicationArea = All;
                Caption = 'Recognize revenue without issuing invoice';
                ToolTip = 'Will be booked as accured / deferred revenue';
                Image = SuggestPayment;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    AdsBookingLine: Record "Ads. Booking Line";
                    CreateAdsSalesJnl: Codeunit "Create Ads Sales Journal";
                    AdsBookingLineCopy: Record "Ads. Booking Line";

                begin

                    if (Rec."Posting Status" <> Rec."Posting Status"::Open) and (Rec."Posting Status" <> Rec."Posting Status"::Rejected) then
                        error('Two requests are not allowed for the same subdeal. Accountant to post or reject the first request.');

                    if rec."Line Status" <> rec."Line Status"::Approved then
                        error('Sub deal is not approved');

                    if not Confirm(StrSubstNo('Do you want to create the journal lines for %1?', rec."Subdeal No.")) then
                        exit;
                    CurrPage.SetSelectionFilter(AdsBookingLine);
                    if AdsBookingLine.Count > 1 then
                        Error('Multiple selection is not allowed. Select single subdeal to recognize revenue');
                    AdsBookingLine.MarkedOnly(true);

                    //AdsBookingLineCopy.Copy(AdsBookingLine);
                    CreateAdsSalesJnl.CreateGenJnlLines(AdsBookingLine);

                    // if AdsBookingLine.FindSet() then
                    //   repeat
                    //     Message(AdsBookingLine."Deal No.");
                    //until AdsBookingLine.next = 0
                end;
            }
            action(ManualInvoice)
            {
                Caption = 'Issue a manual invoice';
                ToolTip = 'Amount can be different from subdeal amount.Revenue will not be recognized (=Deferred/Accrued Revenue).';
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
                    AdsBookingLine: Record "Ads. Booking Line";
                begin
                    CurrPage.SetSelectionFilter(AdsBookingLine);
                    if AdsBookingLine.Count > 1 then
                        Error('Multiple selection is not allowed. Select single deal to issue a manual invoice');
                    AdsBookingHdr.Get(rec."Deal No.");
                    if (AdsBookingHdr."Manual Invoice Status" = AdsBookingHdr."Manual Invoice Status"::"Manual Inv. Pending") then
                        error('Two requests are not allowed for the same subdeal. Accountant to post or reject the first request.');
                    if AdsBookingHdr."Email Validation" <> AdsBookingHdr."Email Validation"::Approved then
                        Error('Validation status for deal no %1 should be approved', AdsBookingHdr."No.");
                    Clear(CreateManualInv);
                    CreateManualInv.InitRequest(AdsBookingHdr."No.");
                    CreateManualInv.RunModal();
                end;
            }

        }
    }
    trigger onaftergetrecord()
    begin
        clear(ClientName);
        Clear(Invoiced);
        Clear(RevRecoAmt);
        Clear(BrandName);
        Clear(FinalCustName);
        Clear(AdsSizeDec);
        Clear(SalesPersonName);
        if SalesPerson.get("Salesperson Code") then
            SalesPersonName := SalesPerson.Name;
        if AdsSize.Get("Ads. Type code (Revenue type Code)", "Ads. Size Code") then
            AdsSizeDec := AdsSize.Description;

        CalcFields("Sell-to Customer No.");
        if Cust.get("Sell-to Customer No.") then
            FinalCustName := Cust.Name;
        if AdsProduct.Get("Brand Code") then
            BrandName := AdsProduct.Description;
        SalesLine.reset;
        SalesLine.SetRange("Deal No.", rec."Deal No.");
        if SalesLine.FindFirst() then begin
            SalesHeader.reset;
            if SalesHeader.get(SalesHeader."Document Type"::Invoice, SalesLine."Document No.") then
                if SalesHeader."Invoice Type" = SalesHeader."Invoice Type"::Deferred then
                    Invoiced := 'Manual invoice issued on this deal' else
                    if SalesHeader."Invoice Type" = SalesHeader."Invoice Type"::Revenue then Invoiced := 'Revenue invoice issued on this deal';
        end;
        CalcFields("Bill-to Customer No.");
        if Customer.get(rec."Bill-to Customer No.") then
            ClientName := Customer.Name;
        GLEntry.Reset();
        GLEntry.SetRange("Deal No.", "Deal No.");
        GLEntry.SetRange("Sub Deal No.", "Subdeal No.");
        GLEntry.Setfilter("Ads Sales Document Type", '%1|%2', GLEntry."Ads Sales Document Type"::Revenue, GLEntry."Ads Sales Document Type"::"JV(Revenue)");
        GLEntry.SetFilter("G/L Account No.", "Bill Revenue G/L Account");
        if GLEntry.FindSet() then
            repeat
                RevRecoAmt += GLEntry.Amount;
            until GLEntry.next = 0;

    end;

    var
        Customer: Record Customer;
        ClientName: Text[50];
        Invoiced: Text[50];
        AdsBookingHeader: Record "Ads. Booking Header";
        GLEntry: Record "G/L Entry";
        RevRecoAmt: Decimal;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        AdsProduct: Record Brand;
        BrandName: Text;
        FinalCustName: Text;
        Cust: Record Customer;
        AdsSize: Record "Ads. Size";
        AdsSizeDec: Text;
        SalesPerson: Record "Salesperson/Purchaser";
        SalesPersonName: Text;

}
