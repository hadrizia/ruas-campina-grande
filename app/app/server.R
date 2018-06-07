#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(tidyverse)
library(here)
source(here("code/read_wrangle.R"))

vias = read_wrangle_data()

profissoes_nos_dados = vias %>% 
  filter(!is.na(profissao)) %>%  
  pull(profissao) %>% 
  unique()

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$prof_ruas_plot <- renderPlot({
    vias %>% filter(profissao %in% input$profissoes) %>% group_by(profissao) %>%
    ggplot(aes(x = arvore, y = comprimento, color = profissao)) + geom_jitter() + 
      labs(y = 'Comprimento da rua', x = 'Número de árvores') + scale_color_discrete("Profissão")
    
  })
  
})
