PageExtension 50010 pageextension50010 extends "Vendor Card"
{
    layout
    {

        //Unsupported feature: Property Insertion (Importance) on ""WHT Business Posting Group"(Control 1500004)".

        modify("WHT Registration ID")
        {
            Visible = false;
        }
        addafter("Address 2")
        {
            field("Address 3"; "Address 3")
            {
                ApplicationArea = Basic;
            }
        }
        addafter(Contact)
        {
            field("Name (Thai)"; "Name (Thai)")
            {
                ApplicationArea = Basic;
            }
            field("Address (Thai)"; "Address (Thai)")
            {
                ApplicationArea = Basic;
                MultiLine = true;
            }
            field(Branch; Branch)
            {
                ApplicationArea = All;
            }
            field("Branch No."; "Branch No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("Dummy Vendor"; "Dummy Vendor")
            {
                ApplicationArea = Basic;
            }
            field("Petty Cash"; "Petty Cash")
            {
                ApplicationArea = Basic;

                trigger OnValidate()
                begin
                    PettyCashOnAfterValidate;
                end;
            }
            field("Petty Cash Amount"; "Petty Cash Amount")
            {
                ApplicationArea = Basic;
                Editable = "Petty Cash";
            }
            field("Cash Advance"; "Cash Advance")
            {
                ApplicationArea = Basic;
            }
            field("Vendor for WHT only"; "Vendor for WHT only")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Application Method")
        {
            group("Bank Cheque")
            {
                Caption = 'Bank Cheque';
                field("Documents Require"; "Documents Require")
                {
                    ApplicationArea = Basic;
                    Caption = 'Documents Require (Distribution Code)';
                    MultiLine = true;
                }
                field(Control1000000020; "Fax No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }

    }
    actions
    {
        modify("Items Received")
        {
            Visible = false;
        }
        modify("Purchase Receipts")
        {
            Visible = false;
        }
    }


    var
        [InDataSet]
        "Petty Cash AmountEditable": Boolean;



    local procedure PettyCashOnAfterValidate()
    begin
        //KKE : #002 +
        if not "Petty Cash" then
            "Petty Cash Amount" := 0;
        "Petty Cash AmountEditable" := "Petty Cash";
        //KKE : #002 -
    end;

}

