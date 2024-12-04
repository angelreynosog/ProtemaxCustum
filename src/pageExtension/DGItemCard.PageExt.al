pageextension 80102 "DG Item Card" extends "Item Card"
{
    layout
    {
        addafter(Inventory)
        {
            field("Inventory Without Obs. Whs."; "InventoryWithoutObsWhs")
            {
                Caption = 'Inventory Without Obsolete WareHouses';
                Editable = false;
                DecimalPlaces = 0 : 5;
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    ItemLedgerEntry: Record "Item Ledger Entry";
                begin
                    GetOnDrillDownQtyInventoryObsolete(Rec."No.", ItemLedgerEntry);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetQuantityInvetoryWithoutObsoloteWarehouse();
    end;

    local procedure GetQuantityInvetoryWithoutObsoloteWarehouse()
    var
        DGManagament: Codeunit "DG Managament";
    begin
        Clear(InventoryWithoutObsWhs);
        DGManagament.GetQtyInventoryObsolete(Rec."No.", InventoryWithoutObsWhs);
    end;

    procedure GetOnDrillDownQtyInventoryObsolete(ItemNo: Code[20]; var ItemLedgerEntry: Record "Item Ledger Entry")
    var
        Location: Record Location;
        LocationCodeEntry: Code[10];
        LocationCode: List of [Code[10]];
        LocationFilter: Text;
    begin
        Location.Reset();
        Location.SetRange("DG Mark Obsolete Inventory", true);
        if Location.FindSet() then
            repeat
                LocationCode.Add(Location.Code);
            until Location.Next() = 0;

        foreach LocationCodeEntry in LocationCode do
            if LocationFilter = '' then
                LocationFilter := '<>' + LocationCodeEntry
            else
                LocationFilter += ' &<> ' + LocationCodeEntry;

        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        if LocationFilter <> '' then
            ItemLedgerEntry.SetFilter("Location Code", LocationFilter);

        Page.Run(Page::"Item Ledger Entries", ItemLedgerEntry);
    end;

    var
        InventoryWithoutObsWhs: Decimal;
}