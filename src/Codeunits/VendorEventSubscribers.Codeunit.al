codeunit 71005 "Vendor Event Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterInsertEvent', '', false, false)]
    local procedure VendorOnAfterInsert(var Rec: Record Vendor; RunTrigger: Boolean)
    begin
        CreateWatchEntry(Rec, Enum::"Vendor Operation Type"::Insert);
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterDeleteEvent', '', false, false)]
    local procedure VendorOnAfterDelete(var Rec: Record Vendor; RunTrigger: Boolean)
    begin
        CreateWatchEntry(Rec, Enum::"Vendor Operation Type"::Delete);
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterModifyEvent', '', false, false)]
    local procedure VendorOnAfterModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    begin
        if not HasMeaningfulChange(Rec, xRec) then
            exit;

        CreateWatchEntry(Rec, Enum::"Vendor Operation Type"::Modify);
    end;

    local procedure HasMeaningfulChange(var Vendor: Record Vendor; var xVendor: Record Vendor): Boolean
    begin
        exit(
            (Vendor.Name <> xVendor.Name) or
            (Vendor.Address <> xVendor.Address) or
            (Vendor.City <> xVendor.City) or
            (Vendor."Phone No." <> xVendor."Phone No.") or
            (Vendor."E-Mail" <> xVendor."E-Mail") or
            (Vendor."VAT Registration No." <> xVendor."VAT Registration No.") or
            (Vendor.Blocked <> xVendor.Blocked)
        );
    end;

    local procedure CreateWatchEntry(var Vendor: Record Vendor; OperationType: Enum "Vendor Operation Type")
    var
        WatchEntry: Record "Vendor Watch Entry";
        VendorSetup: Record "Vendor Watch Setup";
    begin
        if not VendorSetup.Get() then
            exit;

        if not VendorSetup.Enabled then
            exit;

        WatchEntry.Init();
        WatchEntry."Vendor No." := Vendor."No.";
        WatchEntry."Vendor Name" := Vendor.Name;
        WatchEntry."Operation Type" := OperationType;
        WatchEntry.Status := Enum::"Vendor Watch Status"::Pending;
        WatchEntry."Captured Date Time" := CurrentDateTime();
        WatchEntry."User ID" := CopyStr(UserId(), 1, 50);

        WatchEntry.Insert();
    end;
}
