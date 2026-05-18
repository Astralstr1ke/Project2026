page 50128 ChartPage
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ChartSetup;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Chart Type"; Rec."Chart Type")
                {
                    ApplicationArea = All;
                }



            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
    trigger OnOpenPage()

    begin

    end;
}