report 50014 "Get Cash Advance"
{
    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    procedure GetGenJnlLine2(var NewGenLine: record "Gen. Journal Line")
    var
        myInt: Integer;
    begin

    end;
}
