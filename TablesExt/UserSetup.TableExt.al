TableExtension 50020 tableextension50020 extends "User Setup"
{
    Caption = 'User Setup';
    fields
    {



        field(50000; "Allow Confirm Ads. Booking"; Boolean)
        {
        }
        field(50001; "Allow Cancel Ads. Booking"; Boolean)
        {
        }
        field(50002; "Allow Approve Ads. Booking"; Boolean)
        {
            Description = 'Burda1.00';
        }
        field(50003; "Allow Hold Ads. Booking"; Boolean)
        {
            Description = 'Burda1.00';
        }
        field(50004; "Allow Close Ads. Booking"; Boolean)
        {
            Description = 'Burda1.00';
        }
        field(50005; "Ads. Booking Filter"; Option)
        {
            Description = 'Burda1.00';
            OptionMembers = " ",Salesperson,Team,All;
        }
        field(50006; "Salesperson Code"; Code[10])
        {
            Description = 'Burda1.00';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50007; "Allow Create Ads. Invoice"; Boolean)
        {
            Description = 'Burda1.00';
        }
        field(50008; "Sales Posting Option"; Option)
        {
            Description = 'Burda1.00';
            OptionMembers = " ",Ship,Invoice,"Ship and Invoice";
        }
        field(50009; "Magazine Filter"; Text[100])
        {
            Description = 'Burda1.00 use to filter data on Item table';
        }
        field(50010; "Allow Change Issue Date"; Boolean)
        {
            Description = 'Burda1.00';
        }
        field(50011; "Purchase Posting Option"; Option)
        {
            Description = 'Burda1.00';
            OptionMembers = " ",Receive,Invoice,"Receive and Invoice";
        }
        field(50012; "Allow Unblock Bank Cheque"; Boolean)
        {
            Description = 'Burda1.00 New';
        }
        field(50098; "Allow Post Petty Cash Invoice"; Boolean)
        {
            Caption = 'Allow Post Petty Cash Invoice';
        }
        field(50099; "Allow Post Cash Adv. Invoice"; Boolean)
        {
            Caption = 'Allow Post Cash Adv. Invoice';
        }
        field(50015; "Manual Approval"; Boolean)
        {

        }
    }


}

