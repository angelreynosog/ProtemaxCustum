pageextension 80100 "DG User Setup" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("DG Approver Requestor OC"; Rec."DG Approver Requestor OC")
            {
                ToolTip = 'Approver Requestor OC Purchase';
                ApplicationArea = All;
            }
            field("DG Non-Billable Invoice"; Rec."DG Non-Billable Invoice")
            {
                ToolTip = 'Non-Billable Invoice';
                ApplicationArea = All;
            }
        }
    }
}