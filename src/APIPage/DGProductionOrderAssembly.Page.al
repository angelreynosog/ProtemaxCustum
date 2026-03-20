page 80125 "DG Production Order Assembly"
{
    PageType = API;
    APIPublisher = 'ditech';
    APIGroup = 'dg';
    APIVersion = 'v2.0';
    EntityName = 'dgProductionOrderAssembly';
    EntitySetName = 'dgProductionOrderAssembly';
    SourceTable = "Production Order";
    DelayedInsert = true;
    ChangeTrackingAllowed = true;
    ODataKeyFields = Status, "No.";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(status; Rec.Status)
                { }
                field(no; Rec."No.")
                { }
                field(description; Rec.Description)
                { }
                field(description2; Rec."Description 2")
                { }
                field(descriptionDetails; Rec."DG Description Details")
                { }
                field(sourceType; Rec."Source Type")
                { }
                field(sourceNo; Rec."Source No.")
                { }
                field(endingDate; Rec."Ending Date")
                { }
                field(quantity; Rec.Quantity)
                { }
                field(orderNumberCRM; Rec."DG Order Number CRM")
                { }
                field(orderWorkCRM; Rec."DG Order Work CRM")
                { }
                field(blocked; Rec.Blocked)
                { }
            }
        }
    }

    trigger OnInit()
    begin
        Rec.SetRange(Status, Rec.Status::Released);
    end;
}