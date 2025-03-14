table 80110 "DG Protemax Setup Custom"
{
    Caption = 'DG Protemax Setup Custom';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Jnl. Templ. Name Payroll"; Code[10])
        {
            Caption = 'Journal Template Nam Payroll';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(3; "Jnl Batch Name Payroll"; Code[10])
        {
            Caption = 'Journal Batch Name Payroll';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Jnl. Templ. Name Payroll"));
        }
        field(4; "Jnl. Templ. Name Detraction"; Code[10])
        {
            Caption = 'Journal Template Nam Detraction';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(5; "Jnl Batch Name Detraction"; Code[10])
        {
            Caption = 'Journal Batch Name Detraction';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Jnl. Templ. Name Detraction"));
        }
        field(6; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(7; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

}