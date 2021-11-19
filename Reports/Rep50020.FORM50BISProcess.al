Report 50020 "FORM 50 BIS Process"
{
    Caption = 'FORM 50 BIS Process';
    //DefaultLayout = Word;
    //RDLCLayout = './Layouts/FORM 50 BIS.rdlc';
    //WordLayout = './Layouts/FORM 50 BIS.docx';
    //UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = all;
    WordMergeDataItem = "WHT Entry";
    ProcessingOnly = true;

    dataset
    {
        dataitem("WHT Entry"; "WHT Entry")
        {
            DataItemTableView = sorting("Document Type", "Posting Date", "WHT Certificate No.") where("Transaction Type" = const(Purchase), "Document Type" = const(Payment), Amount = filter(<> 0), Cancelled = const(false), "WHT Certificate No." = filter(<> ''));
            RequestFilterFields = "Transaction Type", "Document Type", "Document No.", "WHT Certificate No.";

            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 .. 4));


                trigger OnAfterGetRecord()
                begin

                    //if Number > NumberOfCopy then
                    //  CurrReport.Break; //VAH

                    WHTAmtLCYText := FormatNoThaiText(TotWHTAmtLCY);
                    if WHTAmtLCYText <> '' then
                        WHTAmtLCYText := '(' + WHTAmtLCYText + ')';
                    //Message(WHTSlipNo);//VAH

                end;

                trigger OnPreDataItem()
                begin

                    SetRange(Number, 1, WHTCount);//VAH
                    //SetRange(Number, 1, 1);//VAH
                    if NewDocNo = '' then
                        NewDocNo := "WHT Entry"."WHT Certificate No.";

                    WHTEntry.Copy("WHT Entry");
                    if WHTEntry.Next <> 0 then begin
                        if NewDocNo = WHTEntry."WHT Certificate No." then
                            CurrReport.Break; //VAH
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var


            begin

                if not "WHT Entry"."Certificate Printed" then begin
                    if CertCount = 1 then begin
                        CertCount += 1;
                        PurchSetup.Get();
                        BillToPayto := "WHT Entry"."Bill-to/Pay-to No.";
                        OrigDocNo := "WHT Entry"."Original Document No.";
                        if ("WHT Entry"."WHT Bus. Posting Group" = 'WHT3') then begin
                            PurchSetup.TestField("WHT3 Certificate No. Series");
                            "WHT Entry"."WHT Certificate No." :=
                                  NoSeriesMgt.GetNextNo(
                                    PurchSetup."WHT3 Certificate No. Series", "WHT Entry"."Posting Date", TRUE);
                            "Certificate Printed" := true;
                            "WHT Entry".Modify();
                            CertNo1 := "WHT Entry"."WHT Certificate No.";
                        end;
                        if ("WHT Entry"."WHT Bus. Posting Group" = 'WHT53') then begin
                            PurchSetup.TestField("WHT53 Certificate No. Series");
                            "WHT Entry"."WHT Certificate No." :=
                                  NoSeriesMgt.GetNextNo(
                                    PurchSetup."WHT53 Certificate No. Series", "WHT Entry"."Posting Date", TRUE);
                            "Certificate Printed" := true;
                            "WHT Entry".Modify();
                            CertNo1 := "WHT Entry"."WHT Certificate No.";
                        end;
                    end else begin
                        "WHT Entry"."WHT Certificate No." := CertNo1;
                        "WHT Entry"."Certificate Printed" := true;
                        "WHT Entry".Modify();
                    end;
                end;


                if PFundAmt <> 0 then
                    PFundAmtText := Format(PFundAmt);
                if SocialAmt <> 0 then
                    SocialAmtText := Format(SocialAmt);
                if NewDocNo <> WHTEntry."WHT Certificate No." then begin
                    NewDocNo := "WHT Certificate No.";
                    Clear(Name);
                    Clear(Address);
                    Clear(Phone);  //KKE : #004
                    Clear(VAT);
                    Clear(WHTGroup);
                    Clear(WHTPostingDate);
                    Clear(WHTExpenseText);
                    Clear(WHTBaseAmtLCYExcVAT);
                    Clear(WHTAmtLCY);
                    Clear(TotWHTBaseAmtLCYExcVAT);
                    Clear(TotWHTAmtLCY);
                    Clear(PostingDate);

                    Clear(VAT);
                    Clear(CCID);
                    Clear(CID);
                    Clear(ID1);
                    Clear(ID2);
                    Clear(ID3);
                    Clear(WHTPostingDate);
                    Clear(WHTBaseAmtLCYExcVATT);
                    Clear(WHTAmtLCYT);
                    Clear(TotWHTBaseAmtLCYExcVAT);
                    Clear(TotWHTAmtLCY);
                    Clear(WHTAmtLCYText);
                end;

                if "Actual Vendor No." <> '' then
                    Vendor.Get("Actual Vendor No.")
                else
                    Vendor.Get("Bill-to/Pay-to No.");

                //KKE : #002 +
                if "Dummy Vendor" and PurchInvHeader.Get("Document No.") then begin
                    if PurchInvHeader."Pay-to Name (Thai)" <> '' then begin
                        Name := PurchInvHeader."Pay-to Name (Thai)";
                        Address := PurchInvHeader."Pay-to Address (Thai)";
                    end else begin
                        Name := PurchInvHeader."Pay-to Name" + PurchInvHeader."Pay-to Name 2";
                        Address := PurchInvHeader."Pay-to Address" + '  ' +
                                   PurchInvHeader."Pay-to Address 2" + '  ' + PurchInvHeader."Pay-to Address 3";
                    end;
                    for i := 1 to StrLen("VAT Registration No.(Dummy)") do
                        VAT[i] := CopyStr("VAT Registration No.(Dummy)", i, 1);
                end else begin
                    //KKE : #002 -
                    if Vendor."Name (Thai)" <> '' then begin
                        Name := Vendor."Name (Thai)";
                        Address := Vendor."Address (Thai)";
                    end else begin
                        Name := Vendor.Name + Vendor."Name 2";
                        Address := Vendor.Address + ' ' + Vendor."Address 2" + ' ' + Vendor."Address 3" + ' ' + Format(Vendor."Phone No.");
                    end;
                    //KKE : #004 +
                    if Vendor."Phone No." <> '' then
                        Phone := 'Tel. ' + Vendor."Phone No.";
                    for i := 1 to 13 do
                        ID3[i] := CopyStr(Vendor."ID No.", i, 1);
                    //KKE : #004 -
                    for i := 1 to StrLen(Vendor."VAT Registration No.") do
                        VAT[i] := CopyStr(Vendor."VAT Registration No.", i, 1);
                end;

                if "WHT Report" = "wht report"::"Por Ngor Dor 3" then
                    WHTGroup[1] := 254
                else
                    WHTGroup[1] := 168;

                if "WHT Report" = "wht report"::"Por Ngor Dor 53" then
                    WHTGroup[2] := 254
                else
                    WHTGroup[2] := 168;

                if WHTRevType.Get("WHT Revenue Type") then begin
                    if WHTRevType.Sequence = 0 then
                        CurrReport.Skip;
                    i := WHTRevType.Sequence;
                    if (i = 99) or (i = 19) then begin  //KKE : #004
                        i := 19;
                        WHTExpenseText := WHTRevType.Description;
                        //WHTExpenseText := 'ñÐ­Ê¬Ð­';
                    end;
                    WHTPostingDate[i] := "Posting Date";
                    PostingDate := "Posting Date";
                    //MESSAGE(FORMAT(WHTPostingDate[i]));
                    WHTAmtLCY[i] := WHTAmtLCY[i] + Amount;
                    TotWHTAmtLCY := TotWHTAmtLCY + Amount;
                    WHTBaseAmtLCYExcVAT[i] := WHTBaseAmtLCYExcVAT[i] + Base;
                    TotWHTBaseAmtLCYExcVAT := TotWHTBaseAmtLCYExcVAT + Base;
                    //>>VAH
                    WHTAmtLCYT[i] := BlankZero(WHTAmtLCY[i]);
                    //MESSAGE(WHTAmtLCYT[i]);
                    TotWHTBaseAmtLCYExcVATT := BlankZero(TotWHTBaseAmtLCYExcVAT);
                    WHTBaseAmtLCYExcVATT[i] := BlankZero(ROUND(WHTBaseAmtLCYExcVAT[i], 0.01));
                    WHTCount += 1;//VAH
                    //<<VAH
                end;

                WHTSlipNo := "WHT Certificate No.";

                if PrintTest then
                    TestText := "Original Document No." + '/ ' + "WHT Certificate No.";
                //WHTCount := "WHT Entry".Count;//VAH
            end;

            trigger OnPreDataItem()
            begin
                CertCount := 1;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Control1170000005)
                {
                    field("Test Report"; PrintTest)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Print Form 50 BIS Book No."; FormBookNo)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Number of copies"; NumberOfCopy)
                    {
                        ApplicationArea = Basic;
                    }
                    field(HeadingPrint1; HeadingPrint)
                    {
                        ApplicationArea = Basic;
                        //Caption = 'พิมพ์ฉบับที่ (Heading Print)';
                        CaptionML = ENU = 'Print issue (Heading print)', THA = 'พิมพ์ฉบับที่ (Heading Print)';
                    }
                    field(PFundNo1; PFundNo)
                    {
                        ApplicationArea = Basic;
                        CaptionML = ENU = 'Savings paid to provident fund license number', THA = 'เงินสะสมจ่ายเข้ากองทุนสำรองเลี้ยงชีพใบอนุญาตเลขที่';
                    }
                    field(PFundAmt1; PFundAmt)
                    {
                        ApplicationArea = Basic;
                        CaptionML = ENU = 'Amount (Baht)', THA = 'จำนวนเงิน (บาท)';
                    }
                    field(SocialAmt1; SocialAmt)
                    {
                        ApplicationArea = Basic;
                        CaptionML = ENU = 'Contribution to the social security fund amount (Baht)', THA = 'เงินสมทบเข้ากองทุนประกันสังคม จำนวนเงิน (บาท)';
                    }
                    field(EmployerAccount1; EmployerAccount)
                    {
                        ApplicationArea = Basic;
                        CaptionML = ENU = 'Employer account number', THA = 'เลขที่บัญชีนายจ้าง';
                    }
                    field(SocialID1; SocialID)
                    {
                        ApplicationArea = Basic;
                        CaptionML = ENU = 'Social security card number of the person subject to withholding tax', THA = 'เลขที่บัตรประกันสังคม ของผู้ถูกหักภาษี ณ ที่จ่าย';
                    }
                    field(PaymentOption1; PaymentOption)
                    {
                        ApplicationArea = Basic;
                        CaptionML = ENU = 'Payer', THA = 'ผู้จ่ายเงิน';
                        OptionCaptionML = ENU = 'Withholding tax, Pay forever, One time tax, Other please specify ...............', THA = 'หักภาษี ณ ที่จ่าย,ออกภาษีให้ตลอดไป,ออกภาษีให้ครั้งเดียว,อื่นๆ ให้ระบุ................';
                    }

                }



            }

        }

        actions
        {
        }
        trigger onopenpage()
        var
            myInt: Integer;
        begin
            NumberOfCopy := 1;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if CompanyInfo.Get then begin
            for i := 1 to StrLen(CompanyInfo."VAT Registration No.") do
                CID[i] := CopyStr(CompanyInfo."VAT Registration No.", i, 1);
            //KKE : #004 +
            if CompanyInfo."Phone No." <> '' then
                CompanyPhone := 'Tel. ' + CompanyInfo."Phone No.";
            //KKE : #004 -
            CompanyInfo.CalcFields(Picture);
        end;

        //KKE : #004 +
        for i := 1 to StrLen(ConductVATID) do
            CCID[i] := CopyStr(ConductVATID, i, 1);

        for i := 1 to StrLen(ConductID) do
            ID2[i] := CopyStr(ConductID, i, 1);

        for i := 1 to StrLen(EmployerAccount) do
            EID[i] := CopyStr(EmployerAccount, i, 1);

        for i := 1 to StrLen(SocialID) do
            SoID[i] := CopyStr(SocialID, i, 1);
        //KKE : #004 -

        if NumberOfCopy > 4 then
            Error('Number of copies shouldnot be more than 4.');

        GLSetup.Find('-');
        //TSA003
        Clear(WHTTerm);
        case PaymentOption of
            0:
                WHTTerm[1] := 'P';
            1:
                WHTTerm[2] := 'P';
            2:
                WHTTerm[3] := 'P';
            3:
                WHTTerm[4] := 'P';
        end;
        //TSA003
    end;

    trigger OnPostReport()
    var
        WHTEntryCert: Record "WHT Entry";
        DocNo: Code[20];
        CertNo: Code[20];
    begin
        //>>VAH

        WHTEntryCert.Reset();
        WHTEntryCert.SetRange("Certificate Printed", false);
        WHTEntryCert.Setfilter("Original Document No.", '<>%1', '');
        WHTEntryCert.SetFilter("WHT Certificate No.", '<>%1', '');
        if WHTEntryCert.FindSet() then
            repeat
                if (BillToPayto <> WHTEntryCert."Bill-to/Pay-to No.") and (OrigDocNo <> WHTEntryCert."Original Document No.") then
                    if DocNo <> WHTEntryCert."WHT Certificate No." then begin
                        DocNo := WHTEntryCert."WHT Certificate No.";
                        PurchSetup.Get();
                        if (WHTEntryCert."WHT Bus. Posting Group" = 'WHT3') and (not WHTEntryCert."Certificate Printed") then begin
                            PurchSetup.TestField("WHT3 Certificate No. Series");
                            WHTEntryCert."WHT Certificate No." :=
                                  NoSeriesMgt.GetNextNo(
                                    PurchSetup."WHT3 Certificate No. Series", WHTEntryCert."Posting Date", TRUE);
                            WHTEntryCert."Certificate Printed" := true;
                            WHTEntryCert.Modify();
                            CertNo := WHTEntryCert."WHT Certificate No.";
                        end;
                        if (WHTEntryCert."WHT Bus. Posting Group" = 'WHT53') and (not WHTEntryCert."Certificate Printed") then begin
                            PurchSetup.TestField("WHT53 Certificate No. Series");
                            WHTEntryCert."WHT Certificate No." :=
                                  NoSeriesMgt.GetNextNo(
                                    PurchSetup."WHT53 Certificate No. Series", WHTEntryCert."Posting Date", TRUE);
                            WHTEntryCert."Certificate Printed" := true;
                            WHTEntryCert.Modify();
                            CertNo := WHTEntryCert."WHT Certificate No.";
                        end;
                    end else begin
                        WHTEntryCert."WHT Certificate No." := CertNo;
                        WHTEntryCert."Certificate Printed" := true;
                        WHTEntryCert.Modify();
                    end
                else begin
                    WHTEntryCert."WHT Certificate No." := CertNo1;
                    WHTEntryCert."Certificate Printed" := true;
                    WHTEntryCert.Modify();
                end;
            until WHTEntryCert.next = 0;
        //<<VAH
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        Vendor: Record Vendor;
        WHTBusPostinGrp: Record "WHT Business Posting Group";
        WHTRevType: Record "WHT Revenue Types";
        WHTEntry: Record "WHT Entry";
        WHTEntry2: Record "WHT Entry";
        Name: Text[150];
        Address: Text[250];
        Address2: Text[250];
        City: Text[30];
        VAT: array[20] of Code[1];
        SNo: Integer;
        Pdate: Date;
        CID: array[20] of Code[1];
        i: Integer;
        ConductName: Text[250];
        ConductAddress: Text[250];
        ConductVATID: Text[20];
        ConductID: Text[20];
        CCID: array[20] of Code[1];
        ID1: array[13] of Code[1];
        ID2: array[13] of Code[1];
        ID3: array[13] of Code[1];
        PageNo: Integer;
        WHTGroup: array[2] of Char;
        WHTTerm: array[4] of Text[1];
        WHTPostingDate: array[19] of Date;
        WHTBaseAmtLCYExcVAT: array[19] of Decimal;
        WHTAmtLCY: array[19] of Decimal;
        TotWHTBaseAmtLCYExcVAT: Decimal;
        TotWHTAmtLCY: Decimal;
        ExpenseType: array[4] of Text[1];
        FormBookNo: Code[10];
        WHTAmtLCYText: Text[200];
        NumberOfCopy: Integer;
        NewDocNo: Code[20];
        WHTExpenseText: Text[30];
        HeadingPrint: Boolean;
        Heading: Text[100];
        WHTSlipNo: Code[20];
        PostingDate: Date;
        PrintTest: Boolean;
        TestText: Text[70];
        WHTPostingSetup: Record "WHT Posting Setup";
        PurchInvHeader: Record "Purch. Inv. Header";
        PaymentOption: Option "0","1","2","3";
        PFundNo: Code[20];
        PFundAmt: Decimal;
        SocialAmt: Decimal;
        EmployerAccount: Code[10];
        SocialID: Code[13];
        SoID: array[13] of Code[1];
        EID: array[10] of Code[1];
        CompanyPhone: Text[50];
        Phone: Text[50];
        WHTAmtLCYT: array[19] of Text;
        TotWHTBaseAmtLCYExcVATT: Text;
        WHTBaseAmtLCYExcVATT: array[19] of Text;
        PFundAmtText: Text;
        SocialAmtText: text;
        WHTCount: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CertCount: Integer;
        BillToPayto: Code[20];
        OrigDocNo: Code[20];
        CertNo1: Code[20];

    procedure FormatNoThaiText(Amount: Decimal): Text[200]
    var
        AmountText: Text[30];
        x: Integer;
        l: Integer;
        p: Integer;
        adigit: Text[1];
        dflag: Boolean;
        WHTAmtThaiText: Text[200];
    begin
        Amount := ROUND(Amount);
        AmountText := Format(Amount, 0);
        x := StrPos(AmountText, '.');
        case true of
            x = 0:
                AmountText := AmountText + '.00';
            x = StrLen(AmountText) - 1:
                AmountText := AmountText + '0';
            x > StrLen(AmountText) - 2:
                AmountText := CopyStr(AmountText, 1, x + 2);
        end;
        l := StrLen(AmountText);
        repeat
            dflag := false;
            p := StrLen(AmountText) - l + 1;
            adigit := CopyStr(AmountText, p, 1);
            if (l in [4, 12, 20]) and (l < StrLen(AmountText)) and (adigit = '1') then
                dflag := true;
            WHTAmtThaiText := WHTAmtThaiText + FormatDigitThai(adigit, l - 3, dflag);
            l := l - 1;
        until l = 3;

        if CopyStr(AmountText, StrLen(AmountText) - 2, 3) = '.00' then
            WHTAmtThaiText := WHTAmtThaiText + 'บาทถ้วน'
        else begin
            if WHTAmtThaiText <> '' then
                WHTAmtThaiText := WHTAmtThaiText + 'บาท';
            l := 2;
            repeat
                dflag := false;
                p := StrLen(AmountText) - l + 1;
                adigit := CopyStr(AmountText, p, 1);
                if (l = 1) and (adigit = '1') and (CopyStr(AmountText, p - 1, 1) <> '0') then
                    dflag := true;
                WHTAmtThaiText := WHTAmtThaiText + FormatDigitThai(adigit, l, dflag);
                l := l - 1;
            until l = 0;
            WHTAmtThaiText := WHTAmtThaiText + 'สตางค';
        end;

        exit(WHTAmtThaiText);
    end;


    procedure FormatDigitThai(adigit: Text[1]; pos: Integer; dflag: Boolean): Text[100]
    var
        fdigit: Text[30];
        fcount: Text[30];
    begin
        CASE adigit OF
            '1':
                BEGIN
                    IF (pos IN [1, 9, 17]) AND dflag THEN
                        fdigit := 'เอ็ด'
                    ELSE
                        IF pos IN [2, 10, 18] THEN
                            fdigit := ''
                        ELSE
                            fdigit := 'หนึ่ง';
                END;
            '2':
                BEGIN
                    IF pos IN [2, 10, 18] THEN
                        fdigit := 'ยี่'
                    ELSE
                        fdigit := 'สอง';
                END;
            '3':
                fdigit := 'สาม';
            '4':
                fdigit := 'สี่';
            '5':
                fdigit := 'ห้า';
            '6':
                fdigit := 'หก';
            '7':
                fdigit := 'เจ็ด';
            '8':
                fdigit := 'แปด';
            '9':
                fdigit := 'เก้า';
            '0':
                BEGIN
                    IF pos IN [9, 17, 25] THEN
                        fdigit := 'ล้าน';
                END;
            '-':
                fdigit := 'ลบ';
        END;
        IF (adigit <> '0') AND (adigit <> '-') THEN BEGIN
            CASE pos OF
                2, 10, 18:
                    fcount := 'สิบ';
                3, 11, 19:
                    fcount := 'ร้อย';
                5, 13, 21:
                    fcount := 'พัน';
                6, 14, 22:
                    fcount := 'หมื่น';
                7, 15, 23:
                    fcount := 'แสน';
                9, 17, 25:
                    fcount := 'ล้าน';
            END;
        END;
        EXIT(fdigit + fcount);
    end;

    local procedure BlankZero(Number: Decimal): Text
    begin
        if Number <> 0 then
            exit(Format(Number, 12, '<Precision,2><Sign><Integer Thousand><Decimals>'));

        exit('');
    end;
}

