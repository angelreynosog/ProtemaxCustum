pageextension 80116 "DG Warehouse Receipt" extends "Warehouse Receipt"
{
    layout
    {
        addlast(General)
        {
            field("DG No. Guide Recep./Origen DUA"; Rec."DG No. Guide Recep./Origen DUA")
            {
                ApplicationArea = All;
            }
        }
    }
}