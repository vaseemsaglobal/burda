page 50007 "Subscriber Promotion"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   07.03.2007   KKE   New Form for Promotion Card.

    PageType = Card;
    SourceTable = Promotion;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Limitation Quantity"; "Limitation Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Magazine Item Code"; "Magazine Item Code")
                {
                    ApplicationArea = Basic;
                }
                field("Magazine Code"; "Magazine Code")
                {
                    ApplicationArea = Basic;
                }
                field("Volume No."; "Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field("Issue No."; "Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Date"; "Promotion Date")
                {
                    ApplicationArea = Basic;
                }

                field("Promotion Type"; "Promotion Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    var
                    begin
                        PromotionTypeOnAfterValidate;
                        //SetEditable;

                    end;
                }
                field("Promotion Duration1"; "Promotion Duration")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Promotion Price1"; "Promotion Price")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Promotion Quantity1"; "Promotion Quantity")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Promotion Net Price1"; "Promotion Net Price")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }

            }
            group(Discount)
            {
                Caption = 'Discount';
                field("Discount Type"; "Discount Type")
                {
                    ApplicationArea = Basic;
                    Editable = "Discount TypeEditable";
                }
                field("Discount Value"; "Discount Value")
                {
                    ApplicationArea = Basic;
                    Editable = "Discount ValueEditable";
                }
                field("Credit Card Bank"; "Credit Card Bank")
                {
                    ApplicationArea = Basic;
                    Editable = "Credit Card BankEditable";
                }
                field("Promotion Duration"; "Promotion Duration")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Promotion Price"; "Promotion Price")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Promotion Quantity"; "Promotion Quantity")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Promotion Net Price"; "Promotion Net Price")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Premium)
            {
                Caption = 'Premium';
                field("Premium Flag"; "Premium Flag")
                {
                    ApplicationArea = Basic;
                    Caption = 'Premium';
                    Editable = "Premium FlagEditable";

                    trigger OnValidate()
                    begin
                        PremiumFlagOnAfterValidate;
                    end;
                }
                field("Premium Item 1"; "Premium Item 1")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Item 1Editable";
                }
                field("Premium Item 2"; "Premium Item 2")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Item 2Editable";
                }
                field("Premium Item 3"; "Premium Item 3")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Item 3Editable";
                }
                field("Premium Item 4"; "Premium Item 4")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Item 4Editable";
                }
                field("Premium Item 5"; "Premium Item 5")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Item 5Editable";
                }
                field("Premium Quantity 1"; "Premium Quantity 1")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Quantity 1Editable";
                }
                field("Premium Quantity 2"; "Premium Quantity 2")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Quantity 2Editable";
                }
                field("Premium Quantity 3"; "Premium Quantity 3")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Quantity 3Editable";
                }
                field("Premium Quantity 4"; "Premium Quantity 4")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Quantity 4Editable";
                }
                field("Premium Quantity 5"; "Premium Quantity 5")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Quantity 5Editable";
                }
            }
            group("Free Magazine")
            {
                Caption = 'Free Magazine';
                field("Free Magazine Flag"; "Free Magazine Flag")
                {
                    ApplicationArea = Basic;
                    Caption = 'Free Magazine';
                    Editable = "Free Magazine FlagEditable";

                    trigger OnValidate()
                    begin
                        FreeMagazineFlagOnAfterValidat;
                    end;
                }
                field("Free Magazine Code"; "Free Magazine Code")
                {
                    ApplicationArea = Basic;
                    Editable = "Free Magazine CodeEditable";
                }
                field("Free Magazine Quantity"; "Free Magazine Quantity")
                {
                    ApplicationArea = Basic;
                    Editable = "Free Magazine QuantityEditable";
                }
                label(label)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19026429;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Free Other Magazine Code"; "Free Other Magazine Code")
                {
                    ApplicationArea = Basic;
                    Editable = FreeOtherMagazineCodeEditable;
                }
                field("Free Other Magazine Quantity"; "Free Other Magazine Quantity")
                {
                    ApplicationArea = Basic;
                    Editable = FreeOtherMagazineQuantityEdita;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Promotion")
            {
                Caption = '&Promotion';
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Promotion), "No." = FIELD("No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        FreeOtherMagazineQuantityEdita := TRUE;
        FreeOtherMagazineCodeEditable := TRUE;
        "Free Magazine QuantityEditable" := TRUE;
        "Free Magazine CodeEditable" := TRUE;
        "Free Magazine FlagEditable" := TRUE;
        "Premium Quantity 5Editable" := TRUE;
        "Premium Quantity 4Editable" := TRUE;
        "Premium Quantity 3Editable" := TRUE;
        "Premium Quantity 2Editable" := TRUE;
        "Premium Quantity 1Editable" := TRUE;
        "Premium Item 5Editable" := TRUE;
        "Premium Item 4Editable" := TRUE;
        "Premium Item 3Editable" := TRUE;
        "Premium Item 2Editable" := TRUE;
        "Premium Item 1Editable" := TRUE;
        "Premium FlagEditable" := TRUE;
        "Credit Card BankEditable" := TRUE;
        "Discount ValueEditable" := TRUE;
        "Discount TypeEditable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        [InDataSet]
        "Discount TypeEditable": Boolean;
        [InDataSet]
        "Discount ValueEditable": Boolean;
        [InDataSet]
        "Credit Card BankEditable": Boolean;
        [InDataSet]
        "Premium FlagEditable": Boolean;
        [InDataSet]
        "Premium Item 1Editable": Boolean;
        [InDataSet]
        "Premium Item 2Editable": Boolean;
        [InDataSet]
        "Premium Item 3Editable": Boolean;
        [InDataSet]
        "Premium Item 4Editable": Boolean;
        [InDataSet]
        "Premium Item 5Editable": Boolean;
        [InDataSet]
        "Premium Quantity 1Editable": Boolean;
        [InDataSet]
        "Premium Quantity 2Editable": Boolean;
        [InDataSet]
        "Premium Quantity 3Editable": Boolean;
        [InDataSet]
        "Premium Quantity 4Editable": Boolean;
        [InDataSet]
        "Premium Quantity 5Editable": Boolean;
        [InDataSet]
        "Free Magazine FlagEditable": Boolean;
        [InDataSet]
        "Free Magazine CodeEditable": Boolean;
        [InDataSet]
        "Free Magazine QuantityEditable": Boolean;
        [InDataSet]
        FreeOtherMagazineCodeEditable: Boolean;
        [InDataSet]
        FreeOtherMagazineQuantityEdita: Boolean;
        Text19026429: Label 'Free Other Magazine';

    //[Scope('Internal')]
    procedure SetEditable()
    var
        EditDisc: Boolean;
        EditPremium: Boolean;
    begin
        EditDisc := "Promotion Type" IN ["Promotion Type"::Discount, "Promotion Type"::Both];
        "Discount TypeEditable" := EditDisc;
        "Discount ValueEditable" := EditDisc;
        "Credit Card BankEditable" := EditDisc;
        EditPremium := "Promotion Type" IN ["Promotion Type"::Premium, "Promotion Type"::Both];
        "Premium FlagEditable" := EditPremium;
        "Premium Item 1Editable" := EditPremium AND "Premium Flag";
        "Premium Item 2Editable" := EditPremium AND "Premium Flag";
        "Premium Item 3Editable" := EditPremium AND "Premium Flag";
        "Premium Item 4Editable" := EditPremium AND "Premium Flag";
        "Premium Item 5Editable" := EditPremium AND "Premium Flag";
        "Premium Quantity 1Editable" := EditPremium AND "Premium Flag";
        "Premium Quantity 2Editable" := EditPremium AND "Premium Flag";
        "Premium Quantity 3Editable" := EditPremium AND "Premium Flag";
        "Premium Quantity 4Editable" := EditPremium AND "Premium Flag";
        "Premium Quantity 5Editable" := EditPremium AND "Premium Flag";
        "Free Magazine FlagEditable" := EditPremium;
        "Free Magazine CodeEditable" := EditPremium AND "Free Magazine Flag";
        "Free Magazine QuantityEditable" := EditPremium AND "Free Magazine Flag";
        FreeOtherMagazineCodeEditable := EditPremium AND "Free Magazine Flag";
        FreeOtherMagazineQuantityEdita := EditPremium AND "Free Magazine Flag";
    end;

    local procedure PromotionTypeOnAfterValidate()
    begin
        SetEditable;
    end;

    local procedure PremiumFlagOnAfterValidate()
    begin
        SetEditable;
    end;

    local procedure FreeMagazineFlagOnAfterValidat()
    begin
        SetEditable;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        SetEditable;
    end;
}

