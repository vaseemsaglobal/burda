PageExtension 50014 pageextension50014 extends "Item List"
{

    layout
    {
        addafter(Description)
        {
            field(Inventory; Inventory)
            {
                ApplicationArea = Basic;
            }
            field("Item Type"; "Item Type")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Routing No.")
        {
            field("Magazine Code"; "Magazine Code")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Base Unit of Measure")
        {
            field("Volume No."; "Volume No.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Shelf No.")
        {
            field("Issue No."; "Issue No.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Costing Method")
        {
            field("Issue Date"; "Issue Date")
            {
                ApplicationArea = Basic;
            }
        }

    }
    actions
    {
        modify("Stock Movement")
        {
            Visible = false;
        }
        modify("Items Received & Not Invoiced")
        {
            Visible = false;
        }
        addafter(Identifiers)
        {
            separator(Action1000000000)
            {
            }
            action("VAT Announce Price")
            {
                ApplicationArea = Basic;
                Caption = 'VAT Announce Price';
                RunPageLink = "No." = FIELD("No.");
                RunObject = Page "Posted Cash Advance Invoice";
            }
        }

        addafter("Requisition Worksheet")
        {
            action("Planning Worksheet")
            {
                ApplicationArea = Basic;
                Caption = 'Planning Worksheet';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Planning Worksheet";
            }
        }
    }



    var
        UserMgt: Codeunit CU5700Ext;

    trigger OnOpenPage()
    begin

        //KKE : #002 +
        IF UserMgt.GetMagazineItemFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETFILTER("Magazine Code", UserMgt.GetMagazineItemFilter());
            FILTERGROUP(0);
        END;
        //KKE : #002 -

    end;


}

