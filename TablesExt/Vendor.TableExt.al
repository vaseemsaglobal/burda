TableExtension 50007 tableextension50007 extends Vendor
{
    fields
    {
        modify("Post Dated Checks (LCY)")
        {
            Caption = 'Post Dated Checks (LCY)';
        }
        field(50000; "Name (Thai)"; Text[120])
        {
            Caption = 'Name (Thai)';
        }
        field(50001; "Address (Thai)"; Text[200])
        {
            Caption = 'Address (Thai)';
        }
        field(50002; "Address 3"; Text[150])
        {
            Caption = 'Address 3';
        }
        field(50003; "Dummy Vendor"; Boolean)
        {
            Caption = 'Dummy Vendor';
        }
        field(50004; "Documents Require"; Code[20])
        {
            Description = 'Bank Cheque (Excel)';
        }
        field(50024; Branch; Text[50])
        {

        }
        field(50025; "Branch No."; text[5])
        {

        }
        field(55000; "Petty Cash Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Petty Cash Amount';
            Description = 'Petty Cash';
        }
        field(55001; "Petty Cash"; Boolean)
        {
            Caption = 'Petty Cash';
            Description = 'Petty Cash';

            trigger OnValidate()
            begin
                //KKE : #002 +
                if "Petty Cash" then begin
                    "Petty Cash Amount" := 0;
                    if "Vendor Posting Group" <> '' then
                        CheckVendorPettyCash;
                end;
                //KKE : #002 -
            end;
        }
        field(55050; "Cash Advance"; Boolean)
        {
            Caption = 'Cash Advance';
            Description = 'Cash Advance';

            trigger OnValidate()
            begin
                //KKE : #002 +
                if "Cash Advance" then begin
                    if "Vendor Posting Group" <> '' then
                        CheckVendorCashAdvance;
                end;
                //KKE : #002 -
            end;
        }
        field(55051; "Vendor for WHT only"; Boolean)
        {
            Description = 'Vendor for Printing WHT Slip Only';
        }
    }



    procedure CheckVendorPettyCash()
    var
        PettyCashSetup: Record "Petty Cash Setup";
        VendPostingGroup: Record "Vendor Posting Group";
        GLAcc: Record "G/L Account";
    begin
        //KKE : #002 +
        PettyCashSetup.Get;
        //PettyCashSetup.TESTFIELD("Petty Cash Account No.");
        if VendPostingGroup.Get("Vendor Posting Group") then begin
            GLAcc.Get(VendPostingGroup."Payables Account");
            GLAcc.TestField("Petty Cash Account");
            /*---
            IF VendPostingGroup."Payables Account" <> PettyCashSetup."Petty Cash Account No." THEN
              ERROR(STRSUBSTNO(Text55000,"Vendor Posting Group"));
            ---*/
        end;
        //KKE : #002 -

    end;

    procedure CheckVendorCashAdvance()
    var
        CashAdvanceSetup: Record "Cash Advance Setup";
        VendPostingGroup: Record "Vendor Posting Group";
        GLAcc: Record "G/L Account";
    begin
        //KKE : #003 +
        CashAdvanceSetup.Get;
        //CashAdvanceSetup.TESTFIELD("Cash Advance Account No.");
        if VendPostingGroup.Get("Vendor Posting Group") then
            GLAcc.Get(VendPostingGroup."Payables Account");
        GLAcc.TestField("Cash Advance Account");
        /*---
        IF VendPostingGroup."Payables Account" <> CashAdvanceSetup."Cash Advance Account No." THEN
          ERROR(STRSUBSTNO(Text55050,"Vendor Posting Group"));
        ---*/
        //KKE : #003 -

    end;


    var
        Text55000: label 'Payables account in vendor posting group %1 is not match petty cash account no.';
        Text55050: label 'Payables account in vendor posting group %1 is not match cash advance account no.';
}

