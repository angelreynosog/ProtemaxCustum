pageextension 80128 "DG Production Order List" extends "Production Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("DG Order Number CRM"; Rec."DG Order Number CRM")
            {
                ApplicationArea = All;
            }
            field("DG Order Work CRM"; Rec."DG Order Work CRM")
            {
                ApplicationArea = All;
            }
        }
    }
}