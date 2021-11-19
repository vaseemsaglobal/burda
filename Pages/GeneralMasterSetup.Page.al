Page 50003 "General Master Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // PTH : Phitsanu Thoranasoonthorn
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New Form for Occupation Setup.
    // 002   02.07.2008   PTH   Add New 2 Option for Filed "Type" ...,Credit Card Type,Call Category,Complaint Topic.
    UsageCategory = Administration;
    ApplicationArea = all;
    Caption = 'General Master Setup';
    DataCaptionFields = Type;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "General Master Setup";

    layout
    {
        area(content)
        {
            field(optType; optType)
            {
                ApplicationArea = Basic;
                Caption = 'Type Filter';

                trigger OnValidate()
                begin
                    optTypeOnAfterValidate;
                end;
            }
            repeater(Control1)
            {
                field(Type; Type)
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
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if optType <> Opttype::" " then
            Type := optType - 1
        else
            Type := xRec.Type;
    end;

    var
        optType: Option " ",Occupation,Position,Education,"Zone Area","Customer Type","Resource Lead","Resource Channel",,"Credit Card Bank","Credit Card Type","Call Category","Complaint Topic";

    local procedure optTypeOnAfterValidate()
    begin
        if optType - 1 < 0 then
            SetRange(Type)
        else
            SetRange(Type, optType - 1);
        CurrPage.Update(false);
    end;
}

