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

    trigger OnOpenPage()
    var
        User: Record User;
        UserSetup: Record "User Setup";
    begin
        Clear(InvoiceEditable);

        User.Reset();
        User.SetRange("User Name", UserId);
        User.SetRange(State, User.State::Enabled);
        if User.FindSet() then begin
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