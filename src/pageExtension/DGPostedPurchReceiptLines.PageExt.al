pageextension 80124 "DG Posted Purch. Receipt Lines" extends "Posted Purchase Receipt Lines"
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