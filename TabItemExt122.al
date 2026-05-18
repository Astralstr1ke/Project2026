tableextension 50122 WooCommerceItem extends Item
{
    fields
    {

        field(130; "WoocommerceID"; code[20])
        {
            Caption = 'The Corresponding Woocommerce ID';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin

            end;

        }
        field(140; "Availability"; Option)
        {
            OptionMembers = "Online","Offline","Bothr";
            Caption = 'Availability: Online, Offline or Both';
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
