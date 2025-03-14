tableextension 80106 "DG Sales Line" extends "Sales Line"
{
    fields
    {
        field(80100; "Code System Id"; Guid)
        {
            Caption = 'Code System Id';
            TableRelation = "Sales Header".SystemId;
            DataClassification = CustomerContent;
        }
    }
}