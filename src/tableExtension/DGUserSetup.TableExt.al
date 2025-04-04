tableextension 80100 "DG User Setup" extends "User Setup"
{
    fields
    {
        field(80100; "DG Approver Requestor OC"; Boolean)
        {
            Caption = 'Approver Requestor OC';
            DataClassification = CustomerContent;
        }
        field(80101; "DG Non-Billable Invoice"; Boolean)
        {
            Caption = 'Non-Billable Invoice';
        }
    }

}