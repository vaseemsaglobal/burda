Page 50087 "Cash Advance Invoice Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.
    // Project: Burda
    // 002   08.11.2007   KKE   Show Description for Dim6.

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    MultipleNewLines = true;
    SourceTable = "Cash Advance Line";

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
                field(GenBusPostingGroup; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(GenProdPostingGroup; "Gen. Prod. Posting Group")
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
                field(VATBaseAmount; "VAT Base Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                field(PostingDate; CashAdvHdr."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                    Editable = false;
                }
                field(ActualVendorNo; "Actual Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field(RealCustomerVendorName; "Real Customer/Vendor Name")
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
                field(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,6';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(6, ShortcutDimCode[6]);
                        //KKE : #002 +
                        GLSetup.Get;
                        if not DimVal.Get(GLSetup."Shortcut Dimension 6 Code", ShortcutDimCode[6]) then
                            DimVal.Init;
                        //KKE : #002 -
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                        //KKE : #002 +
                        GLSetup.Get;
                        if not DimVal.Get(GLSetup."Shortcut Dimension 6 Code", ShortcutDimCode[6]) then
                            DimVal.Init;
                        //KKE : #002 -
                    end;
                }
                field(ColumnNameDescription; DimVal.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Column Name Description';
                    Editable = false;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
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
            group(Total)
            {
                field(AccountName; GLAcc.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                    Editable = false;
                }
                field(Balance; CalcBalanceAmt)
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                }
                field(TotalBalance; CalcTotalAmount)
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 1;
                    Caption = 'Total Amount';
                    Editable = false;
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
                        //This functionality was copied from page #50086. Unsupported part was commented. Please check it.
                        /*CurrPage.CashAdvLines.PAGE.*/
                        _ShowDimensions;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);

        if not CashAdvHdr.Get("Document No.") then
            CashAdvHdr.Init;

        //KKE : #002 +
        GLSetup.Get;
        if not DimVal.Get(GLSetup."Shortcut Dimension 6 Code", ShortcutDimCode[6]) then
            DimVal.Init;
        //KKE : #002 -
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := xRec.Type;
        Clear(ShortcutDimCode);

        DimVal.Init;  //KKE : #002
        OnAfterGetCurrRecord;
    end;

    var
        GLAcc: Record "G/L Account";
        CashAdvHdr: Record "Cash Advance Header";
        ShortcutDimCode: array[8] of Code[20];
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";


    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;


    procedure CalcTotalAmount(): Decimal
    var
        CashAdvLine: Record "Cash Advance Line";
    begin
        CashAdvLine.Reset;
        CashAdvLine.SetRange("Document No.", "Document No.");
        //PettyCashLine.SETFILTER("Line No.",'..%1',"Line No.");
        CashAdvLine.CalcSums("Amount (LCY) Incl. VAT", "Balance Amount Settle");
        exit(CashAdvLine."Balance Amount Settle");
    end;


    procedure CalcBalanceAmt(): Decimal
    var
        CashAdvHdr: Record "Cash Advance Header";
        CashAdvLine: Record "Cash Advance Line";
    begin
        if not CashAdvHdr.Get("Document No.") then
            exit;
        CashAdvHdr.CalcFields("Balance Amount Settle");
        CashAdvLine.Reset;
        CashAdvLine.SetRange("Document No.", "Document No.");
        CashAdvLine.SetFilter("Line No.", '..%1', "Line No.");
        if not CashAdvLine.Find('-') then
            CashAdvLine.SetRange("Line No.");
        CashAdvLine.CalcSums("Amount (LCY) Incl. VAT", "Balance Amount Settle");
        exit(CashAdvHdr."Balance Amount Settle" - CashAdvLine."Balance Amount Settle");
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if not GLAcc.Get("No.") then
            GLAcc.Init;
    end;
}

