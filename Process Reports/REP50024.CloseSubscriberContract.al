Report 50024 "Close Subscriber Contract"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   -Subscription Module - Close Subscriber Contract
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    ProcessingOnly = true;

    dataset
    {
        dataitem(UnknownTable50005; "Subscriber Contract")
        {
            DataItemTableView = sorting("No.") where("Contract Status" = const(Released));
            RequestFilterFields = "Magazine Code";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SubscriberContractLE.SETPERMISSIONFILTER;
                SubscriberContractLE.Reset;
                SubscriberContractLE.SetRange("Magazine Code", "Magazine Code");
                SubscriberContractLE.SetRange("Subscriber Contract No.", "No.");
                SubscriberContractLE.SetRange("Paid Flag", false);
                if SubscriberContractLE.Find('-') then
                    CurrReport.Skip;
                SubscriberContractLE.Reset;
                SubscriberContractLE.SetRange("Magazine Code", "Magazine Code");
                SubscriberContractLE.SetRange("Subscriber Contract No.", "No.");
                SubscriberContractLE.SetRange("Sales Order Flag", false);
                if SubscriberContractLE.Find('-') then
                    CurrReport.Skip;
                SubscriberContractLE.Reset;
                SubscriberContractLE.SetRange("Magazine Code", "Magazine Code");
                SubscriberContractLE.SetRange("Subscriber Contract No.", "No.");
                SubscriberContractLE.SetRange("Delivered Flag", false);
                if SubscriberContractLE.Find('-') then
                    CurrReport.Skip;
                "Contract Status" := "contract status"::Closed;
                Modify;
                NoOfUpdated += 1;
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
        if NoOfUpdated <= 1 then
            Message(Text001, NoOfUpdated, 'record')
        else
            Message(Text001, NoOfUpdated, 'records');
    end;

    var
        SubscriberContractLE: Record "Subscriber Contract L/E";
        NoOfUpdated: Integer;
        Text001: label 'Update complete %1 %2.';
}

