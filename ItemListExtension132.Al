pageextension 50132 Availability extends "Item List"
{
    layout
    {
        addlast(Control1)
        {
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
        myInt: Integer;
}