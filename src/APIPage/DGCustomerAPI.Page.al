page 80110 "DG Customer API"
{
    PageType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgcustomer';
    EntitySetName = 'dgcustomers';
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
                field(no; No)
                {
                    trigger OnValidate()
                    begin
                        Rec.Validate("No.", No);
                    end;
                }
                field(code; Rec."No.")
                { }

                field(name; Rec.Name)
                { }
                field(customerPostingGroup; Rec."Customer Posting Group")
                { }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                { }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                { }
                field(address; Rec.Address)
                { }
                field(address2; Rec."Address 2")
                { }
                field(city; Rec.City)
                { }
                field(country; Rec."Country/Region Code")
                { }
                field(postCode; Rec."Post Code")
                { }
                field(phone; Rec."Phone No.")
                { }
                field(telexNo; Rec."Telex No.")
                { }
                field(email; Rec."E-Mail")
                { }
                field(ruc; Rec."VAT Registration No.")
                { }
                field(paymentTermsCode; Rec."Payment Terms Code")
                { }
                field(sunatDocument; Rec."SUNAT Document")
                { }
                field(clasificacionCliente; Rec."Clasificacion Cliente")
                { }
                field(businesslinebusiness; Rec."Business line of business")
                { }
            }
        }
    }
    var
        No: Code[20];
}