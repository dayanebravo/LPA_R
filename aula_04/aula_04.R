################ TEMA 01 -  ENTRADA MANUAL DE DADOS ############################

### funcao scan
# sintaxe basica
scan(file = "", what = double(), nmax = -1, n = -1, sep = "", dec = ".", ...)

# para varias entradas numericas
valores <- scan()
# digitar os valores no console
# parar com enter 2x

print(valores)


# para varias entradas de texto
nomes <- scan(what = "character")
# digitar os nomes no console
# parar com enter 2x

print(nomes)


# limitar a quantidade de dados
valores_3 <- scan(n = 3)
# digitar os valores no console

print(valores_3)



### funcao readine
# entrada texto - unica
nome <- readline("Digite seu nome: ")
# digitar o nome no console

print(paste("Ola,", nome))


# entrada numero - unica
idade <- as.numeric(readline("Digite sua idade: "))
# digitar a idade no console

print(paste("Voce tem", idade, "anos."))





################ TEMA 02 -  IMPORTACAO DE DADOS - ARQUIVOS ##################### 

### funcao read.table - do R Base
# sintaxe basica
read.table(file = "caminho", header = FALSE, sep = "", dec = ".", 
           na.strings = "NA", ...)


# arquivo txt
arquivo_texto_txt <- "arquivo_texto_txt.txt"
#arquivo_texto_txt <- "https://raw.githubusercontent.com/dayanebravo/LPA_R/refs/heads/main/aula_04/arquivo_texto_txt.txt"
read.table(file = arquivo_texto_txt, header = TRUE, sep = "", dec = ".")
# utilizar a barra normal e nao a invertida no caminho da pasta
# a ultima linha do arquivo deve ser vazia



arquivo_texto_csv <- "arquivo_texto_csv.csv"
#arquivo_texto_csv <- "https://raw.githubusercontent.com/dayanebravo/LPA_R/refs/heads/main/aula_04/arquivo_texto_csv.csv"
read.table(arquivo_texto_csv, header = TRUE, sep = ";", dec = ".")
# conferir o separador abrindo o arquivo com o bloco de notas



### funcao read_excel
# necessario instalar e carregar o pacote
if(!require(readxl)) install.packages('readxl')
library(readxl)

# sintaxe basica
read_excel(path = "caminho", sheet = NULL, range = NULL, col_names = TRUE, 
           col_types = NULL, na = "", ...)

# arquivo xlsx
# =================== BAIXAR O ARQUIVO XLSX ================================
# https://github.com/dayanebravo/LPA_R/blob/main/aula_04/planilha_xlsx.xlsx
planilha_xlsx <- "planilha_xlsx.xlsx"
read_excel(path = planilha_xlsx, sheet = NULL, range = NULL, col_names = TRUE, 
           col_types = NULL, na = "")


# arquivo xlsx - especificando aba e intervalo
excel_sheets(planilha_xlsx)  # Para listar o nome das abas
read_excel(path = planilha_xlsx, sheet = "Nome_planilha_2", range = "A1:C4", 
           col_names = TRUE, col_types = NULL, na = "")


# arquivo xlsx - especificando a aba e os tipos das colunas
tipos_colunas <- c("date", "text", "numeric")
read_excel(path = planilha_xlsx, sheet = 3, range = NULL, col_names = TRUE, 
           col_types = tipos_colunas, na = "")



### pacote openxlsx
# instalar e carregar o pacote
if(!require(openxlsx)) install.packages('openxlsx')
library(openxlsx)


# sintaxe basica para leitura
read.xlsx(xlsxFile = "caminho", sheet = 1, startRow = 1, 
          colNames = TRUE, rowNames = FALSE, ...)


# especificando aba, linha inicial, nomes das linhas, omitindo colunas
read.xlsx(xlsxFile = planilha_xlsx, sheet = 4, startRow = 2, colNames = FALSE, 
          rowNames = TRUE)


