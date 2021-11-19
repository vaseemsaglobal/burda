Table 50051 "Ads. Billing Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   25.05.2007   KKE   New table for "Ads. Billing Note Header" - Ads. Sales Module


    fields
    {
        field(1;"Billing No.";Code[20])
        {
            TableRelation = "Ads. Billing Header";
        }
        field(2;"Line No.";Integer)
        {
        }
        field(3;"Bill-to Customer No.";Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(4;"Document Type";Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(5;"Document No.";Code[20])
        {
            Editable = false;
            TableRelation = if ("Document Type"=const(Invoice)) "Sales Invoice Header" where ("Bill-to Customer No."=field("Bill-to Customer No."))
                            else if ("Document Type"=const("Credit Memo")) "Sales Cr.Memo Header" where ("Bill-to Customer No."=field("Bill-to Customer No."));
        }
        field(6;"Due Date";Date)
        {
            Editable = false;
        }
        field(7;"Document Date";Date)
        {
        }
        field(8;"Cust. Ledger Entry No.";Integer)
        {
            TableRelation = "Cust. Ledger Entry" where ("Customer No."=field("Bill-to Customer No."),
                                                        Open=const(true));
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnValidate()
            begin
                AdsBillingHeader.Get("Billing No.");
                AdsBillingHeader.TestField(Status,AdsBillingHeader.Status::Open);

                TempAdsBillingLine := Rec;

                Init;
                "Billing No." := TempAdsBillingLine."Billing No.";
                "Line No." := TempAdsBillingLine."Line No.";
                "Cust. Ledger Entry No." := TempAdsBillingLine."Cust. Ledger Entry No.";
                if "Cust. Ledger Entry No." = 0 then
                  exit;

                if CheckDupCustEntryNo then
                  Error(Text001);
                if CustLedgEntry.Get("Cust. Ledger Entry No.") then begin
                  CustLedgEntry.CalcFields(Amount,"Amount (LCY)","Remaining Amount","Remaining Amt. (LCY)");
                  "Bill-to Customer No." := CustLedgEntry."Customer No.";
                  "Document Type" := CustLedgEntry."Document Type";
                  "Document No." := CustLedgEntry."Document No.";
                  "Document Date" := CustLedgEntry."Document Date";
                  "Due Date" := CustLedgEntry."Due Date";
                  Description := CustLedgEntry.Description;
                  "Salesperson Code" := CustLedgEntry."Salesperson Code";
                  "Currency Code" := CustLedgEntry."Currency Code";
                  "Original Amount" := CustLedgEntry.Amount;
                  "Original Amount (LCY)" := CustLedgEntry."Amount (LCY)";
                  "Remaining Amount" := CustLedgEntry."Remaining Amount";
                  "Remaining Amt. (LCY)" := CustLedgEntry."Remaining Amt. (LCY)";
                  "Billing Amount" := CustLedgEntry."Remaining Amount";

                  case "Document Type" of
                    "document type"::Invoice:
                      begin
                        if SalesInvHeader.Get("Document No.") then begin
                          "Zone Area" := SalesInvHeader."Zone Area";
                          "Sale Type" := SalesInvHeader."Ads. Sales Type";
                        end;
                      end;
                    "document type"::"Credit Memo":
                      begin
                        if SalesCrMemoHeader.Get("Document No.") then begin
                          "Zone Area" := SalesCrMemoHeader."Zone Area";
                          "Sale Type" := SalesCrMemoHeader."Ads. Sales Type";
                        end;
                      end;
                  end;
                end;
            end;
        }
        field(9;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(10;"Salesperson Code";Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(11;"Zone Area";Code[20])
        {
            TableRelation = "Zone Area";
        }
        field(12;"Sale Type";Code[10])
        {
            TableRelation = "General Master Setup".Code where (Type=const("Customer Type"));
        }
        field(13;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(20;"Original Amount";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Editable = false;
        }
        field(21;"Original Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(22;"Remaining Amount";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            Editable = false;
        }
        field(23;"Remaining Amt. (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Amt. (LCY)';
            Editable = false;
        }
        field(24;"Billing Amount";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
        }
    }

    keys
    {
        key(Key1;"Billing No.","Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Cust. Ledger Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        AdsBillingHeader.Get("Billing No.");
        AdsBillingHeader.TestField(Status,AdsBillingHeader.Status::Open);
    end;

    trigger OnInsert()
    begin
        AdsBillingHeader.Get("Billing No.");
        AdsBillingHeader.TestField(Status,AdsBillingHeader.Status::Open);
    end;

    trigger OnModify()
    begin
        AdsBillingHeader.Get("Billing No.");
        AdsBillingHeader.TestField(Status,AdsBillingHeader.Status::Open);
    end;

    var
        AdsItemSetup: Record "Ads. Item Setup";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Text001: label 'System does not allow to insert duplicate cust. ledger entry no.';
        AdsBillingHeader: Record "Ads. Billing Header";
        AdsBillingLine: Record "Ads. Billing Line";
        TempAdsBillingLine: Record "Ads. Billing Line";


    procedure GetCurrencyCode(): Code[10]
    begin
        case "Document Type" of
          "document type"::Invoice:
            begin
              if ("Document No." = SalesInvHeader."No.") then
                exit(SalesInvHeader."Currency Code")
              else
                if SalesInvHeader.Get("Document No.") then
                  exit(SalesInvHeader."Currency Code")
                else
                  exit('');
            end;
          "document type"::"Credit Memo":
            begin
              if ("Document No." = SalesCrMemoHeader."No.") then
                exit(SalesCrMemoHeader."Currency Code")
              else
                if SalesCrMemoHeader.Get("Document No.") then
                  exit(SalesCrMemoHeader."Currency Code")
                else
                  exit('');
            end;
        end;
    end;


    procedure CheckDupCustEntryNo(): Boolean
    begin
        //When suggest line in same cust. ledger entry more than 1 time, system allow insert duplicate entry no.
        //but user have to check data by themself.
        AdsItemSetup.Get;
        if not AdsItemSetup."Allow Duplicate Billing Line" then begin
          AdsBillingLine.Reset;
          AdsBillingLine.SetCurrentkey("Cust. Ledger Entry No.");
          AdsBillingLine.SetRange("Cust. Ledger Entry No.","Cust. Ledger Entry No.");
        //  AdsBillingLine.SETFILTER("Line No.",'<>%1',"Line No.");
          if AdsBillingLine.Find('-') then
            exit(true);
        end;
    end;
}

