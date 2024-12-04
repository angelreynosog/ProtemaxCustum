
page 80106 "DG Comment Line"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "DG Comment Line";
    Caption = 'Comment line';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
            }
        }
    }
}