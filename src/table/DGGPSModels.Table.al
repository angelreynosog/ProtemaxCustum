table 80109 "DG GPS Models"
{
    Caption = 'DG GPS Models';
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
        field(2; "Brands Code"; Integer)
        {
            Caption = 'Brands Code';
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
        key(Key2; "Brands Code", Description)
        {

        }
    }

}