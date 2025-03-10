pageextension 80106 "DG Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Due Date")
        {
            field("DG No. Guide Recep./Origen DUA"; Rec."DG No. Guide Recep./Origen DUA")
            {
                ApplicationArea = All;
            }
        }
    }
}