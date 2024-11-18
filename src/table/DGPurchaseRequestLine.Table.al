table 80101 "DG Purchase Request Line"
{
    Caption = 'Purchase Request Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = "DG Purchase Request Header"."No.";
        }
        field(2; "Document Type"; Enum "DG Document Type Request")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetSearchFields(Rec."Item No.");
            end;
        }
        field(5; "Description"; Text[100])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Description 2"; Text[100])
        {
            Caption = 'Item Description 2';
            DataClassification = CustomerContent;
        }
        field(7; "Inventory Total"; Decimal)
        {
            Caption = 'Inventory Total';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Inventory Without Obs. Whs."; Decimal)
        {
            Caption = 'Inventory Without Obs. Whs.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(13; "Qty. to Requested"; Decimal)
        {
            Caption = 'Qty. to Requested';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Qty. to Requested" <> 0 then
                    "Order Status" := "Order Status"::Request
                else
                    "Order Status" := "Order Status"::" ";


                if not (("Qty. to Requested" + "Qty. Requested") <= Quantity) then
                    Error('Ya no puede');
            end;
        }
        field(14; "Qty. Requested"; Decimal)
        {
            Caption = 'Quantity Requested';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("DG Entry Purchase Request"."Quantity Requested" where("Document No." = field("Document No."), "Line No." = field("Line No.")));
        }
        field(15; "Vendor Code"; Code[20])
        {
            Caption = 'Vendor Code';
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(16; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
        }
        field(17; "Order Status"; Enum "DG Purchase Quote Status")
        {
            Caption = 'Order Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
            DataClassification = CustomerContent;
        }
        field(19; "User Id Authorized"; Code[50])
        {
            Caption = 'User Id Authorized';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; "Authorization Date"; Date)
        {
            Caption = 'User Id';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(21; "User Id"; Code[50])
        {
            Caption = 'User Id';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("DG Purchase Request Header"."User Id" where("No." = field("Document No.")));
        }
        field(22; "Create Date"; Date)
        {
            Caption = 'User Id';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("DG Purchase Request Header"."Create Date" where("No." = field("Document No.")));
        }
    }

    keys
    {
        key(PK; "Document No.", "Document Type", "Line No.")
        {
            Clustered = true;
        }
    }

    local procedure GetSearchFields(ItemNo: Code[20])
    var
        Item: Record Item;
        DGManagament: Codeunit "DG Managament";
        InventoryWithoutObsWhs: Decimal;
    begin
        if Item.Get(ItemNo) then begin
            Item.CalcFields(Inventory);
            Clear(InventoryWithoutObsWhs);
            DGManagament.GetQtyInventoryObsolete(ItemNo, InventoryWithoutObsWhs);

            Rec."Description" := Item.Description;
            Rec."Description 2" := Item.Description;
            Rec."Inventory Total" := Item.Inventory;
            Rec."Inventory Without Obs. Whs." := InventoryWithoutObsWhs;
            Rec."Base Unit of Measure" := Item."Base Unit of Measure";
            Rec."Unit Cost" := Item."Unit Cost";
            Rec."Inventory Posting Group" := Item."Inventory Posting Group";
            Rec."Request Date" := WorkDate();
        end else
            Clear(Item);
    end;

}