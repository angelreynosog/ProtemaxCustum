page 80113 "DG Detraction List"
{
    PageType = ListPart;
    SourceTable = "DG Detraction Lot Det";
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
                field("Document Number"; Rec."Document Number")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Document Number field.';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        PurchInvHeader: Record "Purch. Inv. Header";
                        PostedPurchaseInvoice: Page "Posted Purchase Invoice";
                    begin
                        PurchInvHeader.SetRange("No.", rec."Transaction Number");

                        if PurchInvHeader.FindFirst() then begin
                            PostedPurchaseInvoice.SetRecord(PurchInvHeader);
                            PostedPurchaseInvoice.Run();
                        end;
                    end;
                }
                field("Currency Id"; Rec."Currency Id")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Document Amount field.';
                    Editable = false;
                }
                field("Document Amount"; Rec."Document Amount")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Document Amount field.';
                    Editable = false;
                }
                field("Type of Service"; Rec."Type of Service")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Type of Service field.';
                    Editable = false;
                }
                field("Purch % Detraction"; Rec."Purch % Detraction")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Purch % Detraction field.';
                    Editable = false;
                }
                field("Purch Amount Detraction"; Rec."Purch Amount Detraction")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Purch Amount Detraction field.';
                    Editable = false;
                }
                field("Bank account"; Rec."Bank account")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the Bank account field.';
                    Editable = false;
                }
            }
        }
    }

}
