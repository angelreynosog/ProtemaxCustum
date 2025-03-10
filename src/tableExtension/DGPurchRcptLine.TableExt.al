tableextension 80110 "DG Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(80100; "DG No. Guide Recep./Origen DUA"; Text[1024])
        {
            Caption = 'No. Guide Recep./Origen DUA/Direct Invoice';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Header"."DG No. Guide Recep./Origen DUA" where("No." = field("Document No.")));
        }
    }
}