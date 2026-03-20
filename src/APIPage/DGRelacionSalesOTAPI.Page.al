page 80122 "DG Relacion Sales & OT API"
{
    PageType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgRelationSalesOT';
    EntitySetName = 'dgRelationSalesOT';
    SourceTable = "DG Relation Sales & OT";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    ChangeTrackingAllowed = true;
    Permissions = tabledata "DG Relation Sales & OT" = rimd;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(orderIdCRM; Rec."Order Id CRM")
                { }
                field(customerNo; Rec."Customer No.")
                { }
                field(orderWork; Rec."Order Work")
                { }
                field(systemId; Rec.SystemId)
                { }
            }
        }
    }
}