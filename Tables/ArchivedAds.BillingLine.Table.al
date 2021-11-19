Table 50053 "Archived Ads. Billing Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   01.06.2007   KKE   New table for "Archived Ads. Billing Header" - Ads. Sales Module


    fields
    {
        field(1;"Billing No.";Code[20])
        {
            TableRelation = "Archived Ads. Billing Header";
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


    procedure GetCurrencyCode(): Code[10]
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
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
}

