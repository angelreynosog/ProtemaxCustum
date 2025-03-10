tableextension 80101 "DG Vendor" extends Vendor
{
    fields
    {
        field(80100; "DG Generic Vendor"; Boolean)
        {
            Caption = 'DG Generic Vendor';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "DG Generic Vendor" then
                    ValidateMoreVendor();
            end;
        }
    }

    local procedure ValidateMoreVendor()
    var
        Vendor: Record Vendor;
        CountRecord: Integer;
        VendorMoreErr: Label 'It is not possible to select more than one supplier with this option.';
    begin
        Vendor.Reset();
        Vendor.SetRange("DG Generic Vendor", true);
        CountRecord := Vendor.Count;

        if CountRecord = 1 then
            Error(VendorMoreErr);
    end;
}