#include 'protheus.ch'
#include 'parmtype.ch'
#include 'FWMVCDef.ch'

/**** RCTI TREINAMENTOS
	  ADVPL AVANÇANDO COM MVC
****/

user function MARK_MVC()
	
	Private oMark
	
	oMark := FWMarkBrowse():New() //FWMarkBrowse() - Para fazer as caixinhas de seleção			
	
	oMark:SetAlias('ZZB')
	
	oMark:SetDescription('Seleção de albuns')
	
	oMark:SetFieldMark('ZZB_OK') //SetFieldMark - Define o campo que terá marcação
	
	oMark:AddLegend("ZZB_TIPO == '1'","YELLOW", "CD")
	oMark:AddLegend("ZZB_TIPO == '2'","BLUE", "DVD")
	
	oMark:Activate() //Ativando a classe
	
return Nil

//----------------------------
Static Function MenuDef()
	local aRotina := {}
	
	ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MARK_MVC' OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Incluir' ACTION 'VIEWDEF.MVC001' 	   	OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Processar' ACTION 'u_ProcS()'     	OPERATION 6 ACCESS 0


Return aRotina
//--------------------------
Static Function ModelDef()

Return FWLoadModel('MVC001')
//--------------------------
Static Function ViewDef()     //Carega o modelo de dados do fonte MVC001

Return FWLoadView('MVC001')   //Carega o modelo de dados do fonte MVC001
//---------------------
User Function PROCS()
	Local aArea  := GetArea()
	Local cMarca := oMark:Mark() //Objeto Mark chamando a função Mark()
	Local nCt    := 0
	
		ZZB->( dbGoTop()) //Indo para o inicio da tabela
			While !ZZB->(EOF())
			
				If oMark:IsMark(cMarca)  //IsMark verifica se está marcado
					nCt ++
				EndIf
			ZZB->(dbSkip())
			End
	
		MsgInfo("Foram marcados<b> " + AllTrim(Str(nCt)) + " </b>Registros.")
		RestArea(aArea) //Fechando a conexao com o banco

Return Nil
