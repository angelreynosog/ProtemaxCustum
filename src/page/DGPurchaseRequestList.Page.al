page 80102 "DG Purchase Request List"
{
    ApplicationArea = All;
    Caption = 'DG Purchase Request List';
    PageType = List;
    CardPageId = "DG Purchase Request Header";
    SourceTable = "DG Purchase Request Header";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Status Request"; Rec."Status Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Request field.';
                }
                field("Status Line"; Rec."Status Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Line field.';
                }
                field("Create Date"; Rec."Create Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Create Date field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        DGPurchaseRequestLine: Record "DG Purchase Request Line";
        Count: Decimal;
    begin
        DGPurchaseRequestLine.Reset();
        DGPurchaseRequestLine.SetRange("Document No.", Rec."No.");
        DGPurchaseRequestLine.SetRange("Document Type", Rec."Document Type");
        if DGPurchaseRequestLine.FindSet() then
            repeat
                DGPurchaseRequestLine.CalcFields("Qty. Requested");
                Count += DGPurchaseRequestLine.Quantity - DGPurchaseRequestLine."Qty. Requested";
            until DGPurchaseRequestLine.Next() = 0;

        if Count = 0 then
            Rec."Status Line" := Rec."Status Line"::Closed
        else
            Rec."Status Line" := Rec."Status Line"::Open;
    end;
}
