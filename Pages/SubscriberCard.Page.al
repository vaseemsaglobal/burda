page 50001 "Subscriber Card"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New Form for Subscriber Card.

    PageType = Card;
    SourceTable = Subscriber;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Salutation Code"; "Salutation Code")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(DD; DD)
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = 'Date of Birth (Thai)';
                    MaxValue = 31;
                    MinValue = 0;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CalcDateofBirth;
                    end;
                }
                field(MM; MM)
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '/';
                    MaxValue = 12;
                    MinValue = 0;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CalcDateofBirth;
                    end;
                }
                field(YY; YY)
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Caption = '/';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CalcDateofBirth;
                    end;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';

                    trigger OnValidate()
                    begin
                        DateofBirthOnAfterValidate;
                    end;
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Children"; "No. of Children")
                {
                    ApplicationArea = Basic;
                }
                field("Address 1"; "Address 1")
                {
                    ApplicationArea = Basic;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("Address 3"; "Address 3")
                {
                    ApplicationArea = Basic;
                }
                field("Province/City"; "Province/City")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No."; "Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field("Old Subscriber No."; "Old Subscriber No.")
                {
                    ApplicationArea = Basic;
                }
                field(Sex; Sex)
                {
                    ApplicationArea = Basic;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Estimate Revenue"; "Estimate Revenue")
                {
                    ApplicationArea = Basic;
                }
                field("Estimate Family Revenue"; "Estimate Family Revenue")
                {
                    ApplicationArea = Basic;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                }
                field(Position; Position)
                {
                    ApplicationArea = Basic;
                }
                field("Company Name"; "Company Name")
                {
                    ApplicationArea = Basic;
                }
                field(Education; Education)
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Zone Area"; "Zone Area")
                {
                    ApplicationArea = Basic;
                }
                field("Contact No."; "Contact No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Last Time Modified"; "Last Time Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Comment Text"; "Comment Text")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
            group("Bill-to")
            {
                Caption = 'Bill-to';
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Name 2"; "Bill-to Name 2")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Address 1"; "Bill-to Address 1")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Address 3"; "Bill-to Address 3")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Province/City"; "Bill-to Province/City")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Phone No."; "Bill-to Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Mobile No."; "Bill-to Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Fax No."; "Bill-to Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field("Name (Thai)"; "Name (Thai)")
                {
                    ApplicationArea = Basic;
                }
                field("Address (Thai)"; "Address (Thai)")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
            }
            group("Ship-to")
            {
                Caption = 'Ship-to';
                field("Ship-to Address 1"; "Ship-to Address 1")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Address 3"; "Ship-to Address 3")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Province/City"; "Ship-to Province/City")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Phone No."; "Ship-to Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Mobile No."; "Ship-to Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Fax No."; "Ship-to Fax No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Subscriber")
            {
                Caption = '&Subscriber';
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Subscriber), "No." = FIELD("No.");
                }
                action("Subscriber &Contract")
                {
                    ApplicationArea = Basic;
                    Caption = 'Subscriber &Contract';
                    RunObject = Page "Subscriber Contract List";
                    RunPageLink = "Subscriber No." = FIELD("No.");
                }
                action("Con&tact")
                {
                    ApplicationArea = Basic;
                    Caption = 'Con&tact';
                    RunObject = Page "Contact Card";
                    RunPageLink = "No." = FIELD("Contact No.");
                }
                action("C&ustomer")
                {
                    ApplicationArea = Basic;
                    Caption = 'C&ustomer';
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Customer No.");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Create &Customer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create &Customer';

                    trigger OnAction()
                    begin
                        CreateCustomer(ChooseCustomerTemplate);
                    end;
                }
                action("Create &Subscriber Contract")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create &Subscriber Contract';

                    trigger OnAction()
                    begin
                        CreateSubscriberContract;
                    end;
                }
            }
            action(ChkDupl)
            {
                ApplicationArea = Basic;
                Caption = 'ChkDupl';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Subscriber: Record "Subscriber";
                begin
                    IF PAGE.RUNMODAL(PAGE::"Subscriber Duplicate Check", Subscriber) = ACTION::LookupOK THEN
                        Rec := Subscriber;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        DD: Integer;
        MM: Integer;
        YY: Integer;
        Text001: Label 'Invalid %1.';

    //[Scope('Internal')]
    procedure CalcDMY()
    begin
        DD := 0;
        MM := 0;
        YY := 0;
        IF "Date of Birth" <> 0D THEN BEGIN
            DD := DATE2DMY("Date of Birth", 1);
            MM := DATE2DMY("Date of Birth", 2);
            YY := DATE2DMY("Date of Birth", 3) + 543;
        END;
    end;

    //[Scope('Internal')]
    procedure CalcDateofBirth()
    begin
        IF (DD = 0) OR (MM = 0) OR (YY = 0) THEN
            EXIT;
        IF DD > 31 THEN
            ERROR(Text001, 'Day');
        IF MM > 12 THEN
            ERROR(Text001, 'Month');
        IF (YY - 543 < DATE2DMY(TODAY, 3) - 200) OR (YY - 543 > DATE2DMY(TODAY, 3)) THEN
            ERROR(Text001, 'Year');

        VALIDATE("Date of Birth", DMY2DATE(DD, MM, YY - 543));
    end;

    local procedure DateofBirthOnAfterValidate()
    begin
        CalcDMY;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CalcDMY;
    end;
}

