if (!require(shiny)) install.packages("shiny")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")
if (!require(tidyr)) install.packages("tidyr")

library(shiny)      # Para criar aplicativos web interativos
library(ggplot2)    # Para criar gráficos elegantes
library(dplyr)      # Para manipulação de dados
library(tidyr)      # Para reorganizar dados (wide/long format)

# Dados de vendas
vendas <- read.csv("https://raw.githubusercontent.com/dayanebravo/LPA_R/refs/heads/main/aula_06/vendas.csv")


########## INTERFACE DO USUÁRIO (UI)

# Define a interface do usuário usando fluidPage (layout responsivo)
ui_vendas <- fluidPage(
  
  # TÍTULO PRINCIPAL da aplicação
  titlePanel("Análise de Vendas Interativa"),
  
  # LAYOUT PRINCIPAL: Divide a página em barra lateral + painel principal
  sidebarLayout(
    
    # BARRA LATERAL (SIDEBAR) - Controles de entrada do usuário
    sidebarPanel(
      
      # CONTROLE DE ENTRADA: Dropdown para seleção de região
      selectInput("regiao",                                    # ID do input (usado no server)
                  "Selecione a região:",                       # Rótulo exibido ao usuário
                  choices = c("Todas", unique(vendas$regiao))) # Opções: "Todas" + regiões únicas dos dados
    ), 
    
    # PAINEL PRINCIPAL - Onde serão exibidos os resultados
    mainPanel(
      
      # SEÇÃO 1: TABELA DE DADOS
      h3("Tabela de Vendas"),              
      tableOutput("tabela"),               # Placeholder para tabela (ID: "tabela")
      
      # SEÇÃO 2: GRÁFICO DE BARRAS
      h3("Gráfico de Vendas por Produto"), 
      plotOutput("grafico_barras"),        # Placeholder para gráfico (ID: "grafico_barras")
      
      # SEÇÃO 3: GRÁFICO DE SETORES (PIZZA)
      h3("Total de Vendas por Região"),    
      plotOutput("grafico_setores")        # Placeholder para gráfico (ID: "grafico_setores")
    )
  )
)


##########  LÓGICA DO SERVIDOR (SERVER)

# Define a lógica do servidor - onde ocorre o processamento dos dados
server_vendas <- function(input, output) {
  
  # FUNÇÃO REATIVA: Filtra os dados baseado na seleção do usuário
  # Reactive() cria uma função que se atualiza automaticamente quando inputs mudam
  dados_filtrados <- reactive({
    
    # CONDICIONAL: Verifica qual região foi selecionada
    if (input$regiao == "Todas") {
      # Se "Todas" foi selecionado, retorna todos os dados
      vendas
    } else {
      # Se uma região específica foi selecionada, filtra os dados
      filter(vendas, regiao == input$regiao)  # Usa dplyr::filter()
    }
  })
  

  # SAÍDA 1: TABELA DE VENDAS
  # Renderiza a tabela que será exibida no UI
  output$tabela <- renderTable({
    
    # Pega os dados filtrados e adiciona uma coluna "Total"
    dados_filtrados() %>%                    # Chama a função reativa
      mutate(Total = valor * quantidade)     # Cria nova coluna: valor × quantidade
  })
  

  # SAÍDA 2: GRÁFICO DE BARRAS
  # Renderiza o gráfico de barras
  output$grafico_barras <- renderPlot({
    
    # Armazena os dados filtrados em uma variável local
    dados <- dados_filtrados()
    
    # Cria o gráfico usando ggplot2
    ggplot(dados, aes(x = produto,                    # Eixo X: produtos
                      y = valor * quantidade,          # Eixo Y: valor total (valor × quantidade)
                      fill = produto)) +               # Cor de preenchimento: por produto
      
      # Adiciona barras ao gráfico
      geom_bar(stat = "identity") +                   # stat="identity" usa os valores como estão
      
      # Configura rótulos e títulos
      labs(title = paste("Vendas em", 
                         ifelse(input$regiao == "Todas", 
                                "Todas as Regiões", 
                                input$regiao)),          # Título dinâmico baseado na seleção
           y = "Valor Total (R$)",                    # Rótulo do eixo Y
           x = "") +                                  # Eixo X sem rótulo
      
      # Aplica tema minimalista
      theme_minimal() +
      
      # Personalizações do tema
      theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Texto do eixo X inclinado 45°
            legend.position = "none")                           # Remove a legenda
  })
  

  # SAÍDA 3: GRÁFICO DE SETORES (PIZZA)
  # Renderiza o gráfico de setores
  output$grafico_setores <- renderPlot({
    
    # CONDICIONAL: Só mostra o gráfico se "Todas" as regiões estiverem selecionadas
    if (input$regiao == "Todas") {
      
      # PREPARAÇÃO DOS DADOS: Agrupa por região e soma os valores
      resumo <- vendas %>%                            # Usa dados originais (não filtrados)
        group_by(regiao) %>%                          # Agrupa por região
        summarise(Total = sum(valor * quantidade),    # Soma o valor total por região
                  .groups = 'drop')                   # Remove agrupamento após summarise
      
      # CRIAÇÃO DO GRÁFICO DE PIZZA
      ggplot(resumo, aes(x = "",                      # X vazio (necessário para coord_polar)
                         y = Total,                    # Y: valores totais
                         fill = regiao)) +             # Cor: por região
        
        # Cria barras que serão transformadas em setores
        geom_bar(width = 1, stat = "identity") +      # width=1 para pizza completa
        
        # TRANSFORMAÇÃO EM PIZZA: Converte coordenadas cartesianas em polares
        coord_polar("y", start = 0) +                 # "y" indica que o eixo Y vira ângulo
        
        # Configurações visuais
        labs(title = "Distribuição de Vendas por Região") +
        theme_void()                                  # Remove eixos, grid e fundo
      
    } else {
      # CASO ALTERNATIVO: Quando uma região específica está selecionada
      # Mostra uma mensagem informativa em vez do gráfico de pizza
      
      ggplot() +                                      # Gráfico vazio
        geom_text(aes(x = 0, y = 0,                   # Posição central
                      label = "Selecione 'Todas' para ver este gráfico")) +  # Mensagem
        theme_void()                                  # Tema limpo
    }
  })
}


###########  Executa o aplicativo
shinyApp(ui = ui_vendas, server = server_vendas)
