pageextension 80100 "DG User Setup" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Generate Request Purchase"; Rec."Generate Request Purchase")
            {
                ToolTip = 'Generate Request Purchase';
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