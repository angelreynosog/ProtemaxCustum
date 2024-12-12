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
        field(80102; "DG Serie Batch Code"; Code[20])
        {
            Caption = 'Serie Batch Code';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(80103; "Batch Payment Detraction"; Code[20])
        {
            Caption = 'Batch Payment Detraction';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = const('PAYMENTS'));
            DataClassification = CustomerContent;
        }
    }
}