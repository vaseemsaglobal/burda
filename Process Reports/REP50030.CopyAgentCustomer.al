Report 50030 "Copy Agent Customer"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   30.03.2007   KKE   -Circulation Module - Copy Document Agent Customer
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    ProcessingOnly = true;

    dataset
    {
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
                    field(FromAgentCustNo; FromAgentCustNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Agent Customer No.';
                        TableRelation = "Agent Customer Header";

                        trigger OnValidate()
                        begin
                            if AgentCustHdr."No." = FromAgentCustNo then
                                Error(Text001, FromAgentCustNo);
                        end;
                    }
                    field(MagazineItemNo; Item."No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Magazine Item No.';
                        Editable = false;
                    }
                    field(IncludeHeader; IncludeHeader)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Header';
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
        if FromAgentCustNo <> '' then
            with AgentCustHdr do begin
                AgentCustNo := "No.";
                if IncludeHeader then begin
                    "Document Date" := FromAgentCustHdr."Document Date";
                    "Magazine Item No." := FromAgentCustHdr."Magazine Item No.";
                    "Magazine Code" := FromAgentCustHdr."Magazine Code";
                    "Volume No." := FromAgentCustHdr."Volume No.";
                    "Issue No." := FromAgentCustHdr."Issue No.";
                    "Issue Date" := FromAgentCustHdr."Issue Date";
                    "Salesperson Code" := FromAgentCustHdr."Salesperson Code";
                    "Location Code" := FromAgentCustHdr."Location Code";
                    "Unit of Measure Code" := FromAgentCustHdr."Unit of Measure Code";
                    Modify;
                end;
                LineNo := 0;
                AgentCustLine.Reset;
                AgentCustLine.SetRange("Agent Customer No.", AgentCustNo);
                if AgentCustLine.Find('+') then
                    LineNo := AgentCustLine."Line No.";
                FromAgentCustLine.Reset;
                FromAgentCustLine.SetRange("Agent Customer No.", FromAgentCustNo);
                if FromAgentCustLine.Find('-') then
                    repeat
                        LineNo += 10000;
                        AgentCustLine.Init;
                        AgentCustLine.TransferFields(FromAgentCustLine);
                        AgentCustLine."Agent Customer No." := AgentCustNo;
                        AgentCustLine."Line No." := LineNo;
                        AgentCustLine."Delivered Flag" := false;
                        AgentCustLine."Delivered Date" := 0D;
                        AgentCustLine."Delivered Document No." := '';
                        AgentCustLine."Delivered Document Line No." := 0;
                        AgentCustLine.Insert;
                    until FromAgentCustLine.Next = 0;
            end;
    end;

    var
        AgentCustHdr: Record "Agent Customer Header";
        FromAgentCustHdr: Record "Agent Customer Header";
        NewAgentCustHdr: Record "Agent Customer Header";
        AgentCustLine: Record "Agent Customer Line";
        FromAgentCustLine: Record "Agent Customer Line";
        Item: Record Item;
        AgentCustNo: Code[20];
        FromAgentCustNo: Code[20];
        IncludeHeader: Boolean;
        LineNo: Integer;
        Text001: label 'From Agent Customer No. must not be %1.';


    procedure SetAgentCustHdr(var NewAgentCustHdr: Record "Agent Customer Header")
    begin
        AgentCustHdr := NewAgentCustHdr;
    end;
}

