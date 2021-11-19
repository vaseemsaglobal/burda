Page 50014 Volume
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New form for Volume - Magazine Sales Module
    UsageCategory = Administration;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = Volume;

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

    trigger OnOpenPage()
    begin
        if CurrPage.LookupMode then
            CurrPage.Editable := false;
    end;
}

