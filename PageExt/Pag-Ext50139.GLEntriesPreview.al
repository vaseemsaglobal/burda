pageextension 50139 GLEntriesPreview extends "G/L Entries Preview"
{
    layout
    {
        addafter(Description)
        {
            field("Document Date"; "Document Date")
            {
                ApplicationArea = Basic;
            }
        }
    }
}
