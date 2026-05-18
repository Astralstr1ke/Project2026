page 50101 "Sales Order Chart"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = "Business Chart Buffer";


    layout
    {

        area(content)
        {
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;


                trigger AddInReady()
                begin
                    UpdateChart();
                end;

                trigger Refresh()
                begin
                    UpdateChart();
                end;

                trigger DataPointClicked(Point: JsonObject)
                begin
                end;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Chart Setup")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Page.RunModal(Page::ChartPage);
                    UpdateChart();
                end;
            }
        }
    }
    var
        //ChartSetup: Codeunit "ChartCU";
        BusinessChartBuffer: Record "Business Chart Buffer" temporary;
        ItemLedgEntry: Record "Item Ledger Entry";
        Indeex: Integer;
        QtyPerItem: Dictionary of [Code[20], Decimal];
        ItemNo: Code[20];
        Qty: Decimal;
        ChartSetup: Codeunit "ChartCU";

    local procedure UpdateChart()
    begin
        BusinessChartBuffer := ChartSetup.GetChartSetup(BusinessChartBuffer);
        //GetChartSetup();
    end;
    /* Attempt to move the code from ChartCU to here, to fix the issue, need to investigate more on this.
        local procedure GetChartSetup()
        var
            ChartSetup: Record "ChartSetup";
        begin
            ChartSetup.SetRange("Item ID", ItemLedgEntry."Item No.");
            BusinessChartBuffer.Initialize();
            BusinessChartBuffer.AddMeasure('Quantity', 1, BusinessChartBuffer."Data Type"::Decimal, ChartSetup."Chart Type");
            BusinessChartBuffer.SetXAxis('Item No.', BusinessChartBuffer."Data Type"::Decimal);
            //Message('check1');
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
                BusinessChartBuffer.Addcolumn(
                    Format(ItemNo));
            BusinessChartBuffer.Setvaluebyindex(
                0,
                Indeex,
                Format(QtyPerItem.Get(ItemNo)));
            //Message('check2');
        end;
    */
}