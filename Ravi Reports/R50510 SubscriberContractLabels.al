report 50510 "SM - Labels Printing"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SubscriberContractLabelsV2.rdl';
    Caption = 'SM - Labels Printing';
    dataset
    {
        dataitem("Subscriber Contract L/E"; "Subscriber Contract L/E")
        {
            DataItemTableView = SORTING("Subscriber Contract No.", "Subscriber No.", "Magazine Code", "Volume No.", "Issue No.");
            RequestFilterFields = "Magazine Item No.", "Subscriber No.", "Subscriber Contract No.";
            dataitem("Subscriber Contract"; "Subscriber Contract")
            {
                DataItemTableView = SORTING("Contract Category", "No.") ORDER(Ascending);
                DataItemLink = "No." = FIELD("Subscriber Contract No.");
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                    RecordNo := RecordNo + 1;
                    ColumnNo := ColumnNo + 1;


                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    Clear(Subscri);
                    //  i := 0;
                    CurrReport.SHOWOUTPUT(FALSE);
                    i += 1;
                    IF i > 2 THEN
                        i := 1;
                    IF NOT Subscri.GET("Subscriber No.") THEN
                        CurrReport.SKIP;
                    IF i = 1 THEN BEGIN
                        SubscriberTemp1 := Subscri;
                        IF SubscriberTemp1.INSERT THEN;
                    END ELSE BEGIN
                        SubscriberTemp2 := Subscri;
                        IF SubscriberTemp2.INSERT THEN;
                    END;
                end;

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                NoOfRecords := COUNT;
                NoOfColumns := 2;
                i := 0;
                Counter := 0;
            end;


        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
            column(Number; GroupNo)
            {
            }
            column(Addr1; Addr[1] [1])
            {
            }
            column(Addr2; Addr[1] [2])
            {
            }
            column(Addr3; Addr[1] [3])
            {
            }
            column(Addr4; Addr[1] [4])
            {
            }

            column(Addr21; Addr[2] [1])
            {
            }
            column(Addr22; Addr[2] [2])
            {
            }
            column(Addr23; Addr[2] [3])
            {
            }
            column(Addr24; Addr[2] [4])
            {
            }
            column(SubNo1; SubNo[1])
            {
            }
            column(SubNo2; SubNo[2])
            {
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                IF Number = 1 THEN BEGIN
                    IF SubscriberTemp1.FIND('-') THEN;
                    IF SubscriberTemp2.FIND('-') THEN;
                END ELSE BEGIN
                    IF (SubscriberTemp1.NEXT = 0) AND (SubscriberTemp2.NEXT = 0) THEN
                        CurrReport.BREAK;
                END;

                if Counter = 8 then begin
                    GroupNo := GroupNo + 1;
                    Counter := 0;
                end;
                Counter += 1;

                SubNo[1] := SubscriberTemp1."No.";
                Addr[1] [1] := SubscriberTemp1."Salutation Code" + ' ' + SubscriberTemp1.Name;
                Addr[1] [2] := FORMAT(SubscriberTemp1."Address 1");
                Addr[1] [3] := FORMAT(SubscriberTemp1."Address 2");
                Addr[1] [4] := FORMAT(SubscriberTemp1."Address 3");


                SubNo[2] := SubscriberTemp2."No.";
                Addr[2] [1] := SubscriberTemp2."Salutation Code" + ' ' + SubscriberTemp2.Name;
                Addr[2] [2] := FORMAT(SubscriberTemp2."Address 1");
                Addr[2] [3] := FORMAT(SubscriberTemp2."Address 2");
                Addr[2] [4] := FORMAT(SubscriberTemp2."Address 3");


                IF Number > SubscriberTemp2.COUNT THEN BEGIN
                    CLEAR(Addr[2]);
                    SubNo[2] := '';
                END;

            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

                IF SubscriberTemp1.COUNT > SubscriberTemp2.COUNT THEN
                    SETRANGE(Number, 1, SubscriberTemp1.COUNT)
                ELSE
                    SETRANGE(Number, 1, SubscriberTemp2.COUNT);

            end;
        }

    }
    trigger OnPreReport()
    var
        myInt: Integer;
    BEGIN
        GroupNo := 1;
        RecPerPageNum := 8;

    end;

    var

        Addr: array[2, 4] of Text[250];
        RecPerPageNum: Integer;
        SubNo: array[2] of Code[20];
        NoOfRecords: Integer;
        RecordNo: Integer;
        Counter: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        GroupNo: Integer;
        Subscri: Record Subscriber;
        SubscriberTemp1: Record Subscriber temporary;
        SubscriberTemp2: Record Subscriber temporary;//
        SubscriContract: Record "Subscriber Contract";
}