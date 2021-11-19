PageExtension 50051 pageextension50051 extends "Apply Vendor Entries"
{
    layout
    {


        addafter(AppliesToID)
        {
            field("Applying Entry"; "Applying Entry")
            {
                ApplicationArea = Basic;
            }
            field("Purchase (LCY)"; "Purchase (LCY)")
            {
                ApplicationArea = All;

            }
        }
    }
    actions
    {



        addfirst(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Reset Applies-to ID on Close Entry")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reset Applies-to ID on Close Entry';

                    trigger OnAction()
                    var
                        VendEntryEdit: Codeunit CU113Ext;
                    begin
                        //KKE : #002 +
                        if not Confirm(Text50000, false) then
                            exit;

                        VendEntryEdit.ResetAppliestoIDOnCloseEntry;
                        Clear(VendEntryEdit);
                        //KKE : #002 -
                    end;
                }
            }
        }
    }


    var
        Text50000: label 'Do you want to reset applies-to id on closed entry?';


}

