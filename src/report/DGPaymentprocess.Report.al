namespace ProtemaxCustum.ProtemaxCustum;
using Microsoft.Bank.BankAccount;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Purchases.Setup;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Foundation.NoSeries;

report 80101 "DG Payment process"
{
    Caption = 'Payment process';
    Permissions = TableData "DG Detraction Lot" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = None;

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(_BatchCode; BatchCode)
                    {
                        Caption = 'Batch Code';
                        ToolTip = 'Batch Code';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(_PaymentDate; PaymentDate)
                    {
                        Caption = 'Payment Date';
                        ToolTip = 'Payment Date';
                        ApplicationArea = All;
                    }
                    field(_BankCode; BankCode)
                    {
                        Caption = 'Bank Code';
                        ToolTip = 'Bank Code';
                        ApplicationArea = All;
                        TableRelation = "Bank Account";
                    }
                    field(_OperationNumber; OperationNumber)
                    {
                        Caption = 'Operation Number';
                        ToolTip = 'Operation Number';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPreReport()
    var
        GenJournalLine: Record "Gen. Journal Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DGDetractionLot: Record "DG Detraction Lot";
        GenJournalBatch: Record "Gen. Journal Batch";
        DGDetractionLotDet: Record "DG Detraction Lot Det";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        NoSeries: Codeunit "No. Series";
        NroLinea: Integer;
        BatchText: Text[20];

    begin
        if BankCode = '' then Error('Bank selection is missing');
        if PaymentDate = 0D then Error('Payment date needs to be selected');
        if OperationNumber = '' then Error('An operation number must be selected');

        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Batch Payment Detraction");

        GenJournalLine.Reset();
        GenJournalLine.SetFilter("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetFilter("Journal Batch Name", PurchasesPayablesSetup."Batch Payment Detraction");

        NroLinea := 0;
        if (GenJournalLine.FindLast()) then
            NroLinea := GenJournalLine."Line No." + 10000
        else
            NroLinea := 10000;

        DGDetractionLotDet.Reset();
        DGDetractionLotDet.SetRange("Batch Code", BatchCode);

        if DGDetractionLotDet.FindSet() then begin
            repeat
                GenJournalBatch.Reset();
                GenJournalBatch.SetRange("Journal Template Name", 'PAYMENTS');
                GenJournalBatch.SetRange(Name, PurchasesPayablesSetup."Batch Payment Detraction");

                if GenJournalBatch.FindFirst() then
                    BatchText := GenJournalBatch."No. Series";

                GenJournalLine.Init();
                GenJournalLine.Validate("Journal Template Name", 'PAYMENTS');
                GenJournalLine.Validate("Journal Batch Name", PurchasesPayablesSetup."Batch Payment Detraction");

                GenJournalLine.Validate("Line No.", NroLinea);
                GenJournalLine.Validate("Posting Date", PaymentDate);
                GenJournalLine.Validate("Document No.", NoSeries.GetNextNo(BatchText));

                GenJournalLine.Validate("External Document No.", OperationNumber);
                GenJournalLine.Validate("Document Type", GenJournalLine."Document Type"::Payment);
                GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::Vendor);
                GenJournalLine.Validate("Account No.", DGDetractionLotDet."Vendor Code");

                GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
                GenJournalLine.Validate("Bal. Account No.", BankCode);
                GenJournalLine.Validate(Amount, DGDetractionLotDet."Purch Amount Detraction");
                GenJournalLine.Validate("Applies-to Doc. Type", GenJournalLine."Applies-to Doc. Type"::" ");
                GenJournalLine.Validate("Applies-to Doc. No.", DGDetractionLotDet."Transaction Number");
                GenJournalLine.Insert(true);
                NroLinea += 1000;
            until DGDetractionLotDet.Next() = 0;

            GenJnlPostBatch.Run(GenJournalLine);

            if DGDetractionLot.Get(BatchCode) then begin
                DGDetractionLot.Close := true;
                DGDetractionLot.Modify(true);
            end;


            Message('Payment processed');

        end;
    end;

    procedure SetVariable(vBatchCode: Text[20])
    begin
        BatchCode := vBatchCode;
    end;

    var
        BatchCode: Text[20];
        PaymentDate: Date;
        BankCode: Text[20];
        OperationNumber: Text[30];

}
