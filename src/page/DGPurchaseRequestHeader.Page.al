page 80100 "DG Purchase Request Header"
{
    Caption = 'DG Purchase Request Header';
    PageType = Document;
    SourceTable = "DG Purchase Request Header";
    SourceTableView = where("Document Type" = const(Request));
    UsageCategory = None;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Create Date"; Rec."Create Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                }
            }
            part(PurchRequestLines; "DG Purchase Request Line")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                UpdatePropagation = Both;
                Caption = 'Lines';
            }
        }
    }
}
