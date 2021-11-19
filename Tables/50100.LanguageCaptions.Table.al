table 50100 "Language Caption"
{
    //New Table Created For Language Captions

    DataClassification = ToBeClassified;
    LookupPageId = "Language Caption";
    DrillDownPageId = "Language Caption";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Report ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Report Name"; Text[80])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report), "Object ID" = field("Report ID")));
        }
        field(4; "Caption Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Caption in Thai"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Caption in English"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}