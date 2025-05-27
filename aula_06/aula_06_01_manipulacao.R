################ TEMA 01 - MANIPULAÇÃO DE DADOS ################################

data("iris")      # carrega o conjunto de dados iris
head(iris)        # exibe as 6 primeiras linhas
str(iris)         # mostra a estrutura das colunas
summary(iris)     # calcula estatísticas descritivas básicas



### manipular colunas
# Usando o operador $
comprimento_petala <- iris$Petal.Length  
print(comprimento_petala)   # Retorna um vetor com 150 valores


# Usando colchetes [linhas, colunas]
comprimento_sepala <- iris[, "Sepal.Length"]    # todas as linhas
print(comprimento_sepala)  # Retorna um vetor com 150 valores


# Usando colchetes para combinar colunas
dados_sepala <- iris[, c("Sepal.Length", "Sepal.Width")]  # concatenadas
print(dados_sepala)   # Retorna um dataframe


# Por índice de coluna
especies <- iris[, 5]  # lembre que a coluna 5 são as espécies
print(especies)
class(especies)   # é um fator de 3 níveis



### manipular linhas
# Flores com comprimento de sépala maior que 7 cm
comprimento_sep_7 <- iris[iris$Sepal.Length > 7, ]
print(comprimento_sep_7)


# Flores da espécie virginica
seleciona_virginica <- iris[iris$Species == "virginica", ]
print(seleciona_virginica)


# Combinando as condições anteriores
comprimento_sep_7_virginica <- iris[iris$Sepal.Length > 7 & iris$Species == "virginica", ]
print(comprimento_sep_7_virginica)



### gerar colunas
# Razão entre comprimento e largura da pétala
iris$razao_petala <- iris$Petal.Length / iris$Petal.Width
head(iris)
iris$razao_petala <- NULL  # remove a coluna criada

# Classificação por tamanho de sépala
iris$classifica_tamanho <- ifelse(iris$Sepal.Length > 6, "Grande", "Pequeno")
head(iris)



### ordenar dados
# Ordem crescente por comprimento de sépala
cresc_comp_sepala <- iris[order(iris$Sepal.Length), ]
head(cresc_comp_sepala, n = 20)

# Ordem decrescente por largura de pétala (sinal negativo na coluna)
dec_larg_petala <- iris[order(-iris$Petal.Width), ]
head(dec_larg_petala, n = 20)

# Ordem por espécie e depois por comprimento de sépala
ordem_especie_sepala <- iris[order(iris$Species, iris$Sepal.Length), ]
head(ordem_especie_sepala, n = 20)



### agrupamento
# Média do comprimento da sépala por espécie
aggregate(Sepal.Length ~ Species, data = iris, FUN = mean)


# Desvio padrão do comprimento e largura da sépala por espécie
aggregate(cbind(Sepal.Length, Sepal.Width) ~ Species, 
          data = iris, 
          FUN = sd)
# help("cbind")  # combina colunas
