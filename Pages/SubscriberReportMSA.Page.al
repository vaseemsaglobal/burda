Page 50119 "Subscriber Report MSA"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            label(Control1000000005)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19036015;
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
                    //SHELL(text001);//VAH
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
        }
    }

    var
        text001: label 'Z:\Navision Report\Subscriber\MSA\Expire.exe';
        text002: label 'Z:\Navision Report\Subscriber\MSA\NewContact.exe';
        text003: label 'Z:\Navision Report\Subscriber\MSA\Age.exe';
        text004: label 'Z:\Navision Report\Subscriber\MSA\Education.exe';
        text005: label 'Z:\Navision Report\Subscriber\MSA\Occupation.exe';
        text006: label 'Z:\Navision Report\Subscriber\MSA\Revenue.exe';
        text007: label 'Z:\Navision Report\Subscriber\MSA\Report Subscriber list.exe';
        Text19036015: label 'Report MSA';
}

