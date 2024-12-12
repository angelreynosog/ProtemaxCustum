namespace ProtemaxCustum.ProtemaxCustum;

page 80114 "DG Certificate of Detraction"
{
    ApplicationArea = All;
    Caption = 'Certificate of Detraction';
    PageType = List;
    SourceTable = "DG Detraction Lot Det";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Batch Code"; Rec."Batch Code")
                {
                    ToolTip = 'Specifies the value of the Batch Code field.', Comment = '%';
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
                field("Document Number"; Rec."Document Number")
                {
                    ToolTip = 'Specifies the value of the Document Number field.';
                    Editable = false;
                }
                field("Purch % Detraction"; Rec."Purch % Detraction")
                {
                    ToolTip = 'Specifies the value of the Purch % Detraction field.';
                    Editable = false;
                }
                field("Purch Amount Detraction"; Rec."Purch Amount Detraction")
                {
                    ToolTip = 'Specifies the value of the Purch Amount Detraction field.';
                    Editable = false;
                }
                field("Detraction Date"; Rec."Detraction Date")
                {
                    ToolTip = 'Specifies the value of the Detraction Date field.', Comment = '%';
                }
                field("No. Operation"; Rec."No. Operation")
                {
                    ToolTip = 'Specifies the value of the No. Operation field.', Comment = '%';
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
