report 50016 "Ads Booking Email"
{
    DefaultLayout = Word;
    WordLayout = './Layouts/AdsBookingEmail.docx';

    dataset
    {
        dataitem(AdsBookingHeader; "Ads. Booking Header")
        {
            CalcFields = "Deal Value";
            column(No; "No.")
            {
            }
            column(FinalCustname; FinalCustname)
            {
            }
            column(BillToCustName; BillToCustName)
            {
            }
            column(HeaderRemark; "Header Remark")
            {

            }
            column(WebServiceTrue_Url; WebServiceTrue)
            {

            }
            column(WebServiceTrue_UrlText; WebServiceTrueText)
            {

            }
            column(ServiceYes_Url; ServiceYes)
            {

            }
            column(ServiceYes_UrlText; ServiceYesText)
            {

            }
            column(CurrencyCode; CurrencyCode)
            {

            }
            column(Deal_Value; "Deal Value")
            {

            }
            column(AmtCaption; AmtCaption)
            {

            }
            dataitem("Ads. Booking Line"; "Ads. Booking Line")
            {
                DataItemLink = "Deal No." = field("No.");
                column(Sub_Booking_No_; "Subdeal No.")
                {

                }
                column(Product_Name; "Product Name")
                {

                }
                column(Sub_Product_Name; MagazineName)
                {

                }
                column(Brands; AdsProductDesc)
                {

                }
                column(ProductCategory; "Industry Category Code")
                {

                }
                column(Industry; ProdCatname)
                {

                }
                column(Amount; Amount)
                {

                }
                column(Revenue_Type; BookingRevDesc)
                {

                }
                column(Publication_Date; format("Publication Date"))
                {

                }
                column(Ads_Position; Dim5Value)
                {

                }
                column(Ads_Size; AdsSizeDesc)
                {

                }
                column(Note_Column; "Line Remark (If any)")
                {

                }
                column(Publication_Month; PubMonth)
                {

                }


                trigger OnAfterGetRecord()
                var
                begin

                    if Magazine.get("Sub Product Code") then
                        MagazineName := Magazine.Description;
                    if AdsProduct.Get("Brand Code") then
                        AdsProductDesc := AdsProduct.Description;
                    if BookingRevenueType.get("Ads. Type code (Revenue type Code)", "Shortcut Dimension 7 Code") then
                        BookingRevDesc := BookingRevenueType.Description;
                    if DimValue.Get('ADS.POSITION', "Shortcut Dimension 5 Code") then
                        Dim5Value := DimValue.Name;
                    if AdsSize.Get("Ads. Type Code (Revenue Type Code)", "Ads. Size Code") then
                        AdsSizeDesc := AdsSize.Description;
                    if ProductCategory.Get("Industry Category Code") then
                        ProdCatname := ProductCategory.Description;
                    if GenMasterSetup.Get(GenMasterSetup.Type::"Publication Month", "Publication Month") then
                        PubMonth := GenMasterSetup.Description;


                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if Cust.get("Final Customer No.") then
                    FinalCustname := Cust.Name;
                if Cust.get("Bill-to Customer No.") then
                    BillToCustName := Cust.Name;
                GLSetup.get;
                if "Currency Code" <> '' then
                    CurrencyCode := "Currency Code"
                else
                    CurrencyCode := GLSetup."Local Currency Symbol";
                AmtCaption := 'Amount (' + CurrencyCode + ')';
                //WebServiceTrue_Url := 'https://www.flipkart.com/';
                //WebServiceTrue_UrlText := 'Yes';
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin

    end;

    var
        FinalCustname: text;
        BillToCustName: text;
        Cust: Record Customer;
        Magazine: Record "Sub Product";
        AdsItem: Record "Ads. Item";
        AdsProduct: Record Brand;
        BookingRevenueType: Record "Booking Revenue Type";
        DimValue: Record "Dimension Value";
        AdsSize: Record "Ads. Size";
        MagazineName: Text[50];
        AdsProductDesc: Text[50];
        BookingRevDesc: Text[50];
        Dim5Value: Text[50];
        AdsSizeDesc: text[50];
        WebServiceTrue: text[100];
        WebServiceTrueText: text[10];
        ServiceYes: Text[100];
        ServiceYesText: Text[20];
        ProductCategory: record "Product Category";
        ProdCatname: Text[50];
        GLSetup: Record "General Ledger Setup";
        CurrencyCode: Code[10];
        AmtCaption: Text;
        GenMasterSetup: Record "General Master Setup";
        PubMonth: Text;
}
