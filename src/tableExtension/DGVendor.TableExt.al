tableextension 80101 "DG Vendor" extends Vendor
{
    fields
    {
        field(80100; "DG General Quote Vendor"; Boolean)
        {
            Caption = 'General Quote Vendor';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "DG General Quote Vendor" then
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
        Vendor.SetRange("DG General Quote Vendor", true);
        CountRecord := Vendor.Count;

        if CountRecord = 1 then
            Error(VendorMoreErr);
    end;
}