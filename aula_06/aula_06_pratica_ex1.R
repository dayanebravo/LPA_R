if(!require(shiny)) install.packages('shiny')
if(!require(ggplot2)) install.packages('ggplot2')
if(!require(dplyr)) install.packages('dplyr')
library(shiny)
library(ggplot2)
library(dplyr)

# Dados de vendas (poderia ser lido de um arquivo CSV)
vendas <- read.csv("https://raw.githubusercontent.com/dayanebravo/LPA_R/refs/heads/main/aula_05/vendas.csv")


# Interface do usuário
ui_vendas <- fluidPage(
  titlePanel("Análise de Vendas Interativa"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("regiao", 
                  "Selecione a região:", 
                  choices = c("Todas", unique(vendas$regiao)))
    ), 
    
    mainPanel(
      h3("Tabela de Vendas"),
      tableOutput("tabela"),
      
      h3("Gráfico de Vendas por Produto"),
      plotOutput("grafico_barras"),
      
      h3("Total de Vendas por Região"),
      plotOutput("grafico_setores")
    )
  )
)

# Lógica do servidor
server_vendas <- function(input, output) {
  
  # Filtra os dados com base na seleção
  dados_filtrados <- reactive({
    if (input$regiao == "Todas") {
      vendas
    } else {
      filter(vendas, regiao == input$regiao)
    }
  })
  
  # Tabela de vendas
  output$tabela <- renderTable({
    dados_filtrados() %>%
      mutate(Total = valor * quantidade)
  })
  
  # Gráfico de barras
  output$grafico_barras <- renderPlot({
    dados <- dados_filtrados()
    
    ggplot(dados, aes(x = produto, y = valor * quantidade, fill = produto)) +
      geom_bar(stat = "identity") +
      labs(title = paste("Vendas em", ifelse(input$regiao == "Todas", "Todas as Regiões", input$regiao)),
           y = "Valor Total (R$)", x = "") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  })
  
  # Gráfico de setores (apenas quando "Todas" as regiões estão selecionadas)
  output$grafico_setores <- renderPlot({
    if (input$regiao == "Todas") {
      resumo <- vendas %>%
        group_by(regiao) %>%
        summarise(Total = sum(valor * quantidade), .groups = 'drop') 
      
      ggplot(resumo, aes(x = "", y = Total, fill = regiao)) +
        geom_bar(width = 1, stat = "identity") +
        coord_polar("y", start = 0) +
        labs(title = "Distribuição de Vendas por Região") +
        theme_void()
    } else {
      # Retorna um gráfico vazio quando uma região específica está selecionada
      ggplot() + 
        geom_text(aes(x = 0, y = 0, label = "Selecione 'Todas' para ver este gráfico")) +
        theme_void()
    }
  })
}

# Executa o aplicativo
shinyApp(ui = ui_vendas, server = server_vendas)