tableextension 80112 "DG Sales Header" extends "Sales Header"
{
    fields
    {
        field(80100; "DG Non-Billable Invoice"; Boolean)
        {
            Caption = 'Non-Billable Invoice';
        }
        field(80101; "DG Order Terminated"; Text[50])
        {
            Caption = 'Order Terminated';
        }
        field(80102; "DG Completion Consumption"; Option)
        {
            Caption = 'Completion Consumption';
            OptionCaption = ' ,Yes,No';
            OptionMembers = ,Yes,No;
        }
    }
}