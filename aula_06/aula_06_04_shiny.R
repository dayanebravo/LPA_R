################ TEMA 04 - SHINY ###########################################

# instalando e carregando pacotes
install.packages("shiny")
library(shiny)
library(ggplot2)


### gerando um gráfico interativo - menu
# Definição da interface do usuário
ui_iris <- 
  fluidPage(  
    selectInput("especie", 
                "Selecione a espécie:", 
                choices = unique(iris$Species)),
    plotOutput("grafico")
  )

# Definição do server que processa os dados e gera saídas
server_iris <- 
  function(input, output) {
    output$grafico <- 
      renderPlot({
        dados <- subset(iris, Species == input$especie)
        ggplot(dados, 
               aes(Petal.Length, Petal.Width)) + 
          geom_point()
      })
  }

# Executa o aplicativo
shinyApp(ui = ui_iris, server = server_iris)







### gerando um gráfico interativo - checkbox
# Definição da interface do usuário - agora com checkbox
ui_checkbox <- 
  fluidPage(
    titlePanel("Análise Interativa da Base Iris"),
    
    # Checkbox único para ativar/desativar a visualização por grupos
    checkboxInput(
      inputId = "mostrar_grupos",  # ID referenciado no server
      label = "Mostrar os grupos (espécies)?", 
      value = FALSE  # Valor inicial (desmarcado)
    ),
    
    plotOutput("grafico")
  )

# Definição do server que processa os dados e gera saídas
server_checkbox <- 
  function(input, output) {
    output$grafico <- renderPlot({
      if (input$mostrar_grupos) {
        # Se checkbox = TRUE, plota com cores por espécie
        ggplot(iris, aes(x = Petal.Length, 
                         y = Petal.Width, 
                         color = Species)) +
          geom_point(size = 3) +
          labs(x = "Comprimento da Pétala (cm)",
               y = "Largura da Pétala (cm)")
      } else {
        # Se checkbox = FALSE, plota todos os pontos na mesma cor
        ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
          geom_point(size = 3) +
          labs(x = "Comprimento da Pétala (cm)",
               y = "Largura da Pétala (cm)")
      }
    })
  }

# Executa o aplicativo
shinyApp(ui = ui_checkbox, server = server_checkbox)








### gerando um gráfico interativo - abas
ui_abas <- 
  fluidPage(
    titlePanel("Análise das Características da Iris"),
    
    # Cria a aba das sépalas
    tabsetPanel(
      tabPanel("Sépala",
               selectInput("variavel_sepala", "Selecione a medida:",
                           choices = c("Comprimento" = "Sepal.Length",
                                       "Largura" = "Sepal.Width")),
               tableOutput("tabela_sepala")),
      
      # Cria a aba das pétalas
      tabPanel("Pétala",
               selectInput("variavel_petala", "Selecione a medida:",
                           choices = c("Comprimento" = "Petal.Length",
                                       "Largura" = "Petal.Width")),
               tableOutput("tabela_petala"))
    )
  )

server_abas <- 
  function(input, output) {
    
    # Função para calcular estatísticas
    calcular_estatisticas <- 
      function(variavel) {
        iris %>%
          group_by(Species) %>%
          summarise(
            Media = mean(get(variavel)),
            Desvio_Padrao = sd(get(variavel)),
            Minimo = min(get(variavel)),
            Maximo = max(get(variavel)),
            Observacoes = n()
          ) %>%
          rename(Especie = Species)
      }
    
    # Estatísticas para sépala
    output$tabela_sepala <- 
      renderTable({
        calcular_estatisticas(input$variavel_sepala)
      }, 
      digits = 2, 
      striped = TRUE)   # estética da tabela
    
    # Estatísticas para pétala
    output$tabela_petala <- 
      renderTable({
        calcular_estatisticas(input$variavel_petala)
      }, 
      digits = 2, 
      striped = TRUE)   # estética da tabela
  }

# Executa o aplicativo
shinyApp(ui = ui_abas, server = server_abas)

