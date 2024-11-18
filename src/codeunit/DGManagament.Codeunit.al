codeunit 80100 "DG Managament"
{
    procedure ConvertToRequisition(RecordRefIn: RecordRef)
    var
        DGPurchaseRequestLine: Record "DG Purchase Request Line";
    begin
        RecordRefIn.SetTable(DGPurchaseRequestLine);
        //DGPurchaseRequestLine.SetCurrentKey("Vendor Code", "Item No.");
        if DGPurchaseRequestLine.FindSet() then
            repeat
                FindHeaderRequest(DGPurchaseRequestLine."Document No.");
                CreatePurchaseHeader(DGPurchaseRequestLine."Vendor Code");
                CreatePurchaseLine(DGPurchaseRequestLine);
                TransfieldPostedInsert(DGPurchaseRequestLine);
            until DGPurchaseRequestLine.Next() = 0;
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

    procedure PostedDGJournal(Rec: Record "DG General Journal")
    var
        DGGeneralJournalLine: Record "DG General Journal Line";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init();
        DGGeneralJournalLine.Reset();
        DGGeneralJournalLine.SetRange(Code, Rec.Code);
        if DGGeneralJournalLine.FindSet() then
            repeat
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'DEFAULT';
                GenJournalLine."Line No." := SearchlastlineGenJnLn();
                GenJournalLine.Validate("Document No.", DGGeneralJournalLine.Code);
                GenJournalLine.Validate("Posting Date", Rec."End Date");
                GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::"G/L Account");
                GenJournalLine."Account No." := DGGeneralJournalLine."Account No.";
                GenJournalLine.Description := DGGeneralJournalLine.Description;
                GenJournalLine.Validate(Amount, DGGeneralJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DGGeneralJournalLine."Dimension 1";
                GenJournalLine."Shortcut Dimension 2 Code" := DGGeneralJournalLine."Dimension 2";
                //GenJournalLine."Shortcut Dimension 4 Code" := DGGeneralJournalLine."Dimension 4";
                GenJournalLine.Insert();
            until DGGeneralJournalLine.Next() = 0;
    end;

    local procedure SearchlastlineGenJnLn() LineNoGen: Integer;
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset();
        GenJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine.FindLast() then
            LineNoGen := GenJournalLine."Line No." + 10000
        else
            LineNoGen := 10000;
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
        VendorPurchaseQuoteErr: Label 'There must be a generic supplier for purchase quotations.';
    begin
        VendorNo := VendorCodeIn;

        if VendorNo = '' then begin
            Vendor.Reset();
            Vendor.SetRange("DG General Quote Vendor", true);
            if not Vendor.IsEmpty then
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
            PurchaseHeader."Requested Receipt Date" := DGPurchaseRequestHeader."Request Date";
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
            PurchaseLine.Type := PurchaseLine.Type::Item;
            PurchaseLine.Validate("No.", DGPurchaseRequestLineIn."Item No.");
            PurchaseLine.Description := DGPurchaseRequestLineIn."Description 2";
            PurchaseLine.Validate(Quantity, DGPurchaseRequestLineIn."Qty. to Requested");
            PurchaseLine."Requested Receipt Date" := DGPurchaseRequestLineIn."Request Date";
            PurchaseLine.Insert();
        end else begin
            PurchaseLine.Init();
            PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
            PurchaseLine."Document No." := NewDocLastNo;
            PurchaseLine."Line No." := NoLine;
            PurchaseLine.Type := PurchaseLine.Type::Item;
            PurchaseLine.Validate("No.", DGPurchaseRequestLineIn."Item No.");
            PurchaseLine.Description := DGPurchaseRequestLineIn."Description 2";
            PurchaseLine.Validate(Quantity, DGPurchaseRequestLineIn."Qty. to Requested");
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
        DGEntryPurchaseRequest."Item No." := DGPurchaseRequestLineIn."Item No.";
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
        //Text000Lbl: Label '%1% IGV', Comment = '%1 = Percentage';
        Text001Lbl: Label 'VAT Amount';
        Text002Lbl: Label 'IGV', Comment = '%1 = Percentage';
    begin
        if VATPercentage = 0 then
            Result := Text001Lbl
        else
            //Result := StrSubstNo(Text000Lbl, VATPercentage);
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







    var
        DGPurchaseRequestHeader: Record "DG Purchase Request Header";
        DGCommentLine: Record "DG Comment Line";
        NewDocLastNo: Code[20];
        NewVendorLastNo: Code[20];
        DocLastNo: Code[20];
        NoLine: Integer;
}