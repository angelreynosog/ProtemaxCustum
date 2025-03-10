table 80110 "DG Setup Custom"
{
    Caption = 'DG Setup Custom';
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
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

}