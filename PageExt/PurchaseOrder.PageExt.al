PageExtension 50024 pageextension50024 extends "Purchase Order"
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
        modify("Buy-from Contact")
        {
            Editable = "Buy-from ContactEditable";
        }
        modify("Posting Date")
        {
            Editable = "Posting DateEditable";
        }
        modify("Order Date")
        {
            Editable = "Order DateEditable";
        }
        modify("Document Date")
        {
            Editable = "Document DateEditable";
        }
        modify("Vendor Order No.")
        {
            Editable = "Vendor Order No.Editable";
        }
        modify("Vendor Shipment No.")
        {
            Editable = "Vendor Shipment No.Editable";
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
        modify("Responsibility Center")
        {
            Editable = "Responsibility CenterEditable";
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
        modify("Ship-to Contact")
        {
            Editable = "Ship-to ContactEditable";
        }
        modify("Location Code")
        {
            Editable = "Location CodeEditable";
        }
        modify("Inbound Whse. Handling Time")
        {
            Editable = InboundWhseHandlingTimeEditabl;
        }
        modify("Shipment Method Code")
        {
            Editable = "Shipment Method CodeEditable";
        }
        modify("Lead Time Calculation")
        {
            Editable = "Lead Time CalculationEditable";
        }
        modify("Requested Receipt Date")
        {
            Editable = "Requested Receipt DateEditable";
        }
        modify("Promised Receipt Date")
        {
            Editable = "Promised Receipt DateEditable";
        }
        modify("Expected Receipt Date")
        {
            Editable = "Expected Receipt DateEditable";
        }
        modify("Sell-to Customer No.")
        {
            Editable = "Sell-to Customer No.Editable";
        }
        modify("Ship-to Code")
        {
            Editable = "Ship-to CodeEditable";
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

        //Unsupported feature: Property Modification (SubFormLink) on "Control1906354007(Control 1906354007)".


        //Unsupported feature: Code Modification on ""Shortcut Dimension 1 Code"(Control 100).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShortcutDimension1CodeOnAfterV;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShortcutDimension1CodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: Code Modification on ""Shortcut Dimension 2 Code"(Control 102).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShortcutDimension2CodeOnAfterV;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShortcutDimension2CodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: Code Modification on ""Prices Including VAT"(Control 135).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PricesIncludingVATOnAfterValid;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PricesIncludingVATOnAfterValidate;
        */
        //end;
        addafter("Buy-from Address 2")
        {
            field("Buy-from Address 3"; "Buy-from Address 3")
            {
                ApplicationArea = Basic;
                Editable = "Buy-from Address 3Editable";
            }
        }
        addafter("No. of Archived Versions")
        {
            field("Cal. WHT for any Inv. Amount"; "Cal. WHT for any Inv. Amount")
            {
                ApplicationArea = Basic;
                Editable = CalWHTforanyInvAmountEditable;
            }
            field("PO Type"; "PO Type")
            {
                ApplicationArea = Basic;
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
        addafter(Prepayment)
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

        modify("&Print")
        {
            Visible = false;
        }
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
                action("Purchase Order")
                {
                    ApplicationArea = Basic;
                    Caption = 'Purchase Order';
                    //Image = PrintReport;
                    trigger OnAction()
                    var
                        PurchHeader: Record "Purchase Header";
                    begin
                        //TestField(Status, Status::Released);
                        PurchHeader.Reset;
                        PurchHeader.SetRange("Document Type", "Document Type");
                        PurchHeader.SetRange("No.", "No.");
                        Report.Run(Report::"Purchase Order", true, false, PurchHeader);
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
        "Order DateEditable": Boolean;
        [InDataSet]
        "Buy-from Post CodeEditable": Boolean;
        [InDataSet]
        "Document DateEditable": Boolean;
        [InDataSet]
        "Vendor Order No.Editable": Boolean;
        [InDataSet]
        "Vendor Shipment No.Editable": Boolean;
        [InDataSet]
        "Vendor Invoice No.Editable": Boolean;
        [InDataSet]
        "Order Address CodeEditable": Boolean;
        [InDataSet]
        "Purchaser CodeEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Buy-from Contact No.Editable": Boolean;
        [InDataSet]
        "Buy-from CountyEditable": Boolean;
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
        "VAT Bus. Posting GroupEditable": Boolean;
        [InDataSet]
        "Pay-to Address 3Editable": Boolean;
        [InDataSet]
        "Invoice DescriptionEditable": Boolean;
        [InDataSet]
        "Ship-to CodeEditable": Boolean;
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
        "Sell-to Customer No.Editable": Boolean;
        [InDataSet]
        "Location CodeEditable": Boolean;
        [InDataSet]
        "Ship-to Post CodeEditable": Boolean;
        [InDataSet]
        InboundWhseHandlingTimeEditabl: Boolean;
        [InDataSet]
        "Lead Time CalculationEditable": Boolean;
        [InDataSet]
        "Requested Receipt DateEditable": Boolean;
        [InDataSet]
        "Promised Receipt DateEditable": Boolean;
        [InDataSet]
        "Ship-to CountyEditable": Boolean;
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
        "Posting DateEditable" := true;//vah
        "Order DateEditable" := AllowEdit;
        "Buy-from Post CodeEditable" := AllowEdit;
        "Document DateEditable" := true;//VAH
        "Vendor Order No.Editable" := AllowEdit;
        "Vendor Shipment No.Editable" := true; //VAH
        "Vendor Invoice No.Editable" := true;//VAH
        "Order Address CodeEditable" := AllowEdit;
        "Purchaser CodeEditable" := AllowEdit;
        "Responsibility CenterEditable" := AllowEdit;
        "Buy-from Contact No.Editable" := AllowEdit;
        "Buy-from CountyEditable" := AllowEdit;
        //CurrForm."Buy-from Country Code".EDITABLE := AllowEdit;
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
        //CurrForm."Pay-to Country Code".EDITABLE := AllowEdit;
        "VAT Bus. Posting GroupEditable" := AllowEdit;
        VendorExchangeRateACYEditable := AllowEdit;
        "Pay-to Address 3Editable" := AllowEdit;
        "Invoice DescriptionEditable" := AllowEdit;
        "Ship-to CodeEditable" := AllowEdit;
        "Ship-to NameEditable" := AllowEdit;
        "Ship-to AddressEditable" := AllowEdit;
        "Ship-to Address 2Editable" := AllowEdit;
        "Ship-to CityEditable" := AllowEdit;
        "Ship-to ContactEditable" := AllowEdit;
        "Shipment Method CodeEditable" := AllowEdit;
        "Expected Receipt DateEditable" := AllowEdit;
        "Sell-to Customer No.Editable" := AllowEdit;
        "Location CodeEditable" := AllowEdit;
        "Ship-to Post CodeEditable" := AllowEdit;
        InboundWhseHandlingTimeEditabl := AllowEdit;
        "Lead Time CalculationEditable" := AllowEdit;
        "Requested Receipt DateEditable" := AllowEdit;
        "Promised Receipt DateEditable" := AllowEdit;
        "Ship-to CountyEditable" := AllowEdit;
        //CurrForm."Ship-to Country Code".EDITABLE := AllowEdit;
        "Ship-to Address 3Editable" := AllowEdit;
        "Transaction TypeEditable" := AllowEdit;
        "Transport MethodEditable" := AllowEdit;
        "Entry PointEditable" := AllowEdit;
        AreaEditable := AllowEdit;
        TransactionSpecificationEditab := AllowEdit;
        "Currency CodeEditable" := AllowEdit;
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
        SetEditableForm(Status = Status::Open);
    end;
}

