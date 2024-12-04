pageextension 80108 "DG Purchase Invoice" extends "Purchase Invoice"
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