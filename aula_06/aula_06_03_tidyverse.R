################ TEMA 03 - TIDYVERSE ###########################################

# Instalando e carregando o pacote ggplot2
install.packages("ggplot2")
library(ggplot2)

# gráfico que relaciona o comprimento e largura das sépalas por espéice
ggplot(data = iris, 
       aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
  geom_point(size = 3)  



### Gráfico com linhas de tendência por espécie
ggplot(iris, 
       aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3) +  # Pontos coloridos por espécie
  geom_smooth(method = "lm", se = FALSE) +  # Linhas de tendência por espécie
  labs(
    title = "Relação entre Comprimento e Largura das Sépalas",
    x = "Comprimento da Sépala (cm)",
    y = "Largura da Sépala (cm)")






