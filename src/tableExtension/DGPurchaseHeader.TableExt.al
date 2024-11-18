tableextension 80102 "DG Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(80100; "DG Request No."; Code[20])
        {
            Caption = 'Request No.';
            TableRelation = "DG Purchase Request Header"."No.";
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}