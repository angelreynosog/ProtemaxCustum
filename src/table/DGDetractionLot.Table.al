table 80106 "DG Detraction Lot"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Batch Code"; Code[20])
        {
            Caption = 'Batch Code';
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
            CalcFormula = count("DG Detraction Lot Det" where("Batch Code" = field("Batch Code")));
        }
        field(5; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("DG Detraction Lot Det"."Purch Amount Detraction" where("Batch Code" = field("Batch Code")));
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
        key(Key1; "Batch Code")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        DGDetractionLotDet: Record "DG Detraction Lot Det";
    begin
        DGDetractionLotDet.Reset();
        DGDetractionLotDet.SetRange("Batch Code", rec."Batch Code");

        if DGDetractionLotDet.FindFirst() then
            DGDetractionLotDet.DeleteAll();
    end;
}