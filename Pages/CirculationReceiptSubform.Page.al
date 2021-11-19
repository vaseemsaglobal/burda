Page 50058 "Circulation Receipt Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Circulation Receipt Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(DocumentType;"Document Type")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo;"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentLineNo;"Document Line No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(PostingDate;"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field(No;"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Description2;"Description 2")
                {
                    ApplicationArea = Basic;
                }
                field(DepositAmount;"Deposit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity;Quantity)
                {
                    ApplicationArea = Basic;
                }
                field(UnitPrice;"Unit Price")
                {
                    ApplicationArea = Basic;
                }
                field(Discount;Discount)
                {
                    ApplicationArea = Basic;
                }
                field(LineAmountInclVAT;"Line Amount Incl. VAT")
                {
                    ApplicationArea = Basic;
                }
            }
            field(TotalQty;TotalQty)
            {
                ApplicationArea = Basic;
                Caption = 'Total Quantity';
                DecimalPlaces = 0:5;
                Editable = false;
            }
            field(TotalAmount;TotalAmount)
            {
                ApplicationArea = Basic;
                Caption = 'Total Amount';
                Editable = false;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if ("Deposit Amount" = xRec."Deposit Amount") and ("Description 2" = xRec."Description 2") then
          Error(Text000);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        TotalQty: Decimal;
        TotalAmount: Decimal;
        Text000: label 'You cannot modify this record.';


    procedure CalcTotal(var CirReceiptLine: Record "Circulation Receipt Line";LastCirReceiptLine: Record "Circulation Receipt Line";var TotalQty: Decimal;var TotalAmt: Decimal)
    var
        TempCirReceiptLine: Record "Circulation Receipt Line";
    begin
        TempCirReceiptLine.CopyFilters(CirReceiptLine);
        TempCirReceiptLine.SetCurrentkey("Circulation Receipt No.","Document Type",Type,"No.","Document No.");
        TempCirReceiptLine.CalcSums(Quantity,"Line Amount Incl. VAT");
        TotalQty := TempCirReceiptLine.Quantity;
        TotalAmt := TempCirReceiptLine."Line Amount Incl. VAT";
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CalcTotal(Rec,xRec,TotalQty,TotalAmount);
    end;
}

