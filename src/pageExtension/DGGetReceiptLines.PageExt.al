pageextension 80114 "DG Get Receipt Lines" extends "Get Receipt Lines"
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