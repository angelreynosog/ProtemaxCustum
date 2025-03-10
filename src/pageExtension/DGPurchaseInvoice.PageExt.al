pageextension 80108 "DG Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("DG Request No."; Rec."DG Request No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Due Date")
        {
            field("DG No. Guide Recep./Origen DUA"; Rec."DG No. Guide Recep./Origen DUA")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}