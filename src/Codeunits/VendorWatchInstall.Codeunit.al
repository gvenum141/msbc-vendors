// codeunit 71000 "Vendor Watch Install"
// {
//     Subtype = Install;

//     trigger OnInstallAppPerCompany()
//     begin
//         CreateSetup();
//         CreateJobQueueEntry();
//     end;

//     local procedure CreateSetup()
//     var
//         VendorSetup: Record "Vendor Watch Setup";
//     begin
//         if VendorSetup.Get() then
//             exit;

//         VendorSetup.Init();
//         VendorSetup.Enabled := false;
//         VendorSetup."Batch Size" := 100;
//         VendorSetup."Max Attempts" := 3;
//         VendorSetup.Insert();
//     end;

//     local procedure CreateJobQueueEntry()
//     var
//         JobQueueEntry: Record "Job Queue Entry";
//     begin
//         JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
//         JobQueueEntry.SetRange("Object ID to Run", Codeunit::"Vendor Watch Processor");
//         if JobQueueEntry.FindFirst() then
//             exit;

//         JobQueueEntry.Init();
//         JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
//         JobQueueEntry."Object ID to Run" := Codeunit::"Vendor Watch Processor";
//         JobQueueEntry.Description := 'Vendor Watch Processor';
//         JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime();
//         JobQueueEntry."Recurring Job" := true;
//         JobQueueEntry."No. of Minutes between Runs" := 5;
//         JobQueueEntry.Insert(true);
//     end;
// }
