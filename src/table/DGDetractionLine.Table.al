table 80107 "DG Detraction Line"
{
    Caption = 'Detraction Line';
    DataClassification = CustomerContent;
    Permissions = tabledata "Purch. Inv. Header" = rimd;

    fields
    {
        field(1; "Detraction Code"; Code[20])
        {
            Caption = 'Detraction Code';
            DataClassification = CustomerContent;
        }
        field(2; "Line"; Integer)
        {
            Caption = 'Line';
            DataClassification = CustomerContent;
        }
        field(3; "Vendor Code"; Text[20])
        {
            Caption = 'Vendor Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Vendor Name");
            end;
        }
        field(4; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor Code")));
            FieldClass = FlowField;
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
        field(7; "Document No."; Text[50])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(8; "Amount Document"; Decimal)
        {
            Caption = 'Amount Document';
            DataClassification = CustomerContent;
        }
        field(9; "Type of Service"; Text[10])
        {
            Caption = 'Type of Service';
            DataClassification = CustomerContent;
        }
        field(10; "Purch. % Detraction"; Decimal)
        {
            Caption = '% Detraction';
            DataClassification = CustomerContent;
        }
        field(11; "Purch. Amount Detraction"; Decimal)
        {
            Caption = 'Amount Detraction';
            DataClassification = CustomerContent;
        }
        field(12; "Bank Account"; Text[50])
        {
            Caption = 'Bank Account';
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
            DataClassification = CustomerContent;
        }
        field(15; "Detraction Date"; Date)
        {
            Caption = 'Detraction Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PurchInvHeader: Record "Purch. Inv. Header";
            begin
                PurchInvHeader.Reset();
                PurchInvHeader.SetRange("No.", Rec."Transaction Number");
                PurchInvHeader.SetRange("Pay-to Vendor No.", Rec."Vendor Code");
                if PurchInvHeader.FindSet() then begin
                    PurchInvHeader."Purch Date Detraction" := Rec."Detraction Date";
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
                PurchInvHeader.SetRange("No.", Rec."Transaction Number");
                PurchInvHeader.SetRange("Pay-to Vendor No.", Rec."Vendor Code");
                if PurchInvHeader.FindSet() then begin
                    PurchInvHeader."Purch Detraction Operation" := Rec."No. Operation";
                    PurchInvHeader.Modify();
                end;
            end;
        }
        field(17; "Currency Code"; Text[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Detraction Code", "Line")
        {
            Clustered = true;
        }
    }

}