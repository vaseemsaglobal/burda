Page 50006 "Subscriber Duplicate Check"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   06.03.2007   KKE   New Form for Subscriber List.

    PageType = Card;
    SourceTable = Subscriber;

    layout
    {
        area(content)
        {
            group("Filter")
            {
                Caption = 'Filter';
                field(NoFilter; NoFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    LookupPageID = "Subscriber List";
                    TableRelation = Subscriber;

                    trigger OnValidate()
                    begin
                        NoFilterOnAfterValidate;
                    end;
                }
                field(FirstNameFilter; FirstNameFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';

                    trigger OnValidate()
                    begin
                        FirstNameFilterOnAfterValidate;
                    end;
                }
                field(MiddleNameFilter; MiddleNameFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        MiddleNameFilterOnAfterValidat;
                    end;
                }
                field(LastNameFilter; LastNameFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';

                    trigger OnValidate()
                    begin
                        LastNameFilterOnAfterValidate;
                    end;
                }
                field(DateOfBirth; DateOfBirth)
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth (ñ.˜.) dd/mm/yyyy';
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        SetFilter("Date of Birth", DateOfBirth);
                        DateOfBirthOnAfterValidate;
                    end;
                }
                field(PhoneNo; PhoneNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Phone No.';

                    trigger OnValidate()
                    begin
                        PhoneNoOnAfterValidate;
                    end;
                }
                field(MobileNo; MobileNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';

                    trigger OnValidate()
                    begin
                        MobileNoOnAfterValidate;
                    end;
                }
            }
            repeater(Control1000000000)
            {
                Editable = false;
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(FirstName; "First Name")
                {
                    ApplicationArea = Basic;
                }
                field(MiddleName; "Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field(LastName; "Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth1; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000021; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000023; "Mobile No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        NoFilter: Text[250];
        FirstNameFilter: Text[250];
        MiddleNameFilter: Text[250];
        LastNameFilter: Text[250];
        DateOfBirth: Text[250];
        PhoneNo: Text[250];
        MobileNo: Text[250];

    local procedure NoFilterOnAfterValidate()
    begin
        SetFilter("No.", NoFilter);
        CurrPage.Update(false);
    end;

    local procedure FirstNameFilterOnAfterValidate()
    begin
        SetFilter("First Name", FirstNameFilter);
        CurrPage.Update;
    end;

    local procedure MiddleNameFilterOnAfterValidat()
    begin
        SetFilter("Middle Name", MiddleNameFilter);
        CurrPage.Update;
    end;

    local procedure LastNameFilterOnAfterValidate()
    begin
        SetFilter("Last Name", LastNameFilter);
        CurrPage.Update;
    end;

    local procedure DateOfBirthOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure PhoneNoOnAfterValidate()
    begin
        SetFilter("Phone No.", PhoneNo);
        CurrPage.Update;
    end;

    local procedure MobileNoOnAfterValidate()
    begin
        SetFilter("Mobile No.", MobileNo);
        CurrPage.Update;
    end;
}

