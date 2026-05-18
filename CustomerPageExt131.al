pageextension 50131 CustomerPageID extends "Customer Card"
{
    layout
    {
        addlast(General)
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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}