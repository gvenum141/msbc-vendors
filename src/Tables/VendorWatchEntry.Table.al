table 71001 "Vendor Watch Entry"
{
    Caption = 'Vendor Watch Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(10; "Vendor No."; Code[20])
        {
        }

        field(20; "Vendor Name"; Text[100])
        {
        }

        field(30; "Operation Type"; Enum "Vendor Operation Type")
        {
        }

        field(40; Status; Enum "Vendor Watch Status")
        {
        }

        field(50; Attempts; Integer)
        {
        }

        field(60; "Captured Date Time"; DateTime)
        {
        }

        field(70; "Processed Date Time"; DateTime)
        {
        }

        field(80; "Error Message"; Text[250])
        {
        }

        field(90; "User ID"; Code[50])
        {
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(StatusKey; Status)
        {
        }

        key(DateKey; "Captured Date Time")
        {
        }
    }
}