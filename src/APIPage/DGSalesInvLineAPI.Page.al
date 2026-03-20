page 80121 "DG Sales Inv. Line API"
{
    PageType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgSaleInvLine';
    EntitySetName = 'dgSaleInvLine';
    SourceTable = "Sales Invoice Line";
    ODataKeyFields = SystemId;
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    Permissions = tabledata "Sales Invoice Line" = rimd;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentType; Rec."Document No.")
                { }
                field(documentNo; Rec."Document No.")
                { }
                field(postingDate; Rec."Posting Date")
                { }
                field(lineNo; Rec."Line No.")
                { }
                field(type; Rec.Type)
                { }
                field(no; Rec."No.")
                { }
                field(description; Rec.Description)
                { }
                field(description2; Rec."Description 2")
                { }
                field(quantity; Rec.Quantity)
                { }
                field(unitPrice; Rec."Unit Price")
                { }
                field(amount; Rec.Amount)
                { }
                field(amounIncludingVAT; Rec."Amount Including VAT")
                { }
                field(orderWork; Rec."DG Order Work")
                { }
                field(statusCRM; Rec."DG Status CRM")
                { }
                field(systemId; Rec.SystemId)
                { }
                field(totalInvoice; GetHeader(Rec."Document No."))
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    local procedure GetHeader(NoDocument: Code[20]): Decimal
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if SalesInvoiceHeader.Get(NoDocument) then begin
            SalesInvoiceHeader.CalcFields(Amount, "Amount Including VAT");
            exit(SalesInvoiceHeader."Amount Including VAT");
        end;
    end;
}