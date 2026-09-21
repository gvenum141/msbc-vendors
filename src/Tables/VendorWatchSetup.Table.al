/// <summary>
/// Stores the configuration for Vendor Watch.
/// </summary>
table 71000 "Vendor Watch Setup"
{
    Caption = 'Vendor Watch Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(10; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }

        field(20; "Batch Size"; Integer)
        {
            Caption = 'Batch Size';
        }

        field(30; "Max Attempts"; Integer)
        {
            Caption = 'Max Attempts';
        }

        field(40; "Failure Vendor No."; Code[20])
        {
            Caption = 'Failure Vendor No.';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}