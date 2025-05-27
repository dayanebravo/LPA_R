################ TEMA 01 - ARITMÉTICA DE PONTO FLUTUANTE #######################

# A raiz quadrada de dois elevada ao quadrado menos dois
resultado_raiz = sqrt(2)^2 - 2
print(resultado_raiz)


# A representação das casas decimais da raiz quadrada de 
# dois elevada ao quadrado
print(sqrt(2)^2, digits = 22)


# A soma cujo resultado deveria ser zero
resultado_soma = 0.3 + 0.6 - 0.9
print(resultado_soma)


# A representação das casas decimais dos doubles
num_decimais = c(0.3, 0.6, 0.9)
print(num_decimais, digits = 22)


# Atribuindo a quantidade de casas decimais (após a vírgula)
print(resultado_soma)

resultado_soma_15 <- round(resultado_soma, digits = 15)
print(resultado_soma_15)
# ATENÇÃO: Caso o número de casas seja 16, obtemos o erro novamente. 



### Formato científico com 3 casas significativas (antes E após a vírgula)
resultado_soma_3 <- format(resultado_soma, scientific = TRUE, digits = 3)
print(resultado_soma_3)

print(class(resultado_soma_3))
# ATENÇÃO: O resultado é um caractere, não um número!





################ TEMA 02 - VETORES #############################################

# vetores numéricos
vetor_numerico <- c(2, 9, 4, 8)
print(vetor_numerico)


# Regra da reciclagem
x <- c(10, 5, 2, 4, 8, 9)
y <- c(2, 1)
print(x + y)



### Quando o vetor maior não é divisível pelo vetor menor 
x <- c(10, 5, 2, 4, 8, 9)
y_alterado <- c(2, 1, 3, 2)
print(x + y_alterado) 
# operação realizada mesmo assim!



### Vetores de Caracteres e Lógicos  
# vetor de palavras
vetor_caracter <- c("praia", "montanha", "cidade")
print(typeof(vetor_caracter))  
print(class(vetor_caracter))


# vetor lógico
vetor_numerico <- c(10, 5, 2, 4, 8, 9)
vetor_logico <- (vetor_numerico > 4)
print(vetor_logico)



### Coerção de Tipos - Implícita
# números e caracteres -> converte para caracteres
num_char <- c(1, "a", TRUE)
print(typeof(num_char)) 


# números e valores lógicos -> converte para números
num_logic <- c(1, TRUE, FALSE)
print(typeof(num_logic))  
print(num_logic)



### Coerção de Tipos - Explícita 
# converter de caracteres para numéricos manualmente
vetor_caracteres <- c("1", "2", "3")
print(typeof(vetor_caracteres)) 

vetor_numerico <- as.numeric(vetor_caracteres)
print(typeof(vetor_numerico))  
print(vetor_numerico)



### Valores especiais 
x <- c(1, NA, 3, NaN, Inf)

is.na(x)  

is.nan(x) 

is.infinite(x) 



### Fatores 
vetor_categorico <- c("baixa", "alta", "baixa", "baixa", "média")
exemplo_fator <- factor(vetor_categorico)
print(exemplo_fator)
# automaticamente em ordem alfabética


# ordenar os níveis manualmente
vetor_niveis = c("baixa", "média", "alta")
fator_ordenado <- factor(exemplo_fator, levels = vetor_niveis)
print(fator_ordenado)


# representação numérica interna
unclass(exemplo_fator)
unclass(fator_ordenado)


# argumento “ordered” 
fator_ordenado_crescente <- factor(exemplo_fator, levels = vetor_niveis, 
                                    ordered = TRUE)
print(fator_ordenado_crescente)





################ TEMA 03 - MATRIZES E ARRAYS ###################################

### Matrizes  
matriz_3x4 <- matrix(1:12, nrow = 3, ncol = 4)
print(matriz_3x4)


# argumento byrow = TRUE
matriz_linha_3x4 <- matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)
print(matriz_linha_3x4)



### Indexação
# alterar um determinado elemento da matriz
atribuicao_2_3 = matriz_linha_3x4 [2, 3] <- 35
print(matriz_linha_3x4)


# acessar elementos específicos da matriz usando índices
print(matriz_linha_3x4 [2, 3])


# acessar uma linha inteira
linha_2 = matriz_linha_3x4 [2, ]
print(linha_2)


# acessar uma coluna inteira
coluna_3 = matriz_linha_3x4 [ ,3]
print(coluna_3)


# acessar várias linhas ao mesmo tempo passando um vetor de índices
# deixando o espaço da coluna em branco
vetor_linhas_1_3 = c(1, 3)
print(matriz_linha_3x4 [vetor_linhas_1_3, ])


# acessar várias colunas ao mesmo tempo passando um vetor de índices
# deixando o espaço da linha em branco
vetor_colunas_2_4 = c(2, 4)
print(matriz_linha_3x4 [ ,vetor_colunas_2_4])


# acessar submatrizes especificando intervalos de linhas e colunas
matriz_linha_3x4[2:3, 2:4]



