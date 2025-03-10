table 80104 "DG General Journal"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(6; "Month"; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        DGGeneralJournalLine: Record "DG General Journal Line";
    begin
        DGGeneralJournalLine.Reset();
        DGGeneralJournalLine.SetRange(Code, Rec.Code);
        DGGeneralJournalLine.DeleteAll();
    end;

    procedure PostedDGJournal(CodeIn: Code[20])
    begin
        if not DGSetupCustom.Get() then
            exit;

        DGSetupCustom.TestField("Jnl. Templ. Name Payroll");
        DGSetupCustom.TestField("Jnl Batch Name Payroll");

        ValidationDimension(CodeIn);
        InsertJournalLine(CodeIn);
    end;

    local procedure GenJlnLineLastLine(): Integer
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset();
        GenJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        GenJournalLine.SetRange("Journal Template Name", DGSetupCustom."Jnl. Templ. Name Payroll");
        GenJournalLine.SetRange("Journal Batch Name", DGSetupCustom."Jnl Batch Name Payroll");
        if not GenJournalLine.IsEmpty() then
            exit(GenJournalLine."Line No.");
    end;

    local procedure ValidationDimension(CodeIn: Code[20])
    var
        DGGeneralJournalLine: Record "DG General Journal Line";
        DimensionEmplyLbl: Label 'There are empty dimensions.';
    begin
        DGGeneralJournalLine.Reset();
        DGGeneralJournalLine.SetRange(Code, CodeIn);
        if DGGeneralJournalLine.FindSet() then
            repeat
                if (DGGeneralJournalLine."Dimension 1" = '') or (DGGeneralJournalLine."Dimension 2" = '') or (DGGeneralJournalLine."Dimension 4" = '') then
                    Error(DimensionEmplyLbl);
            until DGGeneralJournalLine.Next() = 0;
    end;

    local procedure InsertJournalLine(CodeIn: Code[20]): Boolean
    var
        GenJournalLine: Record "Gen. Journal Line";
        DGGeneralJournalLine: Record "DG General Journal Line";
        SuccessLbl: Label 'The lines have been correctly processed.';
    begin
        GenJournalLine.Reset();
        GenJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        GenJournalLine.SetRange("Journal Template Name", DGSetupCustom."Jnl. Templ. Name Payroll");
        GenJournalLine.SetRange("Journal Batch Name", DGSetupCustom."Jnl Batch Name Payroll");
        GenJournalLine.SetRange("Document No.", CodeIn);
        if not GenJournalLine.IsEmpty() then
            GenJournalLine.DeleteAll();

        GenJournalLine.Init();
        DGGeneralJournalLine.Reset();
        DGGeneralJournalLine.SetRange(Code, CodeIn);
        if DGGeneralJournalLine.FindSet() then
            repeat
                GenJournalLine."Journal Template Name" := DGSetupCustom."Jnl. Templ. Name Payroll";
                GenJournalLine."Journal Batch Name" := DGSetupCustom."Jnl Batch Name Payroll";
                GenJournalLine."Line No." := GenJlnLineLastLine() + 10000;
                GenJournalLine.Validate("Document No.", DGGeneralJournalLine.Code);
                GenJournalLine.Validate("Posting Date", Rec."End Date");
                GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::"G/L Account");
                GenJournalLine."Account No." := DGGeneralJournalLine."Account No.";
                GenJournalLine.Description := DGGeneralJournalLine.Description;
                GenJournalLine.Validate(Amount, DGGeneralJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DGGeneralJournalLine."Dimension 1";
                GenJournalLine."Shortcut Dimension 2 Code" := DGGeneralJournalLine."Dimension 2";
                DimensionIDTemp(GenJournalLine, DGGeneralJournalLine."Dimension 1", DGGeneralJournalLine."Dimension 2", DGGeneralJournalLine."Dimension 4");
                GenJournalLine.Insert();
            until DGGeneralJournalLine.Next() = 0;

        Message(SuccessLbl);
    end;

    local procedure DimensionIDTemp(GenJournalLine: Record "Gen. Journal Line"; Dimension1: Code[20]; Dimension2: Code[20]; Dimension4: Code[20])
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
        DimSetID: Integer;
    begin
        if not GeneralLedgerSetup.Get() then
            exit;

        Clear(DimSetID);

        TempDimensionSetEntry.DeleteAll();

        if Dimension1 <> '' then begin
            TempDimensionSetEntry.Init();
            TempDimensionSetEntry.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
            TempDimensionSetEntry.Validate("Dimension Value Code", Dimension1);
            TempDimensionSetEntry.Insert();
        end;

        if Dimension2 <> '' then begin
            TempDimensionSetEntry.Init();
            TempDimensionSetEntry.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
            TempDimensionSetEntry.Validate("Dimension Value Code", Dimension2);
            TempDimensionSetEntry.Insert();
        end;

        if Dimension4 <> '' then begin
            TempDimensionSetEntry.Init();
            TempDimensionSetEntry.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
            TempDimensionSetEntry.Validate("Dimension Value Code", Dimension4);
            TempDimensionSetEntry.Insert();
        end;

        DimSetID := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);

        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", DimSetID);
        if not DimensionSetEntry.IsEmpty then begin
            TempDimensionSetEntry.Reset();
            if TempDimensionSetEntry.FindSet() then
                repeat
                    DimensionSetEntry.Init();
                    DimensionSetEntry.Validate("Dimension Set ID", DimSetID);
                    DimensionSetEntry.Validate("Dimension Code", TempDimensionSetEntry."Dimension Code");
                    DimensionSetEntry.Validate("Dimension Value Code", TempDimensionSetEntry."Dimension Value Code");
                    DimensionSetEntry.Insert();
                until TempDimensionSetEntry.Next() = 0;
        end;

        if DimSetID <> 0 then
            GenJournalLine.Validate("Dimension Set ID", DimSetID);
    end;

    var
        DGSetupCustom: Record "DG Setup Custom";
        GeneralLedgerSetup: Record "General Ledger Setup";
}