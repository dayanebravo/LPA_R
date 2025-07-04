########################### TEMA 01 - SELECAO CONDICIONAL ######################

### Selecao numerica
dados <- c(5, 10, 42, 28, 79)
condicao_selecao <- dados > 15

print(dados[condicao_selecao])

print(condicao_selecao)


### Expressoes regulares
# selecao de caracteres
nomes <- c("Ana", "Amanda", "Carlos", "Aline", "Olivia", "Fernando")  


# no inicio da palavra
seleciona_C <- grepl("^C", nomes)
print(seleciona_C)
print(nomes[seleciona_C])


# no final da palavra
seleciona_a <- grepl("a$", nomes)
print(seleciona_a)
print(nomes[seleciona_a])


# no inicio e no final da palavra
seleciona_A_a <- grepl("^A.*a$", nomes)  
print(seleciona_A_a)  
print(nomes[seleciona_A_a])  


# em qualquer lugar da palavra
seleciona_o <- grepl("o.*", nomes, ignore.case = TRUE)
print(seleciona_o)  
print(nomes[seleciona_o]) 



### Combinando selecoes
# intersecao de selecoes - conector "e"
idades <- c(12, 25, 30, 15, 18, 22, 28)
seleciona_idades_e <- idades >= 20 & idades <= 25
print(seleciona_idades_e)
print(idades[seleciona_idades_e])


# uniao de selecoes - conector "ou"
seleciona_idades_ou <- idades < 15 | idades > 25
print(seleciona_idades_ou)
print(idades[seleciona_idades_ou])


# combinando vetores
# Seleciona nome dado a quantidade
frutas <- c("caqui", "banana", "laranja", "uva", "melancia")
quantidade_frutas <- c(10, 5, 8, 15, 3)
seleciona_quantidade_7 <- quantidade_frutas > 7
print(seleciona_quantidade_7)
print(frutas[seleciona_quantidade_7]) 


# funcao %in%
frutas_preferidas <- c("banana", "uva", "goiaba")
print(frutas_preferidas)
print(frutas[frutas %in% frutas_preferidas])



### Selecao Condicional em DataFrames
# Criando o dataframe do estoque de frutas
frutas <- c("caqui", "banana", "laranja", "uva", "melancia")
quantidade_frutas <- c(10, 5, 8, 15, 3)
preco_frutas <- c(2, 1, 3, 4, 5)

estoque <- data.frame(
  fruta = frutas,
  quantidade = quantidade_frutas,
  preco = preco_frutas
)

print(estoque)


# Combinando selecoes em colunas diferentes
quantidade_7 <- estoque$quantidade > 7
print(quantidade_7)

preco_4 <- estoque$preco < 4
print(preco_4)

# Aplicando as condicoes no dataframe
print(estoque[quantidade_7 & preco_4, ])


# Funcao subset
subset(x = estoque, subset = quantidade > 7)

subset(estoque, quantidade > 7 & preco < 4)

seleciona_coluna <- c("fruta", "preco")   # para o select
subset(estoque, quantidade > 7, select = seleciona_coluna)





########################### TEMA 02 - ESTRUTURAS DE REPETICAO ##################

# for
for (i in 1:5) {
  print(i)
}


# for em vetores
seq_veiculos <- c("carro", "onibus", "bicicleta", "moto")
for (veiculo in seq_veiculos) {
  print(veiculo)
}


# o for em dataframes
# Criando um dataframe com notas de alunos
notas <- data.frame(
  aluno = c("Joao", "Maria", "Pedro"),
  prova_1 = c(8, 7, 5),
  prova_2 = c(6, 9, 4),
  prova_3 = c(7, 8, 6)
)

# Criando uma coluna para armazenar as medias
notas$media <- 0  

# Indicando quais colunas estao as notas das provas
colunas_provas <- c("prova_1", "prova_2", "prova_3")   

for (i in 1:nrow(notas)) {
  notas$media[i] <- mean(as.numeric(notas[i, colunas_provas]))
}

print(notas)


# Funcao for aninhados
# Criando uma matriz com todos os elementos iguais a zero
matriz_3x3 <- matrix(0, nrow = 3, ncol = 3)

for (indice_linha in 1:3) {
  for (indice_coluna in 1:3) {
    produto_indices <- indice_linha * indice_coluna
    matriz_3x3[indice_linha, indice_coluna] <- produto_indices
  }
}

print(matriz_3x3)





########################### TEMA 03 - ESTRUTURAS DE SELECAO ####################

# if
x <- 5

if (x > 0) {
  print("O numero eh positivo.")
}


# else
x <- -3

if (x > 0) {
  print("O numero eh positivo.")
} else {
  print("O numero nao eh positivo.")
}


# else if
x <- 0

if (x > 0) {
  print("O numero eh positivo.")
} else if (x < 0) {
  print("O numero eh negativo.")
} else {
  print("O numero eh zero.")
}


