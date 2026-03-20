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
