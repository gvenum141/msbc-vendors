permissionset 71008 "Vendor Watch"
{
    Assignable = true;
    Caption = 'Vendor Watch';

    Permissions =
        tabledata "Vendor Watch Entry" = RIM,
        tabledata "Vendor Watch Setup" = RIM,
        codeunit "Vendor Event Subscribers" = X,
        //codeunit "Vendor Watch Install" = X,
        codeunit "Vendor Watch Processor" = X,
        //codeunit "Vendor Watch Tests" = X,
        page "Vendor Watch Entries" = X,
        page "Vendor Watch Entries API" = X,
        page "Vendor Watch Setup" = X;
}
