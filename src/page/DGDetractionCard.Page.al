page 80112 "DG Detraction Card"
{
    Caption = 'DG Detraction Card';
    PageType = Document;
    UsageCategory = None;
    SourceTable = "DG Detraction Header";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;

                field("Code"; Rec."Code")
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
            part(DGDetractionList; "DG Detraction Line")
            {
                ApplicationArea = All;
                SubPageLink = "Detraction Code" = field("Code");
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
                    DGDetractionLine: Record "DG Detraction Line";
                    GeneralLedgerSetup: Record "General Ledger Setup";

                    Line: Integer;
                    Answer: Boolean;
                    Texto1Lbl: Label 'Are you sure you can get detraction documents?';
                begin
                    GeneralLedgerSetup.Get();
                    if Rec."Start Date" = 0D then
                        Error('Select start date');

                    if Rec."End Date" = 0D then
                        Error('Select end date');

                    Answer := Dialog.Confirm(Texto1Lbl, true);

                    if (Answer = true) then begin
                        VendorLedgerEntry.Reset();
                        VendorLedgerEntry.SetRange("Document Date", rec."Start Date", rec."End Date");
                        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::" ");
                        VendorLedgerEntry.SetRange("Vendor Posting Group", GeneralLedgerSetup."Detraction Posting Group");
                        VendorLedgerEntry.SetRange(Open, true);

                        DGDetractionLine.SetRange("Detraction Code", Rec."Code");
                        if DGDetractionLine.FindSet() then
                            DGDetractionLine.DeleteAll();

                        Line := 1000;
                        if VendorLedgerEntry.FindSet() then
                            repeat
                                VendorLedgerEntry.CalcFields("Remaining Amount");
                                if VendorLedgerEntry."Remaining Amount" <> 0 then begin
                                    PurchInvHeader.Reset();
                                    PurchInvHeader.SetRange("Buy-from Vendor No.", VendorLedgerEntry."Vendor No.");
                                    PurchInvHeader.SetRange("No.", VendorLedgerEntry."Document No.");
                                    if PurchInvHeader.FindSet() then begin
                                        DGDetractionLine.Reset();
                                        DGDetractionLine.SetRange("Vendor Code", PurchInvHeader."Buy-from Vendor No.");
                                        DGDetractionLine.SetRange("Transaction Number", PurchInvHeader."No.");
                                        if DGDetractionLine.FindSet() = false then begin
                                            DGDetractionLine.Init();
                                            DGDetractionLine."Detraction Code" := Rec."Code";
                                            DGDetractionLine."Line" := Line;
                                            DGDetractionLine."Vendor Code" := PurchInvHeader."Buy-from Vendor No.";
                                            DGDetractionLine."Vendor Name" := PurchInvHeader."Buy-from Vendor Name";
                                            DGDetractionLine."Transaction Number" := PurchInvHeader."No.";
                                            DGDetractionLine."Document Type Sunat" := PurchInvHeader."SUNAT Document";
                                            DGDetractionLine."Document No." := PurchInvHeader."Vendor Invoice No.";
                                            DGDetractionLine."Type of Operation" := PurchInvHeader."Type of Operation";
                                            DGDetractionLine."Type of Service" := PurchInvHeader."Type of Service";
                                            DGDetractionLine."Purch. % Detraction" := PurchInvHeader."Purch % Detraction";
                                            DGDetractionLine."Document Date" := PurchInvHeader."Document Date";

                                            PurchInvHeader.CalcFields("Amount Including VAT");

                                            if PurchInvHeader."Currency Code" = '' then begin
                                                DGDetractionLine."Currency Code" := 'PEN';
                                                DGDetractionLine."Amount Document" := PurchInvHeader."Amount Including VAT";
                                                DGDetractionLine."Purch. Amount Detraction" := PurchInvHeader."Purch Amount Detraction";
                                            end else begin
                                                DGDetractionLine."Currency Code" := PurchInvHeader."Currency Code";
                                                DGDetractionLine."Amount Document" := Round(PurchInvHeader."Amount Including VAT" * (1 / PurchInvHeader."Currency Factor"), 0.01);
                                                DGDetractionLine."Purch. Amount Detraction" := PurchInvHeader."Purch Amount Detraction (LCY)";
                                            end;

                                            DGDetractionLine.Insert();
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
                    DGDetractionLine: Record "DG Detraction Line";
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

                    if Rec."File Name" = '' then
                        FileName := 'D' + CompanyInformation."VAT Registration No." + Rec."Code" + '.txt'
                    else
                        FileName := Rec."File Name";

                    TxtAmount := '';
                    Rec.CalcFields("Total Amount");
                    TxtAmount := CopyStr(Format(rec."Total Amount").Replace('.', '').PadLeft(13, '0') + '00', 1, 15);

                    TxtBuilder.AppendLine('*' + CopyStr(CompanyInformation."VAT Registration No.", 1, 11) + CopyStr(CompanyInformation.Name, 1, 35).PadRight(35, ' ') + Rec."Code" + TxtAmount);

                    DGDetractionLine.Reset();
                    DGDetractionLine.SetRange("Detraction Code", Rec."Code");
                    if DGDetractionLine.FindSet() then
                        repeat

                            if not Vendor.Get(DGDetractionLine."Vendor Code") then
                                exit;
                            TxtAmount := '';
                            TxtAmount := CopyStr(Format(DGDetractionLine."Purch. Amount Detraction").Replace('.', '').PadLeft(13, '0') + '00', 1, 15);
                            DateText := '';
                            DateText := Format(DGDetractionLine."Document Date", 6, '<Year4><Month,2>');
                            PeruvianBooks."#SetDocSerie"(DGDetractionLine."Document No.", SerieText, NumberText);

                            TxtBuilder.AppendLine(CopyStr(
                            Vendor."SUNAT Document", 1, 1) +
                            CopyStr(DGDetractionLine."Vendor Code", 1, 11) +
                            CopyStr(DGDetractionLine."Vendor Name", 1, 35).PadRight(35, ' ') +
                            '000000000' +
                            CopyStr(DGDetractionLine."Type of Service", 1, 3) +
                            '11111111111' + //Cuenta bancaria
                            TxtAmount +
                            CopyStr(DGDetractionLine."Type of Operation", 1, 2) +
                            DateText +
                            CopyStr(DGDetractionLine."Document Type Sunat", 1, 2) +
                            CopyStr(SerieText.PadLeft(4, '0'), 1, 4) +
                            CopyStr(NumberText.PadLeft(8, '0'), 1, 8)
                            );
                        until DGDetractionLine.Next() = 0;

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
        Rec."Code" := NoSeries.GetNextNo(PurchasesPayablesSetup."DG Serie Batch Code");
    end;

}