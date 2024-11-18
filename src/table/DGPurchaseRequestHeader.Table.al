table 80100 "DG Purchase Request Header"
{
    Caption = 'Purchase Request Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Editable = false;
        }
        field(2; "Document Type"; Enum "DG Document Type Request")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
        }
        field(5; "User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Create Date"; Date)
        {
            Caption = 'Create Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.", "Document Type")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PurchasesPayablesSetup.Get();
            PurchasesPayablesSetup.TestField("DG Request Nos.");
            "No." := NoSeries.GetNextNo(PurchasesPayablesSetup."DG Request Nos.");
            "User Id" := CopyStr(UserId, 1, 50);
            "Create Date" := Today();
        end;
    end;

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";

}