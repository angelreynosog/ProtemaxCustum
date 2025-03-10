pageextension 80107 "DG Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter("Quote No.")
        {
            field("DG Requisition No."; Rec."DG Request No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Due Date")
        {
            field("DG No. Guide Recep./Origen DUA"; Rec."DG No. Guide Recep./Origen DUA")
            {
                ApplicationArea = All;
            }
        }
    }
}