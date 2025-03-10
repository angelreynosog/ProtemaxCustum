table 80108 "DG GPS Brands"
{
    Caption = 'DG GPS Brands';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Integer)
        {
            Caption = 'Code';
            AutoIncrement = true;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Locked; Boolean)
        {
            Caption = 'Locked';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}