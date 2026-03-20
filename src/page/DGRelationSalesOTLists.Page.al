page 80126 "DG Relation Sales & OT Lists"
{
    ApplicationArea = All;
    Caption = 'DG Relation Sales & OT Lists';
    PageType = List;
    Editable = false;
    SourceTable = "DG Relation Sales & OT";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Order Id CRM"; Rec."Order Id CRM")
                {
                    ToolTip = 'Specifies the value of the Order Id CRM field.';
                }
                field("Order Work"; Rec."Order Work")
                {
                    ToolTip = 'Specifies the value of the Order Terminated field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
            }
        }
    }
}
