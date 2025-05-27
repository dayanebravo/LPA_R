################ TEMA 02 - DPLYR ###############################################

# instalar a carregar pacote
install.packages("tidyverse")
library(dplyr)

### comparando R base com dplyr - legibilidade
# R base
subset(iris, Sepal.Length > 5, select = c(Sepal.Length, Species))


# dplyr
iris %>% 
  filter(Sepal.Length > 5) %>% 
  select(Sepal.Length, Species) 
# %>% é chamado de pipe



### comparando agrupamento
# R base
aggregate(Sepal.Length ~ Species, data = iris, FUN = mean)


# dplyr
iris %>% 
  group_by(Species) %>% 
  summarise(comprimento_medio_sepala = mean(Sepal.Length))



### comparando desempenho computacional
# Criando um dataset grande para teste – 1 milhão de linhas
set.seed(123)
iris_grande <- iris[sample(1:nrow(iris), 1e6, replace = TRUE), ]


# Instalando pacote para cronometrar tempo de processamento
install.packages("microbenchmark")
library(microbenchmark)


# Comparativo dos tempos de processamento 
# (pode variar de acordo com a máquina que está rodando o código)
microbenchmark(
  
  # Versão dplyr
  dplyr = {
    iris_grande %>%
      filter(Sepal.Length > 5) %>%
      group_by(Species) %>%
      summarise(
        media_comprimento = mean(Sepal.Length),
        desvio_comprimento = sd(Sepal.Length),
        mediana_comprimento = median(Sepal.Length),
        
        media_largura = mean(Sepal.Width),
        desvio_largura = sd(Sepal.Width),
        mediana_largura = median(Sepal.Width),
        .groups = 'drop'
      )
  },
  
  
  
  # Versão R base
  r_base = {
    filtro_comprimento_5 <- 
      iris_grande[iris_grande$Sepal.Length > 5, ]
    
    estatisticas <- 
      do.call(data.frame, 
              aggregate(
                cbind(Sepal.Length, Sepal.Width) ~ Species,
                data = filtro_comprimento_5,
                FUN = function(x) {
                  c(mean = mean(x),
                    sd = sd(x),
                    median = median(x))
                }))
    
    estatisticas
  },
  
  times = 10  # quantidade de avaliações
)



