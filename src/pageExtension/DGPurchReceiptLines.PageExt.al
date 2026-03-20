pageextension 80125 "DG Purch. Receipt Lines" extends "Purch. Receipt Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("DG No. Guide Recep./Origen DUA"; Rec."DG No. Guide Recep./Origen DUA")
            {
                ApplicationArea = All;
            }
            field("DG Document SUNAT"; Rec."DG Document SUNAT")
            {
                ApplicationArea = All;
            }
        }
    }
}