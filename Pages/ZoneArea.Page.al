Page 50043 "Zone Area"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Zone Area" - Ads. Sales Module
    UsageCategory = Administration;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Zone Area";

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
            }
        }
    }

    actions
    {
    }
}

