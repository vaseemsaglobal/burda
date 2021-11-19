report 50015 "Update Subscriber Contract L/E"
{
    ApplicationArea = All;
    Caption = 'Update Subscriber Contract L/E';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; Integer)
        {
            trigger OnAfterGetRecord()
            var
                SubscriberContractLE: Record "Subscriber Contract L/E";
                Item: Record Item;
                MonthEndDate: date;
                MonthStartDate: date;
                SubscriberContractLENew: Record "Subscriber Contract L/E";
                SubscriberContractLE1: Record "Subscriber Contract L/E";
            begin

                ConfirmMsg := 'Please make sure new magazine item no. must exist in the item list. Do you want to replace the magazine item selected in the report %1 with new item?';
                ConfirmMsg := StrSubstNo(ConfirmMsg, FrMagazineItemNo);
                if not Confirm(ConfirmMsg) then
                    CurrReport.Skip();
                SubscriberContractLE.Reset();
                if SubscriberNo <> '' then
                    SubscriberContractLE.SetRange("Subscriber No.", SubscriberNo);
                if FrMagazineItemNo <> '' then
                    SubscriberContractLE.SetRange("Magazine Item No.", FrMagazineItemNo);
                if FrMagazineCode <> '' then
                    SubscriberContractLE.SetRange("Magazine Code", FrMagazineCode);
                if FrVolumneNo <> '' then
                    SubscriberContractLE.SetRange("Volume No.", FrVolumneNo);
                if FrIssueNo <> '' then
                    SubscriberContractLE.SetRange("Issue No.", FrIssueNo);
                if FrIssueDate <> 0D then
                    SubscriberContractLE.SetRange("Issue Date", FrIssueDate);
                if SubscriberContractNo <> '' then
                    SubscriberContractLE.SetRange("Subscriber Contract No.", SubscriberContractNo);
                SubscriberContractLE.SetRange("Sales Order Flag", false);
                SubscriberContractLE.SetRange("Delivered Flag", false);
                SubscriberContractLE.SetRange("Paid Flag", true);
                SubscriberContractLE.SetRange(Cancelled, false);
                if SubscriberContractLE.FindSet() then
                    repeat
                        if SubContractRec.get(SubscriberContractLE."Subscriber Contract No.") and (SubContractRec."Contract Status" = SubContractRec."Contract Status"::Released) then begin
                            SubscriberContractLE.Cancelled := true;
                            SubscriberContractLE."Paid Flag" := false;
                            SubscriberContractLE.Modify();

                            SubscriberContractLE1.Reset();
                            SubscriberContractLE1.SetCurrentKey("Subscriber Contract No.", "Subscriber No.", "Magazine Code", "Volume No.", "Issue No.");
                            SubscriberContractLE1.Ascending;
                            SubscriberContractLE.SetRange("Delivered Flag", false);
                            SubscriberContractLE1.SetRange("Sales Order Flag", false);
                            SubscriberContractLE1.SetRange("Subscriber Contract No.", SubscriberContractLE."Subscriber Contract No.");
                            if FrMagazineCode <> '' then
                                SubscriberContractLE1.SetRange("Magazine Code", FrMagazineCode);
                            if SubscriberContractLE1.FindLast() then begin
                                if SubContractRec.get(SubscriberContractLE1."Subscriber Contract No.") and (SubContractRec."Contract Status" = SubContractRec."Contract Status"::Released) then begin
                                    MonthStartDate := calcdate('<1M>', SubscriberContractLE1."Issue Date");
                                    MonthEndDate := CalcDate('<1M-1D>', MonthStartDate);
                                    Item.reset;
                                    Item.SetRange("Magazine Code", FrMagazineCode);
                                    Item.SetRange("Issue Date", MonthStartDate, MonthEndDate);
                                    if Item.FindFirst() then begin
                                        SubscriberContractLENew := SubscriberContractLE1;
                                        SubscriberContractLENew.validate("Magazine Item No.", Item."No.");
                                        SubscriberContractLENew."Paid Flag" := true;
                                        SubscriberContractLENew.Replaced := true;
                                        SubscriberContractLEnew.Cancelled := false;
                                        SubscriberContractLENew.Insert();
                                    end else
                                        Error('Magazine Item No. does not exists for magazine code %1,Issue Date %2 Contract No %3', SubscriberContractLE."Magazine Code", MonthStartDate, SubscriberContractLE."Subscriber Contract No.")
                                end;
                            end;
                            UpdateCount += 1;
                        end;
                    until SubscriberContractLE.Next() = 0;
                if UpdateCount <> 0 then
                    Message('%1 Subscriber Contract L/E have been updated successfully', UpdateCount)
                else
                    Message('Nothing to update');
                /*
                Commit();
                SubscriberContractLE.Reset();
                SubscriberContractLE.SetCurrentKey("Subscriber Contract No.", "Subscriber No.", "Magazine Code", "Volume No.", "Issue No.");
                SubscriberContractLE.Ascending;
                SubscriberContractLE.SetRange("Delivered Flag", false);
                SubscriberContractLE.SetRange("Sales Order Flag", false);
                //SubscriberContractLE.SetRange(Cancelled, true);
                if FrMagazineCode <> '' then
                    SubscriberContractLE.SetRange("Magazine Code", FrMagazineCode);
                if SubscriberContractLE.FindFirst() then
                    repeat
                        SubscriberContractLE.SetRange("Subscriber Contract No.", SubscriberContractLE."Subscriber Contract No.");
                        SubscriberContractLE.Ascending;
                        if SubscriberContractLE.FindLast() then begin
                            if SubContractRec.get(SubscriberContractLE."Subscriber Contract No.") and (SubContractRec."Contract Status" = SubContractRec."Contract Status"::Released) then begin
                                MonthStartDate := calcdate('<1M>', SubscriberContractLE."Issue Date");
                                MonthEndDate := CalcDate('<1M-1D>', MonthStartDate);
                                Item.reset;
                                Item.SetRange("Magazine Code", FrMagazineCode);
                                Item.SetRange("Issue Date", MonthStartDate, MonthEndDate);
                                if Item.FindFirst() then begin
                                    SubscriberContractLENew := SubscriberContractLE;
                                    SubscriberContractLENew.validate("Magazine Item No.", Item."No.");
                                    SubscriberContractLENew."Paid Flag" := true;
                                    SubscriberContractLENew.Replaced := true;
                                    SubscriberContractLENew.Insert();
                                end else
                                    Error('Magazine Item No. does not exists for magazine code %1,Issue Date %2 Contract No %3', SubscriberContractLE."Magazine Code", MonthStartDate, SubscriberContractLE."Subscriber Contract No.")
                            end;
                        end;
                        SubscriberContractLE.SetRange("Subscriber Contract No.");
                    until SubscriberContractLE.Next(2) = 0;
*/

            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange(Number, 1);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field("Subscriber No."; SubscriberNo)
                    {
                        TableRelation = Subscriber;
                        ApplicationArea = All;

                    }
                    group(From)
                    {
                        Caption = 'From';
                        field("From Magazine Item No."; FrMagazineItemNo)
                        {
                            Caption = 'Magazine Item No.';
                            TableRelation = Item WHERE("Item Type" = CONST(Magazine));
                            ApplicationArea = All;
                            trigger OnValidate()
                            var
                                Item: Record Item;
                            begin
                                if Item.get(FrMagazineItemNo) then begin
                                    FrMagazineCode := Item."Magazine Code";
                                    FrVolumneNo := item."Volume No.";
                                    FrIssueNo := Item."Issue No.";
                                    FrIssueDate := Item."Issue Date";
                                end;
                            end;
                        }
                        field("From Magazine Code"; FrMagazineCode)
                        {
                            Caption = 'Magazine Code';
                            Editable = false;
                            ApplicationArea = All;

                        }
                        field("From Volumne No."; FrVolumneNo)
                        {
                            Caption = 'Volumne No.';
                            Editable = false;
                            ApplicationArea = All;

                        }
                        field("From Issue No."; FrIssueNo)
                        {
                            Caption = 'Issue No.';
                            Editable = false;
                            ApplicationArea = All;

                        }
                        field("From Issue Date"; FrIssueDate)
                        {
                            Caption = 'Issue Date';
                            Editable = false;
                            ApplicationArea = All;

                        }
                        field("Subscriber Contract No."; SubscriberContractNo)
                        {
                            ApplicationArea = All;
                            TableRelation = "Subscriber Contract";
                        }

                    }
                    group(To)
                    {
                        Caption = 'To';
                        Visible = false;
                        field("Magazine Item No."; ToMagazineItemNo)
                        {
                            TableRelation = Item WHERE("Item Type" = CONST(Magazine));
                            ApplicationArea = All;
                            trigger OnValidate()
                            var
                                Item: Record Item;
                            begin
                                if Item.get(ToMagazineItemNo) then begin
                                    ToMagazineCode := Item."Magazine Code";
                                    ToVolumneNo := item."Volume No.";
                                    ToIssueNo := Item."Issue No.";
                                    ToIssueDate := Item."Issue Date";
                                end;
                            end;
                        }
                        field("Magazine Code"; ToMagazineCode)
                        {
                            Editable = false;
                            ApplicationArea = All;

                        }
                        field("Volumne No."; ToVolumneNo)
                        {
                            Editable = false;
                            ApplicationArea = All;

                        }
                        field("Issue No."; ToIssueNo)
                        {
                            Editable = false;
                            ApplicationArea = All;

                        }
                        field("Issue Date"; ToIssueDate)
                        {
                            Editable = false;
                            ApplicationArea = All;

                        }
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        SubscriberNo: Code[20];
        FrMagazineItemNo: Code[20];
        FrMagazineCode: Code[20];
        FrVolumneNo: Code[20];
        FrIssueNo: Code[20];
        FrIssueDate: date;
        ToMagazineItemNo: Code[20];
        ToMagazineCode: Code[20];
        ToVolumneNo: Code[20];
        ToIssueNo: Code[20];
        ToIssueDate: date;
        Canceled: Boolean;
        SubscriberContractNo: Code[20];
        SubsContractNo: Code[20];
        SubContractRec: Record "Subscriber Contract";
        ConfirmMsg: Text;
        UpdateCount: Integer;



}
