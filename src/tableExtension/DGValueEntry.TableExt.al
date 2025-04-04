tableextension 80114 "DG Value Entry" extends "Value Entry"
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