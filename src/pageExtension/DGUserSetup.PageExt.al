pageextension 80100 "DG User Setup" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Generate Purchase Quote"; Rec."Generate Purchase Quote")
            {
                ToolTip = 'Generate Purchase Quote';
                ApplicationArea = All;
            }
        }
    }
}