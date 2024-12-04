report 80100 "DG Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/Layout/DG Order.rdl';
    Caption = 'Order';
    PreviewMode = PrintLayout;
    WordMergeDataItem = "Purchase Header";
    UsageCategory = None;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(DocType_PurchHeader; "Document Type")
            { }
            column(No_PurchHeader; "No.")
            { }
            column(AmountCaption; AmountCaptionLbl)
            { }
            column(PurchLineInvDiscAmtCaption; PurchLineInvDiscAmtCaptionLbl)
            { }
            column(SubtotalCaption; SubtotalCaptionLbl)
            { }
            column(VATAmtLineVATCaption; VATAmtLineVATCaptionLbl)
            { }
            column(VATAmtLineVATAmtCaption; VATAmtLineVATAmtCaptionLbl)
            { }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            { }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            { }
            column(VATAmtLineInvDiscBaseAmtCaption; VATAmtLineInvDiscBaseAmtCaptionLbl)
            { }
            column(VATAmtLineLineAmtCaption; VATAmtLineLineAmtCaptionLbl)
            { }
            column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
            { }
            column(TotalCaption; TotalCaptionLbl)
            { }
            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            { }
            column(ShipmentMethodDescCaption; ShipmentMethodDescCaptionLbl)
            { }
            column(PrepymtTermsDescCaption; PrepymtTermsDescCaptionLbl)
            { }
            column(HomePageCaption; HomePageCaptionLbl)
            { }
            column(EmailIDCaption; EmailIDCaptionLbl)
            { }
            column(AllowInvoiceDiscCaption; AllowInvoiceDiscCaptionLbl)
            { }
            column(BuyFromContactPhoneNoLbl; BuyFromContactPhoneNoLbl)
            { }
            column(BuyFromContactMobilePhoneNoLbl; BuyFromContactMobilePhoneNoLbl)
            { }
            column(BuyFromContactEmailLbl; BuyFromContactEmailLbl)
            { }
            column(PayToContactPhoneNoLbl; PayToContactPhoneNoLbl)
            { }
            column(PayToContactMobilePhoneNoLbl; PayToContactMobilePhoneNoLbl)
            { }
            column(PayToContactEmailLbl; PayToContactEmailLbl)
            { }
            column(BuyFromContactPhoneNo; BuyFromContact."Phone No.")
            { }
            column(BuyFromContactMobilePhoneNo; BuyFromContact."Mobile Phone No.")
            { }
            column(BuyFromContactEmail; BuyFromContact."E-Mail")
            { }
            column(PayToContactPhoneNo; PayToContact."Phone No.")
            { }
            column(PayToContactMobilePhoneNo; PayToContact."Mobile Phone No.")
            { }
            column(PayToContactEmail; PayToContact."E-Mail")
            { }
            column(IGVIdentifierCaption; IGVIdentifierCaptionLbl)
            { }
            column(IGVAmtLineIGVAmtCaption; IGVAmtLineIGVAmtCaptionLbl)
            { }
            column(IGVAmtLineIGVCaption; IGVAmtLineIGVCaptionLbl)
            { }
            column(VALIGVBaseLCYCaption; VALIGVBaseLCYCaptionLbl)
            { }
            column(IGVAmtSpecCaption; IGVAmtSpecCaptionLbl)
            { }
            column(PaymentMethodDescCaption; PaymentMethodDescCaptionLbl)
            { }
            column(BusinessLine; "Shortcut Dimension 1 Code")
            { }
            column(CostCenter; "Shortcut Dimension 2 Code")
            { }
            column(BusinessLineCaption; BusinessLineCaptionLbl)
            { }
            column(CostCenterCaption; CostCenterCaptionLbl)
            { }
            column(CommentCaption; CommentCaptionLbl)
            { }

            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReportTitleCopyText; StrSubstNo(Text004Lbl, CopyText))
                    { }
                    column(CompanyAddr1; CompanyAddr[1])
                    { }
                    column(CompanyAddr2; CompanyAddr[2])
                    { }
                    column(CompanyAddr3; CompanyAddr[3])
                    { }
                    column(CompanyAddr4; CompanyAddr[4])
                    { }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    { }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    { }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    { }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    { }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    { }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    { }
                    column(DocDate_PurchHeader; "Purchase Header"."Document Date")
                    { }
                    column(VATNoText; VATNoText)
                    { }
                    column(VATRegNo_PurchHeader; "Purchase Header"."VAT Registration No.")
                    { }
                    column(PurchaserText; PurchaserText)
                    { }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    { }
                    column(ReferenceText; ReferenceText)
                    { }
                    column(YourRef_PurchHeader; "Purchase Header"."Your Reference")
                    { }
                    column(CompanyAddr5; CompanyAddr[5])
                    { }
                    column(CompanyAddr6; CompanyAddr[6])
                    { }
                    column(CompanyAddr7; CompanyAddr[7])
                    { }
                    column(CompanyAddr8; CompanyAddr[8])
                    { }
                    column(BuyFrmVendNo_PurchHeader; "Purchase Header"."Buy-from Vendor No.")
                    { }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    { }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    { }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    { }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    { }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    { }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    { }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    { }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    { }
                    column(PricesInclVAT_PurchHeader; "Purchase Header"."Prices Including VAT")
                    { }
                    column(OutputNo; OutputNo)
                    { }
                    column(VATBaseDisc_PurchHeader; "Purchase Header"."VAT Base Discount %")
                    { }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    { }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    { }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    { }
                    column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
                    { }
                    column(ShowInternalInfo; ShowInternalInfo)
                    { }
                    column(TotalText; TotalText)
                    { }
                    column(DimText; DimText)
                    { }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    { }
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    { }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    { }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    { }
                    column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                    { }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    { }
                    column(PageCaption; PageCaptionLbl)
                    { }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    { }
                    column(BuyFrmVendNo_PurchHeaderCaption; "Purchase Header".FieldCaption("Buy-from Vendor No."))
                    { }
                    column(PricesInclVAT_PurchHeaderCaption; "Purchase Header".FieldCaption("Prices Including VAT"))
                    { }
                    column(PricesInclIGV_PurchHeaderCaption; PriceIGVIncludingLbl)
                    { }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    { }
                    column(PaymentMethDesc; PaymentMethod.Description)
                    { }
                    column(Comment_PurchHeader; GetCommentPurchHeader("Purchase Header"."Document Type", "Purchase Header"."No."))
                    { }
                    column("PurchHeaderInv_Rec_Date"; "Purchase Header"."Invoice Received Date")
                    { }
                    column("PurchHeaderShipt_To_Name"; ShipToName)
                    { }
                    column("PurchHeaderShipt_To_Address"; ShipToAddress)
                    { }
                    column(PurchHeaderShipt_To_Address2; ShipToAddress2)
                    { }
                    column(PurchHeaderShipt_To_City; ShipToCity)
                    { }
                    column(PurchHeaderShipt_To_Post_Code; ShipToPostalCode)
                    { }
                    column(PurchHeaderShipt_To_Country_Code; ShipToCountry)
                    { }
                    column(PurchHeaderCurrencyCode; CurrencyCode)
                    { }
                    column(PurchHeader_CurrencyCaption; CurrencyLbl)
                    { }
                    column(VendorText; VendorTextLbl)
                    { }
                    column(ShipToVendorText; ShipToVendorTextLbl)
                    { }
                    column(AmountLetter; StrSubstNo('%1 %2%3 %4', AreLbl, AmountLetter1[1], AmountLetter2, AmountLetter3))
                    { }
                    column(FooterOrderText; PurchSetup."DG Purchase Order Footer Text")
                    { }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl)
                        { }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet() then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := CopyStr(DimText, 1, 75);
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText := CopyStr(
                                      StrSubstNo(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code"), 1, 120);
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.Next() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(LineAmt_PurchLine; TempPurchaseLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineNo_PurchLine; "Purchase Line"."Line No.")
                        { }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        { }
                        column(Type_PurchLine; Format("Purchase Line".Type, 0, 2))
                        { }
                        column(No_PurchLine; "Purchase Line"."No.")
                        { }
                        column(Desc_PurchLine; "Purchase Line".Description)
                        { }
                        column(Qty_PurchLine; "Purchase Line".Quantity)
                        { }
                        column(UOM_PurchLine; "Purchase Line"."Unit of Measure")
                        { }
                        column(DirUnitCost_PurchLine; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchLine; "Purchase Line"."Line Discount %")
                        { }
                        column(LineAmt2_PurchLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_PurchLine; "Purchase Line"."Allow Invoice Disc.")
                        { }
                        column(HomePage; '')
                        { }
                        column(EMail; CompanyInfo."E-Mail")
                        { }
                        column(VATIdentifier_PurchLine; "Purchase Line"."VAT Identifier")
                        { }
                        column(InvDiscAmt_PurchLine; -TempPurchaseLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVAT; TempPurchaseLine."Line Amount" - TempPurchaseLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        { }
                        column(VATAmountText; TempVATAmountLine.VATAmountText())
                        { }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        { }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DirectUniCostCaption; DirectUniCostCaptionLbl)
                        { }
                        column(PurchLineLineDiscCaption; PurchLineLineDiscCaptionLbl)
                        { }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        { }
                        column(No_PurchLineCaption; "Purchase Line".FieldCaption("No."))
                        { }
                        column(Desc_PurchLineCaption; "Purchase Line".FieldCaption(Description))
                        { }
                        column(Qty_PurchLineCaption; "Purchase Line".FieldCaption(Quantity))
                        { }
                        column(UOM_PurchLineCaption; "Purchase Line".FieldCaption("Unit of Measure"))
                        { }
                        column(VATIdentifier_PurchLineCaption; "Purchase Line".FieldCaption("VAT Identifier"))
                        { }
                        column(Comment_PurchLine; GetCommentPurchLine("Purchase Line"."Document Type", "Purchase Line"."Document No.", "Purchase Line"."Line No."))
                        { }
                        column(RequestReceiptDate_PurchLineCaption; "Purchase Line".FieldCaption("Requested Receipt Date"))
                        { }
                        column(RequestReceiptDate_PurchLine; "Purchase Line"."Requested Receipt Date")
                        { }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                            column(LineDimCaption; LineDimCaptionLbl)
                            { }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := CopyStr(DimText, 1, 75);
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText := CopyStr(
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code"), 1, 120);
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();

                                DimSetEntry2.SetRange("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                TempPurchaseLine.Find('-')
                            else
                                TempPurchaseLine.Next();
                            "Purchase Line" := TempPurchaseLine;

                            if not "Purchase Header"."Prices Including VAT" and
                               (TempPurchaseLine."VAT Calculation Type" = TempPurchaseLine."VAT Calculation Type"::"Full VAT")
                            then
                                TempPurchaseLine."Line Amount" := 0;

                            if ("Purchase Line"."Item Reference No." <> '') and (not ShowInternalInfo) then
                                "Purchase Line"."No." :=
                                    CopyStr("Purchase Line"."Item Reference No.", 1, MaxStrLen("Purchase Line"."No."));
                            if (TempPurchaseLine.Type = TempPurchaseLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Purchase Line"."No." := '';
                            AllowInvDisctxt := Format("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempPurchaseLine.DeleteAll();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempPurchaseLine.Find('+');
                            while MoreLines and (TempPurchaseLine.Description = '') and (TempPurchaseLine."Description 2" = '') and
                                  (TempPurchaseLine."No." = '') and (TempPurchaseLine.Quantity = 0) and
                                  (TempPurchaseLine.Amount = 0)
                            do
                                MoreLines := TempPurchaseLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            TempPurchaseLine.SetRange("Line No.", 0, TempPurchaseLine."Line No.");
                            SetRange(Number, 1, TempPurchaseLine.Count);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        { }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmount = 0 then
                                CurrReport.Break();
                            SetRange(Number, 1, TempVATAmountLine.Count);
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(VALExchRate; VALExchRate)
                        { }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        { }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Purchase Header"."Currency Code" = '') or
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.Break();

                            SetRange(Number, 1, TempVATAmountLine.Count);
                            Clear(VALVATBaseLCY);
                            Clear(VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007Lbl + Text008Lbl
                            else
                                VALSpecLCYHeader := Text007Lbl + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := StrSubstNo(Text009Lbl, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(PayToVendNo_PurchHeader; "Purchase Header"."Pay-to Vendor No.")
                        { }
                        column(VendAddr8; VendAddr[8])
                        { }
                        column(VendAddr7; VendAddr[7])
                        { }
                        column(VendAddr6; VendAddr[6])
                        { }
                        column(VendAddr5; VendAddr[5])
                        { }
                        column(VendAddr4; VendAddr[4])
                        { }
                        column(VendAddr3; VendAddr[3])
                        { }
                        column(VendAddr2; VendAddr[2])
                        { }
                        column(VendAddr1; VendAddr[1])
                        { }
                        column(PaymentDetailsCaption; PaymentDetailsCaptionLbl)
                        { }
                        column(VendNoCaption; VendNoCaptionLbl)
                        { }

                        trigger OnPreDataItem()
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(Total3; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(SellToCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.")
                        { }
                        column(ShipToAddr1; ShipToAddr[1])
                        { }
                        column(ShipToAddr2; ShipToAddr[2])
                        { }
                        column(ShipToAddr3; ShipToAddr[3])
                        { }
                        column(ShipToAddr4; ShipToAddr[4])
                        { }
                        column(ShipToAddr5; ShipToAddr[5])
                        { }
                        column(ShipToAddr6; ShipToAddr[6])
                        { }
                        column(ShipToAddr7; ShipToAddr[7])
                        { }
                        column(ShipToAddr8; ShipToAddr[8])
                        { }
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        { }
                        column(SellToCustNo_PurchHeaderCaption; "Purchase Header".FieldCaption("Sell-to Customer No."))
                        { }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(PrepmtLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalPrepmtLineAmount; TotalPrepmtLineAmount)
                        { }
                        column(PrepmtInvBufGLAccNo; TempPrepmtInvLineBuffer."G/L Account No.")
                        { }
                        column(PrepmtInvBufDesc; TempPrepmtInvLineBuffer.Description)
                        { }
                        column(TotalInclVATText2; TotalInclVATText)
                        { }
                        column(TotalExclVATText2; TotalExclVATText)
                        { }
                        column(PrepmtInvBufAmt; TempPrepmtInvLineBuffer.Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountText; TempPrepmtVATAmountLine.VATAmountText())
                        { }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBuDescCaption; PrepmtInvBuDescCaptionLbl)
                        { }
                        column(PrepmtInvBufGLAccNoCaption; PrepmtInvBufGLAccNoCaptionLbl)
                        { }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        { }
                        column(PrepmtLoopLineNo; PrepmtLoopLineNo)
                        { }
                        dataitem(PrepmtDimLoop; "Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                            column(DummyColumn; 0)
                            { }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not PrepmtDimSetEntry.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := CopyStr(DimText, 1, 75);
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    else
                                        DimText := CopyStr(
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code"), 1, 120);
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until PrepmtDimSetEntry.Next() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();

                                PrepmtDimSetEntry.SetRange("Dimension Set ID", TempPrepmtInvLineBuffer."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not TempPrepmtInvLineBuffer.Find('-') then
                                    CurrReport.Break();
                            end else
                                if TempPrepmtInvLineBuffer.Next() = 0 then
                                    CurrReport.Break();

                            if "Purchase Header"."Prices Including VAT" then
                                PrepmtLineAmount := TempPrepmtInvLineBuffer."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := TempPrepmtInvLineBuffer.Amount;

                            PrepmtLoopLineNo += 1;
                            TotalPrepmtLineAmount += PrepmtLineAmount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            PrepmtLoopLineNo := 0;
                            TotalPrepmtLineAmount := 0;
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(PrepmtVATAmtLineVATAmt; TempPrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; TempPrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; TempPrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVAT; TempPrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATId; TempPrepmtVATAmountLine."VAT Identifier")
                        { }
                        column(PrepymtVATAmtSpecCaption; PrepymtVATAmtSpecCaptionLbl)
                        { }

                        trigger OnAfterGetRecord()
                        begin
                            TempPrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, TempPrepmtVATAmountLine.Count);
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    TempPrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                begin
                    Clear(TempPurchaseLine);
                    Clear(PurchPost);
                    TempPurchaseLine.DeleteAll();
                    TempVATAmountLine.DeleteAll();
                    PurchPost.GetPurchLines("Purchase Header", TempPurchaseLine, 0);
                    TempPurchaseLine.CalcVATAmountLines(0, "Purchase Header", TempPurchaseLine, TempVATAmountLine);
                    TempPurchaseLine.UpdateVATOnLines(0, "Purchase Header", TempPurchaseLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    Utilitiess.FormatNoText(AmountLetter1, TotalAmountInclVAT);
                    Utilitiess.FormatNoText2(AmountLetter2, TotalAmountInclVAT);
                    if "Purchase Header"."Currency Code" <> '' then begin
                        if not Currency.Get("Purchase Header"."Currency Code") then
                            exit;
                        AmountLetter3 := Currency.Description;
                    end else
                        AmountLetter3 := GLSetup."Local Currency Description";

                    if "Purchase Header"."Location Code" = '' then begin
                        ShipToName := StrSubstNo('%1 %2', "Purchase Header"."Buy-from Vendor Name", "Purchase Header"."Buy-from Vendor Name 2");
                        ShipToAddress := "Purchase Header"."Buy-from Address";
                        ShipToAddress2 := "Purchase Header"."Buy-from Address 2";
                        ShipToCity := "Purchase Header"."Buy-from City";
                        ShipToPostalCode := "Purchase Header"."Buy-from Post Code";
                        ShipToCountry := "Purchase Header"."Buy-from Country/Region Code";
                    end else begin
                        ShipToName := StrSubstNo('%1 %2', "Purchase Header"."Ship-to Name", "Purchase Header"."Ship-to Name 2");
                        ShipToAddress := "Purchase Header"."Ship-to Address";
                        ShipToAddress2 := "Purchase Header"."Ship-to Address 2";
                        ShipToCity := "Purchase Header"."Ship-to City";
                        ShipToPostalCode := "Purchase Header"."Ship-to Code";
                        ShipToCountry := "Purchase Header"."Ship-to Country/Region Code";
                    end;

                    TempPrepmtInvLineBuffer.DeleteAll();
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, TempPrepmtPurchLine);
                    if not TempPrepmtPurchLine.IsEmpty() then begin
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.IsEmpty() then
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, TempPrepmtVATAmountLineDeduct, 1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    TempPrepmtVATAmountLine.DeductVATAmountLine(TempPrepmtVATAmountLineDeduct);
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", TempPrepmtPurchLine, 0, TempPrepmtInvLineBuffer);
                    PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then
                        CopyText := FormatDocument.GetCOPYText();
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not IsReportInPreviewMode() then
                        CODEUNIT.Run(CODEUNIT::"Purch.Header-Printed", "Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault("Format Region");
                FormatAddr.SetLanguageCode("Language Code");

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");
                if BuyFromContact.Get("Buy-from Contact No.") then;
                if PayToContact.Get("Pay-to Contact No.") then;
                PricesInclVATtxt := Format("Prices Including VAT");

                if "Purchase Header"."Currency Code" <> '' then
                    CurrencyCode := "Purchase Header"."Currency Code"
                else
                    CurrencyCode := GLSetup."LCY Code";

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                if not IsReportInPreviewMode() then
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);
            end;

        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoofCopies1; NoOfCopies)
                    {
                        ApplicationArea = Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInformation1; ShowInternalInfo)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    field(ArchiveDocument1; ArchiveDocument)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies whether to archive the order.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteraction1; LogInteraction)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want the program to log this interaction.';

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
            ArchiveDocument := PurchSetup."Archive Orders";

        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();

            LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        PurchSetup.Get();
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if "Purchase Header".FindSet() then
                repeat
                    "Purchase Header".CalcFields("No. of Archived Versions");
                    SegManagement.LogDocument(13, "Purchase Header"."No.", "Purchase Header"."Doc. No. Occurrence",
                      "Purchase Header"."No. of Archived Versions", DATABASE::Vendor, "Purchase Header"."Buy-from Vendor No.",
                      "Purchase Header"."Purchaser Code", '', "Purchase Header"."Posting Description", '');
                until "Purchase Header".Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then
            InitLogInteraction();
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Ord.") <> '';
    end;

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then
            FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatDocument.SetTotalLabels(PurchaseHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchaseHeader."Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, PurchaseHeader."Prepmt. Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeader."Shipment Method Code", PurchaseHeader."Language Code");

        FormatDocument.SetPaymentMethod(PaymentMethod, PurchaseHeader."Payment Method Code", PurchaseHeader."Language Code");

        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', CopyStr(PurchaseHeader.FieldCaption("Your Reference"), 1, 35));
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', CopyStr(PurchaseHeader.FieldCaption("VAT Registration No."), 1, 20));
    end;

    local procedure GetCommentPurchLine(DocumentType: Enum "Purchase Document Type"; DocumentNo: Code[20];
                                                          LineNo: Integer): Text
    var
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCommentText: Text;
    begin
        PurchCommentLine.Reset();
        PurchCommentLine.SetRange("Document Type", DocumentType);
        PurchCommentLine.SetRange("No.", DocumentNo);
        PurchCommentLine.SetRange("Document Line No.", LineNo);
        if PurchCommentLine.FindSet() then
            repeat
                if PurchCommentText = '' then
                    PurchCommentText := PurchCommentLine.Comment
                else
                    PurchCommentText += '; ' + PurchCommentLine.Comment;
            until PurchCommentLine.Next() = 0;

        exit(PurchCommentText);
    end;

    local procedure GetCommentPurchHeader(DocumentType: Enum "Purchase Document Type"; DocumentNo: Code[20]): Text
    var
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCommentText: Text;
    begin
        PurchCommentLine.Reset();
        PurchCommentLine.SetRange("Document Type", DocumentType);
        PurchCommentLine.SetRange("No.", DocumentNo);
        PurchCommentLine.SetRange("Document Line No.", 0);
        if PurchCommentLine.FindSet() then
            repeat
                if PurchCommentText = '' then
                    PurchCommentText := PurchCommentLine.Comment
                else
                    PurchCommentText += '; ' + PurchCommentLine.Comment;
            until PurchCommentLine.Next() = 0;

        exit(PurchCommentText);
    end;

    protected var
        CompanyInfo: Record "Company Information";
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        NoOfCopies: Integer;
        ShowInternalInfo: Boolean;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        TempPurchaseLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        TempPrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        PurchSetup: Record "Purchases & Payables Setup";
        BuyFromContact: Record Contact;
        Currency: Record Currency;
        PayToContact: Record Contact;
        LanguageMgt: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        Utilitiess: Codeunit Utilitiess;
        VendAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        BuyFromAddr: array[8] of Text[100];
        PurchaserText: Text[50];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        AmountLetter1: array[2] of Text[80];
        AmountLetter2: Text[80];
        AmountLetter3: Text[80];
        ShipToName: Text[200];
        ShipToAddress: Text[100];
        ShipToAddress2: Text[50];
        ShipToCity: Text[30];
        ShipToPostalCode: Code[20];
        ShipToCountry: Code[10];
        Continue: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        CurrencyCode: Code[10];
        ArchiveDocumentEnable: Boolean;
        LogInteractionEnable: Boolean;
        PrepmtLoopLineNo: Integer;
        TotalPrepmtLineAmount: Decimal;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
        OrderNoCaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        DocumentDateCaptionLbl: Label 'Document Date';
        HdrDimCaptionLbl: Label 'Header Dimensions';
        DirectUniCostCaptionLbl: Label 'Direct Unit Cost';
        PurchLineLineDiscCaptionLbl: Label 'Discount %';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        LineDimCaptionLbl: Label 'Line Dimensions';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        VendNoCaptionLbl: Label 'Vendor No.';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        PrepmtInvBuDescCaptionLbl: Label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        AmountCaptionLbl: Label 'Amount';
        PurchLineInvDiscAmtCaptionLbl: Label 'Discount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATAmtLineVATCaptionLbl: Label 'VAT %';
        VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        VATAmtLineLineAmtCaptionLbl: Label 'Line Amount';
        VALVATBaseLCYCaptionLbl: Label 'VAT Base';
        TotalCaptionLbl: Label 'Total';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        HomePageCaptionLbl: Label 'Home Page';
        EmailIDCaptionLbl: Label 'Email';
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
        BuyFromContactPhoneNoLbl: Label 'Buy-from Contact Phone No.';
        BuyFromContactMobilePhoneNoLbl: Label 'Buy-from Contact Mobile Phone No.';
        BuyFromContactEmailLbl: Label 'Buy-from Contact E-Mail';
        PayToContactPhoneNoLbl: Label 'Pay-to Contact Phone No.';
        PayToContactMobilePhoneNoLbl: Label 'Pay-to Contact Mobile Phone No.';
        PayToContactEmailLbl: Label 'Pay-to Contact E-Mail';
        IGVIdentifierCaptionLbl: Label 'IGV Identifier';
        IGVAmtLineIGVAmtCaptionLbl: Label 'IGV Amount';
        IGVAmtLineIGVCaptionLbl: Label 'IGV %';
        VALIGVBaseLCYCaptionLbl: Label 'IGV Base';
        IGVAmtSpecCaptionLbl: Label 'IGV Amount Specification';
        Text004Lbl: Label 'Purchase Order %1', Comment = '%1 = Document No.';
        PaymentMethodDescCaptionLbl: Label 'Payment Method';
        BusinessLineCaptionLbl: Label 'Business Line';
        CostCenterCaptionLbl: Label 'Cost Center';
        CommentCaptionLbl: Label 'Comments';
        Text007Lbl: Label 'VAT Amount Specification in ';
        Text008Lbl: Label 'Local Currency';
        Text009Lbl: Label 'Exchange rate: %1/%2';
        PriceIGVIncludingLbl: Label 'Prices Including IGV';
        CurrencyLbl: Label 'Currency';
        VendorTextLbl: Label 'VENDOR';
        ShipToVendorTextLbl: Label 'SHIP TO';
        AreLbl: Label 'ARE:';
}

