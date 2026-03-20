pageextension 80111 "DG Posted Purchase Receipts" extends "Posted Purchase Receipts"
{
    layout
    {
        addlast(Control1)
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