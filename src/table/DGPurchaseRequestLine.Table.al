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
        field(3; Type; Enum "Purchase Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';

            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const(Item)) Item where(Blocked = const(false))
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const("Allocation Account")) "Allocation Account"
            else
            if (Type = const(Resource)) Resource;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetSearchFields(Rec."No.");
            end;
        }
        field(6; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
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
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(11; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(12; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(14; "Qty. to Requested"; Decimal)
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
        field(15; "Qty. Requested"; Decimal)
        {
            Caption = 'Quantity Requested';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("DG Entry Purchase Request"."Quantity Requested" where("Document No." = field("Document No."), "Line No." = field("Line No.")));
        }
        field(16; "Vendor Code"; Code[20])
        {
            Caption = 'Vendor Code';
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(17; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
        }
        field(18; "Order Status"; Enum "DG Purchase Quote Status")
        {
            Caption = 'Order Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order), "DG Request No." = field("Document No."));
            DataClassification = CustomerContent;
        }
        field(22; "User Id"; Code[50])
        {
            Caption = 'User Id';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("DG Purchase Request Header"."User Id" where("No." = field("Document No.")));
        }
        field(23; "Create Date"; Date)
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

    trigger OnModify()
    var
        DGPurchaseRequestHeader: Record "DG Purchase Request Header";
        User: Record User;
        UserSetup: Record "User Setup";
        RequestNotApprovedLbl: Label 'You cannot modify this request, it is already approved.';
    begin
        DGPurchaseRequestHeader.Reset();
        DGPurchaseRequestHeader.SetRange("No.", Rec."Document No.");
        DGPurchaseRequestHeader.SetRange("Document Type", Rec."Document Type");
        DGPurchaseRequestHeader.SetRange("Status Request", DGPurchaseRequestHeader."Status Request"::Approved);
        if not DGPurchaseRequestHeader.IsEmpty then begin
            User.Reset();
            User.SetRange("User Name", UserId);
            User.SetRange(State, User.State::Enabled);
            if User.FindFirst() then begin
                UserSetup.Reset();
                UserSetup.SetRange("User ID", User."User Name");
                UserSetup.SetRange("DG Approver Requestor OC", true);
                if UserSetup.IsEmpty then
                    Error(RequestNotApprovedLbl);
            end;
        end;
    end;

    local procedure GetSearchFields(No: Code[20])
    var
        Item: Record Item;
        GLAccount: Record "G/L Account";
        FixedAsset: Record "Fixed Asset";
        DGManagament: Codeunit "DG Managament";
        InventoryWithoutObsWhs: Decimal;
    begin
        case Type of
            "Purchase Line Type"::Item:
                if Item.Get(No) then begin
                    Item.CalcFields(Inventory);
                    Clear(InventoryWithoutObsWhs);
                    DGManagament.GetQtyInventoryObsolete(No, InventoryWithoutObsWhs);
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
            "Purchase Line Type"::"G/L Account":
                if GLAccount.Get(No) then begin
                    Rec."Description" := GLAccount.Name;
                    Rec."Description 2" := GLAccount.Name;
                    Rec."Inventory Total" := 0;
                    Rec."Inventory Without Obs. Whs." := 0;
                    Rec."Base Unit of Measure" := '';
                    Rec."Unit Cost" := 0;
                    Rec."Inventory Posting Group" := '';
                    Rec."Request Date" := WorkDate();
                end else
                    Clear(GLAccount);
            "Purchase Line Type"::"Fixed Asset":
                if FixedAsset.Get(No) then begin
                    Rec."Description" := FixedAsset.Description;
                    Rec."Description 2" := FixedAsset.Description;
                    Rec."Inventory Total" := 0;
                    Rec."Inventory Without Obs. Whs." := 0;
                    Rec."Base Unit of Measure" := '';
                    Rec."Unit Cost" := 0;
                    Rec."Inventory Posting Group" := '';
                    Rec."Request Date" := WorkDate();
                end else
                    Clear(FixedAsset);
        end;
    end;



}