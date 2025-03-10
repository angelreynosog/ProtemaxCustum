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
        }
    }
}