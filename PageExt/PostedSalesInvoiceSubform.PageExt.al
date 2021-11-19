PageExtension 50038 pageextension50038 extends "Posted Sales Invoice Subform"
{
    /*
      Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Burda (Thailand) Co.,Ltd.
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   03.12.2007   KKE   Allow user to edit Description
      001   07.12.2007   GKU   Allow user to edit Issuedate
*/

    layout
    {
        modify(Type)
        {
            Editable = false;
        }
        modify("No.")
        {
            Editable = false;
        }
        modify("Cross-Reference No.")
        {
            Editable = false;
        }
        modify("Variant Code")
        {
            Editable = false;
        }
        modify("Return Reason Code")
        {
            Editable = false;
        }
        modify(Quantity)
        {
            Editable = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Unit of Measure")
        {
            Editable = false;
        }
        modify("Unit Cost (LCY)")
        {
            Editable = false;
        }
        modify("Unit Price")
        {
            Editable = false;
        }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Line Discount %")
        {
            Editable = false;
        }
        modify("Line Discount Amount")
        {
            Editable = false;
        }
        modify("Allow Invoice Disc.")
        {
            Editable = false;
        }
        modify("Job No.")
        {
            Editable = false;
        }
        modify("Appl.-to Item Entry")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = false;
        }
        addafter("Variant Code")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        /*
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = Basic;
            }
        }
        */
        addafter("Return Reason Code")
        {
            field("Report Issuedate"; "Report Issuedate")
            {
                ApplicationArea = Basic;
                Caption = 'Report Issue Date';
            }
            field("Subscriber Contract No."; "Subscriber Contract No.")
            {
                ApplicationArea = Basic;
            }
            field("Agent Customer No."; "Agent Customer No.")
            {
                ApplicationArea = Basic;
            }
            field("Circulation Receipt No."; "Circulation Receipt No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Deal No."; "Deal No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sub Deal No."; "Sub Deal No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Publication Month"; "Publication Month")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        SalesPost: Codeunit CU80Ext;
        AdsBookingLine: Record "Ads. Booking Line";


    //Unsupported feature: Code Insertion on "OnModifyRecord".

    trigger OnModifyRecord(): Boolean
    begin

        //KKE : #001 +
        IF (Description <> xRec.Description) OR
           ("Description 2" <> xRec."Description 2") OR
           ("Report Issuedate" <> xRec."Report Issuedate")
        THEN BEGIN
            SalesPost.SalesInvLineEdit(Rec);
            EXIT(FALSE);
        END;
        //KKE : #001 -

    end;



}

