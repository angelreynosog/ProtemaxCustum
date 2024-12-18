table 80106 "DG Detraction Header"
{
    Caption = 'Detraction Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(4; "Quantity Record"; Integer)
        {
            Caption = 'Quantity Record';
            FieldClass = FlowField;
            CalcFormula = count("DG Detraction Line" where("Detraction Code" = field("Code")));
        }
        field(5; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("DG Detraction Line"."Amount Document" where("Detraction Code" = field("Code")));
        }
        field(6; "File Name"; Text[50])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
        }
        field(7; Close; Boolean)
        {
            Caption = 'Close';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        DGDetractionLine: Record "DG Detraction Line";
    begin
        DGDetractionLine.Reset();
        DGDetractionLine.SetRange("Detraction Code", Rec."Code");
        if DGDetractionLine.FindSet() then
            DGDetractionLine.DeleteAll();
    end;
}