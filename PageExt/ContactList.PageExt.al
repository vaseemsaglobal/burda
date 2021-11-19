PageExtension 50074 pageextension50074 extends "Contact List"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Burda
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   20.03.2007   KKE   Add Menu button for Subscription - Burda
    */
    actions
    {


        addafter("P&erson")
        {
            group("Subscri&ption (Burda)")
            {
                Caption = 'Subscri&ption (Burda)';
                action(Subscriber)
                {
                    ApplicationArea = Basic;
                    Caption = 'Subscriber';

                    trigger OnAction()
                    var
                        Subscriber: Record Subscriber;
                    begin
                        //KKE : #001 +
                        Subscriber.Reset;
                        Subscriber.SetCurrentkey("Contact No.");
                        Subscriber.SetRange("Contact No.", "No.");
                        if not Subscriber.Find('-') then
                            Clear(Subscriber);
                        if Subscriber."No." <> '' then begin
                            Subscriber.Get(Subscriber."No.");
                            PAGE.Run(PAGE::"Subscriber Card", Subscriber);
                        end;
                        //KKE : #001 -
                    end;
                }
                action(Customer1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Customer';

                    trigger OnAction()
                    var
                        Subscriber: Record Subscriber;
                        Cust: Record Customer;
                    begin
                        //KKE : #001 +
                        Subscriber.Reset;
                        Subscriber.SetCurrentkey("Contact No.");
                        Subscriber.SetRange("Contact No.", "No.");
                        if not Subscriber.Find('-') then
                            Clear(Subscriber);
                        if Subscriber."Customer No." <> '' then begin
                            Cust.Get(Subscriber."Customer No.");
                            PAGE.Run(PAGE::"Customer Card", Cust);
                        end;
                        //KKE : #001 -
                    end;
                }
            }
        }
    }


}

