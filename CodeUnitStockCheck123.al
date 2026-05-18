codeunit 50123 StockCheck
{
    trigger OnRun()
    var
        ItemList: Text;
    begin
        ItemList := FindLowStockItems();
        if ItemList <> '' then begin
            SendStockNotificationAutomatically(ItemList);
        end;


    end;



    procedure FindLowStockItems(): Text
    var
        Item: Record Item;
        ItemList: Text;
        CRLF: Text[2];

    begin
        CRLF[1] := 13;
        CRLF[2] := 10;
        Item.Reset();
        Item.SetAutoCalcFields(Inventory);
        Item.SetFilter(Item."Inventory", '<%1', Item."Safety Stock Quantity"); //returns nothing for some reason, even though there are items with inventory below safety stock

        if Item.FindSet() then begin
            repeat
                ItemList += 'ItemNo: ' + Format(Item."No.") + ' ' + Format(Item."Description") + ', Current stock: ' + Format(Item."Inventory") + ', out of minimum stock: ' + Format(Item."Safety Stock Quantity") + CRLF;
            until Item.Next() = 0;
        end;
        exit(ItemList);
    end;

    procedure SendStockNotificationAutomatically(Message: Text)
    var

        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        CRLF: Text[2];


    begin
        CRLF[1] := 13;
        CRLF[2] := 10;

        EmailMessage.Create(
            'holynoob212@gmail.com',
            'Restock Notification',
            'Items below safety stock level:' + CRLF + Message,
            false);

        Email.Send(EmailMessage, Enum::"Email Scenario"::"Restock Notification");
    end;
}