codeunit 50128 ChartCU
{
    trigger OnRun()
    begin

    end;

    var
        ChartSetup: Record "ChartSetup";

    procedure GetChartSetup(var BusinessChartBuffer: Record "Business Chart Buffer"): Record "Business Chart Buffer"
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        Indeex: Integer;
        QtyPerItem: Dictionary of [Code[20], Decimal];
        ItemNo: Code[20];
        Qty: Decimal;

    begin
        ChartSetup.SetRange("Item ID", ItemLedgEntry."Item No.");
        with BusinessChartBuffer do begin
            BusinessChartBuffer.Initialize();
            AddMeasure('Quantity', 1, "Data Type"::Decimal, ChartSetup."Chart Type");
            SetXAxis('Item No.', "Data Type"::String);
            ItemLedgEntry.SetRange(
               "Entry Type",
               ItemLedgEntry."Entry Type"::Sale);

            if ItemLedgEntry.FindSet() then
                repeat
                    ItemNo := ItemLedgEntry."Item No.";
                    Qty := Abs(ItemLedgEntry.Quantity);


                    if QtyPerItem.ContainsKey(ItemNo) then begin
                        QtyPerItem.Set(
                            ItemNo,
                            QtyPerItem.Get(ItemNo) + Qty);

                    end
                    else begin
                        QtyPerItem.Add(ItemNo, Qty);

                    end;
                until ItemLedgEntry.Next() = 0;


            foreach ItemNo in QtyPerItem.Keys do
                Addcolumn(
                    Format(ItemNo));
            Setvaluebyindex(
                0,
                Indeex,
                Format(QtyPerItem.Get(ItemNo)));
        end;
    end;
}