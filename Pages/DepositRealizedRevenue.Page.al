Page 50019 "Deposit Realized Revenue"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   12.03.2007   KKE   New form for "Deposit Realized Revenue" - Subscription Module
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Buffer Subscriber Contract L/E";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            field(MagazineFilter; MagazineFilter)
            {
                ApplicationArea = Basic;
                Caption = 'Magazine Filter';
                TableRelation = "Sub Product";
            }
            repeater(Control1000000000)
            {
                Editable = false;
                field(Status; txtStatus)
                {
                    ApplicationArea = Basic;
                    Caption = 'Status';
                    Style = Attention;
                    StyleExpr = true;

                    trigger OnAssistEdit()
                    begin
                        if Status = '1' then
                            exit;

                        UpdateBuffer("Subscriber No.", xRec."Subscriber No.");
                        Reset;
                        FilterGroup(2);
                        SetRange(Show, true);
                        FilterGroup(0);
                        CurrPage.Update;
                    end;
                }
                field(CustomerNo; "Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(SubscriberNo; "Subscriber No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Subscriber.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                }
                field(SubscriberContractNo; "Subscriber Contract No.")
                {
                    ApplicationArea = Basic;
                }
                field(MagazineCode; "Magazine Code")
                {
                    ApplicationArea = Basic;
                }
                field(DepositPaid; "Deposit Paid")
                {
                    ApplicationArea = Basic;
                }
                field(ContractStatus; "Contract Status")
                {
                    ApplicationArea = Basic;
                }
                field(Block; Block)
                {
                    ApplicationArea = Basic;
                }
                field(RealizedRevenue; "Realized Revenue")
                {
                    ApplicationArea = Basic;
                }
                field(UnrealizedRevenue; "Unrealized Revenue")
                {
                    ApplicationArea = Basic;
                }
                field(ReversedAmount; "Reversed Amount")
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
            action(Show)
            {
                ApplicationArea = Basic;
                Caption = 'Show';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    InsertBufferSubscriberLine(MagazineFilter);
                    Reset;
                    FilterGroup(2);
                    SetRange(Show, true);
                    FilterGroup(0);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Status = '0' then
            txtStatus := '+'
        else
            txtStatus := '-';

        if not Subscriber.Get("Subscriber No.") then
            Clear(Subscriber);

        if Subscriber.Name = '' then
            Subscriber.Name := CopyStr(Subscriber."Name (Thai)", 1, 50);
        txtStatusOnFormat;
        CustomerNoOnFormat;
    end;

    trigger OnOpenPage()
    begin
        //InsertBufferSubscriberLine;
        FilterGroup(2);
        SetRange(Show, true);
        FilterGroup(0);
    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        DeleteAll;
    end;

    var
        Subscriber: Record Subscriber;
        txtStatus: Text[1];
        MagazineFilter: Code[20];


    procedure UpdateBuffer(NewSubscriber: Code[20]; OldSubscriber: Code[20])
    var
        BufferSubscriberLE: Record "Buffer Subscriber Contract L/E";
    begin
        BufferSubscriberLE.Reset;
        BufferSubscriberLE.SetRange("Subscriber No.", NewSubscriber);
        BufferSubscriberLE.SetRange(Status, '1');
        BufferSubscriberLE.SetRange(Show, true);
        if BufferSubscriberLE.FindFirst then begin
            BufferSubscriberLE.ModifyAll(Show, false);
            exit;
        end;
        BufferSubscriberLE.Reset;
        BufferSubscriberLE.SetRange("Subscriber No.", NewSubscriber);
        BufferSubscriberLE.ModifyAll(Show, true);
    end;

    local procedure txtStatusOnFormat()
    begin
        if Status = '0' then begin
        end
        else begin
            begin
            end;
        end;
    end;

    local procedure CustomerNoOnFormat()
    begin
        if Status <> '0' then;
    end;
}

