table 80105 "DG General Journal Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            TableRelation = "DG General Journal".Code;

            trigger OnValidate()
            begin
                GetDocumentSystemId();
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = "G/L Account"."No." where("Account Type" = filter(Posting));
            DataClassification = CustomerContent;
        }
        field(4; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(6; "Dimension 1"; Code[20])
        {
            Caption = 'Dimension 1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;
        }
        field(7; "Dimension 2"; Code[20])
        {
            Caption = 'Dimension 2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;
        }
        field(8; "Dimension 3"; Code[20])
        {
            Caption = 'Dimension 3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            DataClassification = CustomerContent;
        }
        field(9; "Dimension 4"; Code[20])
        {
            Caption = 'Dimension 4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            DataClassification = CustomerContent;
        }
        field(10; "Dimension 5"; Code[20])
        {
            Caption = 'Dimension 5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
            DataClassification = CustomerContent;
        }
        field(11; "Dimension 6"; Code[20])
        {
            Caption = 'Dimension 6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
            DataClassification = CustomerContent;
        }
        field(12; "Dimension 7"; Code[20])
        {
            Caption = 'Dimension 7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
            DataClassification = CustomerContent;
        }
        field(13; "Dimension 8"; Code[20])
        {
            Caption = 'Dimension 8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
            DataClassification = CustomerContent;
        }
        field(14; "Code System Id"; Guid)
        {
            Caption = 'Code System Id';
            TableRelation = "DG General Journal".SystemId;
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; Code, "Line No.")
        {
            Clustered = true;
        }
    }


    local procedure GetDocumentSystemId()
    var
        DGGeneralJournal: Record "DG General Journal";
    begin
        if DGGeneralJournal.Get(Code) then
            Validate("Code System Id", DGGeneralJournal.SystemId)
        else
            Clear(DGGeneralJournal);
    end;
}