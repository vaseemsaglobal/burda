Page 50024 "Column Name Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New table for "Content Setup" - Editorial Module
    UsageCategory = Administration;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Content Column";

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
                field(MagazineCode; "Magazine Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(NoofPage; "No. of Page")
                {
                    ApplicationArea = Basic;
                }
                field(ContentGroup; "Content Group")
                {
                    ApplicationArea = Basic;
                }
                field(ContentSubGroup; "Content Sub Group")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension6Code; "Shortcut Dimension 6 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Remark; Remark)
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

