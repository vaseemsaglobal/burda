TableExtension 50003 tableextension50003 extends "G/L Account"
{
    fields
    {
        modify("Consol. Translation Method")
        {
            OptionCaption = 'Average Rate (Manual),Closing Rate,Historical Rate,Composite Rate,Equity Rate';
        }

        //Unsupported feature: Code Insertion on ""Direct Posting"(Field 14)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        //KKE : #002 +
        IF "Direct Posting" THEN
          IF CalcGLAccWhereUsed.CheckGLAccForDirectPosting("No.") = FALSE THEN
            "Direct Posting" := FALSE;
        //KKE : #002 -
        */
        //end;
        field(50000; "Full Name (Thai)"; Text[150])
        {
        }
        field(50001; "Full Name (Eng)"; Text[100])
        {
        }
        field(55000; "Petty Cash Account"; Boolean)
        {
            Caption = 'Petty Cash Account';
            Description = 'Petty Cash';

            trigger OnValidate()
            begin
                //KKE : #003 +
                if "Petty Cash Account" then
                    TestField("Account Type", "account type"::Posting);
                //KKE : #003 -
            end;
        }
        field(55050; "Cash Advance Account"; Boolean)
        {
            Caption = 'Cash Advance Account';
            Description = 'Cash Advance';

            trigger OnValidate()
            begin
                //KKE : #003 +
                if "Cash Advance Account" then
                    TestField("Account Type", "account type"::Posting);
                //KKE : #003 -
            end;
        }
        field(50010; "For Manual Invoice"; Boolean)
        {

        }
        field(50011; Name2; Text[50])
        {

        }
    }

}

