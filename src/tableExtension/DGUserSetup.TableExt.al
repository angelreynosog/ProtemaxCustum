tableextension 80100 "DG User Setup" extends "User Setup"
{
    fields
    {
        field(80100; "Generate Purchase Quote"; Boolean)
        {
            Caption = 'Generate Purchase Quote';
            DataClassification = CustomerContent;
        }
    }
}