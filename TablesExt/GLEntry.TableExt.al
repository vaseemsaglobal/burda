TableExtension 50004 tableextension50004 extends "G/L Entry"
{
    fields
    {
        field(50000; "Create Date"; Date)
        {
        }
        field(50001; "Description 2"; Text[250])
        {
            Caption = 'Comment';
        }
        field(50002; "Deal No."; Code[20])
        {
            TableRelation = "Ads. Booking Header";
        }
        field(50003; "Sub Deal No."; Text[20])
        {

        }
        field(50004; "Publication Month"; Text[10])
        {

        }
        field(50005; Brand; Code[20])
        {

        }
        field(50006; "Salesperson Code"; Code[20])
        {

        }
        field(50007; "Ads Sales Document Type"; Option)
        {
            OptionMembers = ,Revenue,Deferred,Accrued,"JV(Accrued)","JV(Deferred)","JV(Revenue)";
        }
        field(50008; "Ads Sale Entry Type"; Option)
        {
            OptionMembers = ,"Revenue Recognized","Deferred Revenue",Accrued;
        }
        field(50009; "Source Name"; Text[50])
        {

        }
        field(50010; "Product Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sub Product"."Product Code" where("Sub Product Code" = field("Global Dimension 1 Code")));
        }
    }

}

