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
        field(80101; "DG No. Guide Recep./Origen DUA"; Text[1024])
        {
            Caption = 'No. Guide Recep./Origen DUA/Direct Invoice';
            DataClassification = CustomerContent;
        }
    }
}