tableextension 80107 "DG Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(80100; "DG No. Guide Recep./Origen DUA"; Text[1024])
        {
            Caption = 'No. Guide Recep.|Origen DUA|Direct Invoice';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80101; "DG Document SUNAT"; Code[20])
        {
            Caption = 'Document SUNAT';
            Editable = false;
            TableRelation = "SUNAT Tables" where("Document Type" = const("Document Type"));
            DataClassification = CustomerContent;
        }
    }
}