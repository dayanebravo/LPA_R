# Instalar e carregar o pacote
install.packages("esquisse")
library(esquisse)

install.packages("plotly")
library(plotly)

# Iniciar o esquisse com o dataset 'iris'
esquisser(iris)



### saída do esquisse
ggplot(iris) +
  aes(x = Petal.Length, y = Petal.Width, colour = Species) +
  geom_point() +
  scale_color_hue(direction = 1) +
  theme_minimal()



### exibe os dados quando passamos o cursor neles
install.packages("plotly")
library(plotly)
