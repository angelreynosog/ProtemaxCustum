pageextension 80105 "DG Business Manager Role" extends "Business Manager Role Center"
{
    actions
    {
        addafter("Purchase Quotes")
        {
            action("Request Purchase")
            {
                ApplicationArea = All;
                Caption = 'Request Purchase';
                Image = NewInvoice;
                RunObject = Page "DG Purchase Request List";
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.';
            }
        }
    }
}