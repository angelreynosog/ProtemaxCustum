table 80109 "DG GPS Models"
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
        field(2; "GPS Brands Code"; Integer)
        {
            Caption = 'GPS Brands Code';
            TableRelation = "DG GPS Brands".Code;
            DataClassification = CustomerContent;
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; Locked; Boolean)
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
        key(Key2; "GPS Brands Code", Description)
        {

        }
    }

}