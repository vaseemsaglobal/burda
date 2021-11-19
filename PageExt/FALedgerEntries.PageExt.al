PageExtension 50080 pageextension50080 extends "FA Ledger Entries"
{
    /*
          Burda
      001  11.07.2007  KKE  -Hide function "Reverse Transaction"
    */
    actions
    {
        modify(ReverseTransaction)
        {
            Visible = false;
        }
    }
}

