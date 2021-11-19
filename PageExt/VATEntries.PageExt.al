PageExtension 50058 pageextension50058 extends "VAT Entries"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   24.12.2004   KKE   -Add new fields for localization.
                               -Allow user to edit "Tax Invoice No.","Tax Invoice Date",Submit Date".
      002   28.12.2004   KKE   -Calculate Tax Invoice amount which show on report and not show on report.
    */
    layout
    {
        addafter("Document No.")
        {
            field("External Document No."; "External Document No.")
            {
                ApplicationArea = Basic;
            }
            field("Tax Invoice No."; "Tax Invoice No.")
            {
                ApplicationArea = Basic;
            }
            field("Tax Invoice Date"; "Tax Invoice Date")
            {
                ApplicationArea = Basic;
            }
            field("Submit Date"; "Submit Date")
            {
                ApplicationArea = Basic;
            }
            field("Real Customer/Vendor Name"; "Real Customer/Vendor Name")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }

        addafter(Control1)
        {
            label(Label1)
            {
                ApplicationArea = Basic;
                CaptionClass = '*** For calculate Purchase VAT only.';
                Style = Strong;
                StyleExpr = TRUE;
                //Visible = false;
            }
            field(StartingDate; StartingDate)
            {
                ApplicationArea = Basic;
                Caption = 'From Date';
            }
            field(EndingDate; EndingDate)
            {
                ApplicationArea = Basic;
                Caption = 'To';
            }
            field(SumNotOnReport; SumNotOnReport)
            {
                ApplicationArea = Basic;
                BlankZero = true;
                Caption = 'Amount in period but not show on the report.';
                Editable = false;
            }
            field(SumShowedOnReport; SumShowedOnReport)
            {
                ApplicationArea = Basic;
                BlankZero = true;
                Caption = 'Amount not in period but show on the report.';
                Editable = false;
            }
            field("SumNotOnReport + SumShowedOnReport"; SumNotOnReport + SumShowedOnReport)
            {
                ApplicationArea = Basic;
                BlankZero = true;
                Caption = 'Total Amount';
                Editable = false;
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            action(Calculate)
            {
                ApplicationArea = Basic;
                Caption = 'Calculate';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //KKE : #002 +
                    Reset;
                    if (StartingDate = 0D) or (EndingDate = 0D) then
                        Error(C_0001);
                    if EndingDate - StartingDate < 0 then
                        Error(C_0002);

                    ClearMarks;
                    SumCase1 := 0;
                    SumCase2 := 0;
                    SumCase3 := 0;

                    //CASE 1
                    TmpVATEntry.Reset;
                    TmpVATEntry.SetRange(Type, TmpVATEntry.Type::Purchase);
                    TmpVATEntry.SetFilter("Posting Date", '%1..%2', StartingDate, EndingDate);
                    TmpVATEntry.SetRange("Tax Invoice No.", '');
                    TmpVATEntry.SetCurrentkey("Posting Date", "Document Type", "Document No.");
                    if TmpVATEntry.Find('-') then
                        repeat
                            SumCase1 += TmpVATEntry.Amount;
                            "Entry No." := TmpVATEntry."Entry No.";
                            Mark(true);
                        until TmpVATEntry.Next = 0;

                    //CASE 2
                    TmpVATEntry.Reset;
                    TmpVATEntry.SetRange(Type, TmpVATEntry.Type::Purchase);
                    TmpVATEntry.SetFilter("Posting Date", '<%1 | >%2', StartingDate, EndingDate);
                    TmpVATEntry.SetFilter("Submit Date", '%1..%2', StartingDate, EndingDate);
                    TmpVATEntry.SetFilter("Tax Invoice No.", '<>%1', '');
                    TmpVATEntry.SetCurrentkey("Posting Date", "Document Type", "Document No.");
                    if TmpVATEntry.Find('-') then
                        repeat
                            SumCase2 += TmpVATEntry.Amount;
                            "Entry No." := TmpVATEntry."Entry No.";
                            Mark(true);
                        until TmpVATEntry.Next = 0;

                    //CASE 3
                    TmpVATEntry.Reset;
                    TmpVATEntry.SetRange(Type, TmpVATEntry.Type::Purchase);
                    TmpVATEntry.SetFilter("Posting Date", '%1..%2', StartingDate, EndingDate);
                    TmpVATEntry.SetFilter("Submit Date", '< %1 | > %2', StartingDate, EndingDate);
                    TmpVATEntry.SetFilter("Tax Invoice No.", '<>%1', '');
                    TmpVATEntry.SetCurrentkey("Posting Date", "Document Type", "Document No.");
                    if TmpVATEntry.Find('-') then
                        repeat
                            SumCase3 += TmpVATEntry.Amount;
                            "Entry No." := TmpVATEntry."Entry No.";
                            Mark(true);
                        until TmpVATEntry.Next = 0;

                    SumNotOnReport := SumCase1 + SumCase3;
                    SumShowedOnReport := (-1) * SumCase2;

                    MarkedOnly(true);
                    CurrPage.Update;
                    //KKE : #002 -
                end;
            }
        }
    }
    var
        TmpVATEntry: Record "VAT Entry";
        StartingDate: Date;
        EndingDate: Date;
        currMonth: Integer;
        currYear: Integer;
        SumShowedOnReport: Decimal;
        SumNotOnReport: Decimal;
        SumCase1: Decimal;
        SumCase2: Decimal;
        SumCase3: Decimal;
        C_0001: label 'Please specify both Starting Date and Ending Date';
        C_0002: label 'Invalid Date.';

    trigger OnOpenPage()
    begin

        //KKE : #002 +
        currMonth := DATE2DMY(TODAY, 2);
        currYear := DATE2DMY(TODAY, 3);
        StartingDate := DMY2DATE(1, currMonth, currYear);
        EndingDate := TODAY;
        //KKE : #002 -

    end;
}

