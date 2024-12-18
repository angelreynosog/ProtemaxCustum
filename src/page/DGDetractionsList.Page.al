page 80111 "DG Detractions List"
{
    ApplicationArea = All;
    Caption = 'DG Detractions List';
    PageType = List;
    CardPageId = "DG Detraction Card";
    SourceTable = "DG Detraction Header";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
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

                    if rec."File Name" = '' then
                        FileName := 'D' + CompanyInformation."VAT Registration No." + Rec."Code" + '.txt'
                    else
                        FileName := rec."File Name";

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
                            TxtAmount := CopyStr(Format(DGDetractionLine."Amount Document").Replace('.', '').PadLeft(13, '0') + '00', 1, 15);
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

                    if Rec."File Name" = '' then begin
                        Rec."File Name" := CopyStr(FileName, 1, 50);
                        Rec.Modify();
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
                    DGProcessPayment: Report "DG Process Payment";
                    Answer: Boolean;
                    Texto1Lbl: Label 'Payment processing insurance?';
                begin
                    if Rec.Close = true then
                        Message('The lot is applied')
                    else begin
                        Answer := Dialog.Confirm(Texto1Lbl, true);
                        if (Answer = true) then begin
                            DGProcessPayment.SetVariable(Rec."Code");
                            DGProcessPayment.Run();
                        end;
                    end;

                end;
            }
        }
    }
}