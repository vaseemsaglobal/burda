Page 50022 "Content Group Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New form for "Content Type Setup" - Editorial Module
    UsageCategory = Administration;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Content Group Setup";

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
                field(BlackgroundColor; "Blackground Color")
                {
                    ApplicationArea = Basic;
                }
                field(ForegroundColor; "Foreground Color")
                {
                    ApplicationArea = Basic;
                }
            }
            label(Control1000000042)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19046141;
            }
            label(Control1000000054)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19016082;
                MultiLine = true;
            }
            label(Control1000000053)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19051685;
            }
            label(Control1000000050)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19074475;
                MultiLine = true;
            }
            label(Control1000000048)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19073657;
            }
            label(Control1000000051)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19006866;
            }
            label(Control1000000035)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19057446;
                MultiLine = true;
            }
            label(Control1000000031)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19022310;
                MultiLine = true;
            }
            label(Control1000000052)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19036415;
                MultiLine = true;
            }
            label(Control1000000049)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19079861;
            }
            label(Control1000000044)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19052732;
            }
            label(Control1000000033)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19016090;
                MultiLine = true;
            }
            label(Control1000000032)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19019210;
            }
            label(Control1000000030)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19015665;
                MultiLine = true;
            }
            label(Control1000000024)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19032294;
                MultiLine = true;
            }
            label(Control1000000025)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19056084;
                MultiLine = true;
            }
            label(Control1000000023)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19012296;
                MultiLine = true;
            }
            label(Control1000000020)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19016196;
                MultiLine = true;
            }
            label(Control1000000016)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19058474;
            }
            label(Control1000000039)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19071969;
                MultiLine = true;
            }
            label(Control1000000036)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19044500;
            }
            label(Control1000000015)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19014195;
            }
            label(Control1000000019)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19009302;
                MultiLine = true;
            }
            label(Control1000000028)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19045579;
            }
            label(Control1000000029)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19032025;
            }
            label(Control1000000021)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19008324;
                MultiLine = true;
            }
            label(Control1000000026)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19047863;
            }
            label(Control1000000018)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19060045;
                MultiLine = true;
            }
            label(Control1000000017)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19013543;
                MultiLine = true;
            }
            label(Control1000000027)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19068979;
                MultiLine = true;
            }
            label(Control1000000014)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19029161;
                MultiLine = true;
            }
            label(Control1000000022)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19056105;
                MultiLine = true;
            }
            label(Control1000000047)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19041585;
            }
            label(Control1000000037)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19027750;
            }
            label(Control1000000038)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19002374;
            }
            label(Control1000000040)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19041711;
            }
            label(Control1000000012)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19002388;
            }
            label(Control1000000013)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19076108;
                MultiLine = true;
            }
            label(Control1000000041)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19007305;
            }
            label(Control1000000046)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19053904;
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
        Text19002374: label 'Red';
        Text19027750: label 'Pink';
        Text19041585: label 'Rose';
        Text19056105: label 'Dark Green';
        Text19029161: label 'Light Orange';
        Text19068979: label 'Dark Teal';
        Text19013543: label 'Dark Yellow';
        Text19060045: label 'Lime';
        Text19047863: label 'Dark Blue';
        Text19008324: label 'Green';
        Text19032025: label 'Teal';
        Text19045579: label 'Blue';
        Text19009302: label 'Sea Green';
        Text19014195: label 'Gold';
        Text19044500: label 'Yellow';
        Text19071969: label 'Bright Green';
        Text19058474: label 'Tan';
        Text19016196: label 'Light Yellow';
        Text19012296: label 'Light Green';
        Text19056084: label 'Indigo';
        Text19032294: label 'Gray - 80%';
        Text19015665: label 'Blue-Gray';
        Text19019210: label 'Aqua';
        Text19016090: label 'Light Blue';
        Text19052732: label 'Violet';
        Text19079861: label 'Turquoise';
        Text19036415: label 'Light Turquoise';
        Text19022310: label 'Gray - 50%';
        Text19057446: label 'Gray - 40%';
        Text19006866: label 'Sky Blue';
        Text19073657: label 'Plum';
        Text19074475: label 'Gray - 25%';
        Text19051685: label 'Pale Blue';
        Text19016082: label 'Lavender';
        Text19046141: label 'White';
}

