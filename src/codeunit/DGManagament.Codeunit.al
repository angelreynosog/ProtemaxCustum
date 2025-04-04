codeunit 80100 "DG Managament"
{
    Permissions = tabledata "DG Protemax Setup Custom" = rimd,
                  tabledata "Sales Invoice Header" = m,
                  tabledata "DG Purchase Request Header" = m;

    procedure ConvertRequestPurchase(RecordRefIn: RecordRef)
    var
        DGPurchaseRequestLine: Record "DG Purchase Request Line";
        SuccessLbl: Label 'The %1 request has been successfully completed.';
    begin
        RecordRefIn.SetTable(DGPurchaseRequestLine);
        DGPurchaseRequestLine.Reset();
        DGPurchaseRequestLine.SetFilter("Qty. to Requested", '<>0');
        DGPurchaseRequestLine.SetFilter("Request Date", '<>%1', 0D);
        if DGPurchaseRequestLine.FindSet() then begin
            repeat
                FindHeaderRequest(DGPurchaseRequestLine."Document No.");
                CreatePurchaseHeader(DGPurchaseRequestLine."Vendor Code");
                CreatePurchaseLine(DGPurchaseRequestLine);
                TransfieldPostedInsert(DGPurchaseRequestLine);
            until DGPurchaseRequestLine.Next() = 0;

            if DGPurchaseRequestHeader.Get(DGPurchaseRequestLine."Document No.", DGPurchaseRequestLine."Document Type") then begin
                DGPurchaseRequestHeader."Status Request" := DGPurchaseRequestHeader."Status Request"::Approved;
                DGPurchaseRequestHeader.Modify();
            end;

            Message(SuccessLbl, NewDocLastNo);
        end;
    end;

    procedure GetQtyInventoryObsolete(ItemNo: Code[20]; var InventoryWithoutObsWhs: Decimal)
    var
        Location: Record Location;
        ItemLedgerEntry: Record "Item Ledger Entry";
        LocationCode: List of [Code[10]];
    begin
        Location.Reset();
        Location.SetRange("DG Mark Obsolete Inventory", true);
        if Location.FindSet() then
            repeat
                LocationCode.Add(Location.Code);
            until Location.Next() = 0;

        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        if ItemLedgerEntry.FindSet() then
            repeat
                if not LocationCode.Contains(ItemLedgerEntry."Location Code") then
                    InventoryWithoutObsWhs += ItemLedgerEntry.Quantity;
            until ItemLedgerEntry.Next() = 0;
    end;

    procedure NonBillableInvoice(RecordRefIn: RecordRef; Action: Boolean)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        RecordRefIn.SetTable(SalesInvoiceHeader);
        if SalesInvoiceHeader.FindSet() then
            repeat
                SalesInvoiceHeader."DG Non-Billable Invoice" := Action;
                SalesInvoiceHeader.Modify();
            until SalesInvoiceHeader.Next() = 0;
    end;

    local procedure FindHeaderRequest(DocNoIn: Code[20])
    begin
        if not DGPurchaseRequestHeader.Get(DocNoIn, DGPurchaseRequestHeader."Document Type"::Request) then
            Clear(DGPurchaseRequestHeader);
    end;

    local procedure CreatePurchaseHeader(VendorCodeIn: Code[20])
    var
        Vendor: Record Vendor;
        PurchaseHeader: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";
        VendorNo: Code[20];
        NewVendorNo: Code[20];
        No: Code[20];
        VendorPurchaseQuoteErr: Label 'There must be a generic vendor.';
    begin
        VendorNo := VendorCodeIn;

        if VendorNo = '' then begin
            Vendor.Reset();
            Vendor.SetRange("DG Generic Vendor", true);
            if Vendor.FindFirst() then
                VendorNo := Vendor."No."
            else
                Error(VendorPurchaseQuoteErr);
        end;

        NewVendorNo := VendorNo;
        if not (NewVendorNo = NewVendorLastNo) then begin
            Clear(NewVendorLastNo);
            Clear(NewDocLastNo);
            Clear(DocLastNo);

            PurchasesPayablesSetup.Get();
            PurchasesPayablesSetup.TestField("Order Nos.");

            No := NoSeries.GetNextNo(PurchasesPayablesSetup."Order Nos.");
            PurchaseHeader.Init();
            PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader."No." := No;
            PurchaseHeader.Validate("Buy-from Vendor No.", VendorNo);
            PurchaseHeader.Validate("Pay-to Vendor No.", VendorNo);
            PurchaseHeader.Validate("Posting Date", WorkDate());
            PurchaseHeader."DG Request No." := DGPurchaseRequestHeader."No.";
            PurchaseHeader.Insert();

            NewDocLastNo := No;
            NewVendorLastNo := VendorNo;
        end;
    end;

    local procedure CreatePurchaseLine(DGPurchaseRequestLineIn: Record "DG Purchase Request Line")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", NewDocLastNo);
        if PurchaseLine.FindLast() then
            NoLine := PurchaseLine."Line No." + 10000
        else
            NoLine += 10000;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", NewDocLastNo);
        if PurchaseLine.FindSet() then begin
            PurchaseLine."Line No." := NoLine;
            PurchaseLine.Type := DGPurchaseRequestLineIn.Type;
            PurchaseLine.Validate("No.", DGPurchaseRequestLineIn."No.");
            PurchaseLine.Description := DGPurchaseRequestLineIn."Description 2";
            PurchaseLine.Validate(Quantity, DGPurchaseRequestLineIn."Qty. to Requested");
            if DGPurchaseRequestLineIn."Unit Cost" <> 0 then
                PurchaseLine.Validate("Direct Unit Cost", DGPurchaseRequestLineIn."Unit Cost");
            PurchaseLine."Requested Receipt Date" := DGPurchaseRequestLineIn."Request Date";
            PurchaseLine.Insert();
        end else begin
            PurchaseLine.Init();
            PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
            PurchaseLine."Document No." := NewDocLastNo;
            PurchaseLine."Line No." := NoLine;
            PurchaseLine.Type := DGPurchaseRequestLineIn.Type;
            PurchaseLine.Validate("No.", DGPurchaseRequestLineIn."No.");
            PurchaseLine.Description := DGPurchaseRequestLineIn."Description 2";
            PurchaseLine.Validate(Quantity, DGPurchaseRequestLineIn."Qty. to Requested");
            if DGPurchaseRequestLineIn."Unit Cost" <> 0 then
                PurchaseLine.Validate("Direct Unit Cost", DGPurchaseRequestLineIn."Unit Cost");
            PurchaseLine."Requested Receipt Date" := DGPurchaseRequestLineIn."Request Date";
            PurchaseLine.Insert();
        end;
    end;

    local procedure TransfieldPostedInsert(var DGPurchaseRequestLineIn: Record "DG Purchase Request Line")
    var
        DGEntryPurchaseRequest: Record "DG Entry Purchase Request";
    begin
        DGEntryPurchaseRequest.Init();
        DGEntryPurchaseRequest."Entry No." := GetLastEntryNo();
        DGEntryPurchaseRequest."Document No." := DGPurchaseRequestLineIn."Document No.";
        DGEntryPurchaseRequest."Document Type" := DGPurchaseRequestLineIn."Document Type";
        DGEntryPurchaseRequest."Line No." := DGPurchaseRequestLineIn."Line No.";
        DGEntryPurchaseRequest.Type := DGPurchaseRequestLineIn.Type;
        DGEntryPurchaseRequest."No." := DGPurchaseRequestLineIn."No.";
        DGEntryPurchaseRequest.Description := DGPurchaseRequestLineIn.Description;
        DGEntryPurchaseRequest."Description 2" := DGPurchaseRequestLineIn."Description 2";
        DGEntryPurchaseRequest."Inventory Total" := DGPurchaseRequestLineIn."Inventory Total";
        DGEntryPurchaseRequest."Inventory Without Obs. Whs." := DGPurchaseRequestLineIn."Inventory Without Obs. Whs.";
        DGEntryPurchaseRequest."Base Unit of Measure" := DGPurchaseRequestLineIn."Base Unit of Measure";
        DGEntryPurchaseRequest."Unit Cost" := DGPurchaseRequestLineIn."Unit Cost";
        DGEntryPurchaseRequest."Inventory Posting Group" := DGPurchaseRequestLineIn."Inventory Posting Group";
        DGEntryPurchaseRequest."Quantity Requested" := DGPurchaseRequestLineIn."Qty. to Requested";
        DGEntryPurchaseRequest."Order Status" := DGEntryPurchaseRequest."Order Status"::Requested;
        DGEntryPurchaseRequest."Vendor Code" := NewVendorLastNo;
        DGEntryPurchaseRequest."Order No." := NewDocLastNo;
        DGEntryPurchaseRequest."User Id" := DGPurchaseRequestHeader."User Id";
        DGEntryPurchaseRequest."Create Date" := DGPurchaseRequestHeader."Create Date";
        DGEntryPurchaseRequest."User Id Authorized" := CopyStr(UserId(), 1, 50);
        DGEntryPurchaseRequest."Authorization Date" := Today;
        if DGEntryPurchaseRequest.Insert() then begin
            DGCommentLine.CopyComments(DGPurchaseRequestLineIn."Line No.", DGPurchaseRequestLineIn."Document No.", NewDocLastNo, NoLine);
            AttachmentDocument(DGPurchaseRequestLineIn);
            Clear(DGPurchaseRequestLineIn."Qty. to Requested");
            Clear(DGPurchaseRequestLineIn."Vendor Code");
            DGPurchaseRequestLineIn."Order Status" := DGPurchaseRequestLineIn."Order Status"::Requested;
            DGPurchaseRequestLineIn.Modify();
        end;
    end;

    local procedure GetLastEntryNo(): Integer
    var
        DGEntryPurchaseRequest: Record "DG Entry Purchase Request";
    begin
        DGEntryPurchaseRequest.Reset();
        if DGEntryPurchaseRequest.FindLast() then
            exit(DGEntryPurchaseRequest."Entry No." + 1)
        else
            exit(1);
    end;

    local procedure AttachmentDocument(var DGPurchaseRequestLineIn: Record "DG Purchase Request Line")
    var
        DocumentAttachment: Record "Document Attachment";
        DocumentAttachment1: Record "Document Attachment";
    begin
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"DG Purchase Request Line");
        DocumentAttachment.SetRange("No.", DGPurchaseRequestLineIn."Document No.");
        DocumentAttachment.SetRange("Line No.", DGPurchaseRequestLineIn."Line No.");
        if DocumentAttachment.FindSet() then
            repeat
                DocumentAttachment1.Init();
                DocumentAttachment1.TransferFields(DocumentAttachment);
                DocumentAttachment1."Table ID" := Database::"Purchase Header";
                DocumentAttachment1."No." := NewDocLastNo;
                DocumentAttachment1."Line No." := 0;
                DocumentAttachment1.Insert();
            until DocumentAttachment.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnSetRelatedAttachmentsFilterOnBeforeSetTableIdFilter', '', true, true)]
    local procedure "Document Attachment Mgmt_OnSetRelatedAttachmentsFilterOnBeforeSetTableIdFilter"(TableNo: Integer; var RelatedTable: Integer)
    begin
        case TableNo of
            Database::"DG Purchase Request Line":
                RelatedTable := Database::"DG Purchase Request Line";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnAfterTableHasNumberFieldPrimaryKey', '', true, true)]
    local procedure "Document Attachment Mgmt_OnAfterTableHasNumberFieldPrimaryKey"(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        case TableNo of
            Database::"DG Purchase Request Line":
                begin
                    FieldNo := 1;
                    Result := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnAfterTableHasDocTypePrimaryKey', '', true, true)]
    local procedure "Document Attachment Mgmt_OnAfterTableHasDocTypePrimaryKey"(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        case TableNo of
            Database::"DG Purchase Request Line":
                begin
                    FieldNo := 2;
                    Result := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnAfterTableHasLineNumberPrimaryKey', '', true, true)]
    local procedure "Document Attachment Mgmt_OnAfterTableHasLineNumberPrimaryKey"(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        case TableNo of
            Database::"DG Purchase Request Line":
                begin
                    FieldNo := 3;
                    Result := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterVATAmountText', '', true, true)]
    local procedure "VAT Amount Line_OnAfterVATAmountText"(VATPercentage: Decimal; var Result: Text[30])
    var
        Text001Lbl: Label 'VAT Amount';
        Text002Lbl: Label 'IGV', Comment = '%1 = Percentage';
    begin
        if VATPercentage = 0 then
            Result := Text001Lbl
        else
            Result := Text002Lbl;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Document", 'OnAfterSetTotalLabels', '', true, true)]
    local procedure "VAT Amount Line_OnAfterSetTotalLabels"(CurrencyCode: Code[10]; var TotalText: Text[50]; var TotalExclVATText: Text[50]; var TotalInclVATText: Text[50])
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        TotalTxtLbl: Label 'Total %1', Comment = '%1 = Currency Code';
        TotalInclVATTxtLbl: Label 'Total %1 Incl. IGV', Comment = '%1 = Currency Code';
        TotalExclVATTxtLbl: Label 'Total %1 Excl. IGV', Comment = '%1 = Currency Code';
    begin
        if CurrencyCode = '' then begin
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("LCY Code");
            TotalText := StrSubstNo(TotalTxtLbl, GeneralLedgerSetup."LCY Code");
            TotalInclVATText := StrSubstNo(TotalInclVATTxtLbl, GeneralLedgerSetup."LCY Code");
            TotalExclVATText := StrSubstNo(TotalExclVATTxtLbl, GeneralLedgerSetup."LCY Code");
        end else begin
            TotalText := StrSubstNo(TotalTxtLbl, CurrencyCode);
            TotalInclVATText := StrSubstNo(TotalInclVATTxtLbl, CurrencyCode);
            TotalExclVATText := StrSubstNo(TotalExclVATTxtLbl, CurrencyCode);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateNo', '', true, true)]
    local procedure SalesLine_OnBeforeValidateNo(var SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        if not SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
            clear(SalesHeader)
        else
            SalesLine.Validate("DG Code System Id", SalesHeader.SystemId);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', true, true)]
    local procedure "Purch.-Post_OnBeforePurchInvHeaderInsert"(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        PurchInvHeader."DG No. Guide Recep./Origen DUA" := PurchHeader."DG No. Guide Recep./Origen DUA";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', true, true)]
    local procedure "Purch.-Post_OnBeforePurchRcptHeaderInsert"(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        PurchaseHeader."DG No. Guide Recep./Origen DUA" := WarehouseReceiptHeader."DG No. Guide Recep./Origen DUA";
        PurchRcptHeader."DG No. Guide Recep./Origen DUA" := WarehouseReceiptHeader."DG No. Guide Recep./Origen DUA";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnPostSourceDocumentOnAfterGetWhseRcptHeader', '', true, true)]
    local procedure "Whse.-Post Receipt_OnPostSourceDocumentOnAfterGetWhseRcptHeader"(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        WarehouseReceiptHeader.TestField("DG No. Guide Recep./Origen DUA");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnCodeOnAfterPostSourceDocuments', '', true, true)]
    local procedure "Whse.-Post Receipt_OnAfterCode"(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        Clear(WarehouseReceiptHeader."DG No. Guide Recep./Origen DUA");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnAfterPostInvoice', '', true, true)]
    local procedure "Purch.-Post_OnRunOnAfterPostInvoice"(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader.Receive then
            Clear(PurchaseHeader."DG No. Guide Recep./Origen DUA");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchHeader', '', true, true)]
    local procedure "Item Journal Line_OnAfterCopyItemJnlLineFromPurchHeader"(var ItemJnlLine: Record "Item Journal Line"; PurchHeader: Record "Purchase Header")
    begin
        ItemJnlLine."DG No. Guide Recep./Origen DUA" := PurchHeader."DG No. Guide Recep./Origen DUA";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnBeforePostInvtPostBuf', '', true, true)]
    local procedure "Inventory Posting To G/L_OnPostInvtPostBufOnBeforeSetAmt"(var GenJournalLine: Record "Gen. Journal Line"; ValueEntry: Record "Value Entry")
    begin
        GenJournalLine."DG No. Guide Recep./Origen DUA" := ValueEntry."DG No. Guide Recep./Origen DUA";
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."DG No. Guide Recep./Origen DUA" := GenJournalLine."DG No. Guide Recep./Origen DUA";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInitValueEntryOnAfterAssignFields', '', true, true)]
    local procedure "Item Journal Line_OnInitValueEntryOnAfterAssignFields"(var ValueEntry: Record "Value Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        ValueEntry."DG No. Guide Recep./Origen DUA" := ItemJnlLine."DG No. Guide Recep./Origen DUA";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure "Item Jnl.-Post Line_OnAfterInitItemLedgEntry"(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."DG No. Guide Recep./Origen DUA" := ItemJournalLine."DG No. Guide Recep./Origen DUA";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterCheckTrackingAndWarehouseForReceive', '', true, true)]
    local procedure "Purch.-Post_OnAfterCheckTrackingAndWarehouseForReceive"(var TempWarehouseReceiptHeader: Record "Warehouse Receipt Header" temporary; var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."DG No. Guide Recep./Origen DUA" := TempWarehouseReceiptHeader."DG No. Guide Recep./Origen DUA";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInitHeaderDefaults', '', true, true)]
    local procedure "Sales Line_OnValidateTypeOnCopyFromTempSalesLine"(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        if SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
            SalesLine."DG Code System Id" := SalesHeader.SystemId;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnAfterUpdateUnitPrice', '', true, true)]
    local procedure "Sales Line_OnValidateNoOnAfterUpdateUnitPrice"(var SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
            if SalesHeader."DG Non-Billable Invoice" then
                if (SalesLine.Type = SalesLine.Type::Item) and (SalesLine."Document Type" = SalesLine."Document Type"::Invoice) then begin
                    DGProtemaxSetupCustom.Get();
                    DGProtemaxSetupCustom.TestField("Gen. Prod. Posting Group");
                    DGProtemaxSetupCustom.TestField("VAT Prod. Posting Group");
                    SalesLine."Gen. Prod. Posting Group" := DGProtemaxSetupCustom."Gen. Prod. Posting Group";
                    SalesLine."VAT Prod. Posting Group" := DGProtemaxSetupCustom."VAT Prod. Posting Group";
                end;
    end;


    var
        DGProtemaxSetupCustom: Record "DG Protemax Setup Custom";
        DGPurchaseRequestHeader: Record "DG Purchase Request Header";
        DGCommentLine: Record "DG Comment Line";
        NewDocLastNo: Code[20];
        NewVendorLastNo: Code[20];
        DocLastNo: Code[20];
        NoLine: Integer;
}