Table 50015 "Content Group Setup"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   28.03.2007   KKE   New table for "Content Type Setup" - Editorial Module

    LookupPageID = "Content Group Setup";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Magazine Code"; Code[20])
        {
            TableRelation = "Sub Product";
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Blackground Color"; Option)
        {
            OptionMembers = " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White;
        }
        field(5; "Foreground Color"; Option)
        {
            OptionMembers = " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure GetRBGValue(_Color: Option " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White): Integer
    var
        RBGValue: Integer;
    begin
        case _Color of
            0:
                RBGValue := 0;
            _color::Black:
                RBGValue := 0;
            _color::"Dark Red":
                RBGValue := 128;
            _color::Red:
                RBGValue := 255;
            _color::Pink:
                RBGValue := 16711935;
            _color::Rose:
                RBGValue := 16744703;
            _color::Brown:
                RBGValue := 16512;
            _color::Orange:
                RBGValue := 25850;
            _color::"Light Orange":
                RBGValue := 38655;
            _color::Gold:
                RBGValue := 54015;
            _color::Tan:
                RBGValue := 9229055;
            _color::"Olive Green":
                RBGValue := 24144;
            _color::"Dark Yellow":
                RBGValue := 35985;
            _color::Lime:
                RBGValue := 2677935;
            _color::Yellow:
                RBGValue := 65535;
            _color::"Light Yellow":
                RBGValue := 11206655;
            _color::"Dark Green":
                RBGValue := 16384;
            _color::Green:
                RBGValue := 37177;
            _color::"Sea Green":
                RBGValue := 7372800;
            _color::"Bright Green":
                RBGValue := 16695;
            _color::"Light Green":
                RBGValue := 12058015;
            _color::"Dark Teal":
                RBGValue := 5980160;
            _color::Teal:
                RBGValue := 6576128;
            _color::Aqua:
                RBGValue := 11776768;
            _color::Turquoise:
                RBGValue := 16777005;
            _color::"Light Turquoise":
                RBGValue := 16777134;
            _color::"Dark Blue":
                RBGValue := 8519680;
            _color::Blue:
                RBGValue := 16711680;
            _color::"Light Blue":
                RBGValue := 16750140;
            _color::"Sky Blue":
                RBGValue := 14930432;
            _color::"Pale Blue":
                RBGValue := 16770730;
            _color::Indigo:
                RBGValue := 10630707;
            _color::"Blue-Gray":
                RBGValue := 10117983;
            _color::Violet:
                RBGValue := 16750140;
            _color::Plum:
                RBGValue := 5975190;
            _color::Lavender:
                RBGValue := 16732588;
            _color::"Gray - 80%":
                RBGValue := 3947580;
            _color::"Gray - 50%":
                RBGValue := 5921370;
            _color::"Gray - 40%":
                RBGValue := 8553090;
            _color::"Gray - 25%":
                RBGValue := 11842740;
            _color::White:
                RBGValue := 16777215;
        end;
        exit(RBGValue);
    end;


    procedure GetColorIndex(_Color: Option " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White): Integer
    var
        ColorIndex: Integer;
    begin
        case _Color of
            0:
                ColorIndex := 0;
            _color::Black:
                ColorIndex := 1;
            _color::"Dark Red":
                ColorIndex := 9;
            _color::Red:
                ColorIndex := 3;
            _color::Pink:
                ColorIndex := 7;
            _color::Rose:
                ColorIndex := 38;
            _color::Brown:
                ColorIndex := 53;
            _color::Orange:
                ColorIndex := 46;
            _color::"Light Orange":
                ColorIndex := 45;
            _color::Gold:
                ColorIndex := 44;
            _color::Tan:
                ColorIndex := 40;
            _color::"Olive Green":
                ColorIndex := 52;
            _color::"Dark Yellow":
                ColorIndex := 12;
            _color::Lime:
                ColorIndex := 43;
            _color::Yellow:
                ColorIndex := 6;
            _color::"Light Yellow":
                ColorIndex := 36;
            _color::"Dark Green":
                ColorIndex := 51;
            _color::Green:
                ColorIndex := 10;
            _color::"Sea Green":
                ColorIndex := 50;
            _color::"Bright Green":
                ColorIndex := 4;
            _color::"Light Green":
                ColorIndex := 35;
            _color::"Dark Teal":
                ColorIndex := 49;
            _color::Teal:
                ColorIndex := 14;
            _color::Aqua:
                ColorIndex := 42;
            _color::Turquoise:
                ColorIndex := 8;
            _color::"Light Turquoise":
                ColorIndex := 34;
            _color::"Dark Blue":
                ColorIndex := 11;
            _color::Blue:
                ColorIndex := 5;
            _color::"Light Blue":
                ColorIndex := 41;
            _color::"Sky Blue":
                ColorIndex := 33;
            _color::"Pale Blue":
                ColorIndex := 37;
            _color::Indigo:
                ColorIndex := 55;
            _color::"Blue-Gray":
                ColorIndex := 47;
            _color::Violet:
                ColorIndex := 13;
            _color::Plum:
                ColorIndex := 54;
            _color::Lavender:
                ColorIndex := 39;
            _color::"Gray - 80%":
                ColorIndex := 56;
            _color::"Gray - 50%":
                ColorIndex := 15;
            _color::"Gray - 40%":
                ColorIndex := 48;
            _color::"Gray - 25%":
                ColorIndex := 15;
            _color::White:
                ColorIndex := 2;
        end;
        exit(ColorIndex);
    end;
}

