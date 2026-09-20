codeunit 71006 "Vendor Watch Processor"
{
    trigger OnRun()
    begin
        ProcessPendingEntries();
    end;

    local procedure ProcessPendingEntries()
    var
        WatchEntry: Record "Vendor Watch Entry";
        VendorSetup: Record "Vendor Watch Setup";
        ProcessedCount: Integer;
    begin
        if not VendorSetup.Get() then
            Error('Vendor Watch Setup does not exist.');

        if VendorSetup."Batch Size" <= 0 then
            exit;

        WatchEntry.SetRange(Status, Enum::"Vendor Watch Status"::Pending);

        if WatchEntry.FindSet(true) then
            repeat
                ProcessEntry(WatchEntry, VendorSetup);

                ProcessedCount += 1;

                if ProcessedCount >= VendorSetup."Batch Size" then
                    exit;

            until WatchEntry.Next() = 0;
    end;

    local procedure ProcessEntry(
    var WatchEntry: Record "Vendor Watch Entry";
    Setup: Record "Vendor Watch Setup")
    begin
        ClearLastError();

        if TryProcessEntry(WatchEntry, Setup) then
            MarkAsSent(WatchEntry)
        else
            HandleFailure(WatchEntry, Setup);
    end;

    [TryFunction]
    local procedure TryProcessEntry(
    var WatchEntry: Record "Vendor Watch Entry";
    Setup: Record "Vendor Watch Setup")
    begin
        if (Setup."Failure Vendor No." <> '') and
           (WatchEntry."Vendor No." = Setup."Failure Vendor No.") then
            Error('Configured failure for vendor %1.', WatchEntry."Vendor No.");
    end;

    local procedure MarkAsSent(
    var WatchEntry: Record "Vendor Watch Entry")
    begin
        WatchEntry.Status := Enum::"Vendor Watch Status"::Sent;
        WatchEntry."Processed Date Time" := CurrentDateTime();
        WatchEntry."Error Message" := '';
        WatchEntry.Modify();
    end;

    local procedure HandleFailure(
        var WatchEntry: Record "Vendor Watch Entry";
        Setup: Record "Vendor Watch Setup")
    var
        ErrorText: Text;
    begin
        WatchEntry.Attempts += 1;

        ErrorText := GetLastErrorText();
        if ErrorText = '' then
            ErrorText := 'Vendor processing failed.';

        WatchEntry."Error Message" := CopyStr(ErrorText, 1, MaxStrLen(WatchEntry."Error Message"));

        if WatchEntry.Attempts >= Setup."Max Attempts" then
            WatchEntry.Status := Enum::"Vendor Watch Status"::Failed
        else
            WatchEntry.Status := Enum::"Vendor Watch Status"::Pending;

        WatchEntry.Modify();
    end;
}