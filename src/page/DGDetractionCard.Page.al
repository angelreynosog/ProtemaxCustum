page 80112 "DG Detraction Card"
{
    Caption = 'DG Detraction Card';
    PageType = Document;
    UsageCategory = None;
    SourceTable = "DG Detraction Lot";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;

                field("Batch Code"; Rec."Batch Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
            part(DGDetractionList; "DG Detraction List")
            {
                ApplicationArea = All;
                SubPageLink = "Batch Code" = field("Batch Code");
                UpdatePropagation = Both;
                Caption = 'Lines';
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Documents")
            {
                Caption = 'Get Documents';
                ToolTip = ' ';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    PurchInvHeader: Record "Purch. Inv. Header";
                    DGDetractionLotDet: Record "DG Detraction Lot Det";
                    GeneralLedgerSetup: Record "General Ledger Setup";

                    Line: Integer;
                    Answer: Boolean;
                    Texto1Lbl: Label 'Are you sure you can get detraction documents?';
                begin
                    GeneralLedgerSetup.Get();
                    if rec."Start Date" = 0D then
                        Error('Select start date');

                    if rec."End Date" = 0D then
                        Error('Select end date');

                    Answer := Dialog.Confirm(Texto1Lbl, true);

                    if (Answer = true) then begin
                        VendorLedgerEntry.Reset();
                        VendorLedgerEntry.SetRange("Document Date", rec."Start Date", rec."End Date");
                        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::" ");
                        VendorLedgerEntry.SetRange("Vendor Posting Group", GeneralLedgerSetup."Detraction Posting Group");
                        VendorLedgerEntry.SetRange(Open, true);

                        DGDetractionLotDet.SetRange("Batch Code", rec."Batch Code");
                        if DGDetractionLotDet.FindFirst() then
                            DGDetractionLotDet.DeleteAll();

                        Line := 1000;
                        if VendorLedgerEntry.FindSet() then
                            repeat
                                VendorLedgerEntry.CalcFields("Remaining Amount");
                                if VendorLedgerEntry."Remaining Amount" <> 0 then begin
                                    PurchInvHeader.Reset();
                                    PurchInvHeader.SetRange("Buy-from Vendor No.", VendorLedgerEntry."Vendor No.");
                                    PurchInvHeader.SetRange("No.", VendorLedgerEntry."Document No.");

                                    if PurchInvHeader.FindFirst() then begin
                                        DGDetractionLotDet.Reset();
                                        DGDetractionLotDet.SetRange("Vendor Code", PurchInvHeader."Buy-from Vendor No.");
                                        DGDetractionLotDet.SetRange("Transaction Number", PurchInvHeader."No.");

                                        if DGDetractionLotDet.FindFirst() = false then begin
                                            DGDetractionLotDet.Init();
                                            DGDetractionLotDet."Batch Code" := rec."Batch Code";
                                            DGDetractionLotDet."Line Number" := Line;
                                            DGDetractionLotDet."Vendor Code" := PurchInvHeader."Buy-from Vendor No.";
                                            DGDetractionLotDet."Vendor Name" := PurchInvHeader."Buy-from Vendor Name";
                                            DGDetractionLotDet."Transaction Number" := PurchInvHeader."No.";
                                            DGDetractionLotDet."Document Type Sunat" := PurchInvHeader."SUNAT Document";
                                            DGDetractionLotDet."Document Number" := PurchInvHeader."Vendor Invoice No.";

                                            PurchInvHeader.CalcFields("Amount Including VAT");

                                            if PurchInvHeader."Currency Code" = '' then
                                                DGDetractionLotDet."Currency Id" := 'PEN'
                                            else
                                                DGDetractionLotDet."Currency Id" := PurchInvHeader."Currency Code";

                                            if PurchInvHeader."Currency Code" = '' then
                                                DGDetractionLotDet."Document Amount" := PurchInvHeader."Amount Including VAT"
                                            else
                                                DGDetractionLotDet."Document Amount" := Round(PurchInvHeader."Amount Including VAT" * (1 / PurchInvHeader."Currency Factor"), 0.01);



                                            DGDetractionLotDet."Type of Operation" := PurchInvHeader."Type of Operation";
                                            DGDetractionLotDet."Type of Service" := PurchInvHeader."Type of Service";
                                            DGDetractionLotDet."Purch % Detraction" := PurchInvHeader."Purch % Detraction";

                                            if PurchInvHeader."Currency Code" = '' then
                                                DGDetractionLotDet."Purch Amount Detraction" := PurchInvHeader."Purch Amount Detraction"
                                            else
                                                DGDetractionLotDet."Purch Amount Detraction" := PurchInvHeader."Purch Amount Detraction (LCY)";

                                            DGDetractionLotDet."Document Date" := PurchInvHeader."Document Date";

                                            DGDetractionLotDet.Insert();
                                            Line += 1000;
                                        end;
                                    end;
                                end;
                            until VendorLedgerEntry.Next() = 0;
                    end;
                end;
            }


            action("Generate Text File")
            {
                Caption = 'Generate Text File';
                ToolTip = ' ';
                Image = ExportFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CompanyInformation: Record "Company Information";
                    DGDetractionLotDet: Record "DG Detraction Lot Det";
                    Vendor: Record Vendor;
                    TempBlob: Codeunit "Temp Blob";
                    PeruvianBooks: Codeunit "Peruvian Books";
                    InS: InStream;
                    OutS: OutStream;
                    FileName: Text;
                    TxtBuilder: TextBuilder;
                    TxtAmount: Text[15];
                    DateText: Text[6];
                    SerieText: Text[10];
                    NumberText: Text[20];
                begin
                    CompanyInformation.Get();

                    if rec."File Name" = '' then
                        FileName := 'D' + CompanyInformation."VAT Registration No." + rec."Batch Code" + '.txt'
                    else
                        FileName := rec."File Name";

                    TxtAmount := '';
                    Rec.CalcFields("Total Amount");
                    TxtAmount := CopyStr(Format(rec."Total Amount").Replace('.', '').PadLeft(13, '0') + '00', 1, 15);

                    TxtBuilder.AppendLine('*' + CopyStr(CompanyInformation."VAT Registration No.", 1, 11) + CopyStr(CompanyInformation.Name, 1, 35).PadRight(35, ' ') + REC."Batch Code" + TxtAmount);

                    DGDetractionLotDet.Reset();
                    DGDetractionLotDet.SetRange("Batch Code", rec."Batch Code");

                    if DGDetractionLotDet.FindSet() then
                        repeat

                            Vendor.Get(DGDetractionLotDet."Vendor Code");
                            TxtAmount := '';
                            TxtAmount := CopyStr(Format(DGDetractionLotDet."Purch Amount Detraction").Replace('.', '').PadLeft(13, '0') + '00', 1, 15);

                            DateText := '';
                            DateText := Format(DGDetractionLotDet."Document Date", 6, '<Year4><Month,2>');

                            PeruvianBooks."#SetDocSerie"(DGDetractionLotDet."Document Number", SerieText, NumberText);

                            TxtBuilder.AppendLine(CopyStr(
                            Vendor."SUNAT Document", 1, 1) +
                            CopyStr(DGDetractionLotDet."Vendor Code", 1, 11) +
                            CopyStr(DGDetractionLotDet."Vendor Name", 1, 35).PadRight(35, ' ') +
                            '000000000' +
                            CopyStr(DGDetractionLotDet."Type of Service", 1, 3) +
                            '11111111111' + //Cuenta bancaria
                            TxtAmount +
                            CopyStr(DGDetractionLotDet."Type of Operation", 1, 2) +
                            DateText +
                            CopyStr(DGDetractionLotDet."Document Type Sunat", 1, 2) +
                            CopyStr(SerieText.PadLeft(4, '0'), 1, 4) +
                            CopyStr(NumberText.PadLeft(8, '0'), 1, 8)
                            );
                        until DGDetractionLotDet.Next() = 0;

                    TempBlob.CreateOutStream(OutS);
                    OutS.WriteText(TxtBuilder.ToText());
                    TempBlob.CreateInStream(InS);
                    DownloadFromStream(InS, '', '', '', FileName);

                    if rec."File Name" = '' then begin
                        rec."File Name" := CopyStr(FileName, 1, 50);
                        rec.Modify();
                    end;
                end;
            }
        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("DG Serie Batch Code");

        Rec."Batch Code" := NoSeries.GetNextNo(PurchasesPayablesSetup."DG Serie Batch Code");
    end;

}