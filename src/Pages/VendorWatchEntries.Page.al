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
                }

                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }

                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }

                field("Operation Type"; Rec."Operation Type")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field(Attempts; Rec.Attempts)
                {
                    ApplicationArea = All;
                }

                field("Captured Date Time"; Rec."Captured Date Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}