pageextension 80123 "DG Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("DG Status CRM"; Rec."DG Status CRM")
            {
                ApplicationArea = All;
            }
            field("DG Order Id CRM"; Rec."DG Order Id CRM")
            {
                ApplicationArea = All;
            }
            field("DG Order Work"; Rec."DG Order Work")
            {
                ApplicationArea = All;
            }
        }
    }
}