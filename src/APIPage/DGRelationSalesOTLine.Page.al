namespace ProtemaxCustum.ProtemaxCustum;

page 80124 "DG Relation Sales & OT Line"
{
    PageType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgRelationSalesLineOT';
    EntitySetName = 'dgRelationSalesLineOT';
    SourceTable = "DG Relation Sales & OT Line";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    ChangeTrackingAllowed = true;
    Permissions = tabledata "DG Relation Sales & OT Line" = rimd;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(orderWordDocument; Rec."Order Word Document")
                { }
                field(no; Rec."No.")
                { }
                field(statusCRM; Rec."Status CRM")
                { }
                field(readyPosted; Rec."Ready Posted")
                { }
                field(canceledPosted; Rec."Canceled Posted")
                { }
                field(lineNo; Rec."Line No.")
                { }
                field(systemId; Rec.SystemId)
                { }
            }
        }
    }
}
