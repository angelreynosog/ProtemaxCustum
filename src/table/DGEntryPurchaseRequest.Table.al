table 80102 "DG Entry Purchase Request"
{
    Caption = 'Entry Purchase Request';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = "DG Purchase Request Header"."No.";
        }
        field(3; "Document Type"; Enum "DG Document Type Request")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
        }
        field(6; "Description"; Text[100])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Description 2"; Text[100])
        {
            Caption = 'Item Description 2';
            DataClassification = CustomerContent;
        }
        field(8; "Inventory Total"; Decimal)
        {
            Caption = 'Inventory Total';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Inventory Without Obs. Whs."; Decimal)
        {
            Caption = 'Inventory Without Obs. Whs.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Quantity Requested"; Decimal)
        {
            Caption = 'Quantity Requested';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "Order Status"; Enum "DG Purchase Quote Status")
        {
            Caption = 'Order Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Vendor Code"; Code[20])
        {
            Caption = 'Vendor Code';
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(16; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
            DataClassification = CustomerContent;
        }
        field(17; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
        }
        field(18; "User Id"; Code[50])
        {
            Caption = 'User Id';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Create Date"; Date)
        {
            Caption = 'User Id';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; "User Id Authorized"; Code[50])
        {
            Caption = 'User Id Authorized';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(21; "Authorization Date"; Date)
        {
            Caption = 'User Id';
            Editable = false;
        }

    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(PK1; "Document No.", "Document Type", "Line No.")
        {
            SumIndexFields = "Quantity Requested";
        }

    }
}