tableextension 80112 "DG Sales Header" extends "Sales Header"
{
    fields
    {
        field(80100; "DG Non-Billable Invoice"; Boolean)
        {
            Caption = 'Non-Billable Invoice';
        }
        field(80101; "DG Order Terminated"; Integer)
        {

            Caption = 'Order Terminated';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "DG Relation Sales & OT" where("Order Id CRM" = field("Your Reference"));
            CalcFormula = count("DG Relation Sales & OT" where("Order Id CRM" = field("Your Reference")));
        }
        field(80102; "DG Completion Consumption"; Option)
        {
            Caption = 'Completion Consumption';
            OptionCaption = ' ,Yes,No';
            OptionMembers = ,Yes,No;
        }
        field(80103; "DG Order Number CRM"; Text[100])
        {
            Caption = 'Order Number CRM';
        }
        field(80104; "DG Direct Sales"; Boolean)
        {
            Caption = 'Direct Sales';
            trigger OnValidate()
            var
                DGProtemaxSetupCustom: Record "DG Protemax Setup Custom";
                SalesLine: Record "Sales Line";
            begin
                DGProtemaxSetupCustom.Get();
                DGProtemaxSetupCustom.TestField("Location Direct Sales");
                if "DG Direct Sales" then begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    if SalesLine.FindSet() then
                        repeat
                            SalesLine.Validate("Location Code", DGProtemaxSetupCustom."Location Direct Sales");
                            SalesLine.Modify();
                        until SalesLine.Next() = 0;
                end;
            end;
        }
        field(80105; "DG Channel"; Text[250])
        {
            Caption = 'Channel';
        }
    }
}