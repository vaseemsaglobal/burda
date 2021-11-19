TableExtension 50047 tableextension50047 extends "Purchases & Payables Setup"
{
    Caption = 'Purchases & Payables Setup';
    fields
    {
        modify("Post Dated Check Template")
        {
            Caption = 'Post Dated Check Template';
        }
        modify("Post Dated Check Batch")
        {
            Caption = 'Post Dated Check Batch';
        }
        field(50000; "Allow WHT Difference"; Boolean)
        {
            Caption = 'Allow WHT Difference';
        }
        field(50001; "Allow Manual WHT Cert. No."; Boolean)
        {
            Description = '#002';

            trigger OnValidate()
            var
                GenJnlBatch: Record "Gen. Journal Batch";
            begin
                GenJnlBatch.SetRange("Allow Manual WHT Cert. No.", true);
                if GenJnlBatch.FindFirst then begin
                    if not Confirm(Text001, false) then begin
                        "Allow Manual WHT Cert. No." := xRec."Allow Manual WHT Cert. No.";
                        exit;
                    end;
                    GenJnlBatch.ModifyAll("Allow Manual WHT Cert. No.", false);
                end;
            end;
        }
        field(50002; "Average VAT Varience Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50010; "WHT3 Certificate No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50011; "WHT53 Certificate No. Series"; code[10])
        {
            TableRelation = "No. Series";
        }
    }

    var
        Text001: label 'The Gen. Journal Batch still has one or more lines.\Do you want to reset "Allow Manual WHT Cert. No."?';
}

