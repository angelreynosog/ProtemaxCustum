page 80108 "DG General Journal API"
{
    PageType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgGeneralJournal';
    EntitySetName = 'dgGeneralJournal';
    SourceTable = "DG General Journal";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    ChangeTrackingAllowed = true;
    Permissions = tabledata "DG General Journal" = RIMD,
                  tabledata "DG General Journal Line" = RIMD;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(code; Rec.Code)
                { }
                field(description; Rec.Description)
                { }
                field(startDate; Rec."Start Date")
                { }
                field(endDate; Rec."End Date")
                { }
                field(month; Rec.Month)
                { }

                part(dgGeneralJournalLine; "DG General Journal Line API")
                {
                    EntitySetName = 'dgGeneralJournalLine';
                    EntityName = 'dgGeneralJournalLine';
                    SubPageLink = "Code System Id" = field(SystemId);
                }
                field(systemId; Rec.SystemId)
                { }
            }
        }
    }
}