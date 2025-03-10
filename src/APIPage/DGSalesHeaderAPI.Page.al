page 80117 "dg Sales Header API"
{
    PageType = API;
    Caption = 'Sales Invoice';
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'salesinvoice';
    EntitySetName = 'salesinvoice';
    SourceTable = "Sales Header";
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(documentType; Rec."Document Type")
                { }
                field(no; Rec."No.")
                { }
                field(customerNo; Rec."Bill-to Customer No.")
                { }
                field(customerName; Rec."Bill-to Name")
                { }
                field(postingDate; Rec."Posting Date")
                { }
                part(dgSaleLine; "DG Sales Line API")
                {
                    EntitySetName = 'dgSaleLine';
                    EntityName = 'dgSaleLine';
                    SubPageLink = "Code System Id" = field(SystemId);
                }
                field(systemId; Rec.SystemId)
                { }
            }

        }
    }
}