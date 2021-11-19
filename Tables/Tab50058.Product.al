table 50058 Product
{
    Caption = 'Product';
    DataClassification = ToBeClassified;
    LookupPageId = Products;
    fields
    {
        field(1; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Product Name"; Text[50])
        {
            Caption = 'Product Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Product Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Product Code", "Product Name")
        {

        }

    }


}
