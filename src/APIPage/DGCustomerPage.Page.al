page 80110 "DG Customer Page"
{
    PageType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'customer';
    EntitySetName = 'customers';
    SourceTable = Customer;
    DelayedInsert = true;
    ODataKeyFields = "No.";
    ChangeTrackingAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(code; Rec."No.")
                { }
                field(name; Rec.Name)
                { }
                field(phone; Rec."Phone No.")
                { }
            }
        }
    }
}