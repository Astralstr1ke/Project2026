pageextension 50126 MyExtension extends "Sales Order List"
{
    layout
    {
        addfirst(factboxes)
        {
            part(Chart; "Sales Order Chart")
            {
                ApplicationArea = All;

            }
        }
        // Add changes to page layout here
    }

    actions
    {
        addfirst(navigation)
        {

            action("TestAuto")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin

                    OrderWebhook.ReceiveWebhook('test');
                end;
            }
        }
    }
    var
        OrderWebhook: Codeunit "OrderWebhook";
        JObject: JsonObject;

}