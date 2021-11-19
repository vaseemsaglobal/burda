Page 50063 "Archived Content Index List"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   18.05.2007   KKE   New form for "Archived Content Index List" - Editorial Module
    UsageCategory = History;
    ApplicationArea = all;
    Editable = false;
    CardPageId = "Archived Content Index";
    PageType = List;
    SourceTable = "Archived Content Index Header";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(CreationDate; "Creation Date")
                {
                    ApplicationArea = Basic;
                }
                field(MagazineItemNo; "Magazine Item No.")
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

