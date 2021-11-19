Page 50021 Complaint
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // PTH : Phitsanu Thoranasoonthorn
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   02.07.2008   PTH   Complaint
    UsageCategory = Documents;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = Complaint;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ComplaintNo; "Complaint No.")
                {
                    ApplicationArea = Basic;

                    trigger OnAssistEdit()
                    begin
                        AssistEdit(Rec);
                    end;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field(SubscriberNo; "Subscriber No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        SubscriberNoOnAfterValidate;
                    end;
                }
                field(SubscriberName; "Subscriber Name")
                {
                    ApplicationArea = Basic;
                }
                field(Address1; "Address-1")
                {
                    ApplicationArea = Basic;
                }
                field(Address2; "Address-2")
                {
                    ApplicationArea = Basic;
                }
                field(Address3; "Address-3")
                {
                    ApplicationArea = Basic;
                }
                field(PhoneNo; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(CallCategory; "Call Category")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CallCategoryOnAfterValidate;
                    end;
                }
                field(Control1000000044; CallCategory)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MagazineCode; "Magazine Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        MagazineCodeOnAfterValidate;
                    end;
                }
                field(MagazineDesc; MagazineDesc)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Message1; "Message-1")
                {
                    ApplicationArea = Basic;
                }
                field(Message2; "Message-2")
                {
                    ApplicationArea = Basic;
                }
                field(Message3; "Message-3")
                {
                    ApplicationArea = Basic;
                }
                field(ComplaintTopic; "Complaint Topic")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        ComplaintTopicOnAfterValidate;
                    end;
                }
                field(Control1000000046; ComplaintTopic)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ComplaintDate; "Complaint Date")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerNo; "Customer No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CustomerNoOnAfterValidate;
                    end;
                }
                field(CustName; CustName)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MobileNo; "Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field(FaxNo; "Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field(StartTime; "Start Time")
                {
                    ApplicationArea = Basic;
                }
                field(EndTime; "End Time")
                {
                    ApplicationArea = Basic;
                }
                field(UsageTime; "Usage Time" / 60000)
                {
                    ApplicationArea = Basic;
                    Caption = 'Usage Time';
                }
            }
        }
    }

    actions
    {
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
        GenMasterSetup: Record "General Master Setup";
        Magazine: Record "Sub Product";
        Customer: Record Customer;
        CallCategory: Text[100];
        ComplaintTopic: Text[100];
        MagazineDesc: Text[100];
        CustName: Text[50];


    procedure GetCategory()
    begin
        Clear(CallCategory);

        GenMasterSetup.Reset;
        GenMasterSetup.SetCurrentkey(Type, Code);
        GenMasterSetup.SetRange(Type, GenMasterSetup.Type::"Call Category");
        GenMasterSetup.SetRange(Code, "Call Category");
        if GenMasterSetup.FindFirst then
            CallCategory := GenMasterSetup.Description;
    end;


    procedure GetTopic()
    begin
        Clear(ComplaintTopic);

        GenMasterSetup.Reset;
        GenMasterSetup.SetCurrentkey(Type, Code);
        GenMasterSetup.SetRange(Type, GenMasterSetup.Type::"Complaint Topic");
        GenMasterSetup.SetRange(Code, "Complaint Topic");
        if GenMasterSetup.FindFirst then
            ComplaintTopic := GenMasterSetup.Description;
    end;


    procedure GetMagazine()
    begin
        Clear(MagazineDesc);

        if Magazine.Get("Magazine Code") then
            MagazineDesc := Magazine.Description;
    end;


    procedure GetCustName()
    begin
        Clear(CustName);

        if Customer.Get("Customer No.") then
            CustName := Customer.Name;
    end;

    local procedure SubscriberNoOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure CallCategoryOnAfterValidate()
    begin
        GetCategory();
    end;

    local procedure MagazineCodeOnAfterValidate()
    begin
        GetMagazine();
    end;

    local procedure ComplaintTopicOnAfterValidate()
    begin
        GetTopic();
    end;

    local procedure CustomerNoOnAfterValidate()
    begin
        GetCustName();
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetCategory;
        GetTopic;
        GetMagazine;
        GetCustName;
    end;
}

