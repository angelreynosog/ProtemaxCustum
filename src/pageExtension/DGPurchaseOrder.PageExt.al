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
    }
}