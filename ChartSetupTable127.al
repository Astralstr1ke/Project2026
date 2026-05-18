table 50127 "ChartSetup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(3; "Chart Type"; Option)
        {
            OptionMembers = Column,Bar,Line,Pie;
            OptionCaption = 'Column,Bar,Line,Pie';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Item ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}