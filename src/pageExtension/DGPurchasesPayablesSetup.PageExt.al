pageextension 80104 "DG Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("DG Request Nos."; Rec."DG Request Nos.")
            {
                ApplicationArea = All;
            }
        }

        addafter("Default Accounts")
        {
            group("DG Layout Purchase Order")
            {
                field("DG Purchase Order Footer Text"; Rec."DG Purchase Order Footer Text")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}