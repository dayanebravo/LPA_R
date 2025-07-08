if (!require(shiny)) install.packages("shiny")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")
if (!require(tidyr)) install.packages("tidyr")

library(shiny)      # Para criar aplicativos web interativos
library(ggplot2)    # Para criar gráficos elegantes
library(dplyr)      # Para manipulação de dados
library(tidyr)      # Para reorganizar dados (wide/long format)


# Dados das notas
notas <- read.csv("https://raw.githubusercontent.com/dayanebravo/LPA_R/refs/heads/main/aula_06/notas.csv")


# Calcular estatísticas adicionais para cada aluno
notas <- notas %>%
  mutate(
    # Média das 4 notas de cada aluno
    media = (bimestre1 + bimestre2 + bimestre3 + bimestre4) / 4,
    # Status baseado na média (>=7.0 = Aprovado, <7.0 = Reprovado)
    status = ifelse(media >= 7.0, "Aprovado", "Reprovado")
  )


####### INTERFACE DO USUÁRIO (UI)

ui_notas <- fluidPage(
  # Título principal da aplicação
  titlePanel("Sistema de Análise de Notas Escolares"),
  
  # Layout com barra lateral (sidebar) e painel principal
  sidebarLayout(
    
    # PAINEL LATERAL - Controles de entrada
    sidebarPanel(
      width = 3,  # Largura da barra lateral (escala de 1-12)
      
      # Seletor de aluno individual
      selectInput("aluno_selecionado", 
                  "Selecione um aluno:", 
                  choices = c("Todos os alunos", notas$aluno),
                  selected = "Todos os alunos"),
      
      hr(),  # Linha horizontal para separar seções
      
      # Seletor de filtro por status (aprovado/reprovado)
      selectInput("filtro_status", 
                  "Filtrar por status:", 
                  choices = c("Todos", "Aprovado", "Reprovado"),
                  selected = "Todos"),
      
      hr(),
      
      # Checkbox para mostrar/ocultar estatísticas detalhadas
      checkboxInput("mostrar_stats", 
                    "Mostrar estatísticas detalhadas", 
                    value = TRUE),
      
      hr(),
      
      # Informações sobre o sistema de avaliação
      h5("Informações:"),
      p("• Média ≥ 7.0: Aprovado"),
      p("• Média < 7.0: Reprovado"),
      p("• Notas de 0 a 10")
    ),
    
    # PAINEL PRINCIPAL - Saídas/resultados
    mainPanel(
      width = 9,  # Largura do painel principal
      
      # Abas para organizar diferentes visualizações
      tabsetPanel(
        
        # ABA 1: TABELA DE NOTAS
        tabPanel("Tabela de Notas",
                 br(),  # Quebra de linha
                 h4("Tabela Completa de Notas"),
                 # Saída da tabela formatada
                 tableOutput("tabela_notas")
        ),
        
        # ABA 2: GRÁFICOS INDIVIDUAIS
        tabPanel("Desempenho por Aluno",
                 br(),
                 h4("Evolução das Notas por Bimestre"),
                 # Gráfico de linhas mostrando evolução individual
                 plotOutput("grafico_evolucao", height = "400px"),
                 
                 br(),
                 h4("Comparação de Médias"),
                 # Gráfico de barras com as médias finais
                 plotOutput("grafico_medias", height = "400px")
        ),
        
        # ABA 3: ANÁLISE GERAL
        tabPanel("Análise Geral",
                 br(),
                 h4("Distribuição de Status"),
                 # Gráfico de pizza mostrando aprovados vs reprovados
                 plotOutput("grafico_status", height = "400px"),
                 
                 br(),
                 # Painel condicional que aparece apenas se checkbox estiver marcado
                 conditionalPanel(
                   condition = "input.mostrar_stats",
                   h4("Estatísticas Detalhadas"),
                   # Saída das estatísticas calculadas
                   verbatimTextOutput("estatisticas_gerais")
                 )
        )
      )
    )
  )
)


######## LÓGICA DO SERVIDOR (SERVER)


