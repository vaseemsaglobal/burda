Page 50055 "Agent Customer Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New form for Agent Customer Subform - Circulation Module

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Agent Customer Line";


    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(SelltoCustomerNo; "Sell-to Customer No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field(Name; Cust.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Basic;
                }
                field(UnitPrice; "Unit Price")
                {
                    ApplicationArea = Basic;
                }
                field(Discount; "Discount %")
                {
                    ApplicationArea = Basic;
                }
                field(LineAmount; "Line Amount")
                {
                    ApplicationArea = Basic;
                }
                field(DeliveredFlag; "Delivered Flag")
                {
                    ApplicationArea = Basic;
                }
                field(DeliveredDate; "Delivered Date")
                {
                    ApplicationArea = Basic;
                }
                field(DeliveredDocumentNo; "Delivered Document No.")
                {
                    ApplicationArea = Basic;
                }
            }
            field(TotalResvQty; TotalResvQty)
            {
                ApplicationArea = Basic;
                Caption = 'Total Reserved Quantity';
                DecimalPlaces = 0 : 5;
                Editable = false;
            }
            field(TotalResvAmount; TotalResvAmount)
            {
                ApplicationArea = Basic;
                Caption = 'Total Reserved Amount';
                Editable = false;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if not Cust.Get("Sell-to Customer No.") then
            Clear(Cust);
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(Cust);
        OnAfterGetCurrRecord;
    end;

    var
        Cust: Record Customer;
        TotalResvQty: Decimal;
        TotalResvAmount: Decimal;


    procedure CalcTotal(var AgentCustLine: Record "Agent Customer Line"; LastAgentCustLine: Record "Agent Customer Line"; var TotalQty: Decimal; var TotalAmt: Decimal)
    var
        TempAgentCustLine: Record "Agent Customer Line";
    begin
        TempAgentCustLine.CopyFilters(AgentCustLine);
        TempAgentCustLine.CalcSums(Quantity, "Line Amount");
        TotalQty := TempAgentCustLine.Quantity;
        TotalAmt := TempAgentCustLine."Line Amount";
        /*
        IF AgentCustLine."Line No." = 0 THEN BEGIN
            TotalQty := TotalQty + LastAgentCustLine.Quantity;
            TotalAmt := TotalAmt + LastAgentCustLine."Line Amount";
        END;
        
        IF AgentCustLine."Line No." <> 0 THEN BEGIN
          TempAgentCustLine.SETRANGE("Line No.",0,AgentCustLine."Line No.");
          TempAgentCustLine.CALCSUMS(Quantity,"Line Amount");
          Qty := TempAgentCustLine.Quantity;
          Amt := TempAgentCustLine."Line Amount";
        END ELSE BEGIN
          TempAgentCustLine.SETRANGE("Line No.",0,LastAgentCustLine."Line No.");
          TempAgentCustLine.CALCSUMS(Quantity,"Line Amount");
          Qty := TempAgentCustLine.Quantity;
          Amt := TempAgentCustLine."Line Amount";
          TempAgentCustLine.COPYFILTERS(AgentCustLine);
          TempAgentCustLine := LastAgentCustLine;
          IF TempAgentCustLine.NEXT = 0 THEN BEGIN
            TotalQty := TotalQty + LastAgentCustLine.Quantity;
            TotalAmt := TotalAmt + LastAgentCustLine."Line Amount";
          END;
        END;
         */

    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        if not Cust.Get("Sell-to Customer No.") then
            Clear(Cust);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CalcTotal(Rec, xRec, TotalResvQty, TotalResvAmount);
    end;
}

