tableextension 80118 "DG Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(80101; "DG Status CRM"; Option)
        {
            Caption = 'Status CRM';
            OptionMembers = ,Unscheduled,Registered,Completed,Canceled;
            OptionCaption = ' ,Unscheduled,Registered,Completed,Canceled';
            DataClassification = CustomerContent;
        }
        field(80102; "DG Order Id CRM"; Text[100])
        {
            Caption = 'Order Id CRM';
            DataClassification = CustomerContent;
        }
        field(80103; "DG Order Work"; Text[100])
        {
            Caption = 'Order Work';
            DataClassification = CustomerContent;
        }
    }

}