### Operações com Matrizes  
A <- matrix(1:4, nrow = 2)
B <- matrix(5:8, nrow = 2)
print(A)
print(B)


# soma de matrizes
print(A + B)


# subtração de matrizes
print(A - B)


# multiplicação por uma constante
print(A*5)


# multiplicação de matrizes - usual
mult_AxB <- A %*% B
print(mult_AxB)


# a multiplicação de matrizes não é COMUTATIVA!
C <- matrix(5:10, nrow = 3)
print(A %*% C) # ERRO
print(C %*% A)


# multiplicação elemento a elemento - não usual
# ATENÇÃO para o operador
print(A*B) 	


# calcular a inversa de uma matriz QUADRADA e det(A)\=0
print(A)
print(det(A))
print(solve(A))



### Arrays 
# Criando o array tridimensional/ cubo
seq_dados = 1:8 # Dados numéricos (8 valores)
dimensoes = c(2, 2, 2) # Dimensões (2 alturas, 2 larguras, 2 profundidades)


# Vetores com os nomes dos níveis das dimensões
nomes_alturas = c("Baixo", "Alto") 
nomes_larguras = c("Esquerda", "Direita") 
nomes_profundidades = c("Frente", "Tras") 


# Lista com os nomes das dimensões
nomes_dimensoes = list(
  nomes_alturas, 
  nomes_larguras, 
  nomes_profundidades	
)

cubo <- array(
  data = seq_dados,                
  dim = dimensoes,
  dimnames = nomes_dimensoes
)

print(cubo)


# Indexação de arrays 
# acessar os elementos usando os nomes das dimensões
print(cubo["Alto", "Esquerda", "Frente"])


# acessar toda a Frente do cubo 
print(cubo[, , "Frente"])


# acessar a coluna Esquerda em todas as alturas e profundidades
print(cubo[, "Esquerda", ])  


# acessar a linha Baixo em todas as larguras e profundidades
print(cubo["Baixo", , ])






########################### TEMA 04 - Listas ###################################

### Criando uma lista com diferentes tipos de dados
vetor_nome = c("Maria", 2) # cada OBJETO deve ser do mesmo tipo
valor_idade = 30
vetor_notas = c(8, 7, 9)

minha_lista <- list(
  nome = vetor_nome, 
  idade = valor_idade,
  notas = vetor_notas
)

print(minha_lista)
# coerção implícita: o 2 é convertido em caractere



### Indexação
# acessar os elementos das listas usando o operador $ 
print(minha_lista$nome)


# ou colchetes duplos [[ ]]
print(minha_lista[[3]]) 


# acessar objetos específicos utilizando o operador $ 
# com o nome do item e sua posição
print(minha_lista$nome[1])
print(minha_lista$notas[2])

# ou utilizando os colchetes duplos 
print(minha_lista[[1]][[1]])
print(minha_lista[[3]][[2]])

# ou informando um vetor com a posição do item 
# junto da posição de seu subitem
print(minha_lista[[c(1, 1)]])
print(minha_lista[[c(3, 2)]])


# Modificando elementos
minha_lista$nome[2]<-"Pedro"
print(minha_lista$nome) # Pedro no lugar de "2"


# listas aninhadas
# colocar dentro de uma lista, outra lista
dados_Maria = list(nome = "Maria", idade = 25)
dados_Pedro = list(nome = "Pedro", idade = 30)

lista_aninhada <- list(
  pessoa1 = dados_Maria,
  pessoa2 = dados_Pedro
)

print(lista_aninhada)





########################### TEMA 05 - DataFrames ###############################

### Criando um data frame com informações de pessoas
vetor_nome = c("Joao", "Maria", "Pedro")
vetor_idade = c(30, 25, 28)
vetor_salario = c(3000, 3500, 4000)

meu_df <- data.frame(
  nome = vetor_nome,
  idade = vetor_idade,
  salario = vetor_salario
)

print(meu_df)



### Indexação
# acessar colunas específicas usando o operador $ 
print(meu_df$nome)


# ou colchetes simples
print(meu_df["nome"])


# Acessar a segunda linha (informações da Maria)
print(meu_df[2, ])   


# Acessar a terceira linha, segunda coluna (idade do Pedro)
print(meu_df[3, 2])


# Acessar a terceira linha da coluna nome
print(meu_df[3, "nome"])


# Adicionar a coluna cidade
meu_df$cidade <- c("Sao Paulo", "Curitiba", "Belo Horizonte")
print(meu_df)


# Remover a coluna cidade por meio da função NULL
meu_df$cidade <- NULL
print(meu_df)



### Funções úteis para df
# Mostra as primeiras 6 linhas (ou todas, se houver menos)
print(head(meu_df))


# Mostra as últimas 6 linhas (ou todas, se houver menos)
print(tail(meu_df))


# Quantidade de linhas
print(nrow(meu_df))  


# Quantidade de colunas
print(ncol(meu_df))


# Retorna os nomes das colunas.
print(names(meu_df))







