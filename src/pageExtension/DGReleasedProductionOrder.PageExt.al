pageextension 80127 "DG Released Production Order" extends "Released Production Order"
{
    layout
    {
        addbefore("Description 2")
        {
            field("DG Description Details"; Rec."DG Description Details")
            {
                ApplicationArea = All;
            }
        }
    }
}