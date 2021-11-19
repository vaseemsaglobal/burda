PageExtension 50055 pageextension50055 extends "Payment Journal"
{
    layout
    {

        modify("WHT Payment")
        {
            Visible = false;
        }
        addafter("Account No.")
        {
            field("Dummy Vendor"; "Dummy Vendor")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("VAT Registration No.(Dummy)"; "VAT Registration No.(Dummy)")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter(Description)
        {
            field("Payee Name"; "Payee Name")
            {
                ApplicationArea = Basic;
            }

            field("Bank Name"; "Bank Name")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Bank Branch"; "Bank Branch")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Real Customer/Vendor Name"; "Real Customer/Vendor Name")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Check No."; "Check No.")
            {
                ApplicationArea = All;

            }
            field("Cheque Date"; "Cheque Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("Skip WHT")
        {
            field("One Doc. Per WHT Slip"; "One Doc. Per WHT Slip")
            {
                ApplicationArea = Basic;
            }
            field("WHT Certificate No."; "WHT Certificate No.")
            {
                ApplicationArea = Basic;
                Editable = "WHT Certificate No.Editable";
            }
            field("Certificate Printed"; "Certificate Printed")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Bal. Account No.")
        {
            field("Block Bank Cheque"; "Block Bank Cheque")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("Bal. Gen. Bus. Posting Group"; GetAppliesToDocDueDate)
        moveafter("Bal. Gen. Prod. Posting Group"; "Check Printed")
        moveafter("Bal. VAT Bus. Posting Group"; "Reason Code")
    }
    actions
    {

        addafter("Print WHT Certificate")
        {
            separator(Action1000000025)
            {
            }
            action("Get Cash Advance")
            {
                ApplicationArea = Basic;
                Caption = 'Get Cash Advance';

                trigger OnAction()
                var
                    GetCashAdvance: Report "Get Cash Advance";
                begin
                    //KKE : #002 +
                    GenJnlLine.Reset;
                    GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine.SetRange("Line No.", "Line No.");
                    if GenJnlLine.Find('-') then begin
                        GetCashAdvance.SetTableview(GenJnlLine);
                        GetCashAdvance.GetGenJnlLine2(GenJnlLine);
                        GetCashAdvance.RunModal;
                    end;
                    //KKE : #002 -
                end;
            }
            action("Get WHT From Petty Cash")
            {
                ApplicationArea = Basic;
                Caption = 'Get WHT From Petty Cash';

                trigger OnAction()
                var
                    GenJnlLine2: Record "Gen. Journal Line";
                    WHTAmount: Decimal;
                begin
                    //KKE : #002 +
                    if not Confirm(C_0001, false) then
                        exit;

                    GenJnlLine.Reset;
                    GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine.SetRange("Line No.", "Line No.");
                    if GenJnlLine.Find('-') then begin
                        WHTAmount := WHTManagement.WHTAmountJournal(Rec, false);

                        GenJnlLine2.TransferFields(Rec);
                        GenJnlLine2."Line No." := "Line No." + 10000;

                        if "Account Type" = "account type"::Vendor then begin
                            GenJnlLine2."Document Type" := GenJnlLine2."document type"::Invoice;
                            GenJnlLine2."External Document No." := "Applies-to Doc. No.";
                            GenJnlLine2.Validate("Account Type", "account type"::Vendor);
                            GenJnlLine2.Validate("Account No.", "Account No.");
                            GenJnlLine2.Validate("WHT Business Posting Group", '');
                            GenJnlLine2.Validate(Amount, ((-1) * (Amount - WHTAmount)));
                        end;

                        GenJnlLine2.Validate("Applies-to Doc. Type", GenJnlLine2."applies-to doc. type"::" ");
                        GenJnlLine2.Validate("Applies-to Doc. No.", '');
                        GenJnlLine2.Insert;
                        Modify;
                    end;

                    Commit;
                    Message(C_0002);
                    //KKE : #002 -
                end;
            }
        }
        addfirst(Processing)
        {
            group("P&rint")
            {
                Caption = 'P&rint';
                action("Payment Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Voucher';

                    trigger OnAction()
                    begin
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        GenJnlLine.SetRange("Document No.", "Document No.");
                        Report.Run(Report::"Payment Voucher", true, false, GenJnlLine);
                    end;
                }
                action("WHT Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'WHT Slip';
                    visible = false;
                    trigger OnAction()
                    var
                        GenJnlLine: Record "Gen. Journal Line";
                        WHTSlipBefPost: Report "FORM 50 BIS Before Post";
                        WhtBusPostGrp: Record "WHT Business Posting Group";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                    begin
                        /*
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                        GenJnlLine.SetRange("Document No.", "Document No.");
                        Clear(WHTSlipBefPost);
                        WHTSlipBefPost.SetTableview(GenJnlLine);
                        WHTSlipBefPost.RunModal;
                        */
                        WhtBusPostGrp.Get("WHT Business Posting Group");
                        "WHT Certificate No." := NoSeriesMgt.GetNextNo(WhtBusPostGrp."WHT Certificate No. Series", GenJnlLine."Posting Date", TRUE);
                        "Certificate Printed" := true;
                        Modify();

                    end;
                }
            }
        }
        addafter(CancelPostDatedCheck)
        {
            separator(Action1000000023)
            {
            }
            action("Adjust WHT Amount")
            {
                ApplicationArea = Basic;
                Caption = 'Adjust WHT Amount';

                trigger OnAction()
                var
                    WHTEntry: Record "WHT Entry";
                    AdjustWHTAmount: Page "Adjust WHT Amount";
                begin
                    //KKE : #001 +
                    Clear(AdjustWHTAmount);
                    WHTEntry.Reset;
                    WHTEntry.SetRange("Document Type", WHTEntry."document type"::Invoice);
                    if "Applies-to Doc. No." <> '' then
                        WHTEntry.SetRange("Document No.", "Applies-to Doc. No.")
                    else
                        if "Applies-to ID" <> '' then
                            WHTEntry.SetRange("Applies-to ID", "Applies-to ID")
                        else
                            Error(C_0003);
                    AdjustWHTAmount.SetTableview(WHTEntry);
                    AdjustWHTAmount.Run;
                    //KKE : #001 -
                end;
            }
            separator(Action1000000038)
            {
            }
            action("Bank Cheque (Create File)")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Cheque (Create File)';

                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                begin
                    //KKE : #050 +
                    GenJnlLine.Reset;
                    GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine.SetRange("Posting Date", "Posting Date");
                    Report.Run(Report::"Bank Cheque (Create File)", true, false, GenJnlLine);
                    //KKE : #050 -
                end;
            }
            action("Unblock Bank Cheque")
            {
                ApplicationArea = Basic;
                Caption = 'Unblock Bank Cheque';

                trigger OnAction()
                begin
                    UnblockBankCheque;  //KKE : #050
                end;
            }
        }
    }

    var
        VendEntryEdit: Codeunit "Vend. Entry-Edit";
        WHTManagement: Codeunit WHTManagement;
        C_0001: label 'Do you want to get WHT from petty cash?';
        C_0002: label 'Successfully Inserted.';
        C_0003: label 'WHT Entries does not exists.';
        GenJnlBatch: Record "Gen. Journal Batch";
        [InDataSet]
        "WHT Certificate No.Editable": Boolean;
        GenJnlLine: Record "Gen. Journal Line";

    trigger OnAfterGetRecord()

    begin

        //ShowShortcutDimCode(ShortcutDimCode);
        //KKE : #004 +
        IF "Certificate Printed" THEN
            "WHT Certificate No.Editable" := FALSE
        ELSE BEGIN
            GenJnlBatch.GET("Journal Template Name", "Journal Batch Name");
            "WHT Certificate No.Editable" := GenJnlBatch."Allow Manual WHT Cert. No.";
        END;
        //KKE : #004 -

    end;

}

