page 80118 "DG Sales Line API"
{
    PageType = API;
    Caption = 'Sales Line';
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgSaleLine';
    EntitySetName = 'dgSaleLine';
    SourceTable = "Sales Line";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(documentType; Rec."Document Type")
                { }
                field(documentNo; Rec."Document No.")
                { }
            }
        }
    }
}