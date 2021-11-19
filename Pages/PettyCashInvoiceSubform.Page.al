Page 50072 "Petty Cash Invoice Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   24.08.2006   KKE   Petty Cash.

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Petty Cash Line";

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
                field(ActualVendorNo; "Actual Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field(RealCustomerVendorName; "Real Customer/Vendor Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
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
            group(Control1000000031)
            {
                Caption = '';
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
                        //This functionality was copied from page #50071. Unsupported part was commented. Please check it.
                        /*CurrPage.PettyCashLines.PAGE.*/
                        _ShowDimensions;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := xRec.Type;
        Clear(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    var
        GLAcc: Record "G/L Account";
        ShortcutDimCode: array[8] of Code[20];


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
        PettyCashLine: Record "Petty Cash Line";
    begin
        PettyCashLine.Reset;
        PettyCashLine.SetRange("Document No.", "Document No.");
        //PettyCashLine.SETFILTER("Line No.",'..%1',"Line No.");
        PettyCashLine.CalcSums("Amount (LCY) Incl. VAT");
        exit(PettyCashLine."Amount (LCY) Incl. VAT");
    end;


    procedure CalcBalanceAmt(): Decimal
    var
        PettyCashHdr: Record "Petty Cash Header";
        PettyCashLine: Record "Petty Cash Line";
    begin
        if not PettyCashHdr.Get("Document No.") then
            exit;
        PettyCashHdr.CalcFields("Balance Amount");
        PettyCashLine.Reset;
        PettyCashLine.SetRange("Document No.", "Document No.");
        PettyCashLine.SetFilter("Line No.", '..%1', "Line No.");
        if not PettyCashLine.Find('-') then
            PettyCashLine.SetRange("Line No.");
        PettyCashLine.CalcSums("Amount (LCY) Incl. VAT");
        exit(PettyCashHdr."Balance Amount" - PettyCashLine."Amount (LCY) Incl. VAT");
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if not GLAcc.Get("No.") then
            GLAcc.Init;
    end;
}

