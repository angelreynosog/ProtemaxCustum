pageextension 80122 "DG Item Journal Lines" extends "Item Journal Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("Reason Code"; Rec."Reason Code")
            {
                Caption = 'Reason Code';
                ApplicationArea = All;
            }

        }
    }
}