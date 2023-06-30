#include 'protheus.ch'
#include 'parmtype.ch'
#include 'FwMvcDef.ch' //Include que identifica que estamos trabalhando com mvc

User Function MVC001()

    Local oBrowse := FWMBrowse():New() //Criando objeto oBrowse começa com o

    oBrowse:SetAlias("ZZB") //Definindo tabela a ser utilizada
    oBrowse:SetDescription ("Albuns") //Adicionando descrição

    //Legendas
    oBrowse:AddLegend("ZZB->ZZB_TIPO == '1' ", "GREEN", "CD") //Verde
    oBrowse:AddLegend("ZZB->ZZB_TIPO == '2' ", "BLUE", "DVD") //Azul

    oBrowse:Activate() //Ativando a classe FWMBrowse

Return

//Construção MenuDef
Static Function MenuDef()
    Local aRotina := FwMvcMenu("MVC001")  //Funcao que criar os menus padrao do sistema
    
    //Local aRotina := {}

    /* Add OPTION aRotina TITLE 'Pesquisar'  ACTION 'VIEWDEF.MVC001' OPERATION 1 ACCESS 0
    Add OPTION aRotina TITLE 'Vizualizar' ACTION 'VIEWDEF.MVC001' OPERATION 2 ACCESS 0
    Add OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MVC001' OPERATION 3 ACCESS 0
    Add OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MVC001' OPERATION 4 ACCESS 0
    Add OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MVC001' OPERATION 5 ACCESS 0
    Add OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.MVC001' OPERATION 7 ACCESS 0 */

/* 1 - Pesquisar
2 - Vizualizar
3 - Incluir
4 - Alterar
5 - Excluir
7 - Copiar */

Return aRotina

//Construindo Model Def

Static Function ModelDef()
    Local oModel := Nil
    Local oStZZB := FWFormStruct(1, "ZZB")

    //Instanciando o modelo de dados
    oModel := MPFormModel():new("ZMODELLM", , , ,)

    //Atribuindo formulario para o modelo de dados
    oModel:AddFields("FORMZZB",,oStZZB)

    //Chave primaria da rotina
    oModel:SetPrimaryKey({'ZZB_FILIAL','ZZB_COD'})

    //Adicionando descricao ao modelo de dados
    oModel:SetDescription("Modelo de dados")

    oModel:GetModel("FORMZZB"):SetDescription("Formulario de cadastro")

Return oModel

Static Function ViewDef()
    //Local aStruZZB := ZZB->(DbStruct() )
    Local oView := Nil  
    Local oModel := FWLoadModel("MVC001")
    Local oStZZB := FWFormStruct(2, "ZZB")

    oView := FWFormView():New() 

    oView:setModel(oModel) //Passando o modelo de dados informado

    oStZZB:RemoveField("ZZB_USER") //Removendo campos

    oView:AddField("VIEW_ZZB", oStZZB, "FORMZZB")

    oView:CreateHorizontalBox("TELA",100)

    oView:EnableTitleView("VIEW_ZZB", 'Dados View')
    
    
    oView:SetCloseOnOk({||.T.}) //Forçar o fechamento da janela na confirmação

    oView:SetOwnerView("VIEW_ZZB", "TELA")

Return oView
