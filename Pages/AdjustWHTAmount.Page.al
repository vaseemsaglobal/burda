Page 50000 "Adjust WHT Amount"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   01.02.2006   KKE   localization.

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "WHT Entry";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(EntryNo; "Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; "Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(BilltoPaytoNo; "Bill-to/Pay-to No.")
                {
                    ApplicationArea = Basic;
                }
                field(WHTBusPostingGroup; "WHT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(WHTProdPostingGroup; "WHT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(WHT; "WHT %")
                {
                    ApplicationArea = Basic;
                }
                field(UnrealizedBaseLCY; "Unrealized Base (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(UnrealizedAmountLCY; "Unrealized Amount (LCY)")
                {
                    ApplicationArea = Basic;
                    Editable = UnrealizedAmountLCYEditable;
                }
                field(WHTDifference; "WHT Difference")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        UnrealizedAmountLCYEditable := true;
    end;

    trigger OnOpenPage()
    begin
        PurchSetup.Get;
        UnrealizedAmountLCYEditable := PurchSetup."Allow WHT Difference";
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        THA_001: label '%1 must not be more than %2.';
        [InDataSet]
        UnrealizedAmountLCYEditable: Boolean;


    procedure AdjustWHTAmount(NewUnrealizeAmount: Decimal)
    var
        GenLedgSetup: Record "General Ledger Setup";
        WHTDiff: Decimal;
    begin
        PurchSetup.Get;
        PurchSetup.TestField("Allow WHT Difference", true);
        GenLedgSetup.Get;
        WHTDiff := NewUnrealizeAmount - ROUND(("Unrealized Base (LCY)" * "WHT %") / 100);
        if WHTDiff > GenLedgSetup."Max. WHT Difference Allowed" then
            Error(StrSubstNo(THA_001, FieldCaption("WHT Difference"),
              GenLedgSetup.FieldCaption("Max. WHT Difference Allowed")));
        "WHT Difference" := WHTDiff;
    end;
}

