Page 50048 "Ads. Booking"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.05.2007   KKE   New form for "Ads. Booking" - Ads. Sales Module
    // Burda
    // 002   30.08.2007   KKE   Salesperson permission.

    PageType = Document;
    SourceTable = "Ads. Booking Header";
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

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(BookingDate; "Booking Date")
                {
                    ApplicationArea = Basic;
                }
                field(SalespersonCode; "Salesperson Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field(SalesPersonName; Salesperson.Name)
                {
                    Editable = false;
                    Caption = 'Salesperson Name';
                    ApplicationArea = Basic;
                }
                field(SelltoCustomerNo; "Final Customer No.")
                {
                    Caption = 'Final Customer No.';
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field(SellToCustomerName; FORMAT(Cust.Name))
                {

                    Caption = 'Final Customer Name';
                    ApplicationArea = Basic;
                }
                field(BilltoCustomerNo; "Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        //>>VAH
                        if BillToCust.get("Bill-to Customer No.") then
                            BillToCustomerName := BillToCust.Name;
                        //<<VAH   
                    end;
                }
                field(BilltoCustomerName; BillToCustomerName)
                {
                    Editable = false;
                    Caption = 'Bill-to Customer Name';
                    ApplicationArea = Basic;

                }
                field(PaymentTermsCode; "Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field(ZoneArea; "Zone Area")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }


                field(AdsSalesType; "Client Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Client Type';
                }

                field(BookingType; "Booking Type")
                {
                    Visible = false;
                    ApplicationArea = Basic;

                }
                field(Contract_Submitted; "Contract Submitted")
                {
                    ApplicationArea = Basic;

                }
                field("Header Remark"; "Header Remark")
                {
                    Caption = 'Header Remark For Validator';
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Email Validation"; "Email Validation")
                {
                    Editable = false;
                    Caption = 'Validation Status';
                    ApplicationArea = Basic;

                }
                field("Currency Code"; "Currency Code")
                {
                    //Visible = false;
                    ApplicationArea = BASIC;

                }
                field("Currency Factor"; "Currency Factor")
                {
                    Visible = false;
                    ApplicationArea = Basic;

                }
                field("Contract No."; "Contract No.")
                {
                    ApplicationArea = All;

                }
                field("Remark By Ad Traffic"; Remark)
                {
                    ApplicationArea = All;

                }
            }
            part(AdsBookingSubf; "Ads. Booking Subform")
            {
                ApplicationArea = Basic;
                SubPageLink = "Deal No." = field("No.");
            }
            group(Contact)
            {
                Caption = 'Contact';
                field(Control1000000019; Contact)
                {
                    ApplicationArea = Basic;
                }
                field(PhoneNo; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(FaxNo; "Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field(MobileNo; "Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field(EMail; "E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(Remark; Remark)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Print)
            {
                ApplicationArea = Basic;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    AdsBookingHdr: Record "Ads. Booking Header";
                begin
                    AdsBookingHdr.SetRange("No.", "No.");
                    Report.Run(Report::"Advertising Contract", true, false, AdsBookingHdr);
                end;
            }
            action(Send_Email)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                trigger OnAction()
                var
                    EmailItem: Record "Email Item";
                    AdsBookingHeader: Record "Ads. Booking Header";
                    RecRef: RecordRef;
                    OutStr: OutStream;
                    Salesperson: Record "Salesperson/Purchaser";
                    EmailAuthurlAppr: Text;
                    EmailAuthurlReject: Text;
                    AdsSalesSetup: Record "Ads. Item Setup";
                    companyNametext: Text;
                    StartPos: Integer;
                    Aprovaltext: Text;
                begin
                    AdsSalesSetup.Get();
                    if not AdsSalesSetup."Enable Email Approval" then
                        Error('Email approval in not enabled, contact your system administrator.');
                    if ("Email Validation" = "Email Validation"::"Approval In-Progress") or ("Email Validation" = "Email Validation"::Approved) then
                        Error('An email can not be sent because deal status is ' + Format("Email Validation"));
                    TestField("Salesperson Code");
                    Salesperson.get("Salesperson Code");
                    Salesperson.TestField("E-Mail");
                    Aprovaltext := 'An email will be sent to ' + Salesperson."E-Mail" + '. Do you want to send?';
                    if not Confirm(Aprovaltext) then
                        exit;
                    companyNametext := CompanyName;
                    StartPos := STRPOS(companyNametext, ' ');
                    WHILE StartPos > 0 DO BEGIN
                        companyNametext := DELSTR(companyNametext, StartPos) + '%20' + COPYSTR(companyNametext, StartPos + STRLEN(' '));
                        StartPos := STRPOS(companyNametext, ' ');
                    END;
                    //EXIT(String);

                    if Cust.get("Bill-to Customer No.") then
                        BillToCustomerName := Cust.Name;
                    EmailValidations(Rec);
                    EmailAuthurlAppr := 'http://email-auth-prod-burda.azurewebsites.net/api/EmailAuth?bookingNo=' + rec."No." + '&bookingConfirm=2' + '&companyName=' + companyNametext + '&salesPerson=' + "Salesperson Code";
                    EmailAuthurlReject := 'http://email-auth-prod-burda.azurewebsites.net/api/EmailAuth?bookingNo=' + rec."No." + '&bookingConfirm=1' + '&companyName=' + companyNametext + '&salesPerson=' + "Salesperson Code";
                    EmailItem."Send to" := Salesperson."E-Mail";
                    EmailItem.Subject := "No." + ' / ' + BillToCustomerName;
                    EmailItem.Validate("Plaintext Formatted", false);
                    AdsBookingHeader.SetRange("No.", "No.");
                    RecRef.GetTable(AdsBookingHeader);
                    EmailItem.Body.CreateOutStream(OutStr);
                    //EmailItem.body.Import('./EmailScript.js');
                    OutStr.WriteText('<br><br> &emsp;<b> Validation</b> &emsp;&emsp;&emsp; <a href=' + EmailAuthurlAppr + '>Approve</a> &emsp;&emsp;&emsp; <a href=' + EmailAuthurlReject + '>Reject</a>');
                    Report.SaveAs(Report::"Ads Booking Email", '', ReportFormat::Html, outstr, RecRef);
                    EmailItem.Send(true);
                    rec.validate("Email Validation", rec."Email Validation"::"Approval In-Progress");
                    rec.Modify();
                    Message('Email has been sent');
                end;
            }
            action(Cancel_Email)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                trigger OnAction()
                var

                    AdsBookingLine: Record "Ads. Booking Line";
                begin
                    if not Confirm('Do you want to cancel the email approval?') then
                        exit;
                    rec."Email Validation" := 0;
                    rec.Modify();
                    AdsBookingLine.Reset();
                    AdsBookingLine.SetRange("Deal No.", rec."No.");
                    AdsBookingLine.SetFilter("Posting Status", '%1|%2', AdsBookingLine."Posting Status"::Open, AdsBookingLine."Posting Status"::Rejected);
                    AdsBookingLine.SetRange("Line Status", AdsBookingLine."Line Status"::Approved);
                    if AdsBookingLine.FindSet() then
                        AdsBookingLine.ModifyAll("Line Status", AdsBookingLine."Line Status"::Confirmed);
                    Message('Email request cancelled');

                end;
            }
            action(ManualApproval)
            {
                ApplicationArea = All;
                Image = Approve;
                Caption = 'Manual Approval';
                Visible = ManualApprovalVisible;
                Enabled = ManualApprovalEnabled;

                trigger OnAction()
                var
                    AdsBookingLine: Record "Ads. Booking Line";
                begin
                    EmailValidations(Rec);
                    if rec."Email Validation" = rec."Email Validation"::Approved then begin
                        Message('Deal is already approved');
                        exit;
                    end;
                    rec."Email Validation" := rec."Email Validation"::Approved;
                    rec.Modify();
                    AdsBookingLine.Reset();
                    AdsBookingLine.SetRange("Deal No.", rec."No.");
                    AdsBookingLine.SetFilter("Line Status", '%1|%2', AdsBookingLine."Line Status"::Hold, AdsBookingLine."Line Status"::Confirmed);
                    if AdsBookingLine.FindSet() then begin
                        AdsBookingLine.ModifyAll("Line Status", AdsBookingLine."Line Status"::Approved);
                    end;
                    Message('Deal no. %1 has been approved', rec."No.");
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

    trigger OnOpenPage()
    begin
        //KKE : #002 +
        Reset;
        UserSetup.Get(UserId);
        case UserSetup."Ads. Booking Filter" of
            UserSetup."ads. booking filter"::" ":
                Error(Text001);
            UserSetup."ads. booking filter"::Salesperson:
                begin
                    UserSetup.TestField("Salesperson Code");
                    Salesperson.SetFilter(Code, UserSetup."Salesperson Code");
                    FilterGroup(2);
                    SetFilter("Salesperson Code", '%1|%2', '', Salesperson.GetFilter(Code));
                    FilterGroup(0);
                end;
            UserSetup."ads. booking filter"::Team:
                begin
                    UserSetup.TestField("Salesperson Code");
                    TeamSales.SetRange("Salesperson Code", UserSetup."Salesperson Code");
                    if not TeamSales.Find('-') then
                        Salesperson.SetFilter(Code, UserSetup."Salesperson Code")
                    else begin
                        repeat
                            if StrLen(TeamSalesFilter + TeamSales."Team Code") < 500 then
                                if TeamSalesFilter = '' then
                                    TeamSalesFilter := TeamSales."Team Code"
                                else
                                    TeamSalesFilter := TeamSalesFilter + '|' + TeamSales."Team Code";
                        until TeamSales.Next = 0;
                        TeamSales.Reset;
                        TeamSales.SetFilter("Team Code", TeamSalesFilter);
                        TeamSales.Find('-');
                        repeat
                            if StrLen(SalespersonFilter + TeamSales."Team Code") < 500 then
                                if SalespersonFilter = '' then
                                    SalespersonFilter := Text002 + '|' + TeamSales."Salesperson Code"
                                else
                                    SalespersonFilter := SalespersonFilter + '|' + TeamSales."Salesperson Code";
                        until TeamSales.Next = 0;
                        Salesperson.SetFilter(Code, SalespersonFilter);
                    end;
                    FilterGroup(2);
                    Salesperson.Copyfilter(Code, "Salesperson Code");
                    FilterGroup(0);
                end;
            UserSetup."ads. booking filter"::All:
                begin
                    Salesperson.Reset;
                end;
        end;
        //>>VAH
        if BillToCust.get("Bill-to Customer No.") then
            BillToCustomerName := BillToCust.Name;
        //<<VAH

        //KKE : #002 -
        AdsItemSetup.Get();
        if not AdsItemSetup."Enable Email Approval" then
            ManualApprovalVisible := true
        else
            ManualApprovalVisible := false;
        ManualApprovalEnabled := UserSetup."Manual Approval";

    end;

    var
        Salesperson: Record "Salesperson/Purchaser";
        Cust: Record Customer;
        UserSetup: Record "User Setup";
        TeamSales: Record "Team Salesperson";
        TeamSalesFilter: Text[500];
        SalespersonFilter: Text[500];
        BillToCustomerName: Text[100];
        BillToCust: Record customer;
        Text001: label 'You do not have permision to do Ads. Booking.';
        Text002: label '''''';
        AdsItemSetup: Record "Ads. Item Setup";
        ManualApprovalVisible: Boolean;
        ManualApprovalEnabled: Boolean;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        if not Salesperson.Get("Salesperson Code") then
            Clear(Salesperson);
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        if not Cust.Get("Final Customer No.") then
            Clear(Cust);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if not Salesperson.Get("Salesperson Code") then
            Clear(Salesperson);
        if not Cust.Get("Final Customer No.") then
            Clear(Cust);
    end;
}

