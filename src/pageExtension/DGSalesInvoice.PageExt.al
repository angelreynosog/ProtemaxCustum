pageextension 80115 "DG Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addlast("Invoice Details")
        {
            field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
            {
                ApplicationArea = All;
            }
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
            }

        }
    }
}