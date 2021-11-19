Codeunit 50000 "Create Subscriber Payment"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New codeunit for create subscriber payment process.
    // 002   05.10.2007   KKE   Split sales invoice for credit charge fee.

    Permissions = TableData "Sales Header" = rim,
                  TableData "Sales Line" = rim;
    TableNo = "Subscriber Contract";

    trigger OnRun()
    begin
        if not Confirm(Text000, false, "No.") then
            exit;

        TestField("Contract Status", "contract status"::Released);
        TestField("Payment Status", "payment status"::Open);

        ClearAll;
        SubscriberContract := Rec;
        with SubscriberContract do begin
            TestField("Payment Method Code");
            if "Credit Card Charge Fee" <> 0 then
                TestField("Payment Method (Charge Fee)");

            SubscriptionSetup.Get;
            SubscriptionSetup.TestField("Posted Invoice Nos.");

            Magazine.Get("Magazine Code");
            Magazine.TestField("Subscriber S/O Nos.");
            Magazine.TestField("Defer Revenue SS Account");

            Subscriber.Get("Subscriber No.");
            Subscriber.TestField("Customer No.");

            Cust.Get(Subscriber."Customer No.");
            if Cust.Blocked in [Cust.Blocked::All, Cust.Blocked::Invoice] then
                Error(Text001, Cust."No.");

            SalesOrderNo := InsertSalesHeader;

            //KKE : #002
            if "Credit Card Charge Fee" <> 0 then
                InsertSalesHdrCreditChargeFee;

            SubscriberContractLE.Reset;
            SubscriberContractLE.SetRange("Magazine Code", "Magazine Code");
            SubscriberContractLE.SetRange("Subscriber Contract No.", "No.");
            SubscriberContractLE.SETPERMISSIONFILTER;
            if SubscriberContractLE.Find('-') then begin
                SubscriberContractLE.ModifyAll("Paid Flag", true);
                SubscriberContractLE.ModifyAll("Paid Sales Order No.", SalesOrderNo);
            end;

            "Payment Status" := "payment status"::Paid;
            Modify;
            Commit;
        end;

        Rec := SubscriberContract;

        Message(Text003, SalesHeader."No.");
    end;

    var
        Subscriber: Record Subscriber;
        SubscriberContract: Record "Subscriber Contract";
        Text000: label 'Do you want to create subscriber payment for %1?';
        Text001: label 'Customer %1 has been blocked.';
        Text003: label 'Sales Order %1 for subscriber contract payment has been created successfully.';
        SubscriberContractLE: Record "Subscriber Contract L/E";
        SubscriptionSetup: Record "Subscription Setup";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Cust: Record Customer;
        Magazine: Record "Sub Product";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextLineNo: Integer;
        SalesOrderNo: Code[20];

    local procedure InsertSalesHeader(): Code[20]
    begin
        with SalesHeader do begin
            Init;
            "Document Type" := "document type"::Order;
            "No." := NoSeriesMgt.GetNextNo(Magazine."Subscriber S/O Nos.", WorkDate, true);
            Insert(true);
            Validate("Sell-to Customer No.", Cust."No.");
            Validate("Order Date", SubscriberContract."Subscription Date");
            Validate("Posting Date", SubscriberContract."Subscription Date");
            Validate("Payment Method Code", SubscriberContract."Payment Method Code");
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            Validate("Posting No. Series", SubscriptionSetup."Posted Invoice Nos.");
            Modify;

            NextLineNo := 0;
            //Case: Cash Payment
            if SubscriberContract."Receipt Amount" <> 0 then begin
                NextLineNo += 10000;
                InsertSalesLine(
                  SalesHeader,
                  'Cash Payment : Receipt No. ' + SubscriberContract."Receipt No.",
                  SubscriberContract."Receipt Amount");
            end;
            //Case: Credit Card Payment
            if SubscriberContract."Credit Card Bank Amount" <> 0 then begin
                NextLineNo += 10000;
                InsertSalesLine(
                  SalesHeader,
                  'Credit Card Payment : Bank ' + SubscriberContract."Credit Card Bank",
                  SubscriberContract."Credit Card Bank Amount");
                /*--- split sales order
                IF SubscriberContract."Credit Card Charge Fee" <> 0 THEN BEGIN
                  NextLineNo += 10000;
                  InsertSalesLine(
                    SalesHeader,
                    'Credit Card Payment : Charge Fee',
                    SubscriberContract."Credit Card Charge Fee");
                END;
                ---*/
            end;
            //Case: Check Payment
            if SubscriberContract."Check Amount" <> 0 then begin
                NextLineNo += 10000;
                InsertSalesLine(
                  SalesHeader,
                  'Check Payment : Check No. ' + SubscriberContract."Check No.",
                  SubscriberContract."Check Amount");
            end;
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

    local procedure InsertSalesHdrCreditChargeFee()
    begin
        //KKE : #002
        with SalesHeader do begin
            Init;
            "Document Type" := "document type"::Order;
            "No." := NoSeriesMgt.GetNextNo(Magazine."Subscriber S/O Nos.", WorkDate, true);
            Insert(true);
            Validate("Sell-to Customer No.", Cust."No.");
            Validate("Order Date", SubscriberContract."Subscription Date");
            Validate("Posting Date", SubscriberContract."Subscription Date");
            Validate("Payment Method Code", SubscriberContract."Payment Method (Charge Fee)");
            Validate("Shortcut Dimension 1 Code", Magazine."Dimension 1 Code");
            Validate("Posting No. Series", SubscriptionSetup."Posted Invoice Nos.");
            Modify;

            NextLineNo := 0;
            //Case: Credit Card Payment
            if SubscriberContract."Credit Card Charge Fee" <> 0 then begin
                NextLineNo += 10000;
                InsertSalesLine(
                  SalesHeader,
                  'Credit Card Payment : Charge Fee',
                  SubscriberContract."Credit Card Charge Fee");
            end;
        end;
    end;
}

