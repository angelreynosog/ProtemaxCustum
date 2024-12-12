page 80111 "DG List of Detractions"
{
    ApplicationArea = All;
    Caption = 'Filing and payment of Detracctions';
    PageType = List;
    CardPageId = "DG Detraction Card";
    SourceTable = "DG Detraction Lot";
    UsageCategory = Lists;
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Batch Code"; Rec."Batch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Batch Code field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start End field.';
                }
                field("Quantity Record"; Rec."Quantity Record")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Record field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(Close; Rec.Close)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Close field.';
                }

            }
        }
    }


    actions
    {
        area(Processing)
        {
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

            action("Detraction Payment")
            {
                Caption = 'Detraction Payment';
                ToolTip = ' ';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    DGPaymentprocess: Report "DG Payment process";
                    Answer: Boolean;
                    Texto1Lbl: Label 'Payment processing insurance?';
                begin
                    if Rec.Close = true then
                        Message('The lot is applied')
                    else begin
                        Answer := Dialog.Confirm(Texto1Lbl, true);
                        if (Answer = true) then begin
                            DGPaymentprocess.SetVariable(rec."Batch Code");
                            DGPaymentprocess.Run();
                        end;
                    end;

                end;
            }
        }
    }
}