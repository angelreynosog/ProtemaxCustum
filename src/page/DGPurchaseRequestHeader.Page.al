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
                Caption = 'Lines';
            }
            part(PurchRequestLinesApprvd; "DG Purch. Request Line Apprvd")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                UpdatePropagation = Both;
                Visible = VisibleApprvd;
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
    end;

    var
        VisibleApprvd: Boolean;
}
