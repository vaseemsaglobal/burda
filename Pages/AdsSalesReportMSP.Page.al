Page 50115 "Ads Sales Report MSP"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            label(Control1000000005)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19012975;
                Style = Strong;
                StyleExpr = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ReportAdIssue)
            {
                ApplicationArea = Basic;
                Caption = 'Report Ad &Issue';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text001, COMPANYNAME + '|||' + USERID);
                    //SHELL(text001);//VAH
                end;
            }
            action(ReportAdMonthly)
            {
                ApplicationArea = Basic;
                Caption = 'Report Ad &Monthly';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text002);//VAH
                end;
            }
            action(ReportAdYearly)
            {
                ApplicationArea = Basic;
                Caption = 'Report Ad &Yearly';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text003);//VAH
                end;
            }
            action(ReportEditorial)
            {
                ApplicationArea = Basic;
                Caption = 'Report &Editorial';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text004);//VAH
                end;
            }
            action(ReportADSales)
            {
                ApplicationArea = Basic;
                Caption = 'Report AD &Sales';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text005);//VAH
                end;
            }
            action(ReportADDetail)
            {
                ApplicationArea = Basic;
                Caption = 'Report AD &Detail';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text011);//VAH
                end;
            }
            action(ReportAdSalesMonthly)
            {
                ApplicationArea = Basic;
                Caption = 'Report Ad Sales M&onthly';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text006);//VAH
                end;
            }
            action(ReportAdTop10)
            {
                ApplicationArea = Basic;
                Caption = 'Report Ad Top 10';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text007);//VAH
                end;
            }
            action(ReportAdTop20)
            {
                ApplicationArea = Basic;
                Caption = 'Report Ad Top 20';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text008);//VAH
                end;
            }
            action(ReportAdExpendAmt)
            {
                ApplicationArea = Basic;
                Caption = 'Report Ad E&xpend Amt';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text009);//VAH
                end;
            }
            action(ReportAdsPosition)
            {
                ApplicationArea = Basic;
                Caption = 'Report Ads. &Position';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text010);//VAH
                end;
            }
            action(ReportSalesMonthlyAdtype)
            {
                ApplicationArea = Basic;
                Caption = 'Report Sales Monthly (Adtype)';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text012);//VAH
                end;
            }
        }
    }

    var
        text001: label 'Z:\Navision Report\MSP\Report Ad Issue.exe';
        text002: label 'Z:\Navision Report\MSP\Report Ad Monthly.exe';
        text003: label 'Z:\Navision Report\MSP\Report Ad Yearly.exe';
        text004: label 'Z:\Navision Report\MSP\Report Editorial.exe';
        text005: label 'Z:\Navision Report\MSP\Report AD Sales.exe';
        text006: label 'Z:\Navision Report\MSP\Report Ad Sales Monthly.exe';
        text007: label 'Z:\Navision Report\MSP\Report Ad Top 10.exe';
        text008: label 'Z:\Navision Report\MSP\Report Ad Top 20.exe';
        text009: label 'Z:\Navision Report\MSP\Report Ad Top 100.exe';
        text010: label 'Z:\Navision Report\MSP\Report Ad Position.exe';
        text011: label 'Z:\Navision Report\MSP\Report Ad Detial.exe';
        text012: label 'Z:\Navision Report\MSp\Report Sales Monthly (Adtype).exe';
        Text19012975: label 'Report MSP';
}

