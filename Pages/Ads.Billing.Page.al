Page 50066 "Ads. Billing"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   25.05.2007   KKE   New form for "Ads. Billing Note" - Ads. Sales Module

    PageType = Document;
    SourceTable = "Ads. Billing Header";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = "No.Editable";

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Bill-to Customer No.Editable";
                }
                field(BilltoName; "Bill-to Name")
                {
                    ApplicationArea = Basic;
                    Editable = "Bill-to NameEditable";
                }
                field(BilltoAddress; "Bill-to Address")
                {
                    ApplicationArea = Basic;
                    Editable = "Bill-to AddressEditable";
                }
                field(BilltoAddress2; "Bill-to Address 2")
                {
                    ApplicationArea = Basic;
                    Editable = "Bill-to Address 2Editable";
                }
                field(BilltoAddress3; "Bill-to Address 3")
                {
                    ApplicationArea = Basic;
                    Editable = "Bill-to Address 3Editable";
                }
                field(BilltoPostCodeCity; "Bill-to Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bill-to Post Code/City';
                    Editable = "Bill-to Post CodeEditable";
                }
                field(BilltoCity; "Bill-to City")
                {
                    ApplicationArea = Basic;
                    Editable = "Bill-to CityEditable";
                }
                field(BilltoCounty; "Bill-to County")
                {
                    ApplicationArea = Basic;
                    Editable = "Bill-to CountyEditable";
                }
                field(BilltoCountyCountryCode; "Bill-to Country Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bill-to County/Country Code';
                    Editable = "Bill-to Country CodeEditable";
                }
                field(BilltoContact; "Bill-to Contact")
                {
                    ApplicationArea = Basic;
                    Editable = "Bill-to ContactEditable";
                }
                field(Remark; Remark)
                {
                    ApplicationArea = Basic;
                    Editable = RemarkEditable;
                }
                field(BillingDate; "Billing Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Billing DateEditable";
                }
                field(ExpectedReceiptDate; "Expected Receipt Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Expected Receipt DateEditable";
                }
                field(DueDate; "Due Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Due DateEditable";
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(BillingSubform; "Ads. Billing Subform")
            {
                SubPageLink = "Billing No." = field("No.");
                ApplicationArea = basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action(SuggestLines)
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Lines';
                    Ellipsis = true;
                    Image = SuggestLines;

                    trigger OnAction()
                    begin
                        SuggestBillingLines(Rec);
                    end;
                }
                separator(Action1000000038)
                {
                }
                action(Reopen)
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        Reopen;
                    end;
                }
                action(ArchivedAdsBilling)
                {
                    ApplicationArea = Basic;
                    Caption = 'Archived Ads. Billing';

                    trigger OnAction()
                    begin
                        Rec.ArchivedAdsBilling;
                    end;
                }
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    AdsBillingHeader: Record "Ads. Billing Header";
                begin
                    AdsBillingHeader.SetRange("No.", "No.");
                    Report.RunModal(Report::"Ads. Billing Note", true, false, AdsBillingHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Due DateEditable" := true;
        "Bill-to ContactEditable" := true;
        "Bill-to Country CodeEditable" := true;
        "Bill-to CountyEditable" := true;
        "Bill-to CityEditable" := true;
        "Bill-to Post CodeEditable" := true;
        "Expected Receipt DateEditable" := true;
        "Billing DateEditable" := true;
        RemarkEditable := true;
        "Bill-to Address 3Editable" := true;
        "Bill-to Address 2Editable" := true;
        "Bill-to AddressEditable" := true;
        "Bill-to NameEditable" := true;
        "Bill-to Customer No.Editable" := true;
        "No.Editable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        "Bill-to Customer No.Editable": Boolean;
        [InDataSet]
        "Bill-to NameEditable": Boolean;
        [InDataSet]
        "Bill-to AddressEditable": Boolean;
        [InDataSet]
        "Bill-to Address 2Editable": Boolean;
        [InDataSet]
        "Bill-to Address 3Editable": Boolean;
        [InDataSet]
        RemarkEditable: Boolean;
        [InDataSet]
        "Billing DateEditable": Boolean;
        [InDataSet]
        "Expected Receipt DateEditable": Boolean;
        [InDataSet]
        "Bill-to Post CodeEditable": Boolean;
        [InDataSet]
        "Bill-to CityEditable": Boolean;
        [InDataSet]
        "Bill-to CountyEditable": Boolean;
        [InDataSet]
        "Bill-to Country CodeEditable": Boolean;
        [InDataSet]
        "Bill-to ContactEditable": Boolean;
        [InDataSet]
        "Due DateEditable": Boolean;


    procedure SetEditForm()
    begin
        "No.Editable" := Status = Status::Open;
        "Bill-to Customer No.Editable" := Status = Status::Open;
        "Bill-to NameEditable" := Status = Status::Open;
        "Bill-to AddressEditable" := Status = Status::Open;
        "Bill-to Address 2Editable" := Status = Status::Open;
        "Bill-to Address 3Editable" := Status = Status::Open;
        RemarkEditable := Status = Status::Open;
        "Billing DateEditable" := Status = Status::Open;
        "Expected Receipt DateEditable" := Status = Status::Open;
        "Bill-to Post CodeEditable" := Status = Status::Open;
        "Bill-to CityEditable" := Status = Status::Open;
        "Bill-to CountyEditable" := Status = Status::Open;
        "Bill-to Country CodeEditable" := Status = Status::Open;
        "Bill-to ContactEditable" := Status = Status::Open;
        "Due DateEditable" := Status = Status::Open;
        CurrPage.BillingSubform.Page.Editable := Status = Status::Open;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        SetEditForm;
    end;
}

