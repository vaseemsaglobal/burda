Codeunit 50001 ApplicationManagement1
{

    trigger OnRun()
    begin

        //  OBJECT Modification ApplicationManagement(Codeunit 1)
        //  {
        //    OBJECT-PROPERTIES
        //    {
        //      Date=12082011D;
        //      Time=225623T;
        //      Version List=NAVW16.00.10,NAVAP6.00,AVATHA4.01;
        //    }
        //    PROPERTIES
        //    {
        //      Target=ApplicationManagement(Codeunit 1);
        //    }
        //    CHANGES
        //    {
        //      { CodeModification  ;OriginalCode=BEGIN
        //                                          IF GUIALLOWED THEN
        //                                            LogInStart;
        //                                        END;
        //  
        //                           ModifiedCode=BEGIN
        //                                          IF GUIALLOWED THEN
        //                                            LogInStart;
        //                                          //FORM.RUN(FORM::"Main Menu"); //KKE : #001
        //                                        END;
        //  
        //                           Target=CompanyOpen(PROCEDURE 30) }
        //      { Insertion         ;InsertAfter=GetCurrency(PROCEDURE 1);
        //                           ChangedElements=PROCEDURECollection
        //                           {
        //                             PROCEDURE ChkEncryptPwd@1000000000(Password@1000000000 : Text[30]) : Text[30];
        //                             VAR
        //                               String1@1000000005 : Text[250];
        //                               String2@1000000004 : Text[250];
        //                               Seed@1000000003 : Code[20];
        //                               SeedValue@1000000002 : Integer;
        //                               idx@1000000001 : Integer;
        //                             BEGIN
        //                               //KKE : #002 +
        //                               Seed := '@';
        //                               String1 := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        //                               String2 := 'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM';
        //  
        //                               FOR idx := 1 TO STRLEN(Seed) DO
        //                                 SeedValue := SeedValue + Seed[idx];
        //                               SeedValue := SeedValue MOD STRLEN(String1);
        //                               FOR idx := 1 TO STRLEN(String1) DO BEGIN
        //                                 String1[idx] := String1[idx] + SeedValue;
        //                                 String2[idx] := String2[idx] + SeedValue;
        //                               END;
        //  
        //                               EXIT(CONVERTSTR(Password,String1,String2));
        //                               //KKE : #002 -
        //                             END;
        //  
        //                             PROCEDURE SoftwareLicense@1000000002(VAR g_textLicenseInf@1000000000 : ARRAY [14] OF Text[250]);
        //                             VAR
        //                               l_recLicenseInf@1000000001 : Record "License Information";
        //                               Text50000@1000000005 : TextConst 'ENU=½…Õß—“Õ‰³ÒÊó³’‰ó´Ò‰›“¸Ž©‰­Ë„’ Š“¯™©‡ Í‘Ëñ“½‡Õ ¿®í©„ Ì‰‹“¨Ê‡˜Ê‘“¯í­';
        //                               Text50001@1000000004 : TextConst 'ENU="Ë„’‘³Š“¯™©‡ ­—­Ë…Ò ½¯šÊ…Ï‘ (‹“¨Ê‡˜Í‡’) ¿®í©„ Ê‹Ï‰…©—ß‡‰¿®›‰Ð­’ "';
        //                               Text50002@1000000003 : TextConst 'ENU="½´Ðº‘³Ê•ó    ‹“¨¿®…©—½…Õß—“ÕÊžÒ­šÕÊ•ó‡³Ð  0478 Ê‹Ï‰½…Õß—“ÕÊ•ó‡³Ð %1 "';
        //                               Text50003@1000000002 : TextConst 'ENU=ß•¨Ê‹Ï‰    ½…Õß—“Õ…­‘‘­…“­‰½…Õß—“ÕÊŽ¸Ð­™³š““Ž­í“óºí“‘š““Ž­í“¬‰¯„ ñ.';
        //                             BEGIN
        //                               //KKE : #001 +
        //                               l_recLicenseInf.SETFILTER("Line No.",'%1|%2..%3',2,4,11);
        //                               IF NOT l_recLicenseInf.FIND('-') THEN
        //                                 EXIT;
        //  
        //                               i := 0;
        //                               REPEAT
        //                                 i := i + 1;
        //                                 IF i = 1 THEN
        //                                   g_textLicenseInf[i] := l_recLicenseInf.Text
        //                                 ELSE
        //                                   g_textLicenseInf[i] := COPYSTR(l_recLicenseInf.Text,27,50);
        //                               UNTIL (l_recLicenseInf.NEXT=0) OR (i=9);
        //  
        //                               g_textLicenseInf[10] := Text50000 + '\';
        //                               g_textLicenseInf[11] := Text50001;
        //                               g_textLicenseInf[12] := STRSUBSTNO(Text50002,'N0004');
        //                               g_textLicenseInf[13] := Text50003;
        //                               g_textLicenseInf[14] := 'Version ' + ApplicationVersion;
        //                               //KKE : #001 -
        //                             END;
        //  
        //                           }
        //                            }
        //      { PropertyModification;
        //                           Property=Version List;
        //                           OriginalValue=NAVW16.00.10,NAVAP6.00;
        //                           ModifiedValue=NAVW16.00.10,NAVAP6.00,AVATHA4.01 }
        //    }
        //    CODE
        //    {
        //  
        //      BEGIN
        //      END.
        //    }
        //  }
        //  
        //  

    end;
}

