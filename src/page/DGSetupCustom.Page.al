namespace ProtemaxCustum.ProtemaxCustum;

page 80119 "DG Setup Custom"
{
    ApplicationArea = All;
    Caption = 'DG Setup Custom';
    PageType = Card;
    SourceTable = "DG Setup Custom";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Payroll)
            {
                Caption = 'Payroll';
                field("Jnl. Templ. Name Payroll"; Rec."Jnl. Templ. Name Payroll")
                {
                    ToolTip = 'Specifies the value of the nl. Templ. Name Payroll field.';
                }
                field("Jnl Batch Name Payroll"; Rec."Jnl Batch Name Payroll")
                {
                    ToolTip = 'Specifies the value of the Jnl Batch Name Payroll field.';
                }
            }
            group(Detraction)
            {
                Caption = 'Detraction';
                field("Jnl. Templ. Name Detraction"; Rec."Jnl. Templ. Name Detraction")
                {
                    ToolTip = 'Specifies the value of the Jnl. Templ. Name Detraction field.';
                }
                field("Jnl Batch Name Detraction"; Rec."Jnl Batch Name Detraction")
                {
                    ToolTip = 'Specifies the value of the Jnl Batch Name Detraction field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty then
            Rec.Insert();
    end;
}
