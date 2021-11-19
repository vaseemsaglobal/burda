Page 50017 "Sub Products"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New form for Magazine - Magazine Sales Module
    UsageCategory = Administration;
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Sub Product";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Product Code"; "Product Code")
                {
                    ApplicationArea = Basic;

                }
                field("Code"; "Sub Product Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(PaymentMethodforDelivery; "Payment Method for Delivery")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumNoofPage; "Minimum No. of Page")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultGenProdPosting; "Default Gen. Prod. Posting")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension1Code; "Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
                {
                    ApplicationArea = Basic;

                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;

                }
                field(DeferRevenueSSAccount; "Defer Revenue SS Account")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency; Frequency)
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure"; "Unit Of Measure Code")
                {
                    ApplicationArea = Basic;

                }
                field(MagazineItemNos; "Magazine Item Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PickupInterval; "Pick-up Interval")
                {
                    ApplicationArea = Basic;
                }
                field(UnitPrice; "Unit Price")
                {
                    ApplicationArea = Basic;
                }
                field(AdsClosingInterval; "Ads. Closing Interval")
                {
                    ApplicationArea = Basic;
                }
                field(SubscriberSONos; "Subscriber S/O Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(CirculationSONos; "Circulation S/O Nos.")
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

