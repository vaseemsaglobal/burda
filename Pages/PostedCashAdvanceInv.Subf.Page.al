Page 50091 "Posted Cash Advance Inv. Subf"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.

    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Cash Advance Invoice Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(VATBusPostingGroup; "VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(VATProdPostingGroup; "VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(WHTBusinessPostingGroup; "WHT Business Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(WHTProductPostingGroup; "WHT Product Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalDocumentNo; "External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(TaxInvoiceNo; "Tax Invoice No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(TaxInvoiceDate; "Tax Invoice Date")
                {
                    ApplicationArea = Basic;
                }
                field(RealCustomerVendorName; "Real Customer/Vendor Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(WHTAbsorbBase; "WHT Absorb Base")
                {
                    ApplicationArea = Basic;
                }
                field(AmountInclVAT; "Amount Incl. VAT")
                {
                    ApplicationArea = Basic;
                }
                field(VATAmount; "VAT Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(VATDifference; "VAT Difference")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(PostingDate; CashAdvInvHdr."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                    Editable = false;
                }
                field(ActualVendorNo; "Actual Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000037; "Real Customer/Vendor Name")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccountNo; "Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceAmountSettle; "Balance Amount Settle")
                {
                    ApplicationArea = Basic;
                }
                field(BankCode; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankBranchNo; "Bank Branch No.")
                {
                    ApplicationArea = Basic;
                }
                field(SkipWHT; "Skip WHT")
                {
                    ApplicationArea = Basic;
                }
                field(WHTCertificateNo; "WHT Certificate No.")
                {
                    ApplicationArea = Basic;
                }
                field(CertificatePrinted; "Certificate Printed")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Line)
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50090. Unsupported part was commented. Please check it.
                        /*CurrPage.CashAdvLines.PAGE.*/
                        _ShowDimensions;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if not CashAdvInvHdr.Get("Document No.") then
            CashAdvInvHdr.Init;
    end;

    var
        CashAdvInvHdr: Record "Cash Advance Invoice Header";


    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;
}

