#include 'protheus.ch'
#include 'parmtype.ch'

user function ITEM()
	
	Local aParam   := PARAMIXB //É um array com os parametros do ponto de entrada
	Local xRet     := .T.	   //Variavel de retorno
	Local oObj     := ""
	Local cTipo    := AllTrim(M->B1_TIPO)
	Local cConta   := AllTrim(M->B1_CONTA)
	Local cIdPonto := ""
	Local cIdModel := ""
	
		If aParam <> Nil			//Se tem conteudo no nosso PARAMIXB
			oObj := aParam[1]
			cIdPonto := aParam[2]
			cIdModel := aParam[3]
			
		If cIdPonto == "MODELPOS" .And. cTipo = "PA" .And. cConta = "001"
		
			MsgALert("A conta <b> "+ cConta + "</b> não pode estar associada a um produto do tipo <b>" + cTipo)
			xRet := .F.
		
							//Incluir botao
		ElseIf cIdPonto == "BUTTONBAR"
			xRet := {{"Botão","BOTAO", {||U_BTN_PE()}}}
		
		EndIf
		EndIf
	
	
return xRet

User Function BTN_PE()
	//acao do botao
	
	MsgInfo("Você clicou no botão!")

Return Nil
