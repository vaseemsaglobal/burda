TableExtension 50022 tableextension50022 extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Max. WHT Difference Allowed"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Max. WHT Difference Allowed';

            trigger OnValidate()
            begin
                if "Max. WHT Difference Allowed" <> ROUND("Max. WHT Difference Allowed") then
                    Error(
                      Text004,
                      FieldCaption("Max. WHT Difference Allowed"), "Amount Rounding Precision");

                "Max. WHT Difference Allowed" := Abs("Max. WHT Difference Allowed");
            end;
        }
        field(50001; "Enable VAT Average"; Boolean)
        {
        }
        field(50002; "WHT Minimum Invoice Amount"; Decimal)
        {
            Caption = 'WHT Minimum Invoice Amount';
        }
    }



    procedure GetShortcutDimCode(var GLSetupShortcutDimCode: array[8] of Code[20])
    var
        GLSetup: Record "General Ledger Setup";
    begin
        //KKE : #002 +
        GLSetup.Get;
        GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
        GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
        GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
        GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
        GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
        GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
        GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
        //KKE : #002 -
    end;

    var
        Text004: Label '%1 must be rounded to the nearest %2.';


}

