page 80116 "DG GPS Models"
{
    ApplicationArea = All;
    Caption = 'DG GPS Models';
    PageType = List;
    SourceTable = "DG GPS Models";

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
                field("Brands Code"; Rec."Brands Code")
                {
                    ToolTip = 'Specifies the value of the Brands Code field.';
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
