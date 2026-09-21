permissionset 71001 "Vendor Watch"
{
    Assignable = true;
    Caption = 'Vendor Watch';

    Permissions =
        tabledata "Vendor Watch Entry" = RIM,
        tabledata "Vendor Watch Setup" = RIM,
        tabledata "Job Queue Entry" = RI,
        codeunit "Vendor Event Subscribers" = X,
        codeunit "Vendor Watch Install" = X,
        codeunit "Vendor Watch Processor" = X,
        page "Vendor Watch Entries" = X,
        page "Vendor Watch Entries API" = X,
        page "Vendor Watch Setup" = X;
}
