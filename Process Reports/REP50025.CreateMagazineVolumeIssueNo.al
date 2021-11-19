Report 50025 "Create Magazine/Volume/IssueNo"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   -Circulation Module - Create Magazine/Volume/IssueNo.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Issue No."; "Issue No.")
        {
            DataItemTableView = sorting(Code);
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MagazineVolumeIssue.Init;
                MagazineVolumeIssue.Validate("Magazine Code", Magazine."Sub Product Code");
                MagazineVolumeIssue.Validate("Volume No.", VolumeNo);
                MagazineVolumeIssue.Validate("Issue No.", Code);
                MagazineVolumeIssue.Validate("Issue Date", StartIssueDate);
                MagazineVolumeIssue."Unit Price" := Magazine."Unit Price";
                MagazineVolumeIssue.Validate("Magazine Item Nos.", Magazine."Magazine Item Nos.");
                MagazineVolumeIssue.Insert;
                StartIssueDate := CalcDate(StrSubstNo('CD + %1', Frequency."Date Formula"), StartIssueDate);
            end;

            trigger OnPreDataItem()
            begin
                Copy(IssueNo);
                Magazine.Get(MagazineCode);
                Magazine.TestField(Frequency);
                Frequency.Get(Magazine.Frequency);
                Frequency.TestField("Date Formula");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(MagazineCode; MagazineCode)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Magazine Code';
                        TableRelation = "Sub Product";
                    }
                    field(VolumeNo; VolumeNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Volume No.';
                        TableRelation = Volume;
                    }
                    field(FromIssue; FromIssue)
                    {
                        ApplicationArea = Basic;
                        Caption = 'From Issue No.';
                        TableRelation = "Issue No.";
                    }
                    field(ToIssue; ToIssue)
                    {
                        ApplicationArea = Basic;
                        Caption = 'To Issue No.';
                        TableRelation = "Issue No.";
                    }
                    field(StartIssueDate; StartIssueDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Starting Issue Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if MagazineCode = '' then
            Error(StrSubstNo(Text000, 'Magazine Code'));
        if VolumeNo = '' then
            Error(StrSubstNo(Text000, 'Volume No.'));
        if FromIssue = '' then
            Error(StrSubstNo(Text000, 'From Issue No.'));
        if ToIssue = '' then
            Error(StrSubstNo(Text000, 'To Issue No.'));
        if StartIssueDate = 0D then
            Error(StrSubstNo(Text000, 'Starting Issue Date'));
        IssueNo.SetRange(Code, FromIssue, ToIssue);
        IssueNo.FindFirst;
    end;

    var
        MagazineVolumeIssue: Record "Magazine/Volume/Issue - Matrix";
        Magazine: Record "Sub Product";
        Frequency: Record Frequency;
        IssueNo: Record "Issue No.";
        MagazineCode: Code[20];
        VolumeNo: Code[20];
        FromIssue: Code[20];
        ToIssue: Code[20];
        StartIssueDate: Date;
        Text000: label '%1 must be specify.';
}

