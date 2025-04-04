page 80118 "DG Sales Invoice Line API"
{
    PageType = API;
    Caption = 'DG Sales Invoice Line';
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgSaleLine';
    EntitySetName = 'dgSaleLine';
    SourceTable = "Sales Line";
    ODataKeyFields = "DG Code System Id";
    DelayedInsert = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(codeSystemId; Rec."DG Code System Id")
                { }
                field(documentType; Rec."Document Type")
                { }
                field(documentNo; Rec."Document No.")
                { }
                field(lineNo; Rec."Line No.")
                { }
                field(type; Rec.Type)
                { }
                field(no; Rec."No.")
                { }
                field(locationCode; Rec."Location Code")
                { }
                field(unitMeasureCode; Rec."Unit of Measure Code")
                { }
                field(quantity; Rec.Quantity)
                { }
                field(unitPrice; Rec."Unit Price")
                { }
            }
        }
    }
}