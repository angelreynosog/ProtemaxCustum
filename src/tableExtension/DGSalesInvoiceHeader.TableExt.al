tableextension 80113 "DG Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(80100; "DG Non-Billable Invoice"; Boolean)
        {
            Caption = 'Non-Billable Invoice';
            Editable = true;
        }
        field(80101; "Order Terminated"; Text[50])
        {
            Caption = 'Order Terminated';
        }
        field(80102; "Completion Consumption"; Option)
        {
            Caption = 'Completion Consumption';
            OptionCaption = ' ,Yes,No';
            OptionMembers = ,Yes,No;
        }
    }
}