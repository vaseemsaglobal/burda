Report 50026 "Confirm Ads. Item No."
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   -Circulation Module - Confirm Ads Item No.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Magazine/Volume/Issue - Matrix"; "Magazine/Volume/Issue - Matrix")
        {
            DataItemTableView = sorting("Create as Item", "Magazine Item No.") where("Create as Item" = const(true), "Create as Ads. Item" = const(false));
            RequestFilterFields = "Magazine Code", "Volume No.", "Issue No.", "Magazine Item No.";

            trigger OnAfterGetRecord()
            var
                SubProduct: Record "Sub Product";
            begin
                AdsItem.Init;
                AdsItem."Ads. Item No." := NoSeriesMgnt.GetNextNo("Ads. Item Nos.", WorkDate, true);
                AdsItem.Insert(true);
                AdsItem."Sub Product Code" := "Magazine Code";
                //>>VAH
                if SubProduct.Get("Magazine Code") then
                    AdsItem."Product Code" := SubProduct."Product Code";
                //<<VAH
                AdsItem."Volume No." := "Volume No.";
                AdsItem."Issue No." := "Issue No.";
                AdsItem."Issue Date" := "Issue Date";
                AdsItem."Base Unit of Measure" := AdsItemSetup."Default Base UOM";
                AdsItem."VAT Prod. Posting Group" := AdsItemSetup."VAT Prod. Posting Group";
                AdsItem."Ads. Closing Date" := "Ads. Closing Date";
                AdsItem."No. Series" := "Ads. Item Nos.";
                AdsItem.Modify;
                if AdsItem."Ads. Item No." <> '' then begin
                    MagazineVolumeIssue := "Magazine/Volume/Issue - Matrix";
                    MagazineVolumeIssue."Create as Ads. Item" := true;
                    MagazineVolumeIssue."Ads. Item No." := AdsItem."Ads. Item No.";
                    MagazineVolumeIssue.Modify;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if not FindFirst then
                    CurrReport.Break;
                AdsItemSetup.Get;
                AdsItemSetup.TestField("Default Base UOM");
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

    var
        AdsItemSetup: Record "Ads. Item Setup";
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        Item: Record Item;
        AdsItem: Record "Ads. Item";
        Magazine: Record "Sub Product";
        Volume: Record Volume;
        IssueNo: Record "Issue No.";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
        DimMgnt: Codeunit DimensionManagement;
}

