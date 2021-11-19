Report 50032 "Archive Ads. Booking"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   09.05.2007   KKE   New batchjob to archived Ads. Booking - Ads. Sales Module
    //                          Ads. Booking will be archived when line status = closed,cancelled,invoiced only.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Ads. Booking Header"; "Ads. Booking Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Booking Date", "Salesperson Code", "Final Customer No.", "Bill-to Customer No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                AdsBookingLine.SETPERMISSIONFILTER;
                AdsBookingLine.Reset;
                AdsBookingLine.SetRange("Sub Product Code", UserSetup."Magazine Filter");
                AdsBookingLine.SetRange("Deal No.", "No.");
                AdsBookingLine.SetFilter("Line Status", '<>%1&<>%2&<>%3',
                  AdsBookingLine."line status"::Closed,
                  AdsBookingLine."line status"::Cancelled,
                  AdsBookingLine."line status"::Invoiced);
                if AdsBookingLine.Find('-') then
                    CurrReport.Skip;
                AdsBookingLine.SetRange("Line Status");
                if not AdsBookingLine.Find('-') then
                    CurrReport.Skip;
                ArchAdsBookingHdr.Init;
                ArchAdsBookingHdr.TransferFields("Ads. Booking Header");
                ArchAdsBookingHdr.Insert;
                repeat
                    ArchAdsBookingLine.Init;
                    ArchAdsBookingLine.TransferFields(AdsBookingLine);
                    ArchAdsBookingLine.Insert;
                until AdsBookingLine.Next = 0;
                Delete;
                AdsBookingLine.DeleteAll;
                NoOfArch += 1;
            end;

            trigger OnPreDataItem()
            begin
                NoOfArch := 0;
                UserSetup.Get(UserId);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if NoOfArch <= 1 then
            Message(Text001, NoOfArch, ' has')
        else
            Message(Text001, NoOfArch, 's have');
    end;

    var
        AdsBookingLine: Record "Ads. Booking Line";
        ArchAdsBookingHdr: Record "Archived Ads. Booking Header";
        ArchAdsBookingLine: Record "Archived Ads. Booking Line";
        UserSetup: Record "User Setup";
        NoOfArch: Integer;
        Text001: label '%1 record%2 been archived.';
}

