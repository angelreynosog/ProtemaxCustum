pageextension 80121 "DG General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("DG No. Guide Recep./Origen DUA"; Rec."DG No. Guide Recep./Origen DUA")
            {
                ApplicationArea = All;
            }
        }
    }
}