report 50019 "Overview of Pending Requests"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/OverviewOfPendingRequests.rdlc';
    ApplicationArea = all;
    Caption = 'Overview of Pending Requests';
    PreviewMode = Normal;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Ads. Booking Header"; "Ads. Booking Header")
        {
            //DataItemTableView = where("manual invoice status" = filter(Rejected | "Manual Inv. Pending"),
            //"Revenue Invoice" = const(true));
            CalcFields = "Revenue Invoice";
            DataItemTableView = where("deal completed" = const(false));


            dataitem("Ads. Booking Line"; "Ads. Booking Line")
            {
                CalcFields = "Sub Deal Invoiced Amount";
                DataItemLinkReference = "ads. booking header";
                DataItemLink = "Deal No." = field("no.");
                DataItemTableView = where("posting status" = filter("Rev. Pending" | "Inv.+Rev. Pending" | Rejected));

                trigger OnAfterGetRecord()

                begin
                    // Message('line be ski');
                    if not "Ads. Booking Header"."Revenue Invoice" then begin
                        LoopNO := 1;
                        CurrReport.Skip();
                    end;
                    AdsBookingLineTemp := "Ads. Booking Line";
                    AdsBookingLineTemp.Insert();
                    //Message('line after skip');
                    LoopNO := "Ads. Booking Line".Count;
                    Clear(CustName);
                    Clear(RevRecoAmtSubDeal);
                    DealNotext := "Deal No.";
                    ReqDateTime := "Request Date & Time";
                    CalcFields("Bill-to Customer No.");
                    if Cust.get("Bill-to Customer No.") then
                        CustName := CUst.Name;

                    GLEntry.Reset();
                    GLEntry.SetRange("Deal No.", "Deal No.");
                    GLEntry.SetRange("Sub Deal No.", "Subdeal No.");
                    GLEntry.Setfilter("Ads Sales Document Type", '%1|%2', GLEntry."Ads Sales Document Type"::Revenue, GLEntry."Ads Sales Document Type"::"JV(Revenue)");
                    GLEntry.SetFilter("G/L Account No.", "Bill Revenue G/L Account");
                    if GLEntry.FindSet() then
                        repeat
                            RevRecoAmtSubDeal += GLEntry.Amount;
                        until GLEntry.next = 0;
                end;
            }
            dataitem(integer; integer)
            {
                column(ReqDateTime; ReqDateTime)
                {
                }
                column(DealNotext; DealNotext)
                {
                }
                column(Manual_Invoice_Status; Manual_Invoice_Status)
                {

                }
                column(Accountant_Remark_For_Manual_Inv__; Accountant_Remark_For_Manual_Inv__)
                {

                }

                column(ARDeal; ardeal)
                {

                }
                column(RevRecoAmtDeal; RevRecoAmtDeal)
                {

                }
                column(SubDealNo; AdsBookingLinetemp."Subdeal No.")
                {
                }
                column(ProductName; AdsBookingLinetemp."Product Name")
                {
                }
                column(SubProductName; AdsBookingLinetemp."Sub Product Name")
                {
                }
                column(AdsTypeDescription; AdsBookingLinetemp."Ads. Type Description")
                {
                }
                column(Amount; AdsBookingLinetemp.Amount)
                {
                }
                column(PublicationMonth; AdsBookingLinetemp."Publication Month")
                {
                }
                column(PostingStatus; AdsBookingLinetemp."Posting Status")
                {
                }
                column(RemarkfromAccountant; AdsBookingLinetemp."Remark from Accountant")
                {
                }
                column(CustName; CustName)
                {

                }
                column(Sub_Deal_Invoiced_Amt; AdsBookingLinetemp."Sub Deal Invoiced Amount")
                {

                }
                column(RevRecoAmtSubDeal; RevRecoAmtSubDeal)
                {

                }

                trigger OnPreDataItem()
                begin
                    setrange(number, 1, LoopNO);
                end;

                trigger OnAfterGetRecord()

                begin
                    if LoopNO = 1 then
                        AdsBookingLinetemp.FindSet()
                    else
                        AdsBookingLineTemp.Next();
                end;
            }
            trigger onaftergetrecord()
            begin
                Clear(Manual_Invoice_Status);
                Clear(Accountant_Remark_For_Manual_Inv__);
                Clear(ARDeal);
                Clear(RevRecoAmtDeal);
                Clear(FilterTxt);
                Clear(AdsBookingLineTemp);
                //if "Revenue Invoice" = true then
                // CurrReport.Skip();
                Manual_Invoice_Status := Format(Manual_Invoice_Status);
                Accountant_Remark_For_Manual_Inv__ := "Accountant Remark For Manual Inv. ";
                DealNotext := "No.";
                ReqDateTime := "Request Date & Time";
                CalcFields("Invoiced Amount", "Invoiced Amount Cr");
                ARDeal := "Invoiced Amount" - "Invoiced Amount Cr";
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
                GLEntry.Setfilter("Ads Sales Document Type", '%1|%2', GLEntry."Ads Sales Document Type"::Revenue, GLEntry."Ads Sales Document Type"::"JV(Revenue)");
                GLEntry.SetFilter("G/L Account No.", FilterTxt);
                if GLEntry.FindSet() then
                    repeat
                        RevRecoAmtDeal += GLEntry.Amount;
                    until GLEntry.next = 0;

            end;
        }




    }


    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CustName: Text[50];
        CUst: Record Customer;
        ARDeal: Decimal;
        AdsBookingLine: Record "Ads. Booking Line";
        FilterTxt: Text;
        GLEntry: Record "G/L Entry";
        RevRecoAmtDeal: Decimal;
        RevRecoAmtSubDeal: Decimal;
        ReqDateTime: DateTime;
        DealNotext: Code[20];
        LoopNO: Integer;
        Manual_Invoice_Status: Text;
        Accountant_Remark_For_Manual_Inv__: Text;
        AdsBookingLineTemp: Record "Ads. Booking Line" temporary;
}
