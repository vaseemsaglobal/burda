Table 50044 "Circulation Receipt Line"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.04.2007   KKE   New table for "Circulation Receipt Header" - Circulation Module
    // 002   18.09.2007   KKE   Add Calc. Payment

    Permissions = TableData "Sales Invoice Line"=rm,
                  TableData "Sales Cr.Memo Line"=rm;

    fields
    {
        field(1;"Circulation Receipt No.";Code[20])
        {
            TableRelation = "Circulation Receipt Header";
        }
        field(2;"Line No.";Integer)
        {
        }
        field(3;"Document Type";Option)
        {
            OptionCaption = 'Invoice,Credit Memo,Payment';
            OptionMembers = Invoice,"Credit Memo",Payment;
        }
        field(4;"Document No.";Code[20])
        {
            TableRelation = if ("Document Type"=const(Invoice)) "Sales Invoice Header"
                            else if ("Document Type"=const("Credit Memo")) "Sales Cr.Memo Header";
        }
        field(5;"Document Line No.";Integer)
        {
        }
        field(6;"Posting Date";Date)
        {
        }
        field(7;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(8;"No.";Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type=const("G/L Account")) "G/L Account"
                            else if (Type=const(Item)) Item
                            else if (Type=const(Resource)) Resource
                            else if (Type=const("Fixed Asset")) "Fixed Asset"
                            else if (Type=const("Charge (Item)")) "Item Charge";
        }
        field(9;Description;Text[50])
        {
        }
        field(10;"Description 2";Text[50])
        {
        }
        field(11;Quantity;Decimal)
        {
            DecimalPlaces = 0:5;

            trigger OnValidate()
            begin
                //"Line Amount" := Quantity * "Unit Price" * (1 - "Discount %"/100);
            end;
        }
        field(12;"Unit Price";Decimal)
        {
            AutoFormatType = 2;

            trigger OnValidate()
            begin
                //VALIDATE(Quantity);
            end;
        }
        field(13;Discount;Decimal)
        {
            Caption = 'Discount';

            trigger OnValidate()
            begin
                //VALIDATE(Quantity);
            end;
        }
        field(14;"Line Amount Incl. VAT";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount Incl. VAT';
            Editable = false;
        }
        field(15;"Deposit Amount";Decimal)
        {
            AutoFormatType = 1;
        }
    }

    keys
    {
        key(Key1;"Circulation Receipt No.","Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Circulation Receipt No.","Document Type",Type,"No.","Document No.")
        {
            SumIndexFields = Quantity,"Line Amount Incl. VAT";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        case "Document Type" of
          "document type"::Invoice:
            begin
              SalesInvLine.Get("Document No.","Document Line No.");
              SalesInvLine."Circulation Receipt No." := '';
              SalesInvLine.Modify;
            end;
          "document type"::"Credit Memo":
            begin
              SalesCreMemoLine.Get("Document No.","Document Line No.");
              SalesCreMemoLine."Circulation Receipt No." := '';
              SalesCreMemoLine.Modify;
            end;
        end;
    end;

    trigger OnRename()
    begin
        Error(Text000,TableCaption);
    end;

    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesCreMemoLine: Record "Sales Cr.Memo Line";
        Text000: label 'You cannot rename a %1.';
}