# ESSE COMANDO NaO eh EXECUTADO
x <- c(1, -2, 3)

if (x > 0) {
  print("Pelo menos um numero eh positivo.")
}
# Error in if (x > 0) { : the condition has length > 1
# existem duas condicoes verdadeiras
# o if retorna apenas uma


# Para contornar esse problema:
# ifelse(condicao, valor se verdadeiro, valor se falso)
resultado <- ifelse(x > 0, "Positivo", "Negativo ou zero")
print(resultado)



### Selecao 
# if em dataframes
notas <- data.frame(
  aluno = c("Joao", "Maria", "Pedro"),
  media = c(70, 80, 50)
)

# Criando uma coluna para a situacao do aluno
notas$situacao <- NA  

# Criando as condicoes de aprovacao
for (i in 1:nrow(notas)) {
  
  if (notas$media[i] >= 70) {
    notas$situacao[i] <- "Aprovado"
    
  } else {
    notas$situacao[i] <- "Reprovado"
  }
}

print(notas)


# if em funcoes
soma <- function(a, b) {
  return(a + b)
}

soma_3_5 <- soma(3, 5)

if (soma_3_5 %% 2 == 0) {  # resto da divisao = 0 -> par
  print("A soma eh par.")
} else {
  print("A soma eh impar.")
}



### Combinando if com o for
# break para interromper
for (i in 1:10) {
  if (i == 3) {
    break
  }
  print(i)
}


# next para pular
for (i in 1:5) {
  if (i == 2) {
    next
  }
  print(i)
}
# A iteracao onde i == 2 eh pulada e executada ate o ultimo item i==5.





########################### TEMA 04 - A ESTRUTURA WHILE ########################

# while com contador
contador <- 5

while (contador > 0) {
  print(contador)
  contador <- contador - 1
}


# while com auxiliar
# variavel auxiliar para executar a soma
acumula_soma <- 0
i <- 1

while (i <= 10) {
  acumula_soma <- acumula_soma + i
  i <- i + 1
}

print(acumula_soma)


# while aleatorio
# encontrar o primeiro numero maior que 100 
# em uma sequencia de numeros aleatorios
set.seed(519)  # para reproducao
numero <- 0

while (numero <= 100) {
  numero <- sample(1:200, 1)  # Gera um numero aleatorio entre 1 e 200
  print(numero)
}



### Combinando while com if
# while com break
numero_secreto <- 42 # Este eh o numero que ira encerrar o loop
entrada_usuario <- 0

while (TRUE) {  
  entrada_usuario <- as.numeric(readline("Adivinhe o numero secreto (1 a 50): "))
  
  if (entrada_usuario == numero_secreto) {
    print("Parabens! Voce acertou!")
    break  # Interrompe o loop
    
  } else if (entrada_usuario < numero_secreto) {
    print("Tente um numero maior.")
    
  } else {
    print("Tente um numero menor.")
  }
  
}


### while com next
i <- 1

while (i <= 10) {
  
  if (i %% 2 != 0) {  # Verifica se o numero eh impar
    i <- i + 1
    next  # Pula para a proxima iteracao
  }
  
  print(i)
  i <- i + 1
}





########################### TEMA 05 - A ESTRUTURA REPEAT #######################

# condicao de parada interna via if
# no while fica externa no cabecalho
contador <- 5

repeat {
  print(contador)
  contador <- contador - 1
  
  if (contador == 0) {
    break
  } 
}


# soma com repeat
acumula_soma <- 0
i <- 1

repeat {
  acumula_soma <- acumula_soma + i
  i <- i + 1
  
  if (i > 10) {
    break
  }
}
# quando i == 11, a condicao i > 10 se torna verdadeira
# e o break interrompe o loop

print(acumula_soma)



### next para pular para a proxima iteracao sem executar o restante do codigo
i <- 1
repeat {
  if (i > 10) {
    break
  }
  
  if (i %% 2 != 0) {  # Verifica se o numero eh impar
    i <- i + 1
    next  # Pula para a proxima iteracao
  }
  
  print(i)
  i <- i + 1 
}


# NUMERO SECRETO COM REPEAT
numero_secreto <- 42
tentativas <- 0
max_tentativas <- 4   # condicao de parada

repeat {
  tentativa <- as.numeric(readline("Adivinhe o numero secreto (1 a 100): "))
  tentativas <- tentativas + 1
  
  if (tentativa == numero_secreto) {
    print("Parabens! Voce acertou!")
    break
    
  } else if (tentativas >= max_tentativas) {
    print(paste("Voce excedeu o numero maximo de tentativas.
                  O numero secreto era:", numero_secreto))
    break
    
  } else if (tentativa < numero_secreto) {
    print("Tente um numero maior.")
    
  } else {
    print("Tente um numero menor.")
  }
}
