page 71004 "Vendor Watch Setup"
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
                }

                field("Batch Size"; Rec."Batch Size")
                {
                    ApplicationArea = All;
                }

                field("Max Attempts"; Rec."Max Attempts")
                {
                    ApplicationArea = All;
                }

                field("Failure Vendor No."; Rec."Failure Vendor No.")
                {
                    ApplicationArea = All;
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