################ TEMA 03 -  IMPORTACAO DE DADOS - OUTROS FORMATOS ############## 

### dados da web
# limitando a quantidade de linhas
URL_trabalhadores <- "https://raw.githubusercontent.com/dayanebravo/Est_Graf_py/refs/heads/main/Employee.csv"
#URL_trabalhadores <- "Employee.csv"
trabalhadores_10 <- read.csv(URL_trabalhadores, nrows = 10)
print(trabalhadores_10)


# pela read.table precisamos especificar o separador e o cabecalho
trabalhadores_15 <- read.table(URL_trabalhadores, header = TRUE, sep = ",", nrows = 15)
print(trabalhadores_15)



### Banco de dados
# nao faremos aqui
# mostraremos apenas a sintaxe para o SQLite

# Instalar pacotes
if(!require(DBI)) install.packages('DBI')
if(!require(RSQLite)) install.packages('RSQLite')

# Carregar pacotes
library(DBI)
library(RSQLite)

# Conectar
conexao <- dbConnect(
  SQLite(), 
  dbname = "meu_banco.db"  # Caminho para o arquivo do banco de dados
)

# Desconectar
dbDisconnect(conexao)



### formato json
# Instalando e carregando o pacote
if(!require(jsonlite)) install.packages('jsonlite')
library(jsonlite)

# Importando o arquivo JSON
dados_json_url <- fromJSON("https://raw.githubusercontent.com/Maujor/json/refs/heads/master/db.json")
print(dados_json_url)





################ TEMA 04 - SAIDA DE DADOS ##################################### 

### funcao write.csv
# Criando um primeiro dataframe de exemplo
dados_df <- data.frame(
  Nome = c("Ana", "Maria", "Pedro"),
  Idade = c(25, 30, 22),
  Cidade = c("Curitiba", "Rio de Janeiro", "Belo Horizonte")
)

# Exportando para CSV
caminho_arquivo_csv <- "dados_df_csv.csv"
write.csv(dados_df, file = caminho_arquivo_csv, row.names = FALSE)

# conferindo se o arquivo foi salvo corretamente
read.table(caminho_arquivo_csv, header = TRUE, sep = ",")


# Exportando para xlsx
caminho_arquivo_xlsx <- "dados_df_xlsx.xlsx"
write.xlsx(dados_df, file = caminho_arquivo_xlsx)

# conferindo se o arquivo foi salvo corretamente
read.xlsx(caminho_arquivo_xlsx, colNames = TRUE, sep = ",")


# multiplas planilhas
# Criando um segundo dataframe
dados_2 <- data.frame(
  Produto = c("Caneta", "Papel", "Borracha"),
  Quantidade = c(10, 15, 8)
)

# Exportando para Excel com multiplas planilhas
caminho_arquivo_xlsx_2 <- "dados_df_xlsx_2.xlsx"
write.xlsx(list(Plan1 = dados_df, Plan2 = dados_2), 
           file = caminho_arquivo_xlsx_2)

# conferindo se o arquivo foi salvo corretamente e se a aba 2 foi feita
read.xlsx(caminho_arquivo_xlsx_2, colNames = TRUE, sep = ",", sheet = 2)


# Exportando para JSON
caminho_arquivo_json <- "dados_df_json.json"
write_json(dados_df, path = caminho_arquivo_json) 

# conferindo se o arquivo foi salvo corretamente
read_json(caminho_arquivo_json, colNames = TRUE, sep = ",")





################ TEMA 05 - CARREGANDO DATASETS DO R ########################### 

### consulta quais datasets estao disponiveis
library(help = "datasets")
# ou data()

# Datasets de pacotes especificos 
data(package = "nlme")

# usando um dataset e verificando sua estrutura
data("mtcars")
str(mtcars)

head(mtcars) # as 6 primeiras linhas
?mtcars # documentacao


### datasets mais famosos
data("iris")
head(iris)

data("airquality")
head(airquality)

data("Titanic")
head(Titanic)

data("USArrests")
head(USArrests)
