pageextension 80103 "DG Location Card" extends "Location Card"
{
    layout
    {
        addafter("Use As In-Transit")
        {
            field("DG Mark Obsolete Inventory"; Rec."DG Mark Obsolete Inventory")
            {
                ApplicationArea = All;
            }
        }
    }
}