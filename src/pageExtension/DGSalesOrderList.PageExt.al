pageextension 80118 "DG Sales Order List" extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("DG Order Terminated"; Rec."DG Order Terminated")
            {
                ApplicationArea = All;
            }
        }
    }
}