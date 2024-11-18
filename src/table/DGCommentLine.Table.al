table 80103 "DG Comment Line"
{
    DataClassification = CustomerContent;
    Caption = 'Comment line';
    DrillDownPageId = "DG Comment Line";
    LookupPageId = "DG Comment Line";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Line Document No."; Integer)
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; Comment; Text[80])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        NewLineNo();
    end;

    local procedure NewLineNo()
    var
        DGCommentLine: Record "DG Comment Line";
    begin
        DGCommentLine.Reset();
        DGCommentLine.SetRange("Document No.", "Document No.");
        DGCommentLine.SetRange("Line Document No.", "Line Document No.");
        if DGCommentLine.FindLast() then
            "Line No." := DGCommentLine."Line No." + 10000
        else
            "Line No." := 10000;
    end;

    procedure CopyComments(LineDocumentNo: Integer; FromNumber: Code[20]; ToNumber: Code[20]; NoLine: Integer)
    var
        DGCommentLine: Record "DG Comment Line";
        PurchCommentLine: Record "Purch. Comment Line";
    begin
        DGCommentLine.SetRange("Document No.", FromNumber);
        DGCommentLine.SetRange("Line Document No.", LineDocumentNo);
        if DGCommentLine.FindSet() then
            repeat
                PurchCommentLine.Init();
                PurchCommentLine."Document Type" := PurchCommentLine."Document Type"::Order;
                PurchCommentLine."No." := ToNumber;
                PurchCommentLine."Document Line No." := NoLine;
                PurchCommentLine."Line No." := DGCommentLine."Line No.";
                PurchCommentLine.Date := DGCommentLine.Date;
                PurchCommentLine.Comment := DGCommentLine.Comment;
                PurchCommentLine.Insert();
            until DGCommentLine.Next() = 0;
    end;
}