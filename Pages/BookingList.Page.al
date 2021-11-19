Page 50033 "Booking List"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New form for "Booking List" - Editorial Module

    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Booking List";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(DummyPlanNo; "Dummy Plan No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(FromType; "From Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(BookingNo; "Booking No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(BookingLineNo; "Booking Line No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MagazineItemNo; "Magazine Item No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ContentCode; "Content Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ContentType; "Content Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ColumnName; "Column Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(BlackgroundColor; "Blackground Color")
                {
                    ApplicationArea = Basic;
                }
                field(ForegroundColor; "Foreground Color")
                {
                    ApplicationArea = Basic;
                }
                field(CountingUnit; "Counting Unit")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remark; Remark)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(AdsSize; "Ads. Size")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AdsProduct; "Ads. Product")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Control1000000046; AdsProduct.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Product Description';
                    Editable = false;
                }
                field(AdsPosition; "Ads. Position")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Control1000000048; AdsPosition.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ads. Position Description';
                    Editable = false;
                }
                field(AdsType; "Ads. Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(AdsSubType; "Ads. Sub-Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(PlanningStatus; "Planning Status")
                {
                    ApplicationArea = Basic;
                }
                field(OwnerCustomer; "Owner Customer")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(SalespersonCode; "Salesperson Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(AuthorName; "Author Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(SourceofInformation; "Source of Information")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(ContentReceiptDate; "Content Receipt Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if not AdsProduct.Get("Ads. Product") then
            Clear(AdsProduct);
        if not AdsPosition.Get("Ads. Position") then
            Clear(AdsPosition);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if ("Blackground Color" = xRec."Blackground Color") and ("Foreground Color" = xRec."Foreground Color") then begin
            Message(Text001);
            exit(false);
        end;
    end;

    trigger OnOpenPage()
    begin
        CurrPage.Editable := AllowEditForm;
    end;

    var
        AdsProduct: Record Brand;
        AdsPosition: Record "Ads. Position";
        Text001: label 'System does not allow to modify record.';
        AllowEditForm: Boolean;


    procedure SetEditable(AllowEdit: Boolean)
    begin
        AllowEditForm := AllowEdit;
    end;
}

