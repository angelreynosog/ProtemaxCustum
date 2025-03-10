page 80115 "DG GPS Brands"
{
    ApplicationArea = All;
    Caption = 'DG GPS Brands';
    PageType = List;
    SourceTable = "DG GPS Brands";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Locked; Rec.Locked)
                {
                    ToolTip = 'Specifies the value of the Locked field.';
                }
            }
        }
    }
}
