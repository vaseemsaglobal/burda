PageExtension 50013 pageextension50013 extends "Item Card"
/*
      Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   01.02.2006   KKE   Add new menu button VAT Announce Price.
      Burda
      002   27.03.2007   KKE   Add new fields for Subscription Module.
      003   07.08.2007   KKE   Permission Filter by Magazine Code.
*/
{
    layout
    {
        addafter("Item Category Code")
        {
            field("Item Type"; "Item Type")
            {
                ApplicationArea = Basic;
                Editable = "Item TypeEditable";
            }
            field("Magazine Code"; "Magazine Code")
            {
                ApplicationArea = Basic;
                trigger OnValidate()

                begin
                    if "Magazine Code" <> '' then
                        "Item TypeEditable" := true
                    else
                        "Item TypeEditable" := false;
                end;
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
            field("Last Pick-up Date"; "Last Pick-up Date")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Last Date Modified")
        {
            field(Closed; Closed)
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {

        addafter(Identifiers)
        {

            action("VAT Announce Price")
            {
                ApplicationArea = Basic;
                Caption = 'VAT Announce Price';
                RunPageLink = "No." = FIELD("No.");
                RunObject = Page "Posted Cash Advance Invoice";
            }
        }
    }
    var
        [InDataSet]
        "Item TypeEditable": Boolean;



    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        "Item TypeEditable" := "Magazine Code" = '';  //KKE : #002
    end;

    trigger OnOpenPage()

    begin
        if "Magazine Code" <> '' then
            "Item TypeEditable" := true
        else
            "Item TypeEditable" := false;
    end;

}

