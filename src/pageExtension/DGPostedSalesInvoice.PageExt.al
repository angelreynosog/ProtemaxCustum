pageextension 80109 "DG Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("DG Channel"; Rec."DG Channel")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}