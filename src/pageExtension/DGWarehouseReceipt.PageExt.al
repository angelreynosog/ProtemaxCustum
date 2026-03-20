pageextension 80116 "DG Warehouse Receipt" extends "Warehouse Receipt"
{
    layout
    {
        addlast(General)
        {
            field("DG Document SUNAT"; Rec."DG Document SUNAT")
            {
                ApplicationArea = All;
            }
            field("DG No. Guide Recep./Origen DUA"; Rec."DG No. Guide Recep./Origen DUA")
            {
                ApplicationArea = All;
            }
        }
    }
}