server_notas <- function(input, output) {
  
  # FUNÇÃO REATIVA: Filtrar dados baseado nas seleções do usuário
  dados_filtrados <- reactive({
    # Começar com todos os dados
    dados <- notas
    
    # Filtrar por aluno se não for "Todos os alunos"
    if (input$aluno_selecionado != "Todos os alunos") {
      dados <- dados %>% 
        filter(aluno == input$aluno_selecionado)
    }
    
    # Filtrar por status se não for "Todos"
    if (input$filtro_status != "Todos") {
      dados <- dados %>% 
        filter(status == input$filtro_status)
    }
    
    return(dados)
  })
  

  # SAÍDA 1: TABELA DE NOTAS

  output$tabela_notas <- renderTable({
    # Pegar dados filtrados e formatar para exibição
    dados_filtrados() %>%
      # Renomear colunas para exibição mais amigável
      select(
        "Aluno" = aluno,
        "1º Bimestre" = bimestre1,
        "2º Bimestre" = bimestre2, 
        "3º Bimestre" = bimestre3,
        "4º Bimestre" = bimestre4,
        "Média Final" = media,
        "Status" = status
      ) %>%
      # Arredondar a média para 2 casas decimais
      mutate(`Média Final` = round(`Média Final`, 2))
  }, 
  striped = TRUE,    # Linhas alternadas coloridas
  hover = TRUE,      # Destacar linha ao passar mouse
  bordered = TRUE    # Bordas na tabela
  )
  

  # SAÍDA 2: GRÁFICO DE EVOLUÇÃO DAS NOTAS

  output$grafico_evolucao <- renderPlot({
    # Transformar dados de formato wide para long para o ggplot
    dados_long <- dados_filtrados() %>%
      select(aluno, bimestre1, bimestre2, bimestre3, bimestre4) %>%
      # Pivot_longer transforma colunas em linhas
      pivot_longer(cols = starts_with("bimestre"), 
                   names_to = "bimestre", 
                   values_to = "nota") %>%
      # Limpar nomes dos bimestres para exibição
      mutate(bimestre = case_when(
        bimestre == "bimestre1" ~ "1º Bim",
        bimestre == "bimestre2" ~ "2º Bim", 
        bimestre == "bimestre3" ~ "3º Bim",
        bimestre == "bimestre4" ~ "4º Bim"
      ))
    
    # Criar gráfico de linhas
    ggplot(dados_long, aes(x = bimestre, y = nota, 
                           color = aluno, group = aluno)) +
      geom_line(size = 1.2) +                    # Linhas conectando os pontos
      geom_point(size = 3) +                     # Pontos nas notas
      scale_y_continuous(limits = c(0, 10),      # Escala de 0 a 10
                         breaks = seq(0, 10, 1)) + # Marcas de 1 em 1
      labs(title = "Evolução das Notas por Bimestre",
           x = "Bimestre", 
           y = "Nota",
           color = "Aluno") +
      theme_minimal() +                          # Tema limpo
      theme(legend.position = "bottom",          # Legenda embaixo
            plot.title = element_text(hjust = 0.5, size = 14)) # Título centralizado
  })
  

  # SAÍDA 3: GRÁFICO DE MÉDIAS

  output$grafico_medias <- renderPlot({
    # Criar gráfico de barras com as médias
    ggplot(dados_filtrados(), aes(x = reorder(aluno, media), y = media, 
                                  fill = status)) +
      geom_bar(stat = "identity", alpha = 0.8) +           # Barras com transparência
      geom_hline(yintercept = 7.0, linetype = "dashed",   # Linha da média mínima
                 color = "red", size = 1) +
      geom_text(aes(label = round(media, 2)),              # Texto com valor da média
                vjust = -0.5, size = 4) +
      scale_fill_manual(values = c("Aprovado" = "green3",  # Cores personalizadas
                                   "Reprovado" = "red3")) +
      labs(title = "Média Final por Aluno",
           x = "Aluno", 
           y = "Média Final",
           fill = "Status") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Texto inclinado
            plot.title = element_text(hjust = 0.5, size = 14))
  })
  

  
  # SAÍDA 4: GRÁFICO DE STATUS (PIZZA)

  
  output$grafico_status <- renderPlot({
    # Calcular contagem por status
    resumo_status <- dados_filtrados() %>%
      count(status) %>%
      mutate(
        # Calcular percentual
        percentual = round(n / sum(n) * 100, 1),
        # Criar label com contagem e percentual
        label = paste0(status, "\n", n, " (", percentual, "%)")
      )
    
    # Gráfico de pizza (usando coord_polar)
    ggplot(resumo_status, aes(x = "", y = n, fill = status)) +
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y", start = 0) +              # Transformar em pizza
      geom_text(aes(label = label), 
                position = position_stack(vjust = 0.5),
                size = 5, fontface = "bold") +
      scale_fill_manual(values = c("Aprovado" = "lightgreen", 
                                   "Reprovado" = "lightcoral")) +
      labs(title = "Distribuição de Aprovados e Reprovados") +
      theme_void() +                             # Remove eixos e grid
      theme(plot.title = element_text(hjust = 0.5, size = 14),
            legend.position = "none")            # Remove legenda (info está no gráfico)
  })
  

  # SAÍDA 5: ESTATÍSTICAS GERAIS

  output$estatisticas_gerais <- renderText({
    dados <- dados_filtrados()
    
    # Calcular várias estatísticas
    stats <- list(
      total_alunos = nrow(dados),
      aprovados = sum(dados$status == "Aprovado"),
      reprovados = sum(dados$status == "Reprovado"),
      taxa_aprovacao = round(sum(dados$status == "Aprovado") / nrow(dados) * 100, 1),
      media_geral = round(mean(dados$media), 2),
      maior_media = round(max(dados$media), 2),
      menor_media = round(min(dados$media), 2),
      aluno_maior_media = dados$aluno[which.max(dados$media)],
      aluno_menor_media = dados$aluno[which.min(dados$media)]
    )
    
    # Formatar saída como texto
    paste(
      "ESTATÍSTICAS GERAIS\n",
      sprintf("Total de alunos: %d", stats$total_alunos), "\n",
      sprintf("Aprovados: %d", stats$aprovados), "\n", 
      sprintf("Reprovados: %d", stats$reprovados), "\n",
      sprintf("Taxa de aprovação: %s%%", stats$taxa_aprovacao), "\n\n",
      "MÉDIAS\n",
      sprintf("Média geral da turma: %s", stats$media_geral), "\n",
      sprintf("Maior média: %s (%s)", stats$maior_media, stats$aluno_maior_media), "\n",
      sprintf("Menor média: %s (%s)", stats$menor_media, stats$aluno_menor_media),
      sep = ""
    )
  })
}


######## EXECUTAR O APLICATIVO
shinyApp(ui = ui_notas, server = server_notas)
