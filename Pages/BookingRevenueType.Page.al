Page 50036 "Booking Revenue Type"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Booking Revenue Type" - Ads. Sales Module
    UsageCategory = Administration;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Booking Revenue Type";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
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

                field(AdsType; "Ads. Type")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field(CreateSaleInvoice; "Create Sale Invoice")
                {
                    ApplicationArea = Basic;
                }
                field(BillRevenueGLAccount; "Bill Revenue G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(RequiredBarterGLAccount; "Required Barter G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(BarterGLAccount; "Barter G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(BlackgroundColor; "Blackground Color")
                {
                    ApplicationArea = Basic;
                }
                field(ForegroundColor; "Foreground Color")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
            }

        }
    }

    actions
    {
    }

    var
        Text19053904: label 'Black';
        Text19007305: label 'Brown';
        Text19076108: label 'Olive Green';
        Text19002388: label 'Dark Red';
        Text19041711: label 'Orange';
        Text19013543: label 'Dark Yellow';
        Text19002374: label 'Red';
        Text19056105: label 'Dark Green';
        Text19008324: label 'Green';
        Text19029161: label 'Light Orange';
        Text19060045: label 'Lime';
        Text19027750: label 'Pink';
        Text19014195: label 'Gold';
        Text19044500: label 'Yellow';
        Text19041585: label 'Rose';
        Text19058474: label 'Tan';
        Text19016196: label 'Light Yellow';
        Text19068979: label 'Dark Teal';
        Text19032025: label 'Teal';
        Text19009302: label 'Sea Green';
        Text19071969: label 'Bright Green';
        Text19012296: label 'Light Green';
        Text19047863: label 'Dark Blue';
        Text19056084: label 'Indigo';
        Text19032294: label 'Gray - 80%';
        Text19045579: label 'Blue';
        Text19015665: label 'Blue-Gray';
        Text19019210: label 'Aqua';
        Text19022310: label 'Gray - 50%';
        Text19016090: label 'Light Blue';
        Text19052732: label 'Violet';
        Text19079861: label 'Turquoise';
        Text19036415: label 'Light Turquoise';
        Text19057446: label 'Gray - 40%';
        Text19006866: label 'Sky Blue';
        Text19073657: label 'Plum';
        Text19074475: label 'Gray - 25%';
        Text19051685: label 'Pale Blue';
        Text19016082: label 'Lavender';
        Text19046141: label 'White';
}

