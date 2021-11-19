Codeunit 50003 "Reverse Subscriber Promotion"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.04.2007   KKE   New codeunit for reverse subscriber promotion process.

    Permissions = TableData "Sales Header" = rim,
                  TableData "Sales Line" = rim;
    TableNo = "Subscriber Contract";

    trigger OnRun()
    begin
        if not Confirm(Text000, false, "No.") then
            exit;

        TestField("Contract Status", "contract status"::Released);
        TestField("Payment Status", "payment status"::Paid);

        ClearAll;
        SubscriberContract := Rec;
        with SubscriberContract do begin
            SubscriptionSetup.Get;
            SubscriptionSetup.TestField("Posted Credit Memo Nos.");

            Magazine.Get(SubscriberContract."Magazine Code");
            Magazine.TestField("Subscriber S/O Nos.");
            Magazine.TestField("Defer Revenue SS Account");

            Subscriber.Get("Subscriber No.");
            Subscriber.TestField("Customer No.");

            Cust.Get(Subscriber."Customer No.");
            if Cust.Blocked in [Cust.Blocked::All, Cust.Blocked::Invoice] then
                Error(Text001, Cust."No.");

            ReverseAmount := 0;
            SubscriberContractLE.Reset;
            SubscriberContractLE.SetRange("Magazine Code", "Magazine Code");
            SubscriberContractLE.SetRange("Subscriber Contract No.", "No.");
            SubscriberContractLE.SetRange("Reversed Flag", false);
            SubscriberContractLE.SetRange("Paid Flag", true);
            SubscriberContractLE.SETPERMISSIONFILTER;
            if SubscriberContractLE.Find('-') then
                repeat
                    if SubscriberContractLE."Sales Order Flag" then
                        SubscriberContractLE.TestField("Delivered Flag", true);
                    if (SubscriberContractLE."Sales Order Flag" = false) and (SubscriberContractLE."Delivered Flag" = false) then
                        ReverseAmount += SubscriberContractLE."Unit Price";
                until SubscriberContractLE.Next = 0;
            if ReverseAmount = 0 then
                Error(Text002);

            SalesCrMemoNo := InsertSalesHeader;

            SubscriberContractLE.Reset;
            SubscriberContractLE.SetRange("Magazine Code", "Magazine Code");
            SubscriberContractLE.SetRange("Subscriber Contract No.", "No.");
            SubscriberContractLE.SetRange("Reversed Flag", false);
            SubscriberContractLE.SetRange("Paid Flag", true);
            SubscriberContractLE.SETPERMISSIONFILTER;
            if SubscriberContractLE.Find('-') then
                repeat
                    if (SubscriberContractLE."Sales Order Flag" = false) and (SubscriberContractLE."Delivered Flag" = false) then begin
                        SubscriberContractLE2 := SubscriberContractLE;
                        SubscriberContractLE2."Reversed Flag" := true;
                        SubscriberContractLE2."Reversed Credit Memo No." := SalesCrMemoNo;
                        SubscriberContractLE2.Modify;
                    end;
                until SubscriberContractLE.Next = 0;

            "Contract Status" := "contract status"::Cancelled;
            Modify;
            Commit;
        end;

        Rec := SubscriberContract;

        Message(Text003, SalesHeader."No.");
    end;

    var
        Subscriber: Record Subscriber;
        SubscriberContract: Record "Subscriber Contract";
        Text000: label 'Do you want to reverse promotion for subscriber contract %1?';
        Text001: label 'Customer %1 has been blocked.';
        Text002: label 'There was nothing to reverse.';
        Text003: label 'Sales Credit Memo %1 for subscriber contract payment has been created successfully.';
        SubscriberContractLE: Record "Subscriber Contract L/E";
        SubscriberContractLE2: Record "Subscriber Contract L/E";
        SubscriptionSetup: Record "Subscription Setup";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        Magazine: Record "Sub Product";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextLineNo: Integer;
        SalesCrMemoNo: Code[20];
        ReverseAmount: Decimal;
        Text004: label 'You must select the no. series code.';

    local procedure InsertSalesHeader(): Code[20]
    begin
        with SalesHeader do begin
            Init;
            "Document Type" := "document type"::"Credit Memo";
            "No." := '';
            //  "No." := NoSeriesMgt.GetNextNo(Magazine."Sales Order Nos.",WORKDATE,TRUE);
            SalesSetup.Get;
            SalesSetup.TestField("Credit Memo Nos.");
            if NoSeriesMgt.SelectSeries(SalesSetup."Credit Memo Nos.", '', "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Insert(true);
            end else
                Error(Text004);
            Validate("Sell-to Customer No.", Cust."No.");
            Validate("Order Date", SubscriberContract."Subscription Date");
            Validate("Posting Date", SubscriberContract."Subscription Date");
            //  VALIDATE("Payment Method Code",SubscriberContract."Payment Method Code");
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            Validate("Posting No. Series", SubscriptionSetup."Posted Credit Memo Nos.");
            Modify;

            NextLineNo := 10000;
            InsertSalesLine(
              SalesHeader,
              'Reverse Promotion ' + SubscriberContract."No.",
              ReverseAmount);
            exit("No.");
        end;
    end;


    procedure InsertSalesLine(l_SalesHeader: Record "Sales Header"; Desc: Text[50]; UnitPrice: Decimal)
    begin
        with SalesLine do begin
            SetRange("Document Type", l_SalesHeader."Document Type");
            SetRange("Document No.", l_SalesHeader."No.");
            "Document Type" := l_SalesHeader."Document Type";
            "Document No." := l_SalesHeader."No.";

            "Line No." := NextLineNo;
            Validate(Type, Type::"G/L Account");
            Validate("No.", Magazine."Defer Revenue SS Account");
            Description := Desc;
            Validate(Quantity, 1);
            Validate("Unit Price", UnitPrice);
            Validate("Subscriber Contract No.", SubscriberContract."No.");
            Insert(true);
        end;
    end;
}

