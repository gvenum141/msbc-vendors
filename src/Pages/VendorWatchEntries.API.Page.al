page 71007 "Vendor Watch Entries API"
{
    PageType = API;
    SourceTable = "Vendor Watch Entry";
    APIPublisher = 'interview';
    APIGroup = 'api';
    APIVersion = 'v1.0';
    EntityName = 'vendorWatchEntry';
    EntitySetName = 'vendorWatchEntries';
    ODataKeyFields = SystemId;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                }

                field(entryNo; Rec."Entry No.")
                {
                }

                field(vendorNo; Rec."Vendor No.")
                {
                }

                field(vendorName; Rec."Vendor Name")
                {
                }

                field(operationType; Rec."Operation Type")
                {
                }

                field(status; Rec.Status)
                {
                }

                field(attempts; Rec.Attempts)
                {
                }

                field(capturedDateTime; Rec."Captured Date Time")
                {
                }

                field(processedDateTime; Rec."Processed Date Time")
                {
                }

                field(errorMessage; Rec."Error Message")
                {
                }

                field(userId; Rec."User ID")
                {
                }
            }
        }
    }
}
