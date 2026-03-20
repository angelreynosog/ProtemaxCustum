namespace ProtemaxCustum.ProtemaxCustum;
using Microsoft.Inventory.Item;

page 80127 "DG Sales & OT Line List"
{
    ApplicationArea = All;
    Caption = 'DG Sales & OT Line List';
    PageType = List;
    Editable = false;
    SourceTable = "DG Relation Sales & OT Line";
    SourceTableView = sorting("Order Word Document", "Line No.") order(descending);
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Order Word Document"; Rec."Order Word Document")
                {
                    ToolTip = 'Specifies the value of the Order Word Document field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Sales Invoice No."; Rec."Sales Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Sales Invoice No. field.';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'Posting Group';
                    ToolTip = 'Specifies the value of the Posting Group field.';
                    ApplicationArea = All;
                }
                field("Status CRM"; Rec."Status CRM")
                {
                    ToolTip = 'Specifies the value of the Status CRM field.',;
                }
                field("Assembly Order No."; Rec."Assembly Order No.")
                {
                    ToolTip = 'Specifies the value of the Assembly Order No. field.';
                }
                field("Posted Assembly Order No."; Rec."Posted Assembly Order No.")
                {
                    ToolTip = 'Specifies the value of the Posted Assembly Order No. field.';
                }
                field("Ready Posted"; Rec."Ready Posted")
                {
                    ToolTip = 'Specifies the value of the Ready Posted field.';
                }
                field("Canceled Posted"; Rec."Canceled Posted")
                {
                    ToolTip = 'Specifies the value of the Canceled Posted field.';
                }

            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("DG Create Assembly")
            {
                ApplicationArea = All;
                Caption = 'Create Assembly';
                Image = AssemblyOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    DGRelationSalesOTLine: Record "DG Relation Sales & OT Line";
                    DGManagament: Codeunit "DG Managament";
                    RecordRef: RecordRef;
                begin
                    CurrPage.SetSelectionFilter(DGRelationSalesOTLine);
                    DGRelationSalesOTLine.SetRange("Status CRM", DGRelationSalesOTLine."Status CRM"::Registered);
                    DGRelationSalesOTLine.SetRange("Ready Posted", true);
                    DGRelationSalesOTLine.SetFilter("Location Code", '<>%1', '');
                    DGRelationSalesOTLine.SetFilter("Assembly Order No.", '%1', '');
                    DGRelationSalesOTLine.SetFilter("Posted Assembly Order No.", '%1', '');
                    if DGRelationSalesOTLine.FindSet() then
                        repeat
                            RecordRef.GetTable(DGRelationSalesOTLine);
                            DGManagament.RecordRefAssemblyOrder(RecordRef);
                        until DGRelationSalesOTLine.Next() = 0;
                end;
            }
        }
    }

}
