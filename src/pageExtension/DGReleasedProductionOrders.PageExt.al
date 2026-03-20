pageextension 80126 "DG Released Production Orders" extends "Released Production Orders"
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

        addbefore("Description 2")
        {
            field("DG Description Details"; Rec."DG Description Details")
            {
                ApplicationArea = All;
            }

        }
    }
}