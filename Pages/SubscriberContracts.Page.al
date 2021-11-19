page 50009 "Subscriber Contracts"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // GKU : Goragot Kuanmuang
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   07.03.2007   KKE   New Form for Subscriber Contract Card.
    // 002   04.10.2007   GKU   Edit tab Payment use Credit Charge Amount(Cust.) instead Credit Card Charge Fee in last line

    PageType = Card;
    SourceTable = "Subscriber Contract";
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
                field("Subscriber No."; "Subscriber No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Subscriber No.Editable";
                }
                field(GetSubscriberName; GetSubscriberName)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Sub Type"; "Contract Sub Type")
                {
                    ApplicationArea = Basic;
                }
                field("VIP Type"; "VIP Type")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Category"; "Contract Category")
                {
                    ApplicationArea = Basic;
                }
                field("Renew Contract From"; "Renew Contract From")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Renew Contract To"; "Renew Contract To")
                {
                    ApplicationArea = Basic;
                }
                field("Resource Lead"; "Resource Lead")
                {
                    ApplicationArea = Basic;
                }
                field("Resource Channel"; "Resource Channel")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Quantity"; "Contract Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Net Price"; "Contract Net Price")
                {
                    ApplicationArea = Basic;
                }
                field("Magazine Code"; "Magazine Code")
                {
                    ApplicationArea = Basic;
                }

                field("Starting Magazine Item No."; "Starting Magazine Item No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Magazine Item No.';
                }
                field("Ending Magazine Item No."; "Ending Magazine Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Volume No."; "Starting Volume No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Volume No.';
                }
                field("Ending Volume No."; "Ending Volume No.")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Issue No."; "Starting Issue No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue No.';
                }
                field("Starting Issue Date"; "Starting Issue Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue Date';
                }
                field("Ending Issue No."; "Ending Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Issue Date"; "Ending Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Issue No."; "Contract Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Status"; "Contract Status")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Payment Status"; "Payment Status")
                {
                    ApplicationArea = Basic;
                }
                field("Subscription Date"; "Subscription Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expired Date"; "Expired Date")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field(Block; Block)
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Code"; "Promotion Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        PromotionCodeOnAfterValidate;
                    end;
                }
                field("Promotion Type"; "Promotion Type")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Price"; "Promotion Price")
                {
                    ApplicationArea = Basic;
                }
                field("Discount Type"; "Discount Type")
                {
                    ApplicationArea = Basic;
                }
                field("Discount Value"; "Discount Value")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Net Price"; "Promotion Net Price")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Quantity"; "Promotion Quantity")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Duration"; "Promotion Duration")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Premium)
            {
                Caption = 'Premium';
                field("Premium Flag"; "Premium Flag")
                {
                    ApplicationArea = Basic;

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
                field("Premium Item 11"; Item.GetItemName("Premium Item 1"))
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Premium Item 21"; Item.GetItemName("Premium Item 2"))
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Premium Item 31"; Item.GetItemName("Premium Item 3"))
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Premium Item 41"; Item.GetItemName("Premium Item 4"))
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Premium Item 51"; "Premium Item 5")
                {
                    ApplicationArea = Basic;
                    Editable = "Premium Item 5Editable";
                }

                field("Free Magazine Flag"; "Free Magazine Flag")
                {
                    ApplicationArea = Basic;

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
                field("Related Contract No."; "Related Contract No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Related Contract No.Editable";
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
                label(Label3)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19080001;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("Premium Start Volume No."; "Premium Start Volume No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Volume No.';
                    Visible = false;
                }
                field("Premium Start Issue No."; "Premium Start Issue No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue No.';
                    Visible = false;
                }
                field("Premium Start Issue Date"; "Premium Start Issue Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue Date';
                    Visible = false;
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
                label(label)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19080002;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("Premium End Volume No."; "Premium End Volume No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'End Volume No.';
                    Visible = false;
                }
                field("Premium End Issue No."; "Premium End Issue No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue No.';
                    Visible = false;
                }
                field("Premium End Issue Date"; "Premium End Issue Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue Date';
                    Visible = false;
                }
            }
            group(Payment)
            {
                Caption = 'Payment';
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Remark"; "Payment Remark")
                {
                    ApplicationArea = Basic;
                }
                label(label1)
                {
                    ApplicationArea = Basic;
                    CaptionClass = 'Payment By';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(PaymentOpt1; PaymentOpt[1])
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash';

                    trigger OnValidate()
                    begin
                        PaymentOpt1OnAfterValidate;
                    end;
                }
                field(PaymentOpt2; PaymentOpt[2])
                {
                    ApplicationArea = Basic;
                    Caption = 'Transfer';

                    trigger OnValidate()
                    begin
                        PaymentOpt2OnAfterValidate;
                    end;
                }
                field(PaymentOpt3; PaymentOpt[3])
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal';

                    trigger OnValidate()
                    begin
                        PaymentOpt3OnAfterValidate;
                    end;
                }
                field("Receipt No."; "Receipt No.")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Amount"; "Receipt Amount")
                {
                    ApplicationArea = Basic;
                }

                label(label11)
                {
                    ApplicationArea = Basic;
                    CaptionClass = 'Credit Card Payment';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Credit Card Bank"; "Credit Card Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Card Type"; "Credit Card Type")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Card No."; "Credit Card No.")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Card 3Last No."; "Credit Card 3Last No.")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Card Expire Date"; "Credit Card Expire Date")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Card Base Amount"; "Credit Card Base Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Charge Amount (Cust.)1"; "Credit Charge Amount (Cust.)")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Card Bank Amount"; "Credit Card Bank Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Card Charge Fee"; "Credit Card Charge Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Card Amount"; "Credit Card Amount")
                {
                    ApplicationArea = Basic;
                }

                label(label10)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19042867;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch"; "Bank Branch")
                {
                    ApplicationArea = Basic;
                }
                field("Check No."; "Check No.")
                {
                    ApplicationArea = Basic;
                }
                field("Check Date"; "Check Date")
                {
                    ApplicationArea = Basic;
                }
                field("Check Amount"; "Check Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Promotion Net Price1"; "Promotion Net Price")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Charge Amount (Cust.)"; "Credit Charge Amount (Cust.)")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Method (Charge Fee)"; "Payment Method (Charge Fee)")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Order"; "Postal Order")
                {
                    ApplicationArea = Basic;
                }


                field(ReceiptCreditCardCheckAmt; "Receipt Amount" + "Credit Card Amount" + "Check Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Paid Amount';
                    Editable = false;
                }
                field(Balance1; "Promotion Net Price" + "Credit Charge Amount (Cust.)" - ("Receipt Amount" + "Credit Card Amount" + "Check Amount"))
                {
                    ApplicationArea = Basic;
                    Caption = 'Balance';
                    Editable = false;
                }
            }
            group(Delivery)
            {
                Caption = 'Delivery';
                group("Last Generate Sale Order")
                {
                    Caption = 'Last Generate Sale Order';
                    field("Last SO Magazine Item No."; "Last SO Magazine Item No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Magazine Item No.';
                    }
                    field("Last SO Date"; "Last SO Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Sales Order Date';
                    }
                    field("Last SO Doc. No."; "Last SO Doc. No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Sales Order No.';
                    }
                }
                group("Last Generate Shipment")
                {
                    Caption = 'Last Generate Shipment';
                    field("Last Shipment Magazine Item No"; "Last Shipment Magazine Item No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Magazine Item No.';
                    }
                    field("Last Shipment Date"; "Last Shipment Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Shipment Date';
                    }
                    field("Last Shipment Doc. No."; "Last Shipment Doc. No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Shipment Doc. No.';
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Contract")
            {
                Caption = '&Contract';
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Subscriber Contract L/E";
                    RunPageLink = "Subscriber Contract No." = FIELD("No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Subscriber Contract"), "No." = FIELD("No.");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Create Subscriber Contract L/E")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Subscriber Contract L/E';

                    trigger OnAction()
                    begin
                        CreateSubscriberContractLE;
                    end;
                }
                action("Renew Subscriber Contract")
                {
                    ApplicationArea = Basic;
                    Caption = 'Renew Subscriber Contract';

                    trigger OnAction()
                    begin
                        RenewSubscriberContract;
                    end;
                }
                separator(separator)
                {
                }
                action("Create Subscriber Payment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Subscriber Payment';
                    RunObject = Codeunit "Create Subscriber Payment";
                }
                action("Reverse Promotion")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reverse Promotion';
                    RunObject = Codeunit "Reverse Subscriber Promotion";
                }
                separator(separator1)
                {
                }
                action("Con&firm")
                {
                    ApplicationArea = Basic;
                    Caption = 'Con&firm';

                    trigger OnAction()
                    begin
                        ConfirmContract;
                    end;
                }
                action("Re&lease")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;

                    trigger OnAction()
                    begin
                        Release;
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        Reopen;
                    end;
                }
                action("Ca&ncel")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ca&ncel';

                    trigger OnAction()
                    begin
                        Cancel;
                    end;
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
        "Related Contract No.Editable" := TRUE;
        "Free Magazine QuantityEditable" := TRUE;
        "Free Magazine CodeEditable" := TRUE;
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
        "Subscriber No.Editable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        Item: Record item;
        PaymentOpt: array[3] of Boolean;
        [InDataSet]
        "Subscriber No.Editable": Boolean;
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
        "Free Magazine CodeEditable": Boolean;
        [InDataSet]
        "Free Magazine QuantityEditable": Boolean;
        [InDataSet]
        "Related Contract No.Editable": Boolean;
        [InDataSet]
        FreeOtherMagazineCodeEditable: Boolean;
        [InDataSet]
        FreeOtherMagazineQuantityEdita: Boolean;
        Text19042867: Label 'Case: Check Payment';
        Text19030874: Label 'Start';
        Text19032217: Label 'End';
        Text19080001: Label 'Start';
        Text19080002: Label 'End';

    //[Scope('Internal')]
    procedure SetEditable()
    var
        EditDisc: Boolean;
        EditPremium: Boolean;
    begin
        "Premium Item 1Editable" := "Premium Flag";
        "Premium Item 2Editable" := "Premium Flag";
        "Premium Item 3Editable" := "Premium Flag";
        "Premium Item 4Editable" := "Premium Flag";
        "Premium Item 5Editable" := "Premium Flag";
        "Premium Quantity 1Editable" := "Premium Flag";
        "Premium Quantity 2Editable" := "Premium Flag";
        "Premium Quantity 3Editable" := "Premium Flag";
        "Premium Quantity 4Editable" := "Premium Flag";
        "Premium Quantity 5Editable" := "Premium Flag";
        "Free Magazine CodeEditable" := "Free Magazine Flag";
        "Free Magazine QuantityEditable" := "Free Magazine Flag";
        "Related Contract No.Editable" := "Free Magazine Flag";
        FreeOtherMagazineCodeEditable := "Free Magazine Flag";
        FreeOtherMagazineQuantityEdita := "Free Magazine Flag";
    end;

    local procedure PromotionCodeOnAfterValidate()
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

    local procedure PaymentOpt1OnAfterValidate()
    begin
        "Payment Option" := "Payment Option"::" ";
        PaymentOpt[2] := FALSE;
        PaymentOpt[3] := FALSE;
        CASE TRUE OF
            PaymentOpt[1]:
                "Payment Option" := "Payment Option"::Cash;
            PaymentOpt[2]:
                "Payment Option" := "Payment Option"::Transfer;
            PaymentOpt[3]:
                "Payment Option" := "Payment Option"::"Postal Order";
        END;
    end;

    local procedure PaymentOpt2OnAfterValidate()
    begin
        "Payment Option" := "Payment Option"::" ";
        PaymentOpt[1] := FALSE;
        PaymentOpt[3] := FALSE;
        CASE TRUE OF
            PaymentOpt[1]:
                "Payment Option" := "Payment Option"::Cash;
            PaymentOpt[2]:
                "Payment Option" := "Payment Option"::Transfer;
            PaymentOpt[3]:
                "Payment Option" := "Payment Option"::"Postal Order";
        END;
    end;

    local procedure PaymentOpt3OnAfterValidate()
    begin
        "Payment Option" := "Payment Option"::" ";
        PaymentOpt[1] := FALSE;
        PaymentOpt[2] := FALSE;
        CASE TRUE OF
            PaymentOpt[1]:
                "Payment Option" := "Payment Option"::Cash;
            PaymentOpt[2]:
                "Payment Option" := "Payment Option"::Transfer;
            PaymentOpt[3]:
                "Payment Option" := "Payment Option"::"Postal Order";
        END;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        "Subscriber No.Editable" := "Contract Category" <> "Contract Category"::Renew;
        SetEditable;
        CLEAR(PaymentOpt);
        IF "Payment Option" <> 0 THEN
            PaymentOpt["Payment Option"] := TRUE;
    end;

    var

}

