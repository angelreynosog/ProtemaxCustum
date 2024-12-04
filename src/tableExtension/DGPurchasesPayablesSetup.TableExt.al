tableextension 80105 "DG Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(80100; "DG Request Nos."; Code[20])
        {
            Caption = '* DG Request Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(80101; "DG Purchase Order Footer Text"; Text[2000])
        {
            Caption = '* Purchase Order Footer';
            DataClassification = CustomerContent;
        }
    }
}