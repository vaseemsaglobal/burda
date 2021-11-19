TableExtension 50013 tableextension50013 extends "Purchase Header"
{
    fields
    {

        field(50000; "Cal. WHT for any Inv. Amount"; Boolean)
        {
        }
        field(50001; "Buy-from Name (Thai)"; Text[120])
        {
            Caption = 'Buy-from Name (Thai)';

            trigger OnLookup()
            var
                Vend: Record Vendor;
            begin
                if Vend.get("Buy-from Vendor No.") then;//SAG
                //KKE : #001 +
                if PAGE.RunModal(PAGE::"Vendor List", Vend) = Action::LookupOK then begin
                    if Vend."Name (Thai)" <> '' then
                        "Buy-from Name (Thai)" := Vend."Name (Thai)"
                    else
                        "Buy-from Name (Thai)" := Vend.Name;

                    if Vend."Address (Thai)" <> '' then
                        "Buy-from Address (Thai)" := Vend."Address (Thai)"
                    else
                        "Buy-from Address (Thai)" := Vend.Address;
                end;

                if "Pay-to Name (Thai)" = '' then
                    "Pay-to Name (Thai)" := "Buy-from Name (Thai)";

                if "Pay-to Address (Thai)" = '' then
                    "Pay-to Address (Thai)" := "Buy-from Address (Thai)";
                //KKE : #001 -
            end;

            trigger OnValidate()
            begin
                //KKE : #001 +
                if "Pay-to Address (Thai)" = '' then
                    "Pay-to Address (Thai)" := "Buy-from Address (Thai)";
                //KKE : #001 -
            end;
        }
        field(50002; "Buy-from Address (Thai)"; Text[200])
        {
            Caption = 'Buy-from Address (Thai)';

            trigger OnValidate()
            begin
                //KKE : #001 +
                if "Pay-to Address (Thai)" = '' then
                    "Pay-to Address (Thai)" := "Buy-from Address (Thai)";
                //KKE : #001 -
            end;
        }
        field(50003; "Buy-from Address 3"; Text[150])
        {
            Caption = 'Buy-from Address 3';
        }
        field(50004; "Pay-to Name (Thai)"; Text[120])
        {
            Caption = 'Pay-to Name (Thai)';

            trigger OnLookup()
            var
                Vend: Record Vendor;
            begin
                //KKE : #001 +
                if vend.get("Pay-to Vendor No.") then; //SAG
                if PAGE.RunModal(PAGE::"Vendor List", Vend) = Action::LookupOK then begin
                    if Vend."Name (Thai)" <> '' then
                        "Pay-to Name (Thai)" := Vend."Name (Thai)"
                    else
                        "Pay-to Name (Thai)" := Vend.Name;

                    if Vend."Address (Thai)" <> '' then
                        "Pay-to Address (Thai)" := Vend."Address (Thai)"
                    else
                        "Pay-to Address (Thai)" := Vend.Address;
                end;
                //KKE : #001 -
            end;
        }
        field(50005; "Pay-to Address (Thai)"; Text[200])
        {
            Caption = 'Pay-to Address (Thai)';
        }
        field(50006; "Pay-to Address 3"; Text[150])
        {
            Caption = 'Pay-to Address 3';
        }
        field(50007; "Ship-to Name (Thai)"; Text[120])
        {
            Caption = 'Ship-to Name (Thai)';
        }
        field(50008; "Ship-to Address (Thai)"; Text[200])
        {
            Caption = 'Ship-to Address (Thai)';
        }
        field(50009; "Ship-to Address 3"; Text[150])
        {
            Caption = 'Ship-to Address 3';
        }
        field(50011; "Dummy Vendor"; Boolean)
        {
        }
        field(50012; "Invoice Description"; Text[100])
        {
            Caption = 'Invoice Description';
        }
        field(50020; "PO Type"; Code[20])
        {
            Editable = false;
            TableRelation = "PO Type";
        }
    }


}

