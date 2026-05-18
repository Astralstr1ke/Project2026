codeunit 50129 OrderWebhook
{
    var
        CustomerNo: Text;
        ProductId: Text;
        Item: Record Item;

    [ServiceEnabled]
    procedure ReceiveWebhook(InputJson: Text)
    var
        JObject: JsonObject;
        Token: JsonToken;
    begin
        Error(Format(InputJson));

        JObject.ReadFrom(InputJson);

        if JObject.Get('customerid', Token) then
            CustomerNo := Token.AsValue().AsCode();
        if JObject.Get('productid', Token) then
            ProductId := Token.AsValue().AsCode();

        CreateSalesOrder();
    end;

    local procedure CreateSalesOrder()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        CusmerNumberReal: Code[20];
    begin
        SalesHeader.Init();
        SalesHeader."Document Type" :=
        SalesHeader."Document Type"::Order;
        SalesHeader.Insert(true);
        Item.SetRange("WoocommerceID", ProductId);
        if Item.FindFirst() then begin
            SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
        end;

        SalesHeader.Modify(true);
        //Message(Format(SalesHeader));
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";

        SalesLine.Validate("No.", Item."No.");
        SalesLine.Validate(Quantity, 5);
        SalesLine.Insert(true);


        //Message(
        //    'Sales Order %1 created',
        //    SalesHeader."No.");
    end;

    local procedure SendOrderConfirmation()
    var

        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        CRLF: Text[2];


    begin
        CRLF[1] := 13;
        CRLF[2] := 10;

        EmailMessage.Create(
            'holynoob212@gmail.com',
            'Order confirmation',
            'Item: ' + Item."No." + CRLF +
            'Quantity: ' + Format(5) + CRLF +
            'Thank you for your order!',
            false);

        Email.Send(EmailMessage, Enum::"Email Scenario"::"Sales Order");
    end;
}