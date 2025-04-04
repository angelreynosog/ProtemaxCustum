pageextension 80117 "DG Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        addlast(Control1)
        {
            field("DG Non-Billable Invoice"; Rec."DG Non-Billable Invoice")
            {
                ApplicationArea = All;
                Editable = InvoiceEditable;
            }
        }
    }
    actions
    {
        addbefore(ShowCreditMemo)
        {
            action("DG UnApply")
            {
                Caption = 'UnApply Non-Billable Invoice';
                ToolTip = 'Executes the UnApply Non-Billable Invoice action.';
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = InvoiceEditable;
                ApplicationArea = All;
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    DGManagament: Codeunit "DG Managament";
                    RecordRef: RecordRef;
                begin
                    CurrPage.SetSelectionFilter(SalesInvoiceHeader);
                    SalesInvoiceHeader.SetRange("DG Non-Billable Invoice", true);
                    if SalesInvoiceHeader.FindSet() then begin
                        RecordRef.GetTable(SalesInvoiceHeader);
                        DGManagament.NonBillableInvoice(RecordRef, false);
                    end;
                end;
            }
            action("DG Apply")
            {
                Caption = 'Apply Non-Billable Invoice';
                ToolTip = 'Executes the Apply Non-Billable Invoice action.';
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = InvoiceEditable;
                ApplicationArea = All;
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    DGManagament: Codeunit "DG Managament";
                    RecordRef: RecordRef;
                begin
                    CurrPage.SetSelectionFilter(SalesInvoiceHeader);
                    SalesInvoiceHeader.SetRange("DG Non-Billable Invoice", false);
                    if SalesInvoiceHeader.FindSet() then begin
                        RecordRef.GetTable(SalesInvoiceHeader);
                        DGManagament.NonBillableInvoice(RecordRef, true);
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
        Clear(InvoiceEditable);

        User.Reset();
        User.SetRange("User Name", UserId);
        User.SetRange(State, User.State::Enabled);
        if User.FindFirst() then begin
            UserSetup.Reset();
            UserSetup.SetRange("User ID", User."User Name");
            UserSetup.SetRange("DG Non-Billable Invoice", true);
            if UserSetup.FindFirst() then
                InvoiceEditable := true
            else
                InvoiceEditable := false;
        end;
    end;

    var
        InvoiceEditable: Boolean;
}