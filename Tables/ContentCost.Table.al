Table 50022 "Content Cost"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   29.03.2007   KKE   New table for "Content Cost" - Editorial Module


    fields
    {
        field(1;"Content Index No.";Code[20])
        {
        }
        field(2;"Content Index Line No.";Integer)
        {
        }
        field(3;"Line No.";Integer)
        {
        }
        field(4;"Expense Code";Code[20])
        {
        }
        field(5;"Reference No.";Text[30])
        {
        }
        field(6;Description;Text[50])
        {
        }
        field(7;"Invoice No.";Text[30])
        {
        }
        field(8;"Currency Code";Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                  "Exchange Rate" := 0;
                Validate("Cost Amount");
            end;
        }
        field(9;"Cost Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                  "Cost Amount (LCY)" := "Cost Amount"
                else
                  "Cost Amount (LCY)" := "Cost Amount" * "Exchange Rate";
            end;
        }
        field(10;"Exchange Rate";Decimal)
        {
            DecimalPlaces = 0:15;

            trigger OnValidate()
            begin
                if "Exchange Rate" <> 0 then
                  TestField("Currency Code");
                Validate("Cost Amount");
            end;
        }
        field(11;"Cost Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                  "Cost Amount" := "Cost Amount (LCY)"
                else begin
                  TestField("Exchange Rate");
                  "Cost Amount" := "Cost Amount (LCY)" / "Exchange Rate";
                end;
            end;
        }
        field(12;"Payment Date";Date)
        {
        }
        field(13;"Billing Date";Date)
        {
        }
        field(14;Note;Text[50])
        {
        }
        field(15;"Payment Status";Text[30])
        {
        }
        field(16;Remarks;Text[50])
        {
        }
        field(100;Archived;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Content Index No.","Content Index Line No.","Line No.")
        {
            Clustered = true;
            SumIndexFields = "Cost Amount","Cost Amount (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Archived,false);
        GetContentIndexLine;
    end;

    trigger OnInsert()
    begin
        GetContentIndexLine;
    end;

    trigger OnModify()
    begin
        TestField(Archived,false);
        GetContentIndexLine;
    end;

    trigger OnRename()
    begin
        Error(Text000,TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';
        ContentIndexLine: Record "Content Index Line";


    procedure GetContentIndexLine()
    begin
        ContentIndexLine.Get("Content Index No.","Content Index Line No.");
        ContentIndexLine.TestField(Status,ContentIndexLine.Status::" ");
    end;
}

