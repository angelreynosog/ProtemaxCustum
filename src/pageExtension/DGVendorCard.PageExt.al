pageextension 80101 "DG Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("DG General Quote Vendor"; Rec."DG General Quote Vendor")
            {
                Caption = 'General Quote Vendor';
                ApplicationArea = All;
            }
        }
    }
}