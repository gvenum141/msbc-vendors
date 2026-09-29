/// <summary>
/// Configures the Vendor Watch processing settings.
/// </summary>
page 71002 "Vendor Watch Setup"
{
    PageType = Card;
    SourceTable = "Vendor Watch Setup";
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Vendor Watch Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies whether the Vendor Watch feature is enabled.';
                }

                field("Batch Size"; Rec."Batch Size")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of vendor watch entries to process in a single batch.';
                }

                field("Max Attempts"; Rec."Max Attempts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum number of attempts to process a vendor watch entry before marking it as failed.';
                }

                field("Failure Vendor No."; Rec."Failure Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number for which processing will be intentionally failed for testing purposes.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}