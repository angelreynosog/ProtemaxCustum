page 80100 "DG Purchase Request Header"
{
    Caption = 'DG Purchase Request Header';
    PageType = Document;
    SourceTable = "DG Purchase Request Header";
    SourceTableView = where("Document Type" = const(Request));
    UsageCategory = None;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = IsEditable;

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
                    Editable = false;
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
            part(PurchRequestLines; "DG Purchase Request Line")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                UpdatePropagation = Both;
                Visible = not VisibleApprvd;
                Editable = IsEditable;
                Caption = 'Lines';
            }
            part(PurchRequestLinesApprvd; "DG Purch. Request Line Apprvd")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                UpdatePropagation = Both;
                Visible = VisibleApprvd;
                Editable = IsEditable;
                Caption = 'Lines';
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("DG Request Document")
            {
                ApplicationArea = All;
                Caption = 'Request Document';
                Image = Attach;
                Enabled = IsEditable;
                ToolTip = 'Executes the Request Document action.';

                trigger OnAction()
                begin
                    if not (Rec."Status Request" = Rec."Status Request"::Requested) then
                        if (Rec."Status Request" = Rec."Status Request"::" ") and not (Rec."Status Request" = Rec."Status Request"::Approved) then begin
                            Rec."Status Request" := Rec."Status Request"::Requested;
                            Rec.Modify();
                        end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        User: Record User;
        UserSetup: Record "User Setup";
        DGPurchaseRequestLine: Record "DG Purchase Request Line";
        TotalPending: Decimal;
    begin
        User.Reset();
        User.SetRange("User Name", UserId);
        User.SetRange(State, User.State::Enabled);
        if User.FindFirst() then begin
            UserSetup.Reset();
            UserSetup.SetRange("User ID", User."User Name");
            UserSetup.SetRange("DG Approver Requestor OC", true);
            if not UserSetup.IsEmpty then
                VisibleApprvd := true;
        end;

        DGPurchaseRequestLine.Reset();
        DGPurchaseRequestLine.SetRange("Document No.", Rec."No.");
        DGPurchaseRequestLine.SetRange("Document Type", Rec."Document Type");
        if DGPurchaseRequestLine.FindSet() then
            repeat
                DGPurchaseRequestLine.CalcFields("Qty. Requested");
                TotalPending += DGPurchaseRequestLine.Quantity - DGPurchaseRequestLine."Qty. Requested";
            until DGPurchaseRequestLine.Next() = 0;

        if TotalPending = 0 then
            Rec."Status Line" := Rec."Status Line"::Closed
        else
            Rec."Status Line" := Rec."Status Line"::Open;

        IsEditable := Rec."Status Line" <> Rec."Status Line"::Closed;
    end;

    var
        VisibleApprvd: Boolean;
        IsEditable: Boolean;
}
