Table 55053 "Cash Advance Comment Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.

    Caption = 'Cash Advance Comment Line';

    fields
    {
        field(1;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Invoice,Posted Invoice,Settle';
            OptionMembers = Invoice,"Posted Invoice",Settle;
        }
        field(2;"No.";Code[20])
        {
            Caption = 'No.';
        }
        field(3;"Line No.";Integer)
        {
            Caption = 'Line No.';
        }
        field(4;Date;Date)
        {
            Caption = 'Date';
        }
        field(5;"Code";Code[10])
        {
            Caption = 'Code';
        }
        field(6;Comment;Text[80])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(Key1;"Document Type","No.","Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure SetUpNewLine()
    var
        CashAdvCommentLine: Record "Cash Advance Comment Line";
    begin
        CashAdvCommentLine.SetRange("Document Type",CashAdvCommentLine."document type"::Invoice);
        CashAdvCommentLine.SetRange("No.","No.");
        CashAdvCommentLine.SetRange(Date,WorkDate);
        if not CashAdvCommentLine.Find('-') then
          Date := WorkDate;
    end;
}

