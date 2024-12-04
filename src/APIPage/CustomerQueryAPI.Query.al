query 80100 "Customer Query API"
{
    QueryType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgCustomer';
    EntitySetName = 'dgCustomer';

    elements
    {
        dataitem(Customer; Customer)
        {
            column(no; "No.")
            { }
            column(name; Name)
            { }
            column(phoneNo; "Phone No.")
            { }
        }
    }
}