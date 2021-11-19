codeunit 50020 CU91Ext
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer);
    var
        UserSetup: Record "User Setup";
        Text50002: Label 'You do not have permission to post the %1.';
    begin
        //KKE : #001 +
        UserSetup.GET(USERID);
        IF UserSetup."Purchase Posting Option" = UserSetup."Purchase Posting Option"::" " THEN
            ERROR(Text50002, PurchaseHeader."Document Type");
        //KKE : #001 -
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost_1(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer);
    begin
        HideDialog := true;
        if not ConfirmPost(PurchaseHeader, DefaultOption) then begin
            IsHandled := true;
            exit;
        end;
    end;

    local procedure ConfirmPost(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        Selection: Integer;
        UserSetup: Record "User Setup";
        Text50000: Label '&Receive,,';
        Text50001: Label ',&Invoice,';
        Text50002: Label 'You do not have permission to post the %1.';
    begin
        UserSetup.Get(UserId);
        if DefaultOption > 3 then
            DefaultOption := 3;
        if DefaultOption <= 0 then
            DefaultOption := 1;

        with PurchaseHeader do begin
            case "Document Type" of
                "Document Type"::Order:
                    begin

                        //KKE : #001 +
                        CASE UserSetup."Purchase Posting Option" OF
                            UserSetup."Purchase Posting Option"::Receive:
                                Selection := STRMENU(Text50000, 1);
                            UserSetup."Purchase Posting Option"::Invoice:
                                Selection := STRMENU(Text50001, 2);
                            UserSetup."Purchase Posting Option"::"Receive and Invoice":
                                Selection := STRMENU(ReceiveInvoiceQst, 3);
                        END;
                        //KKE : #001 -
                        //Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit(false);
                        Receive := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end;
                "Document Type"::"Return Order":
                    begin
                        //KKE : #001 +
                        CASE UserSetup."Purchase Posting Option" OF
                            UserSetup."Purchase Posting Option"::Receive:
                                Selection := STRMENU(Text50000, 1);
                            UserSetup."Purchase Posting Option"::Invoice:
                                Selection := STRMENU(Text50001, 2);
                            UserSetup."Purchase Posting Option"::"Receive and Invoice":
                                Selection := STRMENU(ShipInvoiceQst, 3);
                        END;
                        //KKE : #001 -
                        //Selection := StrMenu(ShipInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit(false);
                        Ship := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end
                else begin
                        //KKE : #001 +
                        IF UserSetup."Purchase Posting Option" IN
                          [UserSetup."Purchase Posting Option"::" ", UserSetup."Purchase Posting Option"::Receive]
                        THEN
                            ERROR(Text50002, "Document Type");
                        //KKE : #001 -
                        if not ConfirmManagement.GetResponseOrDefault(
                             StrSubstNo(PostConfirmQst, LowerCase(Format("Document Type"))), true)
                        then
                            exit(false);
                    end;
            end;
            "Print Posted Documents" := false;
            "Posted Tax Document" := true;
        end;
        exit(true);
    end;

    var
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        PostConfirmQst: Label 'Do you want to post the %1?', Comment = '%1 = Document Type';
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';

}
