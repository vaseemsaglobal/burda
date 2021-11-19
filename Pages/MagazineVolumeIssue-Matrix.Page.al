Page 50018 "Magazine/Volume/Issue - Matrix"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New form for Magazine/Volume/Issue Matrix - Magazine Sales Module
    // 002   20.05.2008   KKE   Add function remove ads. item, incase they make a wrong ads. no. series.
    UsageCategory = Lists;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Magazine/Volume/Issue - Matrix";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(MagazineCode; "Magazine Code")
                {
                    ApplicationArea = Basic;
                }
                field(VolumeNo; "Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueNo; "Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field(IssueDate; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field(CreateasItem; "Create as Item")
                {
                    ApplicationArea = Basic;
                }
                field(MagazineItemNo; "Magazine Item No.")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(CoverDescription; "Cover Description")
                {
                    ApplicationArea = Basic;
                }
                field(UnitPrice; "Unit Price")
                {
                    ApplicationArea = Basic;
                }
                field(MagazineItemNos; "Magazine Item Nos.")
                {
                    ApplicationArea = Basic;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action(CreateMagazineVolumeIssueNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Magazine/Volume/Issue No.';
                    RunObject = Report "Create Magazine/Volume/IssueNo";
                }
                action(ConfirmMagazineVolumeIssueNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Confirm Magazine/Volume/Issue No.';

                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"Confirm Magazine/Volume/Issue", true);
                    end;
                }
                separator(Action1000000033)
                {
                }
                action(ConfirmAdsItemNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Confirm Ads Item No.';
                    Visible = false;
                    trigger OnAction()
                    var
                        ConfirmAdsItemNo: Report "Confirm Ads. Item No.";
                    begin
                        ConfirmAdsItemNo.RunModal;
                    end;
                }
                separator(Action1000000035)
                {
                }
                action(RemoveAdsItemNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Remove Ads Item No.';
                    Visible = false;
                    trigger OnAction()
                    begin
                        RemoveAdsItem;
                    end;
                }
            }
        }
    }
}

