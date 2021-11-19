page 50012 Products
{

    ApplicationArea = All;
    Caption = 'Products';
    PageType = List;
    SourceTable = Product;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(SubProduct)
            {
                ApplicationArea = Basic;
                Caption = 'Sub Product List';
                Ellipsis = true;
                Image = ListPage;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    page.Run(page::"Sub Products");
                end;
            }

        }
    }
}
