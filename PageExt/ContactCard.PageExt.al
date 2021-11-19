PageExtension 50073 pageextension50073 extends "Contact Card"
{
    layout
    {
        addafter("Address 2")
        {
            field("Address 3"; "Address 3")
            {
                ApplicationArea = Basic;
            }
        }
        addafter(County)
        {
            field("Name (Thai)"; "Name (Thai)")
            {
                ApplicationArea = Basic;
            }
            field("Address (Thai)"; "Address (Thai)")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Next Task Date")
        {
            field("Subscriber.""No."""; Subscriber."No.")
            {
                ApplicationArea = Basic;
                Caption = 'Subscriber No.';
                Editable = false;
            }
            field("Subscriber.""Customer No."""; Subscriber."Customer No.")
            {
                ApplicationArea = Basic;
                Caption = 'Customer No.';
                Editable = false;
            }
        }
    }


    var
        Subscriber: Record Subscriber;

    trigger OnAfterGetCurrRecord()
    begin
        //KKE : #002 +
        Subscriber.RESET;
        Subscriber.SETCURRENTKEY("Contact No.");
        Subscriber.SETRANGE("Contact No.", "No.");
        IF NOT Subscriber.FIND('-') THEN
            CLEAR(Subscriber);
        //KKE : #002 -
    end;
}

