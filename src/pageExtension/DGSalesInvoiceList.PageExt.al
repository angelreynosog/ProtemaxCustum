pageextension 80129 "DG Sales Invoice List" extends "Sales Invoice List"
{
    layout
    {
        addlast(Control1)
        {
            field("DG Channel"; Rec."DG Channel")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}