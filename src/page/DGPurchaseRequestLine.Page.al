page 80101 "DG Purchase Request Line"
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
                // field("Inventory Total"; Rec."Inventory Total")
                // {
                //     ApplicationArea = All;
                //     Visible = Rec.Type = Rec.Type::Item;
                //     ToolTip = 'Specifies the value of the Inventory Total field.';
                // }
                // field("Inventory Without Obs. Whs."; Rec."Inventory Without Obs. Whs.")
                // {
                //     ApplicationArea = All;
                //     Visible = Rec.Type = Rec.Type::Item;
                //     ToolTip = 'Specifies the value of the Inventory Without Obs. Whs. field.';
                // }
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
                }
                // field("Inventory Posting Group"; Rec."Inventory Posting Group")
                // {
                //     ApplicationArea = All;
                //     Visible = Rec.Type = Rec.Type::Item;
                //     ToolTip = 'Specifies the value of the Inventory Posting Group field.';
                // }
                // field("Vendor Code"; Rec."Vendor Code")
                // {
                //     ApplicationArea = All;
                //     Importance = Standard;
                //     ToolTip = 'Specifies the value of the Vendor Code field.';
                // }

                // field("Qty. to Requested"; Rec."Qty. to Requested")
                // {
                //     ApplicationArea = All;
                //     Importance = Standard;
                //     ToolTip = 'Specifies the value of the Qty. to Requested field.';
                // }
                // field("Qty. Requested"; Rec."Qty. Requested")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Qty. Requested field.';
                // }
                // field("Request Date"; Rec."Request Date")
                // {
                //     ApplicationArea = All;
                //     Importance = Standard;
                //     ToolTip = 'Specifies the value of the Request Date field.';
                // }
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
        }
    }
}
