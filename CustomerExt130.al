tableextension 50130 CustomerWooID extends "Customer"
{
    fields
    {
        field(1000; WooCommerceID; Code[20])
        {
            Caption = 'the Corresponding Woocommerce Customer ID';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin


            end;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}