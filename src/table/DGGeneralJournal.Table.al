table 80104 "DG General Journal"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(6; "Month"; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        DGGeneralJournalLine: Record "DG General Journal Line";
    begin
        DGGeneralJournalLine.Reset();
        DGGeneralJournalLine.SetRange(Code, Rec.Code);
        DGGeneralJournalLine.DeleteAll();
    end;
}