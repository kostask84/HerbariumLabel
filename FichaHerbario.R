###-----------------------------------------------------------------------------------------###

# 1. clear the memory and load the packages
# clear workspace and increase memory
rm(list = ls())
memory.limit(size = 1.75e13) 

###-----------------------------------------------------------------------------------------###

# diret�rio temporario de processamento do R 

tempdir <- function() "D:\\temps"
unlockBinding("tempdir", baseenv())
assignInNamespace("tempdir", tempdir, ns="base", envir=baseenv())
assign("tempdir", tempdir, baseenv())
lockBinding("tempdir", baseenv())
tempdir()


###-----------------------------------------------------------------------------------------###

#--- Carregar fun��es  ---#

  PastaCheckNames<-"C:/Dados/GitHub/CheckNamesBrazilianFlora2020"; setwd(PastaCheckNames); source('CheckNamesBrazilianFlora2020.R')
  PastaRaiz<-"C:/Dados/GitHub/FichaHerbario"; setwd(PastaRaiz); source('FuncoesFichaHerbario.R')

#--- Informar par�metros da ficha ---#
  
  LogoHerbario<-'![Logo Herbario](HRCBlogo.png)'
  Siglaherbario<-'HRCB'
  NomeHerbario<-'HERB�RIO RIOCLARENSE'
  Instituicao<- 'UNESP - Depto de Bot�nica - IB - Rio Claro,SP' #'Universidade Estadual Paulista "J�lio de Mesquita Filho" - UNESP'
  Projeto<-'Vegeta��o sobre rochas calc�rias na Caatinga, Cerrado e Mata Atl�ntica'
  ObservacaoFicha<-'Prensada em �lcool 70%, amostra preservada em s�lica!' 
  
  PastaFichas<-"C:/Dados/GitHub/FichaHerbario/fichas"
  
#--- Carregar organizar e selecionar registros ---#

  coletas.full <- data.frame(fread(file.choose()), stringsAsFactors = F)

  coletas <- coletas.full[coletas.full$record_status %in% c("reimprimir-ficha"), ] 
                          # & coletas.full$duplicatesNumber==1,]
                          # & coletas.full$recordNumber=='788',]
  #doacao-sem-tombo-reimprimir
  coletas = coletas[order(coletas$recordedBy,coletas$recordNumber),]

#--- carregar autores ---#
  
  x = confere.lista.FloraBR2020(coletas$genus, coletas$specificEpithet, coletas$infraspecificEpithet)
  coletas$scientificNameAuthorship = x$scientificNameAuthorship
  coletas$family = ifelse(x$family =='',coletas$family, x$family)
  
#--- Gerar fichas ---# 
#   qtdefichaspagina = 5 ou 6 e qtdemaxpaginasjuncao = 15 (no m�ximo) 
  
  gerafichas(coletas,6,15,PastaFichas) #agrupafichas(QtdeFichasPagina,PastaFichas,QtdeMaxPaginasJuncao)

