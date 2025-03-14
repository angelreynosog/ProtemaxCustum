page 80114 "DG Detraction Certificate"
{
    ApplicationArea = All;
    Caption = 'DG Detraction Certificate';
    PageType = List;
    SourceTable = "DG Detraction Line";
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Detraction Code"; Rec."Detraction Code")
                {
                    ToolTip = 'Specifies the value of the Detraction Code field.';
                    Editable = false;
                }
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ToolTip = 'Specifies the value of the Vendor Code field.';
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                    Editable = false;
                }
                field("Document Type Sunat"; Rec."Document Type Sunat")
                {
                    ToolTip = 'Specifies the value of the Document Type Sunat field.';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document Number field.';
                    Editable = false;
                }
                field("Purch. % Detraction"; Rec."Purch. % Detraction")
                {
                    ToolTip = 'Specifies the value of the Purch. % Detraction field.';
                    Editable = false;
                }
                field("Purch. Amount Detraction"; Rec."Purch. Amount Detraction")
                {
                    ToolTip = 'Specifies the value of the Purch. Amount Detraction field.';
                    Editable = false;
                }
                field("Detraction Date"; Rec."Detraction Date")
                {
                    ToolTip = 'Specifies the value of the Detraction Date field.';
                }
                field("No. Operation"; Rec."No. Operation")
                {
                    ToolTip = 'Specifies the value of the No. Operation field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Importfile)
            {
                Caption = 'Import file';
                Image = Import;
                ToolTip = ' ';
                ApplicationArea = ALL;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Message('En construccion');
                end;
            }
        }
    }
}