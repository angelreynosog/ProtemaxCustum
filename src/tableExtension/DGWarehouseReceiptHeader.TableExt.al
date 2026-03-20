tableextension 80111 "DG Warehouse Receipt Header" extends "Warehouse Receipt Header"
{
    fields
    {
        field(80100; "DG No. Guide Recep./Origen DUA"; Text[1024])
        {
            Caption = 'No. Guide Recep.|Origen DUA|Direct Invoice';
            DataClassification = CustomerContent;
        }
        field(80101; "DG Document SUNAT"; Code[20])
        {
            Caption = 'Document SUNAT';
            TableRelation = "SUNAT Tables"."SUNAT Code" where("Document Type" = const("Document Type"));
            DataClassification = CustomerContent;
        }
    }
}