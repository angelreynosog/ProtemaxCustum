pageextension 80101 "DG Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("DG Generic Vendor"; Rec."DG Generic Vendor")
            {
                ApplicationArea = All;
            }
        }
    }
}