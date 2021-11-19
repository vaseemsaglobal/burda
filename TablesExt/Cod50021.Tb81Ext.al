codeunit 50021 "Tb81Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
    local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean);
    var
        UserSetup: Record "User Setup";
    begin
        //KKE : #001 +
        UserSetup.GET(USERID);
        IF UserSetup."Sales Posting Option" = UserSetup."Sales Posting Option"::" " THEN
            ERROR(Text50002, SalesHeader."Document Type");
        //KKE : #001 -

        HideDialog := true;
        if not ConfirmPost(SalesHeader, DefaultOption) then begin
            IsHandled := true;
            exit;
        end;
    end;

    local procedure ConfirmPost(var SalesHeader: Record "Sales Header"; DefaultOption: Integer): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        Selection: Integer;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if DefaultOption > 3 then
            DefaultOption := 3;
        if DefaultOption <= 0 then
            DefaultOption := 1;

        with SalesHeader do begin
            case "Document Type" of
                "Document Type"::Order:
                    begin

                        //KKE : #001 +
                        CASE UserSetup."Sales Posting Option" OF
                            UserSetup."Sales Posting Option"::Ship:
                                Selection := STRMENU(Text50000, 1);
                            UserSetup."Sales Posting Option"::Invoice:
                                Selection := STRMENU(Text50001, 2);
                            UserSetup."Sales Posting Option"::"Ship and Invoice":
                                Selection := STRMENU(ShipInvoiceQst, 3);
                        END;
                        //KKE : #001 -
                        //Selection := StrMenu(ShipInvoiceQst, DefaultOption);
                        Ship := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                        if Selection = 0 then
                            exit(false);
                    end;
                "Document Type"::"Return Order":
                    begin

                        //KKE : #001 +
                        CASE UserSetup."Sales Posting Option" OF
                            UserSetup."Sales Posting Option"::Ship:
                                Selection := STRMENU(Text50000, 1);
                            UserSetup."Sales Posting Option"::Invoice:
                                Selection := STRMENU(Text50001, 2);
                            UserSetup."Sales Posting Option"::"Ship and Invoice":
                                Selection := STRMENU(ReceiveInvoiceQst, 3);
                        END;
                        //KKE : #001 -
                        //Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit(false);
                        Receive := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end
                else begin

                        //KKE : #001 +
                        IF UserSetup."Sales Posting Option" IN
                          [UserSetup."Sales Posting Option"::" ", UserSetup."Sales Posting Option"::Ship]
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
            "Tax Document Marked" := false;
            case "Tax Document Type" of
                "Tax Document Type"::"Document Post":
                    "Tax Document Marked" := true;
                "Tax Document Type"::Prompt:
                    if Confirm(TaxDocPostConfirmQst, false) then
                        "Tax Document Marked" := true;
            end;
        end;
        exit(true);
    end;


    var
        Text50002: Label 'You do not have permission to post the %1.';
        Text50000: Label '&Ship,,';
        Text50001: Label ',&Invoice,';
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        PostConfirmQst: Label 'Do you want to post the %1?', Comment = '%1 = Document Type';
        TaxDocPostConfirmQst: Label 'Do you want to post the Tax Document?';

}
