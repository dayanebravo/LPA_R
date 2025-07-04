################ TEMA 02 - COMANDOS BÁSICOS ###################################

### OPERAÇÕES MATEMÁTICAS 
# adição
1 + 2

# subtração
2 - 1

# multiplicação
2 * 5

# divisão
5 / 2



### IMPORTANTE: INICIA EM 1 E NÃO EM 0 
# lista de 101 até 126
101:126



### OUTROS OPERADORES MATEMÁTICOS 
# potência
4 ^ 2

# resto da divisão de 7 por 5 / para saber se é par
7 %% 5

# parte inteira da divisão de 7 por 5
7 %/% 5

# resto da divisão de 7 por 5 ***ERRADO***
7 % 5





################ TEMA 03 - OBJETOS E FUNÇÕES #################################

### NOMEAR OBJETOS 
# nomes permitidos
nome_01 <- 5
Nome_01 <- 6
nome.01 <- 7

# nomes não permitidos
nome-01 <- 8
01_nome <- 9
_nome_01 <- 10



### TIPOS E CLASSES DE OBJETOS  
# Classe double - números reais
numeros_reais <- c(5, 2, 7) # A função c() gera um vetor de números reais
tipo_reais <- typeof(numeros_reais)
classe_reais <- class(numeros_reais)
writeLines(c("Tipo:", tipo_reais, "- Classe:", classe_reais), sep = " ")

# Classe integer - números inteiros
numeros_inteiros <- c(5L, 2L, 7L) # O sufixo L força a conversão para inteiro
tipo_inteiros <- typeof(numeros_inteiros)
classe_inteiros <- class(numeros_inteiros)
writeLines(c("Tipo:", tipo_inteiros, "- Classe:", classe_inteiros), sep = " ")

# Classe character - palavras (strings)
vetor_texto <- c("f", "g", "h") # Palavras entre aspas
tipo_texto <- typeof(vetor_texto)
classe_texto <- class(vetor_texto)
writeLines(c("Tipo:", tipo_texto, "- Classe:", classe_texto), sep = " ")

# Classe complex - números imaginários
numeros_complexos <- c(5 + 1i, 2 + 3i, 7 + 1i) # i representa a raiz quadrada de -1
tipo_complexos <- typeof(numeros_complexos)
classe_complexos <- class(numeros_complexos)
writeLines(c("Tipo:", tipo_complexos, "- Classe:", classe_complexos), sep = " ")

# Classe logical - valores lógicos
valores_logicos <- c(TRUE, FALSE, TRUE)
tipo_logicos <- typeof(valores_logicos)
classe_logicos <- class(valores_logicos)
writeLines(c("Tipo:", tipo_logicos, "- Classe:", classe_logicos), sep = " ")

# Classe raw - valores binários
valores_binarios <- raw(3)
tipo_binarios <- typeof(valores_binarios)
classe_binarios <- class(valores_binarios)
writeLines(c("Tipo:", tipo_binarios, "- Classe:", classe_binarios), sep = " ") 





### SINTAXE BASICA FUNÇÃO 
# sintaxe básica para criar uma função
nome_da_funcao <- function(parametro_01, parametro_02, ...) {
  # corpo da função
  # operações a serem realizadas
  return(resultado)  # valor a ser retornado
}


# criando a função soma
soma <- function(valor_01, valor_02) {
  resultado_soma <- valor_01 + valor_02
  return(resultado_soma)
}


# executando a função soma
resultado_funcao_soma <- soma(4, 2)
print(resultado_funcao_soma)


### ARGUMENTO (...) 
# criando a função soma com o terceiro argumento
soma_3_argumento <- function(valor_01, valor_02, ...) {
  resultado_soma <- sum(valor_01, valor_02, ...)
  return(resultado_soma)
}

# criando um objeto com um valor inexistente
lista_a <- c(2, 3, NA) # lista a com o NA = valor inexistente
lista_b <- c(2, 3) # lista b com dois valores

# executando a função soma com o terceiro argumento
resultado_funcao_soma <- soma_3_argumento(lista_a, lista_b, na.rm = TRUE)
print(resultado_funcao_soma)





################ TEMA 04 - BOAS PRÁTICAS #####################################

### FUNÇÃO SOMA - OUTRAS VERSÕES 
# criando a função soma - versão 02
soma_v02 <- function(valor_01, valor_02) {
  return(valor_01 + valor_02)
}

# criando a função soma - versão 03
soma_v03 <- function(valor_01, valor_02) valor_01 + valor_02

# criando a função soma - versão 04
soma_v04 <- function(valor_01, valor_02) {
  resultado_soma <- sum(valor_01, valor_02)
  return(resultado_soma)
}


# executando a função soma versão 02, 03 e 04
resultado_funcao_soma_v02 <- soma_v02(1,2)
print(resultado_funcao_soma_v02)

resultado_funcao_soma_v03 <- soma_v03(2,2)
print(resultado_funcao_soma_v03)

resultado_funcao_soma_v04 <- soma_v04(3,2)
print(resultado_funcao_soma_v04)



### FUNÇÃO RUNINF PRÉ-DEFINIDA 
# Padrão da ordem dos argumentos runinf
runif(n, min = 0, max = 1)

# Gera 10 valores de 1 até 9
runif(10, 1, 9)

# Alterando a ordem do máximo e do mínimo
runif(n = 5, max = 50, min = 1)



### Quais argumentos a função possui
args(runif)
args(writeLines)





################ TEMA 05 - DOCUMENTAÇÃO ######################################

### MECANISMOS DE AJUDA 
?runif
?writeLines
?mean
help(mean)



### MECANISMOS DE BUSCA 
# Encontrar termo no nome da função
apropos('model')

# Encontrar termo dentro da documentação
help.search("model")

# Encontrar o pacote que a função pertence
find('mean')

# Encontrar quais pacotes estão carregados no seu workspace
search()

# Instalar um pacote
install.packages("colorspace")

# Carregar um pacote
library(colorspace)

