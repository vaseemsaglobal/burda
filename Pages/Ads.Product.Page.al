Page 50040 Brands
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Ads. Product" - Ads. Sales Module

    UsageCategory = Administration;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = Brand;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(ShortDescription; "Short Description")
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory; "Indutry Category")
                {
                    ApplicationArea = Basic;
                }
                field(OwnerCustomer; "Owner Customer")
                {
                    ApplicationArea = Basic;
                }
                field(Brand; "Product Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Brand';
                }
            }
        }
    }

    actions
    {
    }
}

