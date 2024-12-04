page 80103 "DG General Journal"
{
    Caption = 'DG General Journal';
    PageType = Document;
    UsageCategory = None;
    SourceTable = "DG General Journal";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Month field.';
                }
            }
            part(DGGeneralJournalLine; "DG General Journal Line")
            {
                ApplicationArea = All;
                SubPageLink = Code = field(Code);
                UpdatePropagation = Both;
                Caption = 'Lines';
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Post)
                {
                    Caption = 'Post', comment = 'ESP="Registrar"';
                    Image = PostDocument;
                    Visible = true;
                    ToolTip = 'Executes the Post action.', comment = 'ESP="Ejecuta la acción Registrar."';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Confirmessage();
                    end;
                }
            }
        }
    }



    local procedure Confirmessage()
    var
        DGManagament: Codeunit "DG Managament";
        Text001Lbl: Label 'You want to register record %1';
    begin
        if not Dialog.Confirm(StrSubstNo(Text001Lbl, Rec.Code), true) then
            exit
        else begin
            DGManagament.PostedDGJournal(Rec);
            CurrPage.Close();
        end;
    end;
}
