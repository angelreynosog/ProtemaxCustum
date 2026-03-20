namespace ProtemaxCustum.ProtemaxCustum;

page 80119 "DG Setup Custom"
{
    ApplicationArea = All;
    Caption = 'DG Protemax Setup Custom';
    PageType = Card;
    SourceTable = "DG Protemax Setup Custom";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("Sales")
            {
                Caption = 'Sales';
                field("Location Direct Sales"; Rec."Location Direct Sales")
                {
                    ToolTip = 'Specifies the value of the Location Direct Sales field.';
                    ApplicationArea = All;
                }

            }
            group("Assembly")
            {
                Caption = 'Assembly';
                field("Assembly Order CRM"; Rec."Assembly Order CRM")
                {
                    ToolTip = 'Specifies the value of the Assembly Order CRM field.';
                }
                field("Posted Assembly Order CRM"; Rec."Posted Assembly Order CRM")
                {
                    ToolTip = 'Specifies the value of the Posted Assembly Order CRM field.';
                }
            }
            group(Payroll)
            {
                Caption = 'Payroll';
                field("Jnl. Templ. Name Payroll"; Rec."Jnl. Templ. Name Payroll")
                {
                    ToolTip = 'Specifies the value of the Jnl. Templ. Name Payroll field.';
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
            group("Field Service CRM")
            {
                Caption = 'Field Service CRM';
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
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
