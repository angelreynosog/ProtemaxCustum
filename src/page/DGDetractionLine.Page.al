page 80113 "DG Detraction Line"
{
    PageType = ListPart;
    SourceTable = "DG Detraction Line";
    DelayedInsert = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Vendor Code field.';
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                    Editable = false;
                }
                field("Document Type Sunat"; Rec."Document Type Sunat")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Document Type Sunat field.';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        PurchInvHeader: Record "Purch. Inv. Header";
                        PostedPurchaseInvoice: Page "Posted Purchase Invoice";
                    begin
                        PurchInvHeader.SetRange("No.", Rec."Transaction Number");
                        if PurchInvHeader.FindSet() then begin
                            PostedPurchaseInvoice.SetRecord(PurchInvHeader);
                            PostedPurchaseInvoice.Run();
                        end;
                    end;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Document Amount field.';
                    Editable = false;
                }
                field("Amount Document"; Rec."Amount Document")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Amount Document field.';
                    Editable = false;
                }
                field("Type of Service"; Rec."Type of Service")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Type of Service field.';
                    Editable = false;
                }
                field("Purch. % Detraction"; Rec."Purch. % Detraction")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Purch. % Detraction field.';
                    Editable = false;
                }
                field("Purch. Amount Detraction"; Rec."Purch. Amount Detraction")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Purch. Amount Detraction field.';
                    Editable = false;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Bank Account field.';
                    Editable = false;
                }
            }
        }
    }

}