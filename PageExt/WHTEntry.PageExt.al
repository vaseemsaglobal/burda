PageExtension 50093 pageextension50093 extends "WHT Entry"
{

    /*
          Microsoft Business Solutions Navision
       ----------------------------------------
       Project: Localization TH
       KKE : Kanoknard Ketnut

       No.   Date         Sign  Description
       ----------------------------------------
       001   11.04.2005   KKE   -Modify program to allow edit WHT entries.
    */
    layout
    {
        modify("Gen. Bus. Posting Group")
        {

            Editable = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Editable = false;
        }
        modify("Posting Date")
        {
            Editable = false;
        }
        modify("Document No.")
        {
            Editable = false;
        }
        modify("Document Type")
        {
            Editable = false;
        }
        modify("Transaction Type")
        {

            Editable = false;
        }
        modify(Base)
        {
            Editable = false;
        }
        modify(Amount)
        {
            Editable = false;
        }
        modify("Currency Code")
        {

            Editable = false;
        }
        modify("Bill-to/Pay-to No.")
        {
            Editable = false;
        }
        modify("User ID")
        {
            Editable = false;
        }
        modify("Source Code")
        {
            Editable = false;
        }
        modify("Reason Code")
        {

            Editable = false;
        }
        modify("Closed by Entry No.")
        {

            Editable = false;
        }
        modify(Closed)
        {
            Editable = false;
        }
        modify("Transaction No.")
        {
            Editable = false;
        }
        modify("Unrealized Amount")
        {
            Editable = false;
        }
        modify("Unrealized Base")
        {
            Editable = false;
        }
        modify("Remaining Unrealized Amount")
        {
            Editable = false;
        }
        modify("Remaining Unrealized Base")
        {
            Editable = false;
        }
        modify("External Document No.")
        {

            Editable = false;
        }
        modify("No. Series")
        {

            Editable = false;
        }
        modify("Unrealized WHT Entry No.")
        {

            Editable = false;
        }
        modify("WHT Bus. Posting Group")
        {
            Editable = false;
        }
        modify("WHT Prod. Posting Group")
        {
            Editable = false;
        }
        modify("Base (LCY)")
        {
            Editable = false;
        }
        modify("Amount (LCY)")
        {
            Editable = false;
        }
        modify("Unrealized Amount (LCY)")
        {
            Editable = false;
        }
        modify("Unrealized Base (LCY)")
        {
            Editable = false;
        }
        modify("WHT %")
        {
            Editable = false;
        }
        modify("Rem Unrealized Amount (LCY)")
        {

            Editable = false;
        }
        modify("Rem Unrealized Base (LCY)")
        {

            Editable = false;
        }
        modify("WHT Difference")
        {

            Editable = false;
        }
        modify("Ship-to/Order Address Code")
        {

            Editable = false;
        }
        modify("Document Date")
        {

            Editable = false;
        }
        modify("Actual Vendor No.")
        {
            Editable = false;
        }
        modify("Void Check")
        {

            Editable = false;
        }
        modify("Original Document No.")
        {
            Editable = false;
        }
        modify("Void Payment Entry No.")
        {

            Editable = false;
        }
        modify("WHT Report")
        {
            Editable = false;
        }
        modify("WHT Calculation Type")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }
        modify("WHT Report Line No")
        {
            Visible = false;
        }
        addfirst(Content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(WHTReportFilter; WHTReportFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'WHT Report';
                }
                field(WHTCertificateNoFilter; WHTCertificateNoFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'WHT Certificate No.';
                }
                field(DocumentNoFilter; DocumentNoFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No.';
                    Editable = false;
                }
                field(StartingDate; StartingDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting Date';
                    Editable = false;
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending Date';
                    Editable = false;
                }
            }
        }
        addafter("WHT Certificate No.")
        {
            field(Cancelled; Cancelled)
            {
                ApplicationArea = Basic;
            }
        }
        addafter("WHT Prod. Posting Group")
        {
            field("WHT Revenue Type"; "WHT Revenue Type")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
        moveafter("Entry No."; "WHT Certificate No.")
        moveafter("WHT Certificate No."; "Original Document No.")
        moveafter("Original Document No."; "WHT Bus. Posting Group")
        moveafter("WHT Prod. Posting Group"; "WHT %")
        moveafter("Posting Date"; "Document Type")
        moveafter("Document No."; "Bill-to/Pay-to No.")
        moveafter("Bill-to/Pay-to No."; "Actual Vendor No.")
        moveafter("Actual Vendor No."; Base)
        moveafter(Amount; "Unrealized Base")
        moveafter("Unrealized Base"; "Unrealized Amount")
        moveafter("Unrealized Amount"; "Remaining Unrealized Base")
        moveafter("Remaining Unrealized Base"; "Remaining Unrealized Amount")
        moveafter("Remaining Unrealized Amount"; "Currency Code")
        moveafter("Currency Code"; "User ID")
    }
    actions
    {
        addfirst(processing)
        {
            action("&Navigate")
            {
                ApplicationArea = Basic;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.Run;
                end;
            }
            action("Fi&nd")
            {
                ApplicationArea = Basic;
                Caption = 'Fi&nd';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if WHTReportFilter <> Whtreportfilter::" " then
                        SetRange("WHT Report", WHTReportFilter)
                    else
                        SetRange("WHT Report");
                    if WHTCertificateNoFilter <> '' then
                        SetRange("WHT Certificate No.", WHTCertificateNoFilter)
                    else
                        SetRange("WHT Certificate No.");
                    if DocumentNoFilter <> '' then
                        SetRange("Document No.", DocumentNoFilter)
                    else
                        SetRange("Document No.");
                    if (StartingDate <> 0D) and (EndingDate <> 0D) then
                        SetFilter("Posting Date", '%1..%2', StartingDate, EndingDate)
                    else
                        if (StartingDate <> 0D) and (EndingDate = 0D) then
                            SetFilter("Posting Date", '%1..', StartingDate)
                        else
                            if (StartingDate = 0D) and (EndingDate <> 0D) then
                                SetFilter("Posting Date", '..%1', EndingDate);
                end;
            }
        }
    }

    var
        WHTManagement: Codeunit WHTManagement;
        StartingDate: Date;
        EndingDate: Date;
        WHTReportFilter: Option " ","Por Ngor Dor 1","Por Ngor Dor 2","Por Ngor Dor 3","Por Ngor Dor 53","Por Ngor Dor 54";
        WHTCertificateNoFilter: Text[50];
        DocumentNoFilter: Text[50];
        VendName: Text[200];
        Navigate: Page Navigate;


}

