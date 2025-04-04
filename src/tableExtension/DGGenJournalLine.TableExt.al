tableextension 80116 "DG Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(80100; "DG No. Guide Recep./Origen DUA"; Text[1024])
        {
            Caption = 'No. Guide Recep./Origen DUA/Direct Invoice';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}