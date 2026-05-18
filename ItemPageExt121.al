pageextension 50121 ItemCardWoocommerce extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field(WoocommerceID; Rec."WoocommerceID")
            {
                ApplicationArea = All;
                Importance = Promoted;
                ShowMandatory = true;
                ToolTip = 'Specifies the Woocommerce ID for the item.';

                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
            field(Availability; Rec."Availability")
            {
                ApplicationArea = All;
                Importance = Promoted;
                ShowMandatory = true;
                ToolTip = 'Specifies the availability of the item.';

                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;

            }


        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}