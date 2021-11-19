Page 50042 "Ads. Sub Type"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Ads. Sub Type" - Ads. Sales Module
    UsageCategory = Administration;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Ads. Sub Type";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(AdsType; "Ads. Type")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(GroupType; GroupType)
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

