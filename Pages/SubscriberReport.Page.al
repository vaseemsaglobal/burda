Page 50117 "Subscriber Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    PageType = Card;

    layout
    {
        area(content)
        {
            label(Control1000000005)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19009583;
                Style = Strong;
                StyleExpr = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Expire)
            {
                ApplicationArea = Basic;
                Caption = 'E&xpire';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text001, COMPANYNAME + '|||' + USERID);
                    //SHELL(text001); //VAH
                end;
            }
            action(NewRenew)
            {
                ApplicationArea = Basic;
                Caption = '&New/Renew';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text002);//VAH
                end;
            }
            action(SubscriberCrossTab)
            {
                ApplicationArea = Basic;
                Caption = '&Subscriber Cross Tab';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text003);//VAH
                end;
            }
            action(SubscriberList)
            {
                ApplicationArea = Basic;
                Caption = '&Subscriber List';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text007);//VAH
                end;
            }
            action(Education)
            {
                ApplicationArea = Basic;
                Caption = 'E&ducation';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text004);//VAH
                end;
            }
            action(Occupation)
            {
                ApplicationArea = Basic;
                Caption = '&Occupation';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text005);//VAH
                end;
            }
            action(Revenue)
            {
                ApplicationArea = Basic;
                Caption = '&Revenue';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text006);//VAH
                end;
            }
            action(SubscriptionMovement)
            {
                ApplicationArea = Basic;
                Caption = 'Subscription Movement';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text008);//VAH
                end;
            }
            action(SubscriptionShipping)
            {
                ApplicationArea = Basic;
                Caption = 'Subscription Shipping';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text009);//VAH
                end;
            }
            action(SubscriptionPromotion)
            {
                ApplicationArea = Basic;
                Caption = 'Subscription Promotion';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text010);//VAH
                end;
            }
            action(SubscriptionPayment)
            {
                ApplicationArea = Basic;
                Caption = 'Subscription Payment';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SHELL(text011);//VAH
                end;
            }
            action(SubscriptionAnalyse)
            {
                ApplicationArea = Basic;
                Caption = 'Subscription Analyse';
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
        text001: label 'Z:\Navision Report\Subscriber\MSM\Expire.exe';
        text002: label 'Z:\Navision Report\Subscriber\MSM\NewContact.exe';
        text003: label 'Z:\Navision Report\Subscriber\MSM\Age.exe';
        text004: label 'Z:\Navision Report\Subscriber\MSM\Education.exe';
        text005: label 'Z:\Navision Report\Subscriber\MSM\Occupation.exe';
        text006: label 'Z:\Navision Report\Subscriber\MSM\Revenue.exe';
        text007: label 'Z:\Navision Report\Subscriber\MSM\Report Subscriber list.exe';
        text008: label 'Z:\Navision Report\Subcriber\Subscription Movement.exe';
        text009: label 'Z:\Navision Report\Subcriber\Subscription Shipping.exe';
        text010: label 'Z:\Navision Report\Subcriber\Subscription Promotion.exe';
        text011: label 'Z:\Navision Report\Subcriber\Subscription Payment.exe';
        text012: label 'Z:\Navision Report\Subcriber\Subscription Analyse.exe';
        Text19009583: label 'Report MSM';
}

