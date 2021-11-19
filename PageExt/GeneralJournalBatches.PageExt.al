PageExtension 50052 pageextension50052 extends "General Journal Batches"
{
    /*
          Microsoft Business Solutions Navision
      ----------------------------------------
      Project: Localization Demo TH
      KKE : Kanoknard Ketnut

      No.   Date         Sign  Description
      ----------------------------------------
      001   08.08.2006   KKE   -Modify program to be able to manual input WHT Certificate No.
      */
    layout
    {
        addafter("Allow VAT Difference")
        {
            field("Allow Manual WHT Cert. No."; "Allow Manual WHT Cert. No.")
            {
                ApplicationArea = Basic;
                Visible = AllowManualWHTCertNoVisible;
            }
        }
    }


    var
        GenJnlTemplate: Record "Gen. Journal Template";
        [InDataSet]
        AllowManualWHTCertNoVisible: Boolean;

    trigger OnOpenPage()

    begin

        //GenJnlManagement.OpenJnlBatch(Rec);
        //KKE : #001 +
        IF GenJnlTemplate.GET("Journal Template Name") THEN
            AllowManualWHTCertNoVisible :=
              GenJnlTemplate.Type IN [GenJnlTemplate.Type::Payments, GenJnlTemplate.Type::"Petty Cash"]
        ELSE
            AllowManualWHTCertNoVisible := FALSE;
        //KKE : #001 -

    end;


}

