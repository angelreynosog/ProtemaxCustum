page 80123 "DG CRM Sales Order"
{
    PageType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgCRMSalesOrder';
    EntitySetName = 'dgCRMSalesOrder';
    SourceTable = "CRM Salesorder";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    ChangeTrackingAllowed = true;
    Permissions = tabledata "CRM Salesorder" = rimd;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(orderNumber; Rec.OrderNumber)
                { }
                field(systemId; Rec.SystemId)
                { }
            }
        }
    }
}