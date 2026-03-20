table 80112 "DG Relation Sales & OT Line"
{
    Caption = 'Relation Sales & OT Line';
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Order Word Document"; Text[100])
        {
            Caption = 'Order Word Document';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
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
            var
                Item: Record Item;
            begin
                if Type = Type::Item then
                    if Item.Get("No.") then
                        "Posting Group" := Item."Inventory Posting Group";
            end;
        }
        field(6; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(8; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(9; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
            DataClassification = CustomerContent;
        }
        field(10; "Status CRM"; Option)
        {
            Caption = 'Status BC';
            OptionMembers = ,Registered,Completed;
            OptionCaption = ' ,Registered,Completed';
            DataClassification = CustomerContent;
        }
        field(11; "Assembly Order No."; Code[20])
        {
            Caption = 'Assembly Order No.';
            DataClassification = CustomerContent;
        }
        field(12; "Posted Assembly Order No."; Code[20])
        {
            Caption = 'Posted Assembly Order No.';
            DataClassification = CustomerContent;
        }
        field(13; "Ready Posted"; Boolean)
        {
            Caption = 'Ready Posted';
            DataClassification = CustomerContent;
        }
        field(14; "Canceled Posted"; Boolean)
        {
            Caption = 'Canceled Posted';
            DataClassification = CustomerContent;
        }
        field(15; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Order Word Document", "Line No.")
        {
            Clustered = true;
        }
    }
}