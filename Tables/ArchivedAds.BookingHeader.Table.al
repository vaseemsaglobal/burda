Table 50039 "Archived Ads. Booking Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   New table for "Archived Ads. Booking Header" - Ads. Sales Module

    LookupPageID = "Archived Ads. Booking List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Booking Date"; Date)
        {
        }
        field(3; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(4; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
        }
        field(5; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            var
            //TempDocDim: Record "Document Dimension" temporary;
            begin
            end;
        }
        field(6; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(7; "Sell-to Customer Type"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Customer Type"));
        }
        field(8; "Bill-to Customer Type"; Code[10])
        {
            TableRelation = "General Master Setup".Code where(Type = const("Customer Type"));
        }
        field(9; "Zone Area"; Code[20])
        {
            TableRelation = "Zone Area";
        }
        field(10; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(11; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(12; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(13; "Mobile No."; Text[30])
        {
        }
        field(14; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(15; Remark; Text[50])
        {
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ArchivedAdsBookingLine.Reset;
        ArchivedAdsBookingLine.SetRange("Booking No.", "No.");
        ArchivedAdsBookingLine.SETPERMISSIONFILTER;
        ArchivedAdsBookingLine.DeleteAll;
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';
        ArchivedAdsBookingLine: Record "Archived Ads. Booking Line";
}

