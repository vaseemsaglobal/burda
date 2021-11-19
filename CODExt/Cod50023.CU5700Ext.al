codeunit 50023 CU5700Ext
{
    PROCEDURE GetMagazineItemFilter(): Text[100];
    BEGIN
        //KKE : #001 +
        IF NOT HasGotMagazineFilter THEN BEGIN
            IF (UserSetup.GET(USERID)) AND (USERID <> '') THEN
                IF UserSetup."Magazine Filter" <> '' THEN
                    UserMagazineCode := UserSetup."Magazine Filter";
            HasGotMagazineFilter := TRUE;
        END;
        EXIT(UserMagazineCode);
        //KKE : #001 -
    END;

    var
        HasGotMagazineFilter: Boolean;
        UserSetup: Record "User Setup";
        UserMagazineCode: text[100];

}
