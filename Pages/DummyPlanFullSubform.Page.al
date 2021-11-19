Page 50047 "Dummy Plan Full Subform"
{
    // Microsoft Business Solutions Navision
    // ----------------------------------------
    // Project: Burda (Thailand) Co., Ltd
    // KKE : Kanoknard Ketnut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   04.06.2007   KKE   New form for "Dummy Plan Full Subform" - Editorial Module

    PageType = CardPart;

    layout
    {
        area(content)
        {
            field(I; I)
            {
                ApplicationArea = Basic;

                //BlankZero = true;
                Editable = false;
                Style = Strong;
                StyleExpr = true;
            }
            field(Product1; Product)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Product2; Product2)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        BgkVisible := true;
    end;

    trigger OnOpenPage()
    begin
        ForeColor := 16777215;
    end;

    var
        I: Code[10];
        Product: Code[50];
        Product2: Code[50];
        ForeColor: Integer;
        [InDataSet]
        BgkVisible: Boolean;
        [InDataSet]
        Black1Visible: Boolean;
        [InDataSet]
        DarkRed1Visible: Boolean;
        [InDataSet]
        Red1Visible: Boolean;
        [InDataSet]
        Pink1Visible: Boolean;
        [InDataSet]
        Rose1Visible: Boolean;
        [InDataSet]
        Brown1Visible: Boolean;
        [InDataSet]
        Orange1Visible: Boolean;
        [InDataSet]
        LightOrange1Visible: Boolean;
        [InDataSet]
        Gold1Visible: Boolean;
        [InDataSet]
        Tan1Visible: Boolean;
        [InDataSet]
        OliveGreen1Visible: Boolean;
        [InDataSet]
        DarkYellow1Visible: Boolean;
        [InDataSet]
        Lime1Visible: Boolean;
        [InDataSet]
        Yellow1Visible: Boolean;
        [InDataSet]
        LightYellow1Visible: Boolean;
        [InDataSet]
        DarkGreen1Visible: Boolean;
        [InDataSet]
        Green1Visible: Boolean;
        [InDataSet]
        SeaGreen1Visible: Boolean;
        [InDataSet]
        BrightGreen1Visible: Boolean;
        [InDataSet]
        LightGreen1Visible: Boolean;
        [InDataSet]
        DarkTeal1Visible: Boolean;
        [InDataSet]
        Teal1Visible: Boolean;
        [InDataSet]
        Aqua1Visible: Boolean;
        [InDataSet]
        Turquoise1Visible: Boolean;
        [InDataSet]
        LightTurquoise1Visible: Boolean;
        [InDataSet]
        DarkBlue1Visible: Boolean;
        [InDataSet]
        Blue1Visible: Boolean;
        [InDataSet]
        LightBlue1Visible: Boolean;
        [InDataSet]
        SkyBlue1Visible: Boolean;
        [InDataSet]
        PaleBlue1Visible: Boolean;
        [InDataSet]
        Indigo1Visible: Boolean;
        [InDataSet]
        BlueGray1Visible: Boolean;
        [InDataSet]
        Violet1Visible: Boolean;
        [InDataSet]
        Plum1Visible: Boolean;
        [InDataSet]
        Lavender1Visible: Boolean;
        [InDataSet]
        "Gray-80%1Visible": Boolean;
        [InDataSet]
        "Gray-50%1Visible": Boolean;
        [InDataSet]
        "Gray-40%1Visible": Boolean;
        [InDataSet]
        "Gray-25%1Visible": Boolean;
        [InDataSet]
        White1Visible: Boolean;


    procedure SetColor(_Color: Option " ",Black,"Dark Red",Red,Pink,Rose,Brown,Orange,"Light Orange",Gold,Tan,"Olive Green","Dark Yellow",Lime,Yellow,"Light Yellow","Dark Green",Green,"Sea Green","Bright Green","Light Green","Dark Teal",Teal,Aqua,Turquoise,"Light Turquoise","Dark Blue",Blue,"Light Blue","Sky Blue","Pale Blue",Indigo,"Blue-Gray",Violet,Plum,Lavender,"Gray - 80%","Gray - 50%","Gray - 40%","Gray - 25%",White; _ForeColor: Integer; _I: Code[10]; _Product: Code[50]; _Product2: Code[50])
    begin
        /*
          Black,Dark Red,Red,Pink,Rose,Brown,Orange,Light Orange,Gold,Tan,Olive Green,Dark Yellow
          Lime,Yellow,Light Yellow,Dark Green,Green,Sea Green,Bright Green,Light Green,Dark Teal,Teal,Aqua,Turquoise,Light Turquoise
          Dark Blue,Blue,Light Blue,Sky Blue,Pale Blue,Indigo,Blue-Gray,Violet,Plum,
          Lavender,Gray - 80%,Gray - 50%,Gray - 40%,Gray - 25%,White
        */

        I := _I;
        if I = '' then
            BgkVisible := false
        else
            BgkVisible := true;
        Product := _Product;
        Product2 := _Product2;
        ForeColor := _ForeColor;

        Black1Visible := _Color = _color::Black;
        DarkRed1Visible := _Color = _color::"Dark Red";
        Red1Visible := _Color = _color::Red;
        Pink1Visible := _Color = _color::Pink;
        Rose1Visible := _Color = _color::Rose;
        Brown1Visible := _Color = _color::Brown;
        Orange1Visible := _Color = _color::Orange;
        LightOrange1Visible := _Color = _color::"Light Orange";
        Gold1Visible := _Color = _color::Gold;
        Tan1Visible := _Color = _color::Tan;
        OliveGreen1Visible := _Color = _color::"Olive Green";
        DarkYellow1Visible := _Color = _color::"Dark Yellow";
        Lime1Visible := _Color = _color::Lime;
        Yellow1Visible := _Color = _color::Yellow;
        LightYellow1Visible := _Color = _color::"Light Yellow";
        DarkGreen1Visible := _Color = _color::"Dark Green";
        Green1Visible := _Color = _color::Green;
        SeaGreen1Visible := _Color = _color::"Sea Green";
        BrightGreen1Visible := _Color = _color::"Bright Green";
        LightGreen1Visible := _Color = _color::"Light Green";
        DarkTeal1Visible := _Color = _color::"Dark Teal";
        Teal1Visible := _Color = _color::Teal;
        Aqua1Visible := _Color = _color::Aqua;
        Turquoise1Visible := _Color = _color::Turquoise;
        LightTurquoise1Visible := _Color = _color::"Light Turquoise";
        DarkBlue1Visible := _Color = _color::"Dark Blue";
        Blue1Visible := _Color = _color::Blue;
        LightBlue1Visible := _Color = _color::"Light Blue";
        SkyBlue1Visible := _Color = _color::"Sky Blue";
        PaleBlue1Visible := _Color = _color::"Pale Blue";
        Indigo1Visible := _Color = _color::Indigo;
        BlueGray1Visible := _Color = _color::"Blue-Gray";
        Violet1Visible := _Color = _color::Violet;
        Plum1Visible := _Color = _color::Plum;
        Lavender1Visible := _Color = _color::Lavender;
        "Gray-80%1Visible" := _Color = _color::"Gray - 80%";
        "Gray-50%1Visible" := _Color = _color::"Gray - 50%";
        "Gray-40%1Visible" := _Color = _color::"Gray - 40%";
        "Gray-25%1Visible" := _Color = _color::"Gray - 25%";
        White1Visible := _Color = _color::White;

        CurrPage.Update;

    end;
}

