tableextension 80108 "DG Item Ledger Entry" extends "Item Ledger Entry"
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