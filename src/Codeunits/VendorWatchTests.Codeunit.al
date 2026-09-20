// codeunit 71001 "Vendor Watch Tests"
// {
//     Subtype = Test;

//     [Test]
//     procedure ProcessorHonorsBatchSize()
//     var
//         VendorSetup: Record "Vendor Watch Setup";
//         WatchEntry: Record "Vendor Watch Entry";
//         FirstEntryNo: Integer;
//         SecondEntryNo: Integer;
//     begin
//         PrepareTestData(VendorSetup, 1, 3, '');
//         FirstEntryNo := CreatePendingEntry('BATCH-1');
//         SecondEntryNo := CreatePendingEntry('BATCH-2');

//         Codeunit.Run(Codeunit::"Vendor Watch Processor");

//         WatchEntry.Get(FirstEntryNo);
//         AssertStatus(WatchEntry, Enum::"Vendor Watch Status"::Sent);
//         WatchEntry.Get(SecondEntryNo);
//         AssertStatus(WatchEntry, Enum::"Vendor Watch Status"::Pending);
//     end;

//     [Test]
//     procedure ProcessorStopsRetryingAtMaxAttempts()
//     var
//         VendorSetup: Record "Vendor Watch Setup";
//         WatchEntry: Record "Vendor Watch Entry";
//         EntryNo: Integer;
//     begin
//         PrepareTestData(VendorSetup, 1, 2, 'FAIL-1');
//         EntryNo := CreatePendingEntry('FAIL-1');

//         Codeunit.Run(Codeunit::"Vendor Watch Processor");
//         Codeunit.Run(Codeunit::"Vendor Watch Processor");

//         WatchEntry.Get(EntryNo);
//         if WatchEntry.Attempts <> 2 then
//             Error('Expected 2 attempts, got %1.', WatchEntry.Attempts);

//         AssertStatus(WatchEntry, Enum::"Vendor Watch Status"::Failed);
//         if WatchEntry."Error Message" = '' then
//             Error('Expected a failure message.');
//     end;

//     local procedure PrepareTestData(
//         var VendorSetup: Record "Vendor Watch Setup";
//         BatchSize: Integer;
//         MaxAttempts: Integer;
//         FailureVendorNo: Code[20])
//     var
//         WatchEntry: Record "Vendor Watch Entry";
//     begin
//         WatchEntry.DeleteAll();
//         VendorSetup.DeleteAll();
//         VendorSetup.Init();
//         VendorSetup.Enabled := true;
//         VendorSetup."Batch Size" := BatchSize;
//         VendorSetup."Max Attempts" := MaxAttempts;
//         VendorSetup."Failure Vendor No." := FailureVendorNo;
//         VendorSetup.Insert();
//     end;

//     local procedure CreatePendingEntry(VendorNo: Code[20]): Integer
//     var
//         WatchEntry: Record "Vendor Watch Entry";
//     begin
//         WatchEntry.Init();
//         WatchEntry."Vendor No." := VendorNo;
//         WatchEntry.Status := Enum::"Vendor Watch Status"::Pending;
//         WatchEntry."Captured Date Time" := CurrentDateTime();
//         WatchEntry.Insert();
//         exit(WatchEntry."Entry No.");
//     end;

//     local procedure AssertStatus(
//         WatchEntry: Record "Vendor Watch Entry";
//         ExpectedStatus: Enum "Vendor Watch Status")
//     begin
//         if WatchEntry.Status <> ExpectedStatus then
//             Error('Expected status %1, got %2.', ExpectedStatus, WatchEntry.Status);
//     end;
// }
