pageextension 80109 "Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("DG Request No."; Rec."DG Request No.")
            {
                ApplicationArea = All;
            }
        }
    }
}