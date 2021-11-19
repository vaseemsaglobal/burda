PageExtension 50025 pageextension50025 extends "Purchase Invoice"
{
    layout
    {

        modify("No.")
        {
            Editable = "No.Editable";
        }
        modify("Buy-from Vendor No.")
        {
            Editable = "Buy-from Vendor No.Editable";
        }
        modify("Buy-from Contact No.")
        {
            Editable = "Buy-from Contact No.Editable";
        }
        modify("Buy-from Vendor Name")
        {
            Editable = "Buy-from Vendor NameEditable";
        }
        modify("Buy-from Address")
        {
            Editable = "Buy-from AddressEditable";
        }
        modify("Buy-from Address 2")
        {
            Editable = "Buy-from Address 2Editable";
        }
        modify("Buy-from Post Code")
        {
            Editable = "Buy-from Post CodeEditable";
        }
        modify("Buy-from City")
        {
            Editable = "Buy-from CityEditable";
        }
        modify("Buy-from County")
        {
            Editable = "Buy-from CountyEditable";
        }
        modify("Buy-from Country/Region Code")
        {
            Editable = BuyfromCountryRegionCodeEditab;
        }
        modify("Buy-from Contact")
        {
            Editable = "Buy-from ContactEditable";
        }
        modify("Posting Date")
        {
            Editable = "Posting DateEditable";
        }
        modify("Document Date")
        {
            Editable = "Document DateEditable";
        }
        modify("Vendor Invoice No.")
        {
            Editable = "Vendor Invoice No.Editable";
        }
        modify("Order Address Code")
        {
            Editable = "Order Address CodeEditable";
        }
        modify("Purchaser Code")
        {
            Editable = "Purchaser CodeEditable";
        }
        modify("Campaign No.")
        {
            Editable = "Campaign No.Editable";
        }
        modify("Responsibility Center")
        {
            Editable = "Responsibility CenterEditable";
        }
        modify("Assigned User ID")
        {
            Editable = "Assigned User IDEditable";
        }

        modify("Pay-to Contact No.")
        {
            Editable = "Pay-to Contact No.Editable";
        }
        modify("Pay-to Name")
        {
            Editable = "Pay-to NameEditable";
        }
        modify("Pay-to Address")
        {
            Editable = "Pay-to AddressEditable";
        }
        modify("Pay-to Address 2")
        {
            Editable = "Pay-to Address 2Editable";
        }
        modify("Pay-to Post Code")
        {
            Editable = "Pay-to Post CodeEditable";
        }
        modify("Pay-to City")
        {
            Editable = "Pay-to CityEditable";
        }
        modify("Pay-to County")
        {
            Editable = "Pay-to CountyEditable";
        }
        modify("Pay-to Country/Region Code")
        {
            Editable = PaytoCountryRegionCodeEditable;
        }
        modify("Pay-to Contact")
        {
            Editable = "Pay-to ContactEditable";
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = ShortcutDimension1CodeEditable;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = ShortcutDimension2CodeEditable;
        }
        modify("Payment Terms Code")
        {
            Editable = "Payment Terms CodeEditable";
        }
        modify("Due Date")
        {
            Editable = "Due DateEditable";
        }
        modify("Payment Discount %")
        {
            Editable = "Payment Discount %Editable";
        }
        modify("Pmt. Discount Date")
        {
            Editable = "Pmt. Discount DateEditable";
        }
        modify("Payment Method Code")
        {
            Editable = "Payment Method CodeEditable";
        }
        modify("On Hold")
        {
            Editable = "On HoldEditable";
        }
        modify("Prices Including VAT")
        {
            Editable = "Prices Including VATEditable";
        }
        modify("VAT Bus. Posting Group")
        {
            Editable = "VAT Bus. Posting GroupEditable";
        }
        modify("Ship-to Name")
        {
            Editable = "Ship-to NameEditable";
        }
        modify("Ship-to Address")
        {
            Editable = "Ship-to AddressEditable";
        }
        modify("Ship-to Address 2")
        {
            Editable = "Ship-to Address 2Editable";
        }
        modify("Ship-to Post Code")
        {
            Editable = "Ship-to Post CodeEditable";
        }
        modify("Ship-to City")
        {
            Editable = "Ship-to CityEditable";
        }
        modify("Ship-to County")
        {
            Editable = "Ship-to CountyEditable";
        }
        modify("Ship-to Country/Region Code")
        {
            Editable = ShiptoCountryRegionCodeEditabl;
        }
        modify("Ship-to Contact")
        {
            Editable = "Ship-to ContactEditable";
        }
        modify("Location Code")
        {
            Editable = "Location CodeEditable";
        }
        modify("Shipment Method Code")
        {
            Editable = "Shipment Method CodeEditable";
        }
        modify("Expected Receipt Date")
        {
            Editable = "Expected Receipt DateEditable";
        }
        modify("Currency Code")
        {
            Editable = "Currency CodeEditable";
        }
        modify("Transaction Type")
        {
            Editable = "Transaction TypeEditable";
        }
        modify("Transaction Specification")
        {
            Editable = TransactionSpecificationEditab;
        }
        modify("Transport Method")
        {
            Editable = "Transport MethodEditable";
        }
        modify("Entry Point")
        {
            Editable = "Entry PointEditable";
        }
        modify("Area")
        {
            Editable = AreaEditable;
        }

        modify("Applies-to Doc. Type")
        {
            Editable = "Applies-to Doc. TypeEditable";
        }
        modify("Applies-to Doc. No.")
        {
            Editable = "Applies-to Doc. No.Editable";
        }


        addafter("Buy-from Address 2")
        {
            field("Buy-from Address 3"; "Buy-from Address 3")
            {
                ApplicationArea = Basic;
                Editable = "Buy-from Address 3Editable";
            }
        }
        addafter(Status)
        {
            field("Cal. WHT for any Inv. Amount"; "Cal. WHT for any Inv. Amount")
            {
                ApplicationArea = Basic;
                Editable = CalWHTforanyInvAmountEditable;
            }

        }
        addafter("Pay-to Address 2")
        {
            field("Pay-to Address 3"; "Pay-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = "Pay-to Address 3Editable";
            }
        }
        addafter("Vendor Exchange Rate (ACY)")
        {
            field("Invoice Description"; "Invoice Description")
            {
                ApplicationArea = Basic;
                Editable = VendorExchangeRateACYEditable;
            }
        }
        addafter("Ship-to Address 2")
        {
            field("Ship-to Address 3"; "Ship-to Address 3")
            {
                ApplicationArea = Basic;
                Editable = "Ship-to Address 3Editable";
            }
        }
        addafter(Application)
        {
            group("Address (Thai)")
            {
                Caption = 'Address (Thai)';
                field("Buy-from Name (Thai)"; "Buy-from Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = "Buy-from Name (Thai)Editable";
                }
                field("Buy-from Address (Thai)"; "Buy-from Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = BuyfromAddressThaiEditable;
                    MultiLine = true;
                }
                field("Pay-to Name (Thai)"; "Pay-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = "Pay-to Name (Thai)Editable";
                }
                field("Pay-to Address (Thai)"; "Pay-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = "Pay-to Address (Thai)Editable";
                    MultiLine = true;
                }
                field("Ship-to Name (Thai)"; "Ship-to Name (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = "Ship-to Name (Thai)Editable";
                }
                field("Ship-to Address (Thai)"; "Ship-to Address (Thai)")
                {
                    ApplicationArea = Basic;
                    Editable = "Ship-to Address (Thai)Editable";
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {


        addafter("P&osting")
        {
            group("P&rint")
            {

                action("Account Payable Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Payable Voucher';

                    trigger OnAction()
                    var
                        PurchHeader: Record "Purchase Header";
                    begin
                        //KKE : #002 +
                        TestField(Status, Status::Released);
                        PurchHeader.Reset;
                        PurchHeader.SetRange("Document Type", "Document Type");
                        PurchHeader.SetRange("No.", "No.");
                        Report.Run(Report::"Account Payable Voucher", true, false, PurchHeader);
                        //KKE : #002 -
                    end;
                }
            }
        }
    }

    var
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        "Buy-from Vendor No.Editable": Boolean;
        [InDataSet]
        "Buy-from Vendor NameEditable": Boolean;
        [InDataSet]
        "Buy-from AddressEditable": Boolean;
        [InDataSet]
        "Buy-from Address 2Editable": Boolean;
        [InDataSet]
        "Buy-from CityEditable": Boolean;
        [InDataSet]
        "Buy-from ContactEditable": Boolean;
        [InDataSet]
        "Posting DateEditable": Boolean;
        [InDataSet]
        "Buy-from Post CodeEditable": Boolean;
        [InDataSet]
        "Document DateEditable": Boolean;
        [InDataSet]
        "Vendor Invoice No.Editable": Boolean;
        [InDataSet]
        "Order Address CodeEditable": Boolean;
        [InDataSet]
        "Campaign No.Editable": Boolean;
        [InDataSet]
        "Purchaser CodeEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Assigned User IDEditable": Boolean;
        [InDataSet]
        "Buy-from Contact No.Editable": Boolean;
        [InDataSet]
        "Buy-from CountyEditable": Boolean;
        [InDataSet]
        BuyfromCountryRegionCodeEditab: Boolean;
        [InDataSet]
        "Buy-from Address 3Editable": Boolean;
        [InDataSet]
        CalWHTforanyInvAmountEditable: Boolean;
        [InDataSet]
        "Pay-to Vendor No.Editable": Boolean;
        [InDataSet]
        "Pay-to NameEditable": Boolean;
        [InDataSet]
        "Pay-to AddressEditable": Boolean;
        [InDataSet]
        "Pay-to Address 2Editable": Boolean;
        [InDataSet]
        "Pay-to CityEditable": Boolean;
        [InDataSet]
        "Pay-to ContactEditable": Boolean;
        [InDataSet]
        "Payment Terms CodeEditable": Boolean;
        [InDataSet]
        "Due DateEditable": Boolean;
        [InDataSet]
        "Payment Discount %Editable": Boolean;
        [InDataSet]
        "Pmt. Discount DateEditable": Boolean;
        [InDataSet]
        ShortcutDimension1CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        "On HoldEditable": Boolean;
        [InDataSet]
        "Pay-to Post CodeEditable": Boolean;
        [InDataSet]
        "Payment Method CodeEditable": Boolean;
        [InDataSet]
        "Prices Including VATEditable": Boolean;
        [InDataSet]
        "Pay-to Contact No.Editable": Boolean;
        [InDataSet]
        "Pay-to CountyEditable": Boolean;
        [InDataSet]
        PaytoCountryRegionCodeEditable: Boolean;
        [InDataSet]
        "VAT Bus. Posting GroupEditable": Boolean;
        [InDataSet]
        "Pay-to Address 3Editable": Boolean;
        [InDataSet]
        "Invoice DescriptionEditable": Boolean;
        [InDataSet]
        "Ship-to NameEditable": Boolean;
        [InDataSet]
        "Ship-to AddressEditable": Boolean;
        [InDataSet]
        "Ship-to Address 2Editable": Boolean;
        [InDataSet]
        "Ship-to CityEditable": Boolean;
        [InDataSet]
        "Ship-to ContactEditable": Boolean;
        [InDataSet]
        "Shipment Method CodeEditable": Boolean;
        [InDataSet]
        "Expected Receipt DateEditable": Boolean;
        [InDataSet]
        "Location CodeEditable": Boolean;
        [InDataSet]
        "Ship-to Post CodeEditable": Boolean;
        [InDataSet]
        "Ship-to CountyEditable": Boolean;
        [InDataSet]
        ShiptoCountryRegionCodeEditabl: Boolean;
        [InDataSet]
        "Ship-to Address 3Editable": Boolean;
        [InDataSet]
        "Transaction TypeEditable": Boolean;
        [InDataSet]
        "Transport MethodEditable": Boolean;
        [InDataSet]
        "Entry PointEditable": Boolean;
        [InDataSet]
        AreaEditable: Boolean;
        [InDataSet]
        TransactionSpecificationEditab: Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        "Applies-to Doc. TypeEditable": Boolean;
        [InDataSet]
        "Applies-to Doc. No.Editable": Boolean;
        [InDataSet]
        "Buy-from Name (Thai)Editable": Boolean;
        [InDataSet]
        BuyfromAddressThaiEditable: Boolean;
        [InDataSet]
        "Pay-to Name (Thai)Editable": Boolean;
        [InDataSet]
        "Pay-to Address (Thai)Editable": Boolean;
        [InDataSet]
        "Ship-to Name (Thai)Editable": Boolean;
        [InDataSet]
        "Ship-to Address (Thai)Editable": Boolean;
        [InDataSet]
        VendorExchangeRateACYEditable: Boolean;


    procedure SetEditableForm(AllowEdit: Boolean)
    begin
        "No.Editable" := AllowEdit;
        "Buy-from Vendor No.Editable" := AllowEdit;
        "Buy-from Vendor NameEditable" := AllowEdit;
        "Buy-from AddressEditable" := AllowEdit;
        "Buy-from Address 2Editable" := AllowEdit;
        "Buy-from CityEditable" := AllowEdit;
        "Buy-from ContactEditable" := AllowEdit;
        "Posting DateEditable" := AllowEdit;
        "Buy-from Post CodeEditable" := AllowEdit;
        "Document DateEditable" := AllowEdit;
        "Vendor Invoice No.Editable" := AllowEdit;
        "Order Address CodeEditable" := AllowEdit;
        "Campaign No.Editable" := AllowEdit;
        "Purchaser CodeEditable" := AllowEdit;
        "Responsibility CenterEditable" := AllowEdit;
        "Assigned User IDEditable" := AllowEdit;
        "Buy-from Contact No.Editable" := AllowEdit;
        "Buy-from CountyEditable" := AllowEdit;
        BuyfromCountryRegionCodeEditab := AllowEdit;
        "Buy-from Address 3Editable" := AllowEdit;
        CalWHTforanyInvAmountEditable := AllowEdit;
        "Pay-to Vendor No.Editable" := AllowEdit;
        "Pay-to NameEditable" := AllowEdit;
        "Pay-to AddressEditable" := AllowEdit;
        "Pay-to Address 2Editable" := AllowEdit;
        "Pay-to CityEditable" := AllowEdit;
        "Pay-to ContactEditable" := AllowEdit;
        "Payment Terms CodeEditable" := AllowEdit;
        "Due DateEditable" := AllowEdit;
        "Payment Discount %Editable" := AllowEdit;
        "Pmt. Discount DateEditable" := AllowEdit;
        ShortcutDimension1CodeEditable := AllowEdit;
        ShortcutDimension2CodeEditable := AllowEdit;
        "On HoldEditable" := AllowEdit;
        "Pay-to Post CodeEditable" := AllowEdit;
        "Payment Method CodeEditable" := AllowEdit;
        "Prices Including VATEditable" := AllowEdit;
        "Pay-to Contact No.Editable" := AllowEdit;
        "Pay-to CountyEditable" := AllowEdit;
        PaytoCountryRegionCodeEditable := AllowEdit;
        "VAT Bus. Posting GroupEditable" := AllowEdit;
        VendorExchangeRateACYEditable := AllowEdit;
        "Pay-to Address 3Editable" := AllowEdit;
        "Invoice DescriptionEditable" := AllowEdit;
        "Ship-to NameEditable" := AllowEdit;
        "Ship-to AddressEditable" := AllowEdit;
        "Ship-to Address 2Editable" := AllowEdit;
        "Ship-to CityEditable" := AllowEdit;
        "Ship-to ContactEditable" := AllowEdit;
        "Shipment Method CodeEditable" := AllowEdit;
        "Expected Receipt DateEditable" := AllowEdit;
        "Location CodeEditable" := AllowEdit;
        "Ship-to Post CodeEditable" := AllowEdit;
        "Ship-to CountyEditable" := AllowEdit;
        ShiptoCountryRegionCodeEditabl := AllowEdit;
        "Ship-to Address 3Editable" := AllowEdit;
        "Transaction TypeEditable" := AllowEdit;
        "Transport MethodEditable" := AllowEdit;
        "Entry PointEditable" := AllowEdit;
        AreaEditable := AllowEdit;
        TransactionSpecificationEditab := AllowEdit;
        "Currency CodeEditable" := AllowEdit;
        "Applies-to Doc. TypeEditable" := AllowEdit;
        "Applies-to Doc. No.Editable" := AllowEdit;
        "Buy-from Name (Thai)Editable" := AllowEdit;
        BuyfromAddressThaiEditable := AllowEdit;
        "Pay-to Name (Thai)Editable" := AllowEdit;
        "Pay-to Address (Thai)Editable" := AllowEdit;
        "Ship-to Name (Thai)Editable" := AllowEdit;
        "Ship-to Address (Thai)Editable" := AllowEdit;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //xRec := Rec;
        SetEditableForm(Status = Status::Open);  //KKE : #003
    end;

}

