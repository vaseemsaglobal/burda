PageExtension 50063 pageextension50063 extends "Bank Account Ledger Entries"
{
    layout
    {


        addafter("Bal. Account No.")
        {
            field(VendorCustName; VendorCustName)
            {
                ApplicationArea = Basic;
                Caption = 'Vendor/Customer Name';
                Editable = false;
            }
            field("Vendor Bank Account No."; "Vendor Bank Account No.")
            {
                ApplicationArea = Basic;
            }
            field("Vendor Bank Branch No."; "Vendor Bank Branch No.")
            {
                ApplicationArea = Basic;
            }
            field("Customer/Vendor Bank"; "Customer/Vendor Bank")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter(Description; "Bal. Account Type")
    }
    var
        Cust: Record Customer;
        Vend: Record Vendor;
        VendorCustName: Text[150];




    trigger OnAfterGetRecord()
    begin

        VendorCustName := '';
        CASE "Bal. Account Type" OF
            "Bal. Account Type"::Customer:
                IF Cust.GET("Bal. Account No.") THEN BEGIN
                    IF Cust."Name (Thai)" <> '' THEN
                        VendorCustName := Cust."Name (Thai)"
                    ELSE
                        VendorCustName := Cust.Name + Cust."Name 2";
                END;
            "Bal. Account Type"::Vendor:
                IF Vend.GET("Bal. Account No.") THEN BEGIN
                    IF Vend."Name (Thai)" <> '' THEN
                        VendorCustName := Vend."Name (Thai)"
                    ELSE
                        VendorCustName := Vend.Name + Vend."Name 2";
                END;
        END;

    end;
}

