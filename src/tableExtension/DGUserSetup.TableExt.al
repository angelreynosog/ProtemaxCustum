tableextension 80100 "DG User Setup" extends "User Setup"
{
    fields
    {
        field(80100; "Generate Request Purchase"; Boolean)
        {
            Caption = 'Generate Request Purchase';
            DataClassification = CustomerContent;
        }
        field(80101; "DG Non-Billable Invoice"; Boolean)
        {
            Caption = 'Non-Billable Invoice';
        }
    }
}