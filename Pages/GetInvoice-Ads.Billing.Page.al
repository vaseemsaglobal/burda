Page 50113 "Get Invoice - Ads. Billing"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(CustomerNo;"Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate;"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentType;"Document Type")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo;"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(DueDate;"Due Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(RemainingAmount;"Remaining Amount")
                {
                    ApplicationArea = Basic;
                }
                field(UsedByAdsBillingNo;"Used By Ads. Billing No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        if CloseAction = Action::LookupOK then
            LookupOKOnPush;
    end;

    var
        DocNo: Code[20];
        LineNo: Integer;


    procedure InitRequest(_DocNo: Code[20];_LineNo: Integer)
    begin
        DocNo := _DocNo;
        LineNo := _LineNo;
    end;


    procedure InsertAdsBillingLine(var CustLedgEntry: Record "Cust. Ledger Entry")
    var
        AdsBillingLine: Record "Ads. Billing Line";
    begin
        if CustLedgEntry.Find('-') then
        repeat
          CustLedgEntry.CalcFields("Remaining Amount","Remaining Amt. (LCY)");
          LineNo += 10000;
          AdsBillingLine.Init;
          AdsBillingLine."Billing No." := DocNo;
          AdsBillingLine."Line No." := LineNo ;
          AdsBillingLine."Bill-to Customer No." := CustLedgEntry."Customer No.";
          AdsBillingLine."Cust. Ledger Entry No." := CustLedgEntry."Entry No.";
          if not AdsBillingLine.CheckDupCustEntryNo then begin
            AdsBillingLine.Validate("Cust. Ledger Entry No.",CustLedgEntry."Entry No.");
            AdsBillingLine.Insert;
          end;
        until CustLedgEntry.Next=0;
    end;

    local procedure LookupOKOnPush()
    begin
        CurrPage.SetSelectionFilter(Rec);
        InsertAdsBillingLine(Rec);
        CurrPage.Close;
    end;
}

