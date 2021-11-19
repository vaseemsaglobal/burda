PageExtension 50047 pageextension50047 extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field(RemainingAmt; RemainingAmt)
            {
                ApplicationArea = Basic;
                Caption = 'Remaining Amount';
            }
        }
    }



    var
        CirReceiptHeader: Record "Circulation Receipt Header";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GetValueFromCirReceipt: Boolean;
        RemainingAmt: Decimal;


    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    trigger OnAfterGetRecord()
    begin

        //KKE : #001
        RemainingAmt := 0;
        CustLedgEntry.RESET;
        CustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        CustLedgEntry.SETRANGE("Customer No.", "Bill-to Customer No.");
        CustLedgEntry.SETRANGE("Document No.", "No.");
        CustLedgEntry.SETRANGE("Posting Date", "Posting Date");
        IF CustLedgEntry.FIND('-') THEN BEGIN
            CustLedgEntry.CALCFIELDS("Remaining Amount");
            RemainingAmt := CustLedgEntry."Remaining Amount";
        END;
    end;


    //Unsupported feature: Code Insertion on "OnOpenPage".

    trigger OnOpenPage()
    begin

        //KKE : #001
        IF GetValueFromCirReceipt THEN BEGIN
            SETRANGE("Get by Circulation Receipt", FALSE);
            SETRANGE(Open, TRUE);
        END;

    end;


    //Unsupported feature: Code Insertion on "OnQueryClosePage".

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        IF CloseAction = Action::LookupOK THEN
            LookupOKOnPush;

    end;

    procedure GetFromCirReceipt(_CirReceiptHeader: Record "Circulation Receipt Header")
    begin
        //KKE : #001
        GetValueFromCirReceipt := true;
        CirReceiptHeader := _CirReceiptHeader;
    end;

    procedure InsertCirReceiptLine(var _SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        CirReceiptLine: Record "Circulation Receipt Line";
        SalesPost: Codeunit CU80Ext;
        LineNo: Integer;
    begin
        //KKE : #001
        if _SalesCrMemoHeader.Find('-') then begin
            CirReceiptLine.SetRange("Circulation Receipt No.", CirReceiptHeader."No.");
            if CirReceiptLine.FindLast then
                LineNo := CirReceiptLine."Line No.";
            repeat
                SalesCrMemoLine.SetRange("Document No.", _SalesCrMemoHeader."No.");
                SalesCrMemoLine.SetRange("Circulation Receipt No.", '');
                if SalesCrMemoLine.Find('-') then
                    repeat
                        LineNo += 10000;
                        CirReceiptLine.Init;
                        CirReceiptLine."Circulation Receipt No." := CirReceiptHeader."No.";
                        CirReceiptLine."Line No." := LineNo;
                        CirReceiptLine."Document Type" := CirReceiptLine."document type"::"Credit Memo";
                        CirReceiptLine."Document No." := SalesCrMemoLine."Document No.";
                        CirReceiptLine."Document Line No." := SalesCrMemoLine."Line No.";
                        CirReceiptLine."Posting Date" := _SalesCrMemoHeader."Posting Date";
                        CirReceiptLine.Type := SalesCrMemoLine.Type;
                        CirReceiptLine."No." := SalesCrMemoLine."No.";
                        CirReceiptLine.Description := SalesCrMemoLine.Description;
                        CirReceiptLine."Description 2" := SalesCrMemoLine."Description 2";
                        CirReceiptLine.Quantity := -SalesCrMemoLine.Quantity;
                        CirReceiptLine."Unit Price" := SalesCrMemoLine."Unit Price";
                        CirReceiptLine.Discount := -(SalesCrMemoLine."Line Discount Amount" + SalesCrMemoLine."Inv. Discount Amount");
                        //CirReceiptLine."Line Amount Incl. VAT" := -SalesCrMemoLine."Line Amount";
                        CirReceiptLine."Line Amount Incl. VAT" := -SalesCrMemoLine."Amount Including VAT";  //11.10.07
                        CirReceiptLine.Insert;

                        SalesPost.UpdateSalesCrMemoCirReceipt(
                          SalesCrMemoLine."Document No.",
                          SalesCrMemoLine."Line No.",
                          CirReceiptHeader."No.");
                        Clear(SalesPost);
                    until SalesCrMemoLine.Next = 0;
            until _SalesCrMemoHeader.Next = 0;
        end;
    end;

    local procedure LookupOKOnPush()
    begin
        //KKE : #001 +
        if GetValueFromCirReceipt then begin
            CurrPage.SetSelectionFilter(Rec);
            InsertCirReceiptLine(Rec);
            Commit;
            CurrPage.Close;
        end;
        //KKE : #001 -
    end;
}

