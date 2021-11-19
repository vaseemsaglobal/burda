codeunit 50035 BookingEmailValidator
{
    procedure IsBookingConfirm(BookingNo: code[20]; BookingConfirm: Integer; SalesPerson: Code[20]): Text[30];
    var
        AdsBookingHeader: Record "Ads. Booking Header";
        AdsBookingLine: Record "Ads. Booking Line";
    begin
        if AdsBookingHeader.Get(BookingNo) then begin
            if AdsBookingHeader."Email Validation" <> AdsBookingHeader."Email Validation"::"Approval In-Progress" then
                exit('Validation status should be Approval In-Progress');
            if AdsBookingHeader."Salesperson Code" <> SalesPerson then
                exit('Salesperson does not match');
            AdsBookingHeader."Email Validation" := BookingConfirm;
            AdsBookingHeader.Modify();
            AdsBookingLine.Reset();
            AdsBookingLine.SetRange("Deal No.", BookingNo);
            AdsBookingLine.SetFilter("Line Status", '%1|%2', AdsBookingLine."Line Status"::Hold, AdsBookingLine."Line Status"::Confirmed);
            if AdsBookingLine.FindSet() then begin
                if BookingConfirm = 1 then
                    AdsBookingLine.ModifyAll("Line Status", AdsBookingLine."Line Status"::Hold);
                if BookingConfirm = 2 then
                    AdsBookingLine.ModifyAll("Line Status", AdsBookingLine."Line Status"::Approved);
            end;
            exit('Confirmation is sent');
        end;
    end;
}

