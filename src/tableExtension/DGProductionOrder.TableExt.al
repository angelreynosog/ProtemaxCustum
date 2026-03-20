tableextension 80110 "DG Production Order" extends "Production Order"
{
    fields
    {
        field(80100; "DG Order Number CRM"; Text[100])
        {
            Caption = 'Order Number CRM';
        }
        field(80101; "DG Order Work CRM"; Text[100])
        {
            Caption = 'Order Work CRM';
        }
        field(80102; "DG Description Details"; Text[250])
        {
            Caption = 'Description Details';
        }
    }

}