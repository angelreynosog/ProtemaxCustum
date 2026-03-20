page 80120 "DG Purch. Request Line Apprvd"
{
    PageType = ListPart;
    SourceTable = "DG Purchase Request Line";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    Editable = Rec."Order Status" <> Rec."Order Status"::Requested;
                    ToolTip = 'Specifies the value of the Type field.';
                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    Editable = Rec."Order Status" <> Rec."Order Status"::Requested;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    Editable = Rec."Order Status" <> Rec."Order Status"::Requested;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Vendor Code field.';
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Base Unit of Measure field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Editable = Rec."Order Status" <> Rec."Order Status"::Requested;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                    Editable = Rec.Type <> Rec.Type::Item;
                }
                field("Qty. to Requested"; Rec."Qty. to Requested")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Qty. to Requested field.';
                }
                field("Qty. Requested"; Rec."Qty. Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. Requested field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field("Status Line"; Rec."Status Line")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("DG Comment Line")
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Image = Comment;
                RunObject = page "DG Comment Line";
                RunPageLink = "Document No." = field("Document No."), "Line Document No." = field("Line No.");
                ToolTip = 'Executes the Comments action.';
            }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action("DG Approved")
            {
                ApplicationArea = All;
                Caption = 'Approved';
                Image = Approval;
                Enabled = Rec."Status Line" <> Rec."Status Line"::Closed;
                ToolTip = 'Approved';

                trigger OnAction()
                var
                    DGPurchaseRequestHeader: Record "DG Purchase Request Header";
                begin
                    if DGPurchaseRequestHeader.Get(Rec."Document No.", Rec."Document Type") then begin
                        DGPurchaseRequestHeader."Status Request" := DGPurchaseRequestHeader."Status Request"::Approved;
                        DGPurchaseRequestHeader.Modify();
                    end;
                end;
            }
            action("DG Generate Requisition")
            {
                Caption = 'Generate Request';
                ToolTip = 'Executes the Generate Request action.';
                Image = ExecuteBatch;
                ApplicationArea = All;
                Enabled = Rec."Status Line" <> Rec."Status Line"::Closed;
                trigger OnAction()
                var
                    DGPurchaseRequestLine: Record "DG Purchase Request Line";
                    DGPurchaseRequestHeader: Record "DG Purchase Request Header";
                    DGManagament: Codeunit "DG Managament";
                    RecordRef: RecordRef;
                    RequestNotApprovedLbl: Label 'This application cannot be approved because you have not completed the process.';
                begin
                    DGPurchaseRequestHeader.Reset();
                    DGPurchaseRequestHeader.SetRange("No.", DGPurchaseRequestLine."Document No.");
                    DGPurchaseRequestHeader.SetRange("Document Type", DGPurchaseRequestLine."Document Type");
                    DGPurchaseRequestHeader.SetFilter("Status Request", '%1|%2', DGPurchaseRequestHeader."Status Request"::" ", DGPurchaseRequestHeader."Status Request"::Approved);
                    if not DGPurchaseRequestHeader.IsEmpty then
                        Error(RequestNotApprovedLbl);

                    CurrPage.SetSelectionFilter(DGPurchaseRequestLine);
                    RecordRef.GetTable(DGPurchaseRequestLine);
                    DGManagament.ConvertRequestPurchase(RecordRef);
                end;
            }
        }
    }
}
