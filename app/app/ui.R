#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(here)
source(here("code/read_wrangle.R"))

profissoes_nos_dados = read_wrangle_data() %>% 
  filter(!is.na(profissao)) %>%  
  pull(profissao) %>% 
  unique()

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Profissões, arborização e ruas de Campina Grande"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput('profissoes', 'Selecione uma ou mais profissões:', 
                   profissoes_nos_dados, multiple = TRUE, 
                   selected = sample(profissoes_nos_dados, 1)),
       helpText("A partir da profissão da pessoa cujo nome foi dado a uma rua, pode-se observar o comprimento das ruas e o número de árvores existentes.")
       ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("prof_ruas_plot")
    )
  )
))
