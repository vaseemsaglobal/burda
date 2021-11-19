Report 50022 "Confirm Magazine/Volume/Issue"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   16.03.2007   KKE   New batchjob to confirm Magazine/Volume/Issue for Magazine Sales Module

    ProcessingOnly = true;

    dataset
    {
        dataitem("Magazine/Volume/Issue - Matrix"; "Magazine/Volume/Issue - Matrix")
        {
            DataItemTableView = sorting("Create as Item") where("Create as Item" = const(false));
            RequestFilterFields = "Magazine Code", "Volume No.", "Issue No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Item.Init;
                Item."No." := NoSeriesMgnt.GetNextNo("Magazine Item Nos.", WorkDate, true);
                Item.Insert(true);
                ItemUOM.Init;
                ItemUOM.Validate("Item No.", Item."No.");
                ItemUOM.Validate(Code, MagazineSalesSetup."Default Base UOM");
                ItemUOM.Insert;
                Magazine.Get("Magazine Code");
                Magazine.TestField("Default Gen. Prod. Posting");
                Item.Validate(Description, CopyStr("Magazine Code" + '-' + "Volume No." + '-' + "Issue No.", 1, 30));
                Item.Validate("Base Unit of Measure", MagazineSalesSetup."Default Base UOM");
                Item."Costing Method" := MagazineSalesSetup."Default Costing Method";
                //Item.VALIDATE("Gen. Prod. Posting Group",MagazineSalesSetup."Default Gen. Prod. Posting");
                Item.Validate("Gen. Prod. Posting Group", Magazine."Default Gen. Prod. Posting");
                Item.Validate("VAT Prod. Posting Group", MagazineSalesSetup."Default VAT Prod. Posting Grou");
                Item.Validate("WHT Product Posting Group", MagazineSalesSetup."Default WHT Prod. Posting Grou");
                Item.Validate("Inventory Posting Group", MagazineSalesSetup."Default Inventory Posting Grou");
                Item."Item Type" := Item."item type"::Magazine;
                Item."Magazine Code" := "Magazine Code";
                Item."Volume No." := "Volume No.";
                Item."Issue No." := "Issue No.";
                Item."Issue Date" := "Issue Date";
                Item."Unit Price" := "Unit Price";
                Item."No. Series" := "Magazine Item Nos.";
                if Magazine."Dimension 1 Code" <> '' then
                    Item.Validate("Global Dimension 1 Code", Magazine."Dimension 1 Code");
                Item."Last Pick-up Date" := CalcDate(Magazine."Pick-up Interval", "Issue Date");
                item."Inventory Value Zero" := true;
                Item.Modify;
                Volume.Get("Volume No.");
                /*
                if Volume."Dimension 3 Code" <> '' then
                    DimMgnt.SaveDefaultDim(Database::Item, Item."No.", 3, Volume."Dimension 3 Code");
                IssueNo.Get("Issue No.");
                if IssueNo."Dimension 4 Code" <> '' then
                    DimMgnt.SaveDefaultDim(Database::Item, Item."No.", 4, IssueNo."Dimension 4 Code");
                 */
                if Item."No." <> '' then begin
                    MagazineVolumeIssue := "Magazine/Volume/Issue - Matrix";
                    MagazineVolumeIssue."Create as Item" := true;
                    MagazineVolumeIssue."Magazine Item No." := Item."No.";
                    MagazineVolumeIssue.Modify;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if not FindFirst then
                    CurrReport.Break;
                MagazineSalesSetup.Get;
                MagazineSalesSetup.TestField("Default Base UOM");
                MagazineSalesSetup.TestField("Default Costing Method");
                //MagazineSalesSetup.TESTFIELD("Default Gen. Prod. Posting");
                MagazineSalesSetup.TestField("Default VAT Prod. Posting Grou");
                //MagazineSalesSetup.TestField("Default WHT Prod. Posting Grou"); //VAH
                MagazineSalesSetup.TestField("Default Inventory Posting Grou");
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
        MagazineSalesSetup: Record "Magazine Sales Setup";
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        Magazine: Record "Sub Product";
        Item: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        Volume: Record Volume;
        IssueNo: Record "Issue No.";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
        DimMgnt: Codeunit DimensionManagement;
}

