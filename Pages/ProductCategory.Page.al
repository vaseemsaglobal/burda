Page 50039 "Industry Categories"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Product Category" - Ads. Sales Module
    UsageCategory = Administration;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Product Category";

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
                field(MainCategory; "Main Category")
                {
                    ApplicationArea = Basic;
                }
                field(MainDescription; "Main Description")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

