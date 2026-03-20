table 80111 "DG Relation Sales & OT"
{
    Caption = 'Relation Sales & OT';
    DrillDownPageId = "DG Relation Sales & OT Lists";
    LookupPageId = "DG Relation Sales & OT Lists";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Order Id CRM"; Text[100])
        {
            Caption = 'Order Id CRM';
            DataClassification = CustomerContent;
        }
        field(2; "Order Work"; Text[100])
        {
            Caption = 'Order Work';
            DataClassification = CustomerContent;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Order Id CRM", "Order Work")
        {
            Clustered = true;
        }
    }
}