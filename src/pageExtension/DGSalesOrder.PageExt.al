pageextension 80119 "DG Sales Order" extends "Sales Order"
{
    layout
    {
        addafter(Status)
        {
            field("DG Order Terminated"; Rec."DG Order Terminated")
            {
                ApplicationArea = All;
            }
            field("DG Completion Consumption"; Rec."DG Completion Consumption")
            {
                ApplicationArea = All;
            }
            field("DG Non-Billable Invoice"; Rec."DG Non-Billable Invoice")
            {
                ApplicationArea = All;
            }

        }
    }
}