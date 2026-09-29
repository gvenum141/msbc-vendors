page 71001 "Vendor Watch Entries"
{
    PageType = List;
    SourceTable = "Vendor Watch Entry";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Vendor Watch Entries';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the entry number.';
                }

                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number.';
                }

                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name.';
                }

                field("Operation Type"; Rec."Operation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the operation type.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the vendor watch entry.';
                }

                field(Attempts; Rec.Attempts)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of attempts made to process the vendor watch entry.';
                }

                field("Captured Date Time"; Rec."Captured Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date and time when the vendor watch entry was captured.';
                }
            }
        }
    }
}