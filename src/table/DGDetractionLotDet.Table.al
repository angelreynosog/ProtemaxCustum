table 80107 "DG Detraction Lot Det"
{
    DataClassification = ToBeClassified;
    Permissions = tabledata "Purch. Inv. Header" = rimd;
    fields
    {
        field(1; "Batch Code"; Code[20])
        {
            Caption = 'Batch Code';
            DataClassification = CustomerContent;
        }
        field(2; "Line Number"; Integer)
        {
            Caption = 'Line Number';
            DataClassification = CustomerContent;
        }
        field(3; "Vendor Code"; Text[20])
        {
            Caption = 'Vendor Code';
            DataClassification = CustomerContent;
        }
        field(4; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
        }
        field(5; "Transaction Number"; Text[50])
        {
            Caption = 'Transaction Number';
            DataClassification = CustomerContent;
        }
        field(6; "Document Type Sunat"; Text[20])
        {
            Caption = 'Document Type Sunat';
            DataClassification = CustomerContent;
        }
        field(7; "Document Number"; Text[50])
        {
            Caption = 'Document Number';
            DataClassification = CustomerContent;
        }
        field(8; "Document Amount"; Decimal)
        {
            Caption = 'Document Amount';
            DataClassification = CustomerContent;
        }
        field(9; "Type of Service"; Text[10])
        {
            Caption = 'Type of Service';
            DataClassification = CustomerContent;
        }
        field(10; "Purch % Detraction"; Decimal)
        {
            Caption = 'Purch % Detraction';
            DataClassification = CustomerContent;
        }
        field(11; "Purch Amount Detraction"; Decimal)
        {
            Caption = 'Purch Amount Detraction';
            DataClassification = CustomerContent;
        }
        field(12; "Bank account"; Text[50])
        {
            Caption = 'Bank account';
            DataClassification = CustomerContent;
        }
        field(13; "Type of Operation"; Text[10])
        {
            Caption = 'Type of Operation';
            DataClassification = CustomerContent;
        }
        field(14; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }

        field(15; "Detraction Date"; Date)
        {
            Caption = 'Detraction Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PurchInvHeader: Record "Purch. Inv. Header";
            begin
                PurchInvHeader.Reset();
                PurchInvHeader.SetRange("No.", rec."Transaction Number");
                PurchInvHeader.SetRange("Pay-to Vendor No.", rec."Vendor Code");

                if PurchInvHeader.FindFirst() then begin
                    PurchInvHeader."Purch Date Detraction" := rec."Detraction Date";
                    PurchInvHeader.Modify();
                end;
            end;
        }

        field(16; "No. Operation"; Text[20])
        {
            Caption = 'No. Operation';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PurchInvHeader: Record "Purch. Inv. Header";
            begin
                PurchInvHeader.Reset();
                PurchInvHeader.SetRange("No.", rec."Transaction Number");
                PurchInvHeader.SetRange("Pay-to Vendor No.", rec."Vendor Code");

                if PurchInvHeader.FindFirst() then begin
                    PurchInvHeader."Purch Detraction Operation" := rec."No. Operation";
                    PurchInvHeader.Modify();
                end;
            end;
        }
        field(17; "Currency Id"; Text[20])
        {
        }

    }

    keys
    {
        key(Key1; "Batch Code", "Line Number")
        {
            Clustered = true;
        }
    }

}