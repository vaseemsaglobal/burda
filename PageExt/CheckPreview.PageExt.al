PageExtension 50065 pageextension50065 extends "Check Preview"
{
    /*
          Microsoft Business Solutions Navision
        ----------------------------------------
        Project: Localization TH
        KKE : Kanoknard Ketnut

        No.   Date         Sign  Description
        ----------------------------------------
        001   01.02.2006   KKE   Correct WHT Amount.
    */
    layout
    {

        moveafter(Control1500007; CheckAmount)
        moveafter(Control1500006; Control1500009)
        modify("CheckToAddr[1]")
        {
            Visible = false;
        }
        addbefore("CheckToAddr[2]")
        {

            field(VendorName; VendorName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pay-to Name';
                ToolTip = 'Specifies the name of the payee that will appear on the check.';
            }
        }
    }
    var
        VendorName: Text[150];

    trigger OnAfterGetRecord()
    var
        Vend: Record Vendor;
    begin
        //KKE : #001 +
        IF rec."Payee Name" <> '' THEN
            VendorName := rec."Payee Name"
        ELSE
            IF Vend."Name (Thai)" <> '' THEN
                VendorName := Vend."Name (Thai)"
            ELSE
                VendorName := Vend.Name + Vend."Name 2";
        //KKE : #001 -
    end;
}

