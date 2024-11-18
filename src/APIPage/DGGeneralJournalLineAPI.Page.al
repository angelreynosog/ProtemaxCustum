page 80109 "DG General Journal Line API"
{
    PageType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgGeneralJournalLine';
    EntitySetName = 'dgGeneralJournalLine';
    SourceTable = "DG General Journal Line";
    ODataKeyFields = "Code System Id";
    DelayedInsert = true;
    Permissions = tabledata "DG General Journal Line" = RIMD,
                  tabledata "DG General Journal" = RIMD;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codeId; Rec."Code System Id")
                { }
                field(systemId; Rec.SystemId)
                { }
                field(code; Rec.Code)
                { }
                field(lineNo; Rec."Line No.")
                { }
                field(accountNo; Rec."Account No.")
                { }
                field(description; Rec.Description)
                { }
                field(amount; Rec.Amount)
                { }
                field(dimensionCode1; Rec."Dimension 1")
                { }
                field(dimensionCode2; Rec."Dimension 2")
                { }
                field(dimensionCode3; Rec."Dimension 3")
                { }
                field(dimensionCode4; Rec."Dimension 4")
                { }
                field(dimensionCode5; Rec."Dimension 5")
                { }
                field(dimensionCode6; Rec."Dimension 6")
                { }
                field(dimensionCode7; Rec."Dimension 7")
                { }
                field(dimensionCode8; Rec."Dimension 8")
                { }
            }
        }
    }
}