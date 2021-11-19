Page 50121 "Subscriber Contract L/E"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   07.03.2007   KKE   New Form for Subscriber Contract L/E.

    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Subscriber Contract L/E";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(SubscriberContractNo; "Subscriber Contract No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
                field(SubscriberNo; "Subscriber No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
                field(MagazineItemNo; "Magazine Item No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
                field(MagazineCode; "Magazine Code")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
                field(VolumeNo; "Volume No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
                field(IssueNo; "Issue No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
                field(IssueDate; "Issue Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Basic;
                }
                field(UnitPrice; "Unit Price")
                {
                    ApplicationArea = Basic;
                }
                field(ShippingAgentCode; "Shipping Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field(PaidFlag; "Paid Flag")
                {
                    ApplicationArea = Basic;
                }
                field(PaidSalesOrderNo; "Paid Sales Order No.")
                {
                    ApplicationArea = Basic;
                }
                field(SalesOrderFlag; "Sales Order Flag")
                {
                    ApplicationArea = Basic;
                }
                field(SalesOrderNo; "Sales Order No.")
                {
                    ApplicationArea = Basic;
                }
                field(SalesOrderDate; "Sales Order Date")
                {
                    ApplicationArea = Basic;
                }
                field(SalesOrderLineNo; "Sales Order Line No.")
                {
                    ApplicationArea = Basic;
                }
                field(DeliveredFlag; "Delivered Flag")
                {
                    ApplicationArea = Basic;
                }
                field(DeliveredDocumentNo; "Delivered Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(DeliveredDate; "Delivered Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReversedFlag; "Reversed Flag")
                {
                    ApplicationArea = Basic;
                }
                field(ReversedCreditMemoNo; "Reversed Credit Memo No.")
                {
                    ApplicationArea = Basic;
                }
                field(Cancelled; Cancelled)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Replaced; Replaced)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SubscriberContract.Get("Subscriber Contract No.");
        "Subscriber No." := SubscriberContract."Subscriber No.";
        "Magazine Code" := SubscriberContract."Magazine Code";
        "Shipping Agent Code" := SubscriberContract."Shipping Agent Code";
        Quantity := 1;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Cancelled = true then
            StyleText := 'Unfavorable'
        else
            StyleText := 'Standard';
    end;

    var
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        SubscriberContract: Record "Subscriber Contract";
        StyleText: Text;
}

