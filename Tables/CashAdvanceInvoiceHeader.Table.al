Table 55054 "Cash Advance Invoice Header"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Localization TH
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.08.2006   KKE   Cash Advance.

    Caption = 'Cash Advance Invoice Header';
    DrillDownPageID = "Posted Cash Advance Invoices";
    LookupPageID = "Posted Cash Advance Invoices";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Cash Advance Vendor No."; Code[20])
        {
            Caption = 'Cash Advance Vendor No.';
            TableRelation = Vendor where("Cash Advance" = const(true));
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(8; "Balance Amount Settle"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cash Advance Invoice Line"."Balance Amount Settle" where("Document No." = field("No.")));
            Caption = 'Balance Amount Settle';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Invoice Description"; Text[50])
        {
            Caption = 'Invoice Description';
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(21; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(22; "WHT Business Posting Group"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            TableRelation = "WHT Business Posting Group";
        }
        field(25; "Printing WHT Slip (Doc:WHT)"; Option)
        {
            Caption = 'Printing WHT Slip (Doc:WHT)';
            OptionMembers = "1:1","1:N";
        }
        field(30; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(31; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(32; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(33; "Address 3"; Text[30])
        {
            Caption = 'Address 3';
        }
        field(34; "Name (Thai)"; Text[120])
        {
            Caption = 'Name (Thai)';
        }
        field(35; "Address (Thai)"; Text[200])
        {
            Caption = 'Address (Thai)';
        }
        field(36; City; Text[30])
        {
            Caption = 'City';
        }
        field(37; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(38; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(39; County; Text[30])
        {
            Caption = 'County';
        }
        field(40; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = exist("Cash Advance Comment Line" where("Document Type" = const("Posted Invoice"),
                                                                   "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
            //LoginMgt: Codeunit "Login Management";
            begin
            end;
        }
        field(48; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(50; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(51; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
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
        //DimMgt.DeletePostedDocDim(Database::"Cash Advance Invoice Header", "No.", 0);

        CashAdvInvLine.LockTable;
        CashAdvInvLine.SetRange("Document No.", "No.");
        CashAdvInvLine.DeleteAll;

        CashAdvCmtLine.SetRange("Document Type", CashAdvCmtLine."document type"::"Posted Invoice");
        CashAdvCmtLine.SetRange("No.", "No.");
        CashAdvCmtLine.DeleteAll;

        //PostCodeCheck.DeleteAllAddressID(Database::"Cash Advance Invoice Header", Rec.GetPosition);//SAG
        DeleteAllAddressID(Database::"Cash Advance Invoice Header", Rec.GetPosition);//SAG
    end;

    var
        CashAdvInvLine: Record "Cash Advance Invoice Line";
        CashAdvCmtLine: Record "Cash Advance Comment Line";
        DimMgt: Codeunit DimensionManagement;
        PostCodeCheck: Codeunit "Post Code Check";


    /*procedure ShowDocDim()
    var
        DocDim: Record "Document Dimension";
        DocDims: Page UnknownPage546;
    begin
        DocDim.SetRange("Table ID", Database::"Cash Advance Invoice Header");
        DocDim.SetRange("Document Type", DocDim."document type"::Invoice);
        DocDim.SetRange("Document No.", "No.");
        DocDim.SetRange("Line No.", 0);
        DocDims.SetTableview(DocDim);
        DocDims.RunModal;
        Get("No.");
    end;*/
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeShowDocDim(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //OnShowDocDimOnBeforeUpdateSalesLines(Rec, xRec);
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            //if SalesLinesExist then
            // UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;


    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "No.");
        NavigateForm.Run;
    end;
    //>>SAG
    procedure DeleteAllAddressID(TableNo: Integer; TableKey: Text[1024])
    var
        AddressID: Record "Address ID";
    begin
        AddressID.SetRange("Table No.", TableNo);
        AddressID.SetRange("Table Key", TableKey);
        AddressID.DeleteAll();
    end;
    //<<SAG
    procedure ShowDimensions()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption, "No."));
    end;




}

