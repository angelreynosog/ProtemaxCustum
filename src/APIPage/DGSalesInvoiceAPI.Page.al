page 80117 "DG Sales Invoice API"
{
    PageType = API;
    Caption = 'DG Sales Invoice';
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgSalesInvoice';
    EntitySetName = 'dgSalesInvoice';
    SourceTable = "Sales Header";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    ChangeTrackingAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentType; Rec."Document Type")
                { }
                field(no; Rec."No.")
                { }
                field(customerNo; Rec."Sell-to Customer No.")
                { }
                field(customerName; Rec."Sell-to Customer Name")
                { }
                field(postingDate; Rec."Posting Date")
                { }
                field(dueDate; Rec."Due Date")
                { }
                field(nonBillableInvoice; Rec."DG Non-Billable Invoice")
                { }
                part(dgSaleInvoiceLine; "DG Sales Invoice Line API")
                {
                    EntitySetName = 'dgSaleLine';
                    EntityName = 'dgSaleLine';
                    SubPageLink = "DG Code System Id" = field(SystemId);
                }
                field(systemId; Rec.SystemId)
                { }
            }
        }
    